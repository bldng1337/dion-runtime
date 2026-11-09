use std::collections::{BTreeMap, HashMap};
use std::ops::Deref;
use std::ops::DerefMut;
use std::pin::Pin;
use std::rc::Rc;
use std::task::Poll;
use std::time::Duration;
use std::{cell::RefCell, collections::VecDeque};

use boa_engine::builtins::promise::PromiseState;
use boa_engine::context::time::{JsDuration, JsInstant};
use boa_engine::job::TimeoutJob;
use boa_engine::object::builtins::JsPromise;
use boa_engine::{
    Context, JsNativeError, JsResult, JsValue,
    job::{Job, JobExecutor, NativeAsyncJob, PromiseJob},
};
use boa_gc::GcRefCell;
use futures_concurrency::future::FutureGroup;
use futures_lite::{Stream, StreamExt, future};
use tokio::task::{self, JoinHandle};
use tokio_util::sync::CancellationToken;

use boa_engine::Finalize;
use boa_engine::JsData;
use boa_engine::module::{ModuleLoader, ModuleRequest, Referrer};
use boa_engine::{JsError, Module, Trace, js_string};

use anyhow::{Result, anyhow};

pub(crate) fn error_to_reject_value(err: JsError, context: &mut Context) -> JsValue {
    err.into_opaque(context)
        .unwrap_or_else(|err| JsValue::from(js_string!(err.to_string())))
}

/// Boilerplate shared by the JS modules that need to await Rust async work
/// (permission prompts, file IO, ...) before resolving: enqueues a
/// `NativeAsyncJob` whose future runs `work` with the live
/// `InnerExtension`, then converts the Rust result to a `JsValue` with the
/// context borrowed back, resolving/rejecting the returned promise.
pub(crate) fn enqueue_job<T, WF, F, C>(
    context: &mut Context,
    work: WF,
    convert: C,
) -> JsResult<JsValue>
where
    T: 'static,
    WF: FnOnce(std::sync::Arc<crate::extension::container::InnerExtension>) -> F + 'static,
    F: Future<Output = anyhow::Result<T>> + 'static,
    C: FnOnce(T, &mut Context) -> JsResult<JsValue> + 'static,
{
    let runtime: Option<crate::extension::executor::ExtensionRuntimeDataContainer> =
        context.get_data().cloned();
    let runtime = runtime.ok_or(JsError::from_native(
        JsNativeError::error().with_message("Failed to get runtime data"),
    ))?;
    let Some(inner) = runtime.inner.upgrade() else {
        return Err(JsError::from_native(
            JsNativeError::error().with_message("Runtime container has been dropped"),
        ));
    };
    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(<Job>::from(NativeAsyncJob::with_realm(
        async move |context: &RefCell<&mut Context>| {
            let result = work(inner).await;
            let mut guard = context.borrow_mut();
            let ctx: &mut Context = &mut guard;
            match result {
                Ok(value) => {
                    let val = convert(value, ctx)?;
                    resolve.resolve.call(&promise.into(), &[val], ctx)?
                }
                Err(err) => {
                    let err = JsError::from_rust(&*err);
                    resolve
                        .reject
                        .call(&promise.into(), &[error_to_reject_value(err, ctx)], ctx)?
                }
            };
            Ok(JsValue::undefined())
        },
        context.realm().clone(),
    )));
    Ok(ret.into())
}

pub(crate) trait Abortable {
    fn abort(&self);
}

impl<T> Abortable for JoinHandle<T> {
    fn abort(&self) {
        JoinHandle::abort(self);
    }
}

#[derive(Debug)]
pub(crate) struct AbortOnDrop<T: Abortable> {
    handle: T,
}

impl<T: Abortable> AbortOnDrop<T> {
    pub fn new(handle: T) -> Self {
        Self { handle }
    }
}

impl<T: Abortable> Drop for AbortOnDrop<T> {
    fn drop(&mut self) {
        self.handle.abort();
    }
}

