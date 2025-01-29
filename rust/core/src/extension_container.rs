use std::convert;
use std::path::PathBuf;
use std::rc::Rc;
use std::sync::Arc;

use boa_engine::ast::operations::contains;
use boa_engine::property::Attribute;
use boa_engine::value::TryIntoJs;
use boa_engine::{context, js_string, Context, JsObject, JsString, JsValue, Module};
use boa_runtime::Console;
use serde_json::Value;
use tokio::fs;
use tokio::runtime::Builder;
use tokio::sync::{mpsc, oneshot::Sender, RwLock};
use tokio::sync::{oneshot, RwLockReadGuard, RwLockWriteGuard};
use tokio::task::LocalSet;
use tokio_util::sync::CancellationToken;

use crate::datastructs::{self, Entry, EntryDetailed, ExtensionData, Sort, Source};
use crate::error::{Error, Result};
use crate::extension::TExtension;
use crate::extension_manager::JSExtension;
use crate::utils::{
    await_promise, Queue, ReadOnlyUserContextContainer, SharedUserContextContainer,
    VirtualModuleLoader,
};
use crate::{convert_js, networking_js, permission_js, setting_js};

#[derive(Debug)]
enum Task {
    Browse {
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>,
        send: Sender<Result<Vec<Entry>>>,
    },
    Search {
        page: i64,
        filter: String,
        token: Option<CancellationToken>,
        send: Sender<Result<Vec<Entry>>>,
    },
    FromUrl {
        url: String,
        token: Option<CancellationToken>,
        send: Sender<Result<Option<Entry>>>,
    },
    Source {
        epid: String,
        token: Option<CancellationToken>,
        send: Sender<Result<Source>>,
    },
    Detail {
        entryid: String,
        token: Option<CancellationToken>,
        send: Sender<Result<EntryDetailed>>,
    },
}

#[derive(Clone)]
pub struct ExtensionContainer {
    send: Option<mpsc::UnboundedSender<Task>>,
    ext: Arc<RwLock<JSExtension>>,
    code: String,
}

