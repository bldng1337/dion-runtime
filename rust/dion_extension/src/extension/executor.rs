use std::collections::HashMap;
use std::rc::Rc;
use std::sync::Arc;

use crate::extension::container::{DionExtension, ExtensionRuntimeData};
use crate::extension_executor::JSExecutor;
use crate::js;
use crate::utils::{
    MapJsResult, Queue, ReadOnlyUserContextContainer, VirtualModuleLoader, await_promise,
};
use anyhow::{Context as ErrorContext, Result, anyhow};
use boa_engine::property::Attribute;
use boa_engine::value::TryIntoJs;
use boa_engine::{Context, JsObject, JsValue, Module, js_string};
use boa_runtime::Console;
use dion_runtime::data::action::{EventData, EventResult};
use dion_runtime::data::activity::EntryActivity;
use dion_runtime::data::settings::Setting;
use dion_runtime::data::source::{
    EntryDetailed, EntryDetailedResult, EntryId, EntryList, EpisodeId, Source, SourceResult,
};
use serde::de::DeserializeOwned;
use serde_json::Value;
use tokio::sync::oneshot::Sender;
use tokio_util::sync::CancellationToken;

#[derive(Debug)]
pub(super) enum Task {
    Browse {
        page: i32,

        token: Option<CancellationToken>,
        send: Sender<Result<EntryList>>,
    },
    Search {
        page: i32,
        filter: String,

        token: Option<CancellationToken>,
        send: Sender<Result<EntryList>>,
    },
    Event {
        event: EventData,

        token: Option<CancellationToken>,
        send: Sender<Result<Option<EventResult>>>,
    },
    HandleUrl {
        url: String,

        token: Option<CancellationToken>,
        send: Sender<Result<bool>>,
    },
    Source {
        epid: EpisodeId,
        settings: HashMap<String, Setting>,

        token: Option<CancellationToken>,
        send: Sender<Result<SourceResult>>,
    },
    Detail {
        entryid: EntryId,
        settings: HashMap<String, Setting>,

        token: Option<CancellationToken>,
        send: Sender<Result<EntryDetailedResult>>,
    },
    MapEntry {
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
        send: Sender<Result<EntryDetailedResult>>,
    },
    OnEntryActivity {
        activity: EntryActivity,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
        send: Sender<Result<()>>,
    },
    ProcessSource {
        source: Source,
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
        send: Sender<Result<SourceResult>>,
    },
}

pub(super) struct ExtensionExecutor {
    code: String,
    data: Arc<ExtensionRuntimeData>,
}

impl ExtensionExecutor {
    pub(super) fn create(ext: &DionExtension) -> Self {
        Self {
            code: ext.code.clone(),
            data: ext.data.clone(),
        }
    }

    async fn get_plugin(context: &mut Context) -> Result<JsObject> {
        let val = context
            .global_object()
            .get(js_string!("__plugin"), context)
            .map_anyhow_ctx(context)
            .context("Failed to get extension in JS VM")?;
        Ok(val
            .as_object()
            .ok_or(anyhow!("__plugin is not an object"))
            .context("Extension not an object")?
            .clone())
    }

    async fn exec<T: DeserializeOwned>(
        context: &mut Context,
        func: &str,
        args: &[JsValue],
        token: Option<CancellationToken>,
    ) -> Result<T> {
        match token {
            Some(tok) => context
                .insert_data::<CancellationTokenContainer>(ReadOnlyUserContextContainer::new(tok)),
            None => context.remove_data::<CancellationTokenContainer>(),
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
        let ret = serde_json::from_value(match json {
            Some(val) => val,
            None => Value::Null,
        })?;
        Ok(ret)
    }
}

pub(crate) type CancellationTokenContainer = ReadOnlyUserContextContainer<CancellationToken>;
pub type ExtensionRuntimeDataContainer = ReadOnlyUserContextContainer<Arc<ExtensionRuntimeData>>;

#[async_trait::async_trait(?Send)]
impl JSExecutor<Task> for ExtensionExecutor {
    async fn init(&self) -> Result<Context> {
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
        ctx.strict(true);

        let container = ExtensionRuntimeDataContainer::new(self.data.clone());
        ctx.insert_data::<ExtensionRuntimeDataContainer>(container);

        let console = Console::init(&mut ctx);
        ctx.register_global_property(Console::NAME, console, Attribute::all())
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to init console")?;
        js::declare(&mut ctx, &loader)?;

        let module = Module::parse(boa_engine::Source::from_bytes(&self.code), None, &mut ctx)
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

            if let Some(promise) = val.as_promise() {
                await_promise(promise, &mut ctx)
                    .await
                    .map_anyhow_ctx(&mut ctx)
                    .context("Extension failed loading")?;
            }
        }
        Ok(ctx)
    }