pub async fn await_promise(promise: JsPromise, context: &mut Context) -> JsResult<JsValue> {
    let queue: Rc<Queue> = context.downcast_job_executor().ok_or(JsError::from_native(
        JsNativeError::error().with_message("Failed to find Job Executor"),
    ))?;
    let context = RefCell::new(context);
    loop {
        match promise.state() {
            PromiseState::Pending => {
                queue.clone().run_jobs_async(&context).await?;
                if !matches!(promise.state(), PromiseState::Pending) {
                    continue;
                }
                let delay = queue.next_timeout_delay(&context.borrow());
                let Some(delay) = delay else {
                    break Err(JsError::from_native(JsNativeError::error().with_message(
                        "Promise can never settle: no pending jobs or timers remain",
                    )));
                };
                tokio::time::sleep(delay).await;
                queue.drain_jobs(&mut context.borrow_mut());
                task::yield_now().await;
            }
            PromiseState::Fulfilled(js_value) => break Ok(js_value),
            PromiseState::Rejected(js_value) => break Err(JsError::from_opaque(js_value)),
        }
    }
}

pub(crate) async fn await_promise_cancellable(
    promise: JsPromise,
    context: &mut Context,
    token: Option<&CancellationToken>,
) -> JsResult<JsValue> {
    let Some(token) = token else {
        return await_promise(promise, context).await;
    };
    let queue: Option<Rc<Queue>> = context.downcast_job_executor();
    match token
        .run_until_cancelled(await_promise(promise, context))
        .await
    {
        Some(result) => result,
        None => {
            if let Some(queue) = queue {
                queue.clear();
            }
            Err(JsError::from_native(
                JsNativeError::error().with_message("Task was cancelled"),
            ))
        }
    }
}

#[derive(Trace, Finalize, JsData)]
pub struct ReadOnlyUserContextContainer<T> {
    #[unsafe_ignore_trace]
    pub inner: T,
}

impl<T> Default for ReadOnlyUserContextContainer<T>
where
    T: Default,
{
    fn default() -> Self {
        Self {
            inner: Default::default(),
        }
    }
}

impl<T> Clone for ReadOnlyUserContextContainer<T>
where
    T: Clone,
{
    fn clone(&self) -> Self {
        Self {
            inner: self.inner.clone(),
        }
    }
}

impl<T> Deref for ReadOnlyUserContextContainer<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

impl<T> ReadOnlyUserContextContainer<T> {
    pub fn new(inner: T) -> Self {
        ReadOnlyUserContextContainer { inner }
    }
}

#[derive(Debug)]
pub struct VirtualModuleLoader {
    module_map: GcRefCell<HashMap<String, Module>>,
}

impl VirtualModuleLoader {
    /// Creates a new `SimpleModuleLoader` from a root module path.
    pub fn new() -> JsResult<Self> {
        Ok(Self {
            module_map: GcRefCell::default(),
        })
    }

    /// Inserts a new module onto the module map.
    #[inline]
    pub fn insert(&self, path: String, module: Module) {
        self.module_map.borrow_mut().insert(path, module);
    }

    /// Gets a module from its original path.
    #[inline]
    pub fn get(&self, path: &String) -> Option<Module> {
        self.module_map.borrow().get(path).cloned()
    }
}

impl ModuleLoader for VirtualModuleLoader {
    async fn load_imported_module(
        self: Rc<Self>,
        _referrer: Referrer,
        request: ModuleRequest,
        _context: &RefCell<&mut Context>,
    ) -> JsResult<Module> {
        let specifier = request.specifier();
        let short_path = specifier.to_std_string_escaped();
        if let Some(module) = self.get(&short_path) {
            return Ok(module);
        }
        Err(JsError::from_native(
            JsNativeError::syntax().with_message(format!("no such module `{short_path}`")),
        ))
    }
}

pub struct Queue {
    async_jobs: RefCell<VecDeque<NativeAsyncJob>>,
    promise_jobs: RefCell<VecDeque<PromiseJob>>,
    timeout_jobs: RefCell<BTreeMap<JsInstant, TimeoutJob>>,
}

impl Queue {
    pub fn new() -> Self {
        Self {
            async_jobs: RefCell::default(),
            promise_jobs: RefCell::default(),
            timeout_jobs: RefCell::default(),
        }
    }

    fn has_runnable_jobs(&self) -> bool {
        !self.promise_jobs.borrow().is_empty() || !self.async_jobs.borrow().is_empty()
    }

    fn clear(&self) {
        self.async_jobs.borrow_mut().clear();
        self.promise_jobs.borrow_mut().clear();
        self.timeout_jobs.borrow_mut().clear();
    }

