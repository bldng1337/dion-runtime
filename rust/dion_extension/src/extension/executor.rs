use std::collections::HashMap;
use std::rc::Rc;
use std::sync::{Arc, Weak};

use crate::extension::container::{DionExtension, InnerExtension};
use crate::extension_executor::JSExecutor;
use crate::extension_manager::HostModule;
use crate::js;
use crate::proxy::{ProxyResult, request_to_value};
use crate::utils::{
    MapJsResult, Queue, ReadOnlyUserContextContainer, VirtualModuleLoader, await_promise,
    await_promise_cancellable,
};
use anyhow::{Context as ErrorContext, Result, anyhow};
use boa_engine::object::builtins::JsUint8Array;
use boa_engine::property::Attribute;
use boa_engine::value::TryIntoJs;
use boa_engine::{Context, JsError, JsNativeError, JsObject, JsResult, JsValue, Module, js_string};
use boa_runtime::Console;
use boa_runtime::extensions::{
    AbortControllerExtension, MicrotaskExtension, StructuredCloneExtension, TimeoutExtension,
};
use dion_runtime::data::action::{EventData, EventResult};
use dion_runtime::data::activity::EntryActivity;
use dion_runtime::data::auth::Account;
use dion_runtime::data::settings::Setting;
use dion_runtime::data::source::{
    EntryDetailed, EntryDetailedResult, EntryId, EntryList, EpisodeId, Source, SourceResult,
};
use hyper::Request;
use hyper::body::Bytes;
use serde::de::DeserializeOwned;
use serde_json::Value;
use tokio::sync::oneshot::Sender;
use tokio_util::sync::CancellationToken;
#[derive(Debug)]
pub(crate) enum Task {
    Validate {
        account: Account,

        token: Option<CancellationToken>,
        send: Sender<Result<Option<Account>>>,
    },
    HandleProxy {
        req: Request<String>,

        send: Sender<Result<ProxyResult>>,
    },
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
    Refresh {
        entry: EntryDetailed,
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
    data: Weak<InnerExtension>,
    host_modules: Arc<[HostModule]>,
}

impl ExtensionExecutor {
    pub(super) fn create(ext: &DionExtension) -> Self {
        Self {
            code: ext.code.clone(),
            data: Arc::downgrade(&ext.data),
            host_modules: ext.host_modules.clone(),
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

    /// Calls a plugin function and returns the raw JS value it resolved with
    /// (before any JSON conversion).
    async fn exec_value(
        context: &mut Context,
        func: &str,
        args: &[JsValue],
        token: Option<CancellationToken>,
    ) -> Result<JsValue> {
        if token.as_ref().is_some_and(CancellationToken::is_cancelled) {
            return Err(anyhow!("Task was cancelled before {func} started"));
        }
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
        await_promise_cancellable(asd, context, token.as_ref())
            .await
            .map_anyhow_ctx(context)
            .context(format!("Error while evaluating {func}"))
    }

    async fn exec_raw(
        context: &mut Context,
        func: &str,
        args: &[JsValue],
        token: Option<CancellationToken>,
    ) -> Result<Value> {
        let val = Self::exec_value(context, func, args, token).await?;
        let val = invoke_to_json_hooks(&val, context)
            .map_anyhow_ctx(context)
            .context(format!(
                "Failed to normalize toJSON values in {func} result"
            ))?;
        let json = val
            .to_json(context)
            .map_anyhow_ctx(context)
            .context(format!("Failed to convert result of {func}"))?;
        Ok(match json {
            Some(val) => val,
            None => Value::Null,
        })
    }

    async fn exec<T: DeserializeOwned>(
        context: &mut Context,
        func: &str,
        args: &[JsValue],
        token: Option<CancellationToken>,
    ) -> Result<T> {
        let val = Self::exec_raw(context, func, args, token).await?;
        let ret = serde_json::from_value(val)?;
        Ok(ret)
    }
}

pub type ExtensionRuntimeDataContainer = ReadOnlyUserContextContainer<Weak<InnerExtension>>;

fn invoke_to_json_hooks(value: &JsValue, context: &mut Context) -> JsResult<JsValue> {
    normalize_json_value(value, context, 0, &mut HashMap::new())
}

fn normalize_json_value(
    value: &JsValue,
    context: &mut Context,
    depth: usize,
    seen: &mut HashMap<JsObject, JsValue>,
) -> JsResult<JsValue> {
    const MAX_DEPTH: usize = 64;
    let Some(object) = value.as_object() else {
        return Ok(value.clone());
    };
    if depth > MAX_DEPTH {
        return Ok(value.clone());
    }
    if let Some(normalized) = seen.get(&object) {
        return Ok(normalized.clone());
    }
    seen.insert(object.clone(), value.clone());
    let normalized = normalize_json_object(&object, value, context, depth, seen)?;
    seen.insert(object, normalized.clone());
    Ok(normalized)
}

fn normalize_json_object(
    object: &JsObject,
    value: &JsValue,
    context: &mut Context,
    depth: usize,
    seen: &mut HashMap<JsObject, JsValue>,
) -> JsResult<JsValue> {
    let to_json = object.get(js_string!("toJSON"), context)?;
    if let Some(to_json) = to_json.as_callable() {
        let result = to_json.call(&object.clone().into(), &[], context)?;
        // The result itself may contain objects with `toJSON` hooks.
        return normalize_json_value(&result, context, depth + 1, seen);
    }
    if let Ok(array) = boa_engine::object::builtins::JsArray::from_object(object.clone()) {
        let length = array.length(context)?;
        let mut items = Vec::new();
        let mut changed = false;
        for index in 0..length {
            let item = array.at(index as i64, context)?;
            let converted = normalize_json_value(&item, context, depth + 1, seen)?;
            changed |= !JsValue::same_value(&item, &converted);
            items.push(converted);
        }
        if !changed {
            return Ok(value.clone());
        }
        return Ok(boa_engine::object::builtins::JsArray::from_iter(items, context).into());
    }
    // Plain object: visit enumerable own string keys via Object.keys.
    let object_ctor = context
        .global_object()
        .get(js_string!("Object"), context)?
        .as_object()
        .ok_or_else(|| {
            JsError::from_native(JsNativeError::error().with_message("Object global is missing"))
        })?;
    let keys_fn = object_ctor
        .get(js_string!("keys"), context)?
        .as_callable()
        .ok_or_else(|| {
            JsError::from_native(JsNativeError::error().with_message("Object.keys is missing"))
        })?
        .clone();
    let keys = keys_fn.call(&JsValue::undefined(), std::slice::from_ref(value), context)?;
    let Some(keys) = keys.as_object() else {
        return Ok(value.clone());
    };
    let keys = boa_engine::object::builtins::JsArray::from_object(keys).map_err(|_| {
        JsError::from_native(JsNativeError::error().with_message("Object.keys result"))
    })?;
    let length = keys.length(context)?;
    let mut entries = Vec::new();
    let mut changed = false;
    for index in 0..length {
        let key = keys.at(index as i64, context)?;
        let property_key = key.to_property_key(context)?;
        let item = object.get(property_key.clone(), context)?;
        let converted = normalize_json_value(&item, context, depth + 1, seen)?;
        changed |= !JsValue::same_value(&item, &converted);
        entries.push((property_key, converted));
    }
    if !changed {
        return Ok(value.clone());
    }
    let copy = JsObject::with_object_proto(context.intrinsics());
    for (key, item) in entries {
        copy.create_data_property_or_throw(key, item, context)?;
    }
    Ok(copy.into())
}

/// Converts a `handleProxy` result. A `response` body may be a `Uint8Array`;
/// raw bytes cannot survive the JSON round-trip, so they are lifted out
/// beforehand and attached to the parsed response directly.
fn proxy_result_from_value(val: JsValue, context: &mut Context) -> Result<ProxyResult> {
    let mut body_bytes: Option<Vec<u8>> = None;
    if let Some(object) = val.as_object() {
        let kind = object
            .get(js_string!("type"), context)
            .map_anyhow_ctx(context)
            .context("Failed to read handleProxy result type")?;
        if kind
            .as_string()
            .is_some_and(|kind| kind.to_std_string_escaped() == "response")
        {
            let body = object
                .get(js_string!("body"), context)
                .map_anyhow_ctx(context)
                .context("Failed to read handleProxy response body")?;
            if let Some(array_object) = body.as_object()
                && let Ok(array) = JsUint8Array::from_object(array_object.clone())
            {
                body_bytes = Some(
                    array
                        .to_vec(context)
                        .map_anyhow_ctx(context)
                        .context("Failed to read Uint8Array proxy body")?,
                );
                object
                    .set(js_string!("body"), js_string!(""), false, context)
                    .map_anyhow_ctx(context)?;
            }
        }
    }
    let json = val
        .to_json(context)
        .map_anyhow_ctx(context)
        .context("Failed to convert handleProxy result")?
        .unwrap_or(Value::Null);
    let mut result: ProxyResult = json
        .try_into()
        .context("Failed to convert serde Value to ProxyResult")?;
    if let (Some(bytes), ProxyResult::Response(response)) = (body_bytes, &mut result) {
        *response.body_mut() = Bytes::from(bytes);
    }
    Ok(result)
}

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

        let container = ExtensionRuntimeDataContainer::new(self.data.clone());
        ctx.insert_data::<ExtensionRuntimeDataContainer>(container);

        let console = Console::init(&mut ctx);
        ctx.register_global_property(Console::NAME, console, Attribute::all())
            .map_anyhow_ctx(&mut ctx)
            .context("Failed to init console")?;
        js::declare(&mut ctx, &loader)?;
        boa_runtime::register_extensions(
            (
                TimeoutExtension,
                MicrotaskExtension,
                StructuredCloneExtension,
                AbortControllerExtension,
            ),
            None,
            &mut ctx,
        )
        .map_anyhow_ctx(&mut ctx)
        .context("Failed to register timer and abort globals")?;
        for host_module in self.host_modules.iter() {
            let module = Module::parse(
                boa_engine::Source::from_bytes(host_module.source.as_ref()),
                None,
                &mut ctx,
            )
            .map_anyhow_ctx(&mut ctx)
            .with_context(|| format!("Failed parsing host module {}", host_module.name))?;
            loader.insert(host_module.name.clone(), module);
        }

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
            Task::Validate {
                account,
                token,
                send,
            } => {
                let res = async {
                    let vals = &[JsValue::from_json(
                        &serde_json::to_value(account)
                            .context("Failed to convert Account to serde Value")?,
                        context,
                    )
                    .map_anyhow_ctx(context)
                    .context("Failed to convert Account to js")?];
                    Self::exec(context, "validate", vals, token)
                        .await
                        .context("Failed to call validate")
                }
                .await;
                let _ = send.send(res);
            }
            Task::HandleProxy { req, send } => {
                let res = async {
                    let vals = &[JsValue::from_json(
                        &request_to_value(&req)
                            .context("Failed to convert Request to serde Value")?,
                        context,
                    )
                    .map_anyhow_ctx(context)
                    .context("Failed to convert Request to js")?];
                    let val = Self::exec_value(context, "handleProxy", vals, None)
                        .await
                        .context("Failed to call handleProxy")?;
                    let val: ProxyResult = proxy_result_from_value(val, context)
                        .context("Failed to convert serde Value to ProxyResult")?;
                    Ok(val)
                }
                .await;
                let _ = send.send(res);
            }
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
                        .context("Failed to call onEvent")
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
            Task::Refresh {
                entry,
                settings,
                token,
                send,
            } => {
                let res = async {
                    let settings_val = JsValue::from_json(
                        &serde_json::to_value(settings)
                            .context("Failed to convert Settings to serde Value")?,
                        context,
                    )
                    .map_anyhow_ctx(context)
                    .context("Failed to convert Settings to js")?;
                    let plugin = Self::get_plugin(context).await?;
                    if plugin
                        .has_property(js_string!("refresh"), context)
                        .map_anyhow_ctx(context)
                        .context("Failed to check for refresh function")?
                    {
                        let vals = &[
                            JsValue::from_json(
                                &serde_json::to_value(entry)
                                    .context("Failed to convert Entry to serde Value")?,
                                context,
                            )
                            .map_anyhow_ctx(context)
                            .context("Failed to convert Entry to js")?,
                            settings_val,
                        ];
                        Self::exec::<EntryDetailedResult>(context, "refresh", vals, token)
                            .await
                            .context("Failed to call refresh")
                    } else {
                        // No incremental refresh on the extension: fall back to
                        // a plain detail fetch of the stored entry's id so
                        // callers can always use refresh with cached entries.
                        let vals = &[
                            JsValue::from_json(
                                &serde_json::to_value(entry.id)
                                    .context("Failed to convert EntryId to serde Value")?,
                                context,
                            )
                            .map_anyhow_ctx(context)
                            .context("Failed to convert EntryId to js")?,
                            settings_val,
                        ];
                        Self::exec::<EntryDetailedResult>(context, "detail", vals, token)
                            .await
                            .context("Failed to call detail")
                    }
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
                                .context("Failed to convert EpisodeId to serde Value")?,
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
                        .context("Failed to convert Source to js")?,
                        JsValue::from_json(
                            &serde_json::to_value(epid)
                                .context("Failed to convert EpisodeId to serde Value")?,
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

#[cfg(test)]
mod tests {
    use super::*;
    use boa_engine::builtins::promise::PromiseState;

    #[test]
    fn modules_are_strict_without_forcing_strict_mode() {
        let mut context = Context::default();
        let module = Module::parse(
            boa_engine::Source::from_bytes("undeclared = 1;"),
            None,
            &mut context,
        )
        .expect("parse failed");
        let promise = module.load_link_evaluate(&mut context);
        context.run_jobs().expect("jobs failed");
        assert!(matches!(promise.state(), PromiseState::Rejected(_)));
    }

    #[test]
    fn temporal_globals_and_stringify() {
        let mut context = Context::default();
        // The boa `temporal` feature must be enabled for extension JS.
        context
            .eval(boa_engine::Source::from_bytes(
                "typeof Temporal === 'object' && typeof Temporal.Instant === 'function'",
            ))
            .expect("Temporal globals missing")
            .as_boolean()
            .expect("expected boolean")
            .then_some(())
            .expect("Temporal.Instant not available");

        let value = context
            .eval(boa_engine::Source::from_bytes(
                "({ aired: Temporal.Instant.from('2024-01-02T03:04:05Z'), list: [Temporal.PlainDate.from('2024-01-02')] })",
            ))
            .expect("eval failed");
        let value = invoke_to_json_hooks(&value, &mut context).expect("toJSON pass failed");
        let json = value
            .to_json(&mut context)
            .expect("to_json failed")
            .expect("expected json");
        assert_eq!(json["aired"], "2024-01-02T03:04:05Z");
        assert_eq!(json["list"][0], "2024-01-02");

        // ZonedDateTime strings (with the bracketed zone annotation) are
        // handed through as strings; the Rust side strips the annotation.
        let zoned = context
            .eval(boa_engine::Source::from_bytes(
                "new Temporal.ZonedDateTime(0n, 'UTC').toJSON()",
            ))
            .expect("zdt failed");
        let json = zoned.to_json(&mut context).unwrap().unwrap();
        assert_eq!(json, "1970-01-01T00:00:00+00:00[UTC]");
    }

    #[test]
    fn non_temporal_objects_pass_through() {
        let mut context = Context::default();
        let value = context
            .eval(boa_engine::Source::from_bytes(
                "({ nested: { keep: new Date(0) } })",
            ))
            .expect("eval failed");
        let value = invoke_to_json_hooks(&value, &mut context).expect("toJSON pass failed");
        let json = value.to_json(&mut context).unwrap().unwrap();
        // boa's own Date JSON handling stays intact (ISO string).
        assert!(
            json["nested"]["keep"]
                .as_str()
                .unwrap()
                .starts_with("1970-01-01")
        );
    }

    #[test]
    fn frozen_objects_are_converted_without_being_modified() {
        let mut context = Context::default();
        let value = context
            .eval(boa_engine::Source::from_bytes(
                "Object.freeze({ when: new Date(0), list: Object.freeze([new Date(0)]) })",
            ))
            .expect("eval failed");

        let converted = invoke_to_json_hooks(&value, &mut context).expect("toJSON pass failed");

        let json = converted.to_json(&mut context).unwrap().unwrap();
        assert!(json["when"].as_str().unwrap().starts_with("1970-01-01"));
        assert!(json["list"][0].as_str().unwrap().starts_with("1970-01-01"));
    }

    #[test]
    fn shared_and_cyclic_references_are_visited_once() {
        let mut context = Context::default();
        let shared = context
            .eval(boa_engine::Source::from_bytes(
                "(() => { let o = { leaf: 1 }; for (let i = 0; i < 60; i++) o = { a: o, b: o }; return o; })()",
            ))
            .expect("eval failed");
        let cyclic = context
            .eval(boa_engine::Source::from_bytes(
                "(() => { const o = { items: [] }; o.items.push(o, o); return o; })()",
            ))
            .expect("eval failed");

        invoke_to_json_hooks(&shared, &mut context).expect("shared references failed");
        invoke_to_json_hooks(&cyclic, &mut context).expect("cyclic references failed");
    }
}