    async fn handle(&self, value: Task, context: &mut Context) {
        match value {
            Task::Browse { page, token, send } => {
                let vals = &[page.into()];
                let browse_res = Self::exec(context, "browse", vals, token).await;
                let _ = send.send(browse_res);
            }
            Task::Search {
                page,
                filter,
                token,
                send,
            } => {
                let res = async {
                    let vals = [
                        page.into(),
                        filter
                            .try_into_js(context)
                            .map_anyhow_ctx(context)
                            .context("Failed to convert filter to js")?,
                    ];
                    Self::exec(context, "search", &vals, token).await
                }
                .await;
                let _ = send.send(res);
            }
            Task::HandleUrl { url, token, send } => {
                let res = async {
                    let vals = &[url
                        .try_into_js(context)
                        .map_anyhow_ctx(context)
                        .context("Failed to convert url to js")?];
                    Self::exec(context, "handleUrl", vals, token)
                        .await
                        .context("Failed to call handleUrl")
                }
                .await;
                let _ = send.send(res);
            }
            Task::Event { event, token, send } => {
                let res = async {
                    let vals = &[JsValue::from_json(
                        &serde_json::to_value(event)
                            .context("Failed to convert Entry to serde Value")?,
                        context,
                    )
                    .map_anyhow_ctx(context)
                    .context("Failed to convert Entry to js")?];
                    Self::exec(context, "onEvent", vals, token)
                        .await
                        .context("Failed to call handleUrl")
                }
                .await;
                let _ = send.send(res);
            }
            Task::Detail {
                entryid,
                token,
                settings,
                send,
            } => {
                let res = async {
                    let vals = &[
                        JsValue::from_json(
                            &serde_json::to_value(entryid)
                                .context("Failed to convert EntryId to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert EntryId to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(settings)
                                .context("Failed to convert Settings to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Settings to js")?,
                    ];
                    Self::exec(context, "detail", vals, token)
                        .await
                        .context("Failed to call detail")
                }
                .await;
                let _ = send.send(res);
            }
            Task::Source {
                epid,
                settings,
                token,
                send,
            } => {
                let res = async {
                    let vals = &[
                        JsValue::from_json(
                            &serde_json::to_value(epid)
                                .context("Failed to convert EntryId to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert EpisodeId to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(settings)
                                .context("Failed to convert Settings to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Settings to js")?,
                    ];
                    Self::exec::<SourceResult>(context, "source", vals, token)
                        .await
                        .context("Failed to call source")
                }
                .await;
                let _ = send.send(res);
            }
            Task::MapEntry {
                entry,
                settings,
                token,
                send,
            } => {
                let res = async {
                    let vals = &[
                        JsValue::from_json(
                            &serde_json::to_value(entry)
                                .context("Failed to convert Entry to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Entry to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(settings)
                                .context("Failed to convert Settings to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Settings to js")?,
                    ];
                    Self::exec(context, "mapEntry", vals, token)
                        .await
                        .context("Failed to call mapEntry")
                }
                .await;
                let _ = send.send(res);
            }
            Task::OnEntryActivity {
                activity,
                entry,
                settings,
                token,
                send,
            } => {
                let res = async {
                    let vals = &[
                        JsValue::from_json(
                            &serde_json::to_value(activity)
                                .context("Failed to convert EntryActivity to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert EntryActivity to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(entry)
                                .context("Failed to convert Entry to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Entry to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(settings)
                                .context("Failed to convert Settings to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Settings to js")?,
                    ];
                    Self::exec(context, "onEntryActivity", vals, token)
                        .await
                        .context("Failed to call onEntryActivity")
                }
                .await;
                let _ = send.send(res);
            }
            Task::ProcessSource {
                source,
                epid,
                settings,
                token,
                send,
            } => {
                let res = async {
                    let vals = &[
                        JsValue::from_json(
                            &serde_json::to_value(source)
                                .context("Failed to convert Source to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert EpisodeId to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(epid)
                                .context("Failed to convert EpisodeId to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Source to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(settings)
                                .context("Failed to convert Settings to serde Value")?,
                            context,
                        )
                        .map_anyhow_ctx(context)
                        .context("Failed to convert Settings to js")?,
                    ];
                    Self::exec(context, "mapSource", vals, token)
                        .await
                        .context("Failed to call mapSource")
                }
                .await;
                let _ = send.send(res);
            }
        }
    }
}