impl ExtensionContainer {
    pub async fn get_extension(&self) -> RwLockReadGuard<'_, JSExtension> {
        self.ext.read().await
    }

    pub async fn get_extension_mut(&self) -> RwLockWriteGuard<'_, JSExtension> {
        self.ext.write().await
    }

    pub(crate) async fn create(path: PathBuf) -> Result<Self> {
        let contents: String = String::from_utf8(fs::read(path).await?)?;
        let data: ExtensionData = serde_json::from_str(
            contents
                .lines()
                .next()
                .unwrap_or_default()
                .strip_prefix("//")
                .unwrap_or_default(),
        )?;
        let ext = JSExtension {
            //TODO: Save permission and setting
            data: data,
            permission: Default::default(),
            setting: Default::default(),
        };
        Ok(Self {
            ext: Arc::new(RwLock::new(ext)),
            send: None,
            code: contents,
        })
    }

    fn disable(&mut self) {
        self.send = None;
    }

    async fn enable(&mut self) -> Result<()> {
        let (send, mut recv) = mpsc::unbounded_channel();
        let rt = Builder::new_current_thread().enable_all().build().unwrap();
        let ext = self.ext.clone();
        let code = self.code.clone();
        let (isend, iresponse) = oneshot::channel();
        std::thread::spawn(move || {
            let local = LocalSet::new();
            let ext = ext;
            let code = code;

            local.spawn_local(async move {
                let ext = ext;
                let code = code;
                let mut context = match Self::get_context(ext, &code).await {
                    Ok(context) => {
                        let _ = isend.send(Ok(()));
                        context
                    }
                    Err(err) => {
                        let _ = isend.send(Err(err));
                        panic!();
                    }
                };

                while let Some(new_task) = recv.recv().await {
                    match new_task {
                        Task::Browse {
                            page,
                            sort,
                            token,
                            send,
                        } => {
                            let _ =
                                send.send(Self::do_browse(&mut context, page, sort, token).await);
                        }
                        Task::Search {
                            page,
                            filter,
                            token,
                            send,
                        } => {
                            let _ =
                                send.send(Self::do_search(&mut context, page, filter, token).await);
                        }
                        Task::FromUrl { url, token, send } => {
                            let _ = send.send(Self::do_fromurl(&mut context, url, token).await);
                        }
                        Task::Detail {
                            entryid,
                            token,
                            send,
                        } => {
                            let _ = send.send(Self::do_detail(&mut context, entryid, token).await);
                        }
                        Task::Source { epid, token, send } => {
                            let _ = send.send(Self::do_source(&mut context, epid, token).await);
                        }
                    }
                    // tokio::task::spawn_local(run_task(new_task, ext, code));
                }
                // If the while loop returns, then all the LocalSpawner
                // objects have been dropped.
            });

            // This will return once all senders are dropped and all
            // spawned tasks have returned.
            rt.block_on(local);
        });
        match iresponse.await {
            Ok(Ok(_)) => {
                self.send = Some(send);
                Ok(())
            }
            Ok(Err(err)) => Err(err),
            Err(err) => Err(err.into()),
        }
    }

    async fn get_context(ext: Arc<RwLock<JSExtension>>, code: &String) -> Result<Context> {
        let queue = Queue::new();
        let mut ctx = Context::builder()
            .job_executor(Rc::new(queue))
            .module_loader(Rc::new(VirtualModuleLoader::new()?))
            .build()?;
        let context = &mut ctx;
        let a = SharedUserContextContainer::from(ext);
        context.insert_data::<SharedUserContextContainer<JSExtension>>(a);
        context.strict(true);
        let console = Console::init(context);
        context
            .register_global_property(Console::NAME, console, Attribute::all())
            .expect("the console builtin shouldn't exist");
        context.eval(boa_engine::Source::from_bytes(
            "const print=(a)=>console.log(a);",
        ))?;
        networking_js::declare(context)?;
        permission_js::declare(context)?;
        setting_js::declare(context)?;
        convert_js::declare(context)?;
        let module = Module::parse(boa_engine::Source::from_bytes(code.as_str()), None, context)?;
        context
            .module_loader()
            .register_module(js_string!("extension"), module.clone());
        let promise = module.load_link_evaluate(context);
        await_promise(promise, context)
            .await
            .map_err(|e| Error::JSEngineData(e.to_string()))?;
        let val = module.get_value(js_string!("default"), context)?;
        let class = val.as_constructor().ok_or(Error::ExtensionError(
            "pluginclass is not a constructor".to_string(),
        ))?;
        let plugin = class.construct(&[], None, context)?;
        context
            .global_object()
            .set(js_string!("__plugin"), plugin.clone(), true, context)?;
        if plugin.has_property(js_string!("load"), context)? {
            let val = plugin
                .get(js_string!("load"), context)?
                .as_callable()
                .ok_or(Error::ExtensionError("load is not a function".to_string()))?
                .call(&plugin.into(), &[], context)?;
            // context.run_jobs_async().await?;
            if val.is_promise() {
                let val = val.as_promise().unwrap();
                // val.await_blocking(context)
                await_promise(val, context)
                    .await
                    .map_err(|e| Error::JSEngineData(e.to_string()))?;
            }
        }
        Ok(ctx)
    }

    async fn get_plugin(context: &mut Context) -> Result<JsObject> {
        let val = context
            .global_object()
            .get(js_string!("__plugin"), context)?;

        match val.is_object() {
            true => Ok(val.as_object().unwrap().clone()), //TODO: remove clone
            _ => Err(Error::ExtensionError(
                "Extension not properly created".to_string(),
            )),
        }
    }

    async fn exec(
        context: &mut Context,
        func: JsString,
        args: &[JsValue],
        token: Option<CancellationToken>,
    ) -> Result<Value> {
        match token {
            Some(tok) => context.insert_data(ReadOnlyUserContextContainer::new(tok)),
            None => context.remove_data::<ReadOnlyUserContextContainer<CancellationToken>>(),
        };
        let plugin = Self::get_plugin(context).await?;
        let asd = plugin
            .get(func.clone(), context)?
            .as_callable()
            .ok_or(Error::ExtensionError(format!(
                "Couldnt find function {}",
                func.to_std_string_lossy()
            )))?
            .call(&plugin.into(), args, context)?
            .as_promise()
            .ok_or(Error::ExtensionError(format!(
                "Function {} didnt return a Promise or is not async",
                func.to_std_string_lossy()
            )))?;
        let val = await_promise(asd, context)
            .await
            .map_err(|e| Error::ExtensionError(e.to_string()))?;
        Ok(val.to_json(context)?)
    }

    async fn do_browse(
        context: &mut Context,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        let vals = &[page.into(), sort.try_into_js(context)?];
        Ok(serde_json::from_value(
            Self::exec(context, js_string!("browse"), vals, token).await?,
        )?)
    }

    async fn do_search(
        context: &mut Context,
        page: i64,
        filter: String,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        let vals = &[page.into(), filter.try_into_js(context)?];
        Ok(serde_json::from_value(
            Self::exec(context, js_string!("search"), vals, token).await?,
        )?)
    }

    async fn do_detail(
        context: &mut Context,
        entryid: String,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed> {
        let vals = &[entryid.try_into_js(context)?];
        Ok(serde_json::from_value(
            Self::exec(context, js_string!("detail"), vals, token).await?,
        )?)
    }

    async fn do_source(
        context: &mut Context,
        epid: String,
        token: Option<CancellationToken>,
    ) -> Result<datastructs::Source> {
        let vals = &[epid.try_into_js(context)?];
        Ok(serde_json::from_value(
            Self::exec(context, js_string!("source"), vals, token).await?,
        )?)
    }

    async fn do_fromurl(
        context: &mut Context,
        url: String,
        token: Option<CancellationToken>,
    ) -> Result<Option<Entry>> {
        let vals = &[url.try_into_js(context)?];
        Ok(serde_json::from_value(
            Self::exec(context, js_string!("fromurl"), vals, token).await?,
        )?)
    }
}

