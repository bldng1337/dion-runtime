use std::collections::HashMap;
use std::panic;
use std::path::PathBuf;
use std::rc::Rc;
use std::sync::Arc;

use crate::data::datastructs::{Entry, EntryDetailed, ExtensionData, Sort, Source};
use crate::data::permission::PermissionStore;
use crate::data::settings::{Setting, SettingStore};
use crate::extension::utils::{
    await_promise, Queue, ReadOnlyUserContextContainer, SharedUserContextContainer,
    VirtualModuleLoader,
};
use crate::js;
use anyhow::{anyhow, Context as ErrorContext, Result};
use boa_engine::property::Attribute;
use boa_engine::value::TryIntoJs;
use boa_engine::{js_string, Context, JsObject, JsValue, Module};
use boa_runtime::Console;
use log::error;
use serde_json::Value;
use tokio::fs;
use tokio::runtime::Builder;
use tokio::sync::{mpsc, oneshot::Sender, RwLock};
use tokio::sync::{oneshot, RwLockReadGuard, RwLockWriteGuard};
use tokio::task::LocalSet;
use tokio_util::sync::CancellationToken;

use super::extension_trait::TSourceExtension;
use super::utils::MapJsResult;

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
        settings: HashMap<String, Setting>,

        token: Option<CancellationToken>,
        send: Sender<Result<Source>>,
    },
    Detail {
        entryid: String,
        settings: HashMap<String, Setting>,

        token: Option<CancellationToken>,
        send: Sender<Result<EntryDetailed>>,
    },
}
pub struct JSSourceExtension {
    pub data: ExtensionData,
    pub permission: PermissionStore,
    pub setting: SettingStore,
}

#[derive(Clone)]
pub struct ExtensionContainer {
    send: Option<mpsc::UnboundedSender<Task>>,
    ext: Arc<RwLock<JSSourceExtension>>,
    code: String,
}