    fn next_timeout_delay(&self, context: &Context) -> Option<Duration> {
        let timeouts = self.timeout_jobs.borrow();
        let (deadline, _) = timeouts.first_key_value()?;
        let remaining = *deadline - context.clock().now();
        Some(Duration::from_millis(remaining.as_millis()))
    }

    fn drain_timeout_jobs(&self, context: &mut Context) {
        let now = context.clock().now();

        let mut timeouts_borrow = self.timeout_jobs.borrow_mut();
        // `split_off` returns the jobs after (or equal to) the key. So we need to add 1ms to
        // the current time to get the jobs that are due, then swap with the inner timeout
        // tree so that we get the jobs to actually run.
        let jobs_to_keep = timeouts_borrow.split_off(&(now + JsDuration::from_millis(1)));
        let jobs_to_run = std::mem::replace(timeouts_borrow.deref_mut(), jobs_to_keep);
        drop(timeouts_borrow);

        for job in jobs_to_run.into_values() {
            if let Err(e) = job.call(context) {
                eprintln!("Uncaught {e}");
            }
        }
    }

    fn drain_jobs(&self, context: &mut Context) {
        // Run the timeout jobs first.
        self.drain_timeout_jobs(context);

        let jobs = std::mem::take(&mut *self.promise_jobs.borrow_mut());
        for job in jobs {
            if let Err(e) = job.call(context) {
                eprintln!("Uncaught {e}");
            }
        }
    }
}

impl JobExecutor for Queue {
    fn enqueue_job(self: Rc<Self>, job: Job, context: &mut Context) {
        match job {
            Job::PromiseJob(job) => self.promise_jobs.borrow_mut().push_back(job),
            Job::AsyncJob(job) => self.async_jobs.borrow_mut().push_back(job),
            Job::TimeoutJob(t) => {
                let now = context.clock().now();
                self.timeout_jobs.borrow_mut().insert(now + t.timeout(), t);
            }
            _ => panic!("unsupported job type"),
        }
    }

    // While the sync flavor of `run_jobs` will block the current thread until all the jobs have finished...
    fn run_jobs(self: Rc<Self>, context: &mut Context) -> JsResult<()> {
        // The executor must run on its own dedicated thread (the JS engine
        // uses thread-local state), so this sync flavor must never be reached
        // from inside a tokio runtime — building a nested runtime here would
        // panic with a confusing message.
        assert!(
            tokio::runtime::Handle::try_current().is_err(),
            "run_jobs() called from within an async context; the sync executor \
             must run on its own dedicated thread — use run_jobs_async() instead"
        );
        let runtime = tokio::runtime::Builder::new_current_thread()
            .enable_time()
            .build()
            .expect("Failed to create Tokio Runtime");

        task::LocalSet::default().block_on(&runtime, self.run_jobs_async(&RefCell::new(context)))
    }

    // ...the async flavor won't, which allows concurrent execution with external async tasks.
    async fn run_jobs_async(self: Rc<Self>, context: &RefCell<&mut Context>) -> JsResult<()> {
        // Early return in case there were no jobs scheduled.
        if self.promise_jobs.borrow().is_empty() && self.async_jobs.borrow().is_empty() {
            return Ok(());
        }
        let mut group = FutureGroup::new();
        loop {
            for job in std::mem::take(&mut *self.async_jobs.borrow_mut()) {
                group.insert(job.call(context));
            }

            if group.is_empty() && self.promise_jobs.borrow().is_empty() {
                // Both queues are empty. We can exit.
                return Ok(());
            }

            let finished = if self.promise_jobs.borrow().is_empty() {
                let timer = self.next_timeout_delay(&context.borrow());
                let progress =
                    std::future::poll_fn(|cx| match Pin::new(&mut group).poll_next(cx) {
                        Poll::Pending if self.has_runnable_jobs() => Poll::Ready(None),
                        poll => poll,
                    });
                match timer {
                    Some(delay) => tokio::time::timeout(delay, progress).await.ok().flatten(),
                    None => progress.await,
                }
            } else {
                future::poll_once(group.next()).await.flatten()
            };
            if let Some(Err(err)) = finished {
                eprintln!("Uncaught {err}");
            };

            // Only one macrotask can be executed before the next drain of the microtask queue.
            self.drain_jobs(&mut context.borrow_mut());
            task::yield_now().await
        }
    }
}