#[async_trait::async_trait()]
impl TExtension for ExtensionContainer {
    fn is_enabled(&self) -> bool {
        self.send
            .as_ref()
            .map(|send| send.is_closed())
            .unwrap_or(false)
    }

    async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        match (enabled, self.is_enabled()) {
            (true, true) => Ok(()),
            (false, false) => Ok(()),
            (true, false) => self.enable().await,
            (false, true) => Ok(self.disable()),
        }
    }

    async fn get_data(&self) -> datastructs::ExtensionData {
        self.ext.read().await.data.clone()
    }

    async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        if self.is_enabled() {
            return Err(Error::ExtensionError("()".to_string()));
        }
        let (send, response) = oneshot::channel();
        self.send.as_ref().unwrap().send(Task::Browse {
            page: page,
            sort: sort,
            token: token,
            send: send,
        });
        response.await?
    }

    async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        if self.is_enabled() {
            return Err(Error::ExtensionError("()".to_string()));
        }
        let (send, response) = oneshot::channel();
        self.send.as_ref().unwrap().send(Task::Search {
            page: page,
            filter: filter.to_string(),
            token: token,
            send: send,
        });
        response.await?
    }

    async fn detail(
        &self,
        entryid: &str,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed> {
        if self.is_enabled() {
            return Err(Error::ExtensionError("()".to_string()));
        }
        let (send, response) = oneshot::channel();
        self.send.as_ref().unwrap().send(Task::Detail {
            entryid: entryid.to_string(),
            token: token,
            send: send,
        });
        response.await?
    }

    async fn source(
        &self,
        epid: &String,
        token: Option<CancellationToken>,
    ) -> Result<datastructs::Source> {
        if self.is_enabled() {
            return Err(Error::ExtensionError("()".to_string()));
        }
        let (send, response) = oneshot::channel();
        self.send.as_ref().unwrap().send(Task::Source {
            epid: epid.clone(),
            token: token,
            send: send,
        });
        response.await?
    }

    async fn fromurl(
        &self,
        url: String,
        token: Option<CancellationToken>,
    ) -> Result<Option<Entry>> {
        if self.is_enabled() {
            return Err(Error::ExtensionError("()".to_string()));
        }
        let (send, response) = oneshot::channel();
        self.send.as_ref().unwrap().send(Task::FromUrl {
            url: url,
            token: token,
            send: send,
        });
        response.await?
    }
}