impl ExtensionContainer {
    pub async fn get_extension(&self) -> RwLockReadGuard<'_, JSSourceExtension> {
        self.ext.read().await
    }

    pub async fn get_extension_mut(&self) -> RwLockWriteGuard<'_, JSSourceExtension> {
        self.ext.write().await
    }

    pub(crate) async fn create(path: PathBuf) -> Result<Self> {
        let contents: String = String::from_utf8(fs::read(&path).await?)?;
        let data: ExtensionData = serde_json::from_str(
            contents
                .lines()
                .next()
                .unwrap_or_default()
                .strip_prefix("//")
                .unwrap_or_default(),
        )
        .context("Failed to read ExtensionData")?;
        let ext = JSSourceExtension {
            data,
            permission: PermissionStore::new(path.with_extension("permission.json"))
                .await
                .context("Failed to initialise Permission Store")?,
            setting: SettingStore::new(path.with_extension("setting.json"))
                .await
                .context("Failed to initialise Settings Store")?,
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
        let ext: Arc<RwLock<JSSourceExtension>> = self.ext.clone();
        let code = self.code.clone();
        let (isend, iresponse) = oneshot::channel();
        let isend = isend;
        let extname = self.ext.read().await.data.name.clone();
        std::thread::spawn(move || {
            let orig_hook = panic::take_hook();
            panic::set_hook(Box::new(move |panic_info| {
                error!("Extension Thread for {extname} panicked {panic_info}");
                orig_hook(panic_info);
            }));
            let rt = Builder::new_current_thread().enable_all().build().unwrap();
            let local = LocalSet::new();
            let ext = ext;
            let isend = isend;
            let code = code;
            local.spawn_local(async move {
                let ext = ext;
                let code = code;
                let isend = isend;

                let mut context = match Self::get_context(ext, &code).await {
                    Ok(context) => {
                        let res = isend.send(Ok(()));
                        if let Some(err) = res.err().and_then(|a| a.err()) {
                            error!("Failed to send channel back {err}");
                        }
                        context
                    }
                    Err(err) => {
                        let res = isend.send(Err(err));
                        if let Some(err) = res.err().and_then(|a| a.err()) {
                            error!("Failed to send channel back {err}");
                        }
                        return;
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
                            settings,
                            send,
                        } => {
                            let _ = send.send(
                                Self::do_detail(&mut context, entryid, settings, token).await,
                            );
                        }
                        Task::Source {
                            epid,
                            settings,
                            token,
                            send,
                        } => {
                            let _ = send
                                .send(Self::do_source(&mut context, epid, settings, token).await);
                        }
                    }
                }
            });
            rt.block_on(local);
        });
        iresponse
            .await
            .context("Message channel to extension thread failed")?
            .context("Extension failed to startup")?;

        self.send = Some(send);
        Ok(())
    }

    async fn get_context(ext: Arc<RwLock<JSSourceExtension>>, code: &str) -> Result<Context> {
        let queue = Queue::new();
        let loader: Rc<VirtualModuleLoader> = Rc::new(
            VirtualModuleLoader::new()
                .map_anyhow()
                .context("Failed to init VirtualModuleLoader")?,
        );
        let mut ctx = Context::builder()
            .job_executor(Rc::new(queue))
            .module_loader(loader.clone())
            .build()
            .map_anyhow()
            .context("Failed to build JsContext")?;
        let a = SharedUserContextContainer::from(ext);
        ctx.insert_data::<SharedUserContextContainer<JSSourceExtension>>(a);
        ctx.strict(true);
        let console = Console::init(&mut ctx);
        ctx.register_global_property(Console::NAME, console, Attribute::all())
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to init console")?;
        js::declare(&mut ctx, &loader)?;
        let module = Module::parse(boa_engine::Source::from_bytes(code), None, &mut ctx)
            .map_anyhow_ctx(&mut ctx)
            .context("Failed parsing Extension Source Code")?;
        loader.insert("extension".to_string(), module.clone());
        let promise = module.load_link_evaluate(&mut ctx);
        await_promise(promise, &mut ctx)
            .await
            .map_anyhow_ctx(&mut ctx)
            .context("Failed evaluating Extension Source")?;
        let val = module
            .get_value(js_string!("default"), &mut ctx)
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to get Extension class")?;
        let class = val
            .as_constructor()
            .ok_or(anyhow!("Pluginclass is not a constructor"))?;
        let plugin = class
            .construct(&[], None, &mut ctx)
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to construct Extension Class")?;
        ctx.global_object()
            .set(js_string!("__plugin"), plugin.clone(), true, &mut ctx)
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to set plugin var")?;
        if plugin
            .has_property(js_string!("load"), &mut ctx)
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to check for load function")?
        {
            let val = plugin
                .get(js_string!("load"), &mut ctx)
                .map_anyhow_ctx(&mut ctx)
                .context("Failed to get load function")?
                .as_callable()
                .ok_or(anyhow!("field load is not a function"))?
                .call(&plugin.into(), &[], &mut ctx)
                .map_anyhow_ctx(&mut ctx)
                .context("Failed to call load")?;
            // context.run_jobs_async().await?;
            if val.is_promise() {
                let val = val.as_promise().unwrap();
                // val.await_blocking(context)
                await_promise(val, &mut ctx)
                    .await
                    .map_anyhow_ctx(&mut ctx)
                    .context("Extension failed loading")?;
            }
        }
        Ok(ctx)
    }

    async fn get_plugin(context: &mut Context) -> Result<JsObject> {
        let val = context
            .global_object()
            .get(js_string!("__plugin"), context)
            .map_anyhow_ctx(context)
            .context("Failed to get extension in JS VM")?;
        Ok(val
            .as_object()
            .ok_or(anyhow!("field load is not a function"))
            .context("Extension not an object")?
            .clone())
    }

    async fn exec(
        context: &mut Context,
        func: &str,
        args: &[JsValue],
        token: Option<CancellationToken>,
    ) -> Result<Value> {
        match token {
            Some(tok) => context.insert_data(ReadOnlyUserContextContainer::new(tok)),
            None => context.remove_data::<ReadOnlyUserContextContainer<CancellationToken>>(),
        };
        let plugin = Self::get_plugin(context).await?;
        let asd = plugin
            .get(js_string!(func), context)
            .map_anyhow_ctx(context)
            .context(format!("Failed to get Function {func}"))?
            .as_callable()
            .ok_or(anyhow!("Function {func} is not callable "))?
            .call(&plugin.into(), args, context)
            .map_anyhow_ctx(context)
            .context(format!("Failed sync call of Function {func}"))?
            .as_promise()
            .ok_or(anyhow!(
                "Function {func} didnt return a Promise or is not async"
            ))?;
        let val = await_promise(asd, context)
            .await
            .map_anyhow_ctx(context)
            .context(format!("Error while evaluating {func}"))?;
        let json = val
            .to_json(context)
            .map_anyhow_ctx(context)
            .context(format!("Failed to convert result of {func}"))?;
        match json {
            Some(val) => Ok(val),
            None => Ok(Value::Null),
        }
    }

    async fn do_browse(
        context: &mut Context,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        let vals = &[
            page.into(),
            sort.try_into_js(context)
                .map_anyhow_ctx(context)
                .context("Failed to convert Sort to js")?,
        ];
        Ok(serde_json::from_value(
            Self::exec(context, "browse", vals, token).await?,
        )?)
    }

    async fn do_search(
        context: &mut Context,
        page: i64,
        filter: String,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        let vals = &[
            page.into(),
            filter
                .try_into_js(context)
                .map_anyhow_ctx(context)
                .context("Failed to convert filter to js")?,
        ];
        Ok(serde_json::from_value(
            Self::exec(context, "search", vals, token).await?,
        )?)
    }

    async fn do_detail(
        context: &mut Context,
        entryid: String,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed> {
        let vals = &[
            entryid
                .try_into_js(context)
                .map_anyhow_ctx(context)
                .context("Failed to convert entryid to js")?,
            JsValue::from_json(
                &serde_json::to_value(settings)
                    .context("Failed to convert Settings to serde Value")?,
                context,
            )
            .map_anyhow_ctx(context)
            .context("Failed to convert Settings to js")?,
        ];
        serde_json::from_value(
            Self::exec(context, "detail", vals, token)
                .await
                .context("Failed to call detail")?,
        )
        .context("Failed to parse Result of detail")
    }

    async fn do_source(
        context: &mut Context,
        epid: String,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<Source> {
        let vals = &[
            epid.try_into_js(context)
                .map_anyhow_ctx(context)
                .context("Failed to convert epid to js")?,
            JsValue::from_json(
                &serde_json::to_value(settings)
                    .context("Failed to convert Settings to serde Value")?,
                context,
            )
            .map_anyhow_ctx(context)
            .context("Failed to convert Settings to js")?,
        ];
        serde_json::from_value(
            Self::exec(context, "source", vals, token)
                .await
                .context("Failed to call source")?,
        )
        .context("Failed to parse Result of source")
    }

    async fn do_fromurl(
        context: &mut Context,
        url: String,
        token: Option<CancellationToken>,
    ) -> Result<Option<Entry>> {
        let vals = &[url
            .try_into_js(context)
            .map_anyhow_ctx(context)
            .context("Failed to convert url to js")?];
        serde_json::from_value(
            Self::exec(context, "fromurl", vals, token)
                .await
                .context("Failed to call fromurl")?,
        )
        .context("Failed to parse Result of fromurl")
    }
}

#[async_trait::async_trait()]
impl TSourceExtension for ExtensionContainer {
    fn is_enabled(&self) -> bool {
        self.send
            .as_ref()
            .map(|send| !send.is_closed())
            .unwrap_or(false)
    }

    async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        match (enabled, self.is_enabled()) {
            (true, true) => Ok(()),
            (false, false) => Ok(()),
            (true, false) => self.enable().await,
            (false, true) => {
                self.disable();
                Ok(())
            }
        }
    }

    async fn get_data(&self) -> ExtensionData {
        self.ext.read().await.data.clone()
    }

    async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        if !self.is_enabled() {
            return Err(anyhow!("Extension is not enabled"));
        }
        let (send, response) = oneshot::channel();
        self.send
            .as_ref()
            .unwrap()
            .send(Task::Browse {
                page,
                sort,
                token,
                send,
            })
            .context("Failed to send message to Extension Thread")?;
        response.await?
    }

    async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>> {
        if !self.is_enabled() {
            return Err(anyhow!("Extension is not enabled"));
        }
        let (send, response) = oneshot::channel();
        self.send
            .as_ref()
            .unwrap()
            .send(Task::Search {
                page,
                filter: filter.to_string(),
                token,
                send,
            })
            .context("Failed to send message to Extension Thread")?;
        response.await?
    }

    async fn detail(
        &self,
        entryid: &str,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed> {
        if !self.is_enabled() {
            return Err(anyhow!("Extension is not enabled"));
        }
        let (send, response) = oneshot::channel();
        self.send
            .as_ref()
            .unwrap()
            .send(Task::Detail {
                entryid: entryid.to_string(),
                settings,
                token,
                send,
            })
            .context("Failed to send message to Extension Thread")?;
        response.await?
    }

    async fn source(
        &self,
        epid: &str,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<Source> {
        if !self.is_enabled() {
            return Err(anyhow!("Extension is not enabled"));
        }
        let (send, response) = oneshot::channel();
        self.send
            .as_ref()
            .unwrap()
            .send(Task::Source {
                epid: epid.to_string(),
                settings,
                token,
                send,
            })
            .context("Failed to send message to Extension Thread")?;
        response.await?
    }

    async fn fromurl(&self, url: &str, token: Option<CancellationToken>) -> Result<Option<Entry>> {
        if !self.is_enabled() {
            return Err(anyhow!("Extension is not enabled"));
        }
        let (send, response) = oneshot::channel();
        self.send
            .as_ref()
            .unwrap()
            .send(Task::FromUrl {
                url: url.to_string(),
                token,
                send,
            })
            .context("Failed to send message to Extension Thread")?;
        response.await?
    }
}