pub trait MapJsResult<T> {
    fn map_anyhow(self) -> Result<T>;
    fn map_anyhow_ctx(self, context: &mut Context) -> Result<T>;
}

impl<T> MapJsResult<T> for JsResult<T> {
    fn map_anyhow_ctx(self, context: &mut Context) -> Result<T> {
        match self {
            Ok(val) => Ok(val),
            Err(jserr) => match jserr.try_native(context) {
                Ok(err) => Err(anyhow!(
                    "Error executing JS[{}]: {}",
                    err.kind(),
                    err.message()
                )),
                Err(err) => Err(anyhow!(
                    "Error executing JS[Failed to get Error - {}]: {}",
                    err,
                    jserr
                )),
            },
        }
    }

    fn map_anyhow(self) -> Result<T> {
        match self {
            Ok(val) => Ok(val),
            Err(jserr) => match jserr.as_native() {
                Some(err) => Err(anyhow!(
                    "Error executing JS[{}]: {}",
                    err.kind(),
                    err.message()
                )),
                None => Err(anyhow!("Error executing JS: {}", jserr)),
            },
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use boa_engine::job::TimeoutJob;
    use std::cell::Cell;

    fn test_context() -> Context {
        Context::builder()
            .job_executor(Rc::new(Queue::new()))
            .build()
            .expect("failed to build context")
    }

    #[tokio::test]
    async fn never_settling_promise_is_an_error() {
        let mut context = test_context();
        let (promise, _resolvers) = JsPromise::new_pending(&mut context);

        let err = await_promise(promise, &mut context).await.unwrap_err();

        assert!(err.to_string().contains("never settle"), "{err}");
    }

    #[tokio::test]
    async fn pending_promise_waits_for_its_timer() {
        let mut context = test_context();
        let (promise, resolvers) = JsPromise::new_pending(&mut context);
        context.enqueue_job(
            TimeoutJob::from_duration(
                move |context: &mut Context| {
                    resolvers
                        .resolve
                        .call(&JsValue::undefined(), &[JsValue::from(7)], context)
                },
                Duration::from_millis(10),
            )
            .into(),
        );

        let value = await_promise(promise, &mut context).await.unwrap();

        assert_eq!(value.as_number(), Some(7.0));
    }

    #[tokio::test]
    async fn cancelling_abandons_in_flight_jobs() {
        let mut context = test_context();
        let (promise, _resolvers) = JsPromise::new_pending(&mut context);
        context.enqueue_job(
            NativeAsyncJob::new(async |_context: &RefCell<&mut Context>| {
                std::future::pending::<()>().await;
                Ok(JsValue::undefined())
            })
            .into(),
        );
        let token = CancellationToken::new();
        let canceller = token.clone();
        tokio::spawn(async move {
            tokio::time::sleep(Duration::from_millis(10)).await;
            canceller.cancel();
        });

        let err = await_promise_cancellable(promise, &mut context, Some(&token))
            .await
            .unwrap_err();

        assert!(err.to_string().contains("cancelled"), "{err}");
        let queue: Rc<Queue> = context.downcast_job_executor().unwrap();
        assert!(!queue.has_runnable_jobs());
    }

    #[tokio::test]
    async fn in_flight_jobs_are_only_polled_when_woken() {
        let mut context = test_context();
        let polls = Rc::new(Cell::new(0u32));
        let counter = polls.clone();
        context.enqueue_job(
            NativeAsyncJob::new(async move |_context: &RefCell<&mut Context>| {
                let mut sleep = std::pin::pin!(tokio::time::sleep(Duration::from_millis(50)));
                std::future::poll_fn(|cx| {
                    counter.set(counter.get() + 1);
                    sleep.as_mut().poll(cx)
                })
                .await;
                Ok(JsValue::undefined())
            })
            .into(),
        );
        let queue: Rc<Queue> = context.downcast_job_executor().unwrap();

        queue
            .run_jobs_async(&RefCell::new(&mut context))
            .await
            .unwrap();

        assert!(polls.get() <= 3, "polled {} times", polls.get());
    }
}
