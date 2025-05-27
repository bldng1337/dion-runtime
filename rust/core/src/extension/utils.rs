use std::collections::HashMap;
use std::{cell::RefCell, collections::VecDeque, future::Future, pin::Pin};
use std::{ops::Deref, sync::Arc};

use boa_engine::builtins::promise::PromiseState;
use boa_engine::object::builtins::JsPromise;
use boa_engine::{
    job::{Job, JobExecutor, NativeAsyncJob, PromiseJob},
    Context, JsNativeError, JsResult, JsValue,
};
use boa_gc::GcRefCell;
use futures_concurrency::future::FutureGroup;
use futures_lite::{future, StreamExt};
use tokio::task;

use boa_engine::module::{ModuleLoader, Referrer};
use boa_engine::Finalize;
use boa_engine::JsData;
use boa_engine::{JsError, JsString, Module, Trace};
use tokio::sync::RwLock;

use anyhow::{anyhow, Context as ErrorContext, Result};

pub async fn await_promise(promise: JsPromise, context: &mut Context) -> JsResult<JsValue> {
    loop {
        match promise.state() {
            PromiseState::Pending => context.run_jobs_async().await?,
            PromiseState::Fulfilled(js_value) => break Ok(js_value),
            PromiseState::Rejected(js_value) => break Err(JsError::from_opaque(js_value)),
        }
    }
}

#[derive(Trace, Finalize, JsData)]
pub struct SharedUserContextContainer<T> {
    #[unsafe_ignore_trace]
    pub inner: Arc<RwLock<T>>,
}
impl<T> Clone for SharedUserContextContainer<T> {
    fn clone(&self) -> Self {
        Self {
            inner: self.inner.clone(),
        }
    }
}

impl<T> SharedUserContextContainer<T> {
    // pub fn new(inner: T) -> Self {
    //     SharedUserContextContainer {
    //         inner: Arc::new(RwLock::new(inner)),
    //     }
    // }
    pub fn from(arc: Arc<RwLock<T>>) -> Self {
        SharedUserContextContainer { inner: arc }
    }
    // pub async fn get(&self) -> tokio::sync::RwLockReadGuard<'_, T> {
    //     self.inner.read().await
    // }
    // pub async fn get_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, T> {
    //     self.inner.write().await
    // }
}

impl<T> Default for SharedUserContextContainer<T>
where
    T: Default,
{
    fn default() -> Self {
        Self {
            inner: Default::default(),
        }
    }
}

// #[derive(Trace, Finalize, JsData)]
// pub struct UserContextContainer<T> {
//     #[unsafe_ignore_trace]
//     pub inner: RwLock<T>,
// }

// impl<T> UserContextContainer<T> {
//     pub fn new(inner: T) -> Self {
//         UserContextContainer {
//             inner: RwLock::new(inner),
//         }
//     }
//     pub fn get(&self) -> tokio::sync::RwLockReadGuard<'_, T> {
//         self.inner.blocking_read()
//     }
//     pub fn get_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, T> {
//         self.inner.blocking_write()
//     }
// }

// impl<T> Default for UserContextContainer<T>
// where
//     T: Default,
// {
//     fn default() -> Self {
//         Self {
//             inner: Default::default(),
//         }
//     }
// }

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
        return ReadOnlyUserContextContainer { inner: inner };
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
    fn load_imported_module(
        &self,
        _referrer: Referrer,
        specifier: JsString,
        finish_load: Box<dyn FnOnce(JsResult<Module>, &mut Context)>,
        context: &mut Context,
    ) {
        let result: Result<Module, JsError> = (|| {
            let short_path = specifier.to_std_string_escaped();
            if let Some(module) = self.get(&short_path) {
                return Ok(module);
            }
            Err(JsError::from_native(JsNativeError::syntax().with_message(
                format!("could not parse module `{short_path}`"),
            )))
        })();
        finish_load(result, context);
    }

    fn register_module(&self, specifier: JsString, module: Module) {
        self.insert(specifier.to_std_string_escaped(), module);
    }

    fn get_module(&self, specifier: JsString) -> Option<Module> {
        self.get(&specifier.to_std_string_escaped())
    }
}

pub struct Queue {
    async_jobs: RefCell<VecDeque<NativeAsyncJob>>,
    promise_jobs: RefCell<VecDeque<PromiseJob>>,
}

impl Queue {
    pub fn new() -> Self {
        Self {
            async_jobs: RefCell::default(),
            promise_jobs: RefCell::default(),
        }
    }

    fn drain_jobs(&self, context: &mut Context) {
        let jobs = std::mem::take(&mut *self.promise_jobs.borrow_mut());
        for job in jobs {
            if let Err(e) = job.call(context) {
                eprintln!("Uncaught {e}");
            }
        }
    }
}

impl JobExecutor for Queue {
    fn enqueue_job(&self, job: Job, _context: &mut Context) {
        match job {
            Job::PromiseJob(job) => self.promise_jobs.borrow_mut().push_back(job),
            Job::AsyncJob(job) => self.async_jobs.borrow_mut().push_back(job),
            _ => panic!("unsupported job type"),
        }
    }

    // While the sync flavor of `run_jobs` will block the current thread until all the jobs have finished...
    fn run_jobs(&self, context: &mut Context) -> JsResult<()> {
        let runtime = tokio::runtime::Builder::new_current_thread()
            .enable_time()
            .build()
            .unwrap();

        task::LocalSet::default().block_on(&runtime, self.run_jobs_async(&RefCell::new(context)))
    }

    // ...the async flavor won't, which allows concurrent execution with external async tasks.
    fn run_jobs_async<'a, 'b, 'fut>(
        &'a self,
        context: &'b RefCell<&mut Context>,
    ) -> Pin<Box<dyn Future<Output = JsResult<()>> + 'fut>>
    where
        'a: 'fut,
        'b: 'fut,
    {
        Box::pin(async move {
            // Early return in case there were no jobs scheduled.
            if self.promise_jobs.borrow().is_empty() && self.async_jobs.borrow().is_empty() {
                return Ok(());
            }
            let mut group = FutureGroup::new();
            loop {
                for job in std::mem::take(&mut *self.async_jobs.borrow_mut()) {
                    group.insert(job.call(context));
                }

                if self.promise_jobs.borrow().is_empty() {
                    let Some(result) = group.next().await else {
                        // Both queues are empty. We can exit.
                        return Ok(());
                    };

                    if let Err(err) = result {
                        eprintln!("Uncaught {err}");
                    }

                    continue;
                }
                // We have some jobs pending on the microtask queue. Try to poll the pending
                // tasks once to see if any of them finished, and run the pending microtasks
                // otherwise.
                let Some(result) = future::poll_once(group.next()).await.flatten() else {
                    // No completed jobs. Run the microtask queue once.
                    self.drain_jobs(&mut context.borrow_mut());

                    task::yield_now().await;
                    continue;
                };

                if let Err(err) = result {
                    eprintln!("Uncaught {err}");
                }

                // Only one macrotask can be executed before the next drain of the microtask queue.
                self.drain_jobs(&mut context.borrow_mut());
            }
        })
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
            Err(err) => match err.try_native(context) {
                Ok(err) => Err(anyhow!(err.message().to_string())),
                Err(err) => Err(anyhow!(err.to_string())),
            },
        }
    }

    fn map_anyhow(self) -> Result<T> {
        match self {
            Ok(val) => Ok(val),
            Err(err) => match err.as_native() {
                Some(err) => Err(anyhow!(err.message().to_string())),
                None => Err(anyhow!("Unkown Error")),
            },
        }
    }
}
