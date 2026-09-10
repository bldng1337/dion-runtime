use std::rc::Rc;
use std::sync::Arc;
use std::time::Duration;

use anyhow::{Context as ErrorContext, Result};
use boa_engine::Context;
use boa_engine::boa_class;
use boa_engine::boa_module;
use boa_engine::class::Class;
use boa_engine::{
    JsData, JsError, JsNativeError, JsResult, JsString, JsValue,
    object::builtins::{JsArray, JsUint8Array},
};
use boa_gc::{Finalize, Trace};

use crate::cache::{CacheInner, CacheManager, CachePolicy, CacheValue};
use crate::extension::container::InnerExtension;
use crate::extension::executor::ExtensionRuntimeDataContainer;
use crate::utils::{MapJsResult, VirtualModuleLoader, enqueue_job};

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    context
        .register_global_class::<Cache>()
        .map_anyhow_ctx(context)
        .context("Failed to register Cache class")?;
    loader.insert("cache".to_string(), cache::boa_module(None, context));
    Ok(())
}

#[derive(Debug, Trace, Finalize, JsData, Clone)]
struct Cache {
    #[unsafe_ignore_trace]
    inner: Arc<CacheInner>,
}

// Result of a `get`/`peek`, kept as Rust data until the promise resolves
// and a context is available to build the JS value.
enum GetResult {
    Json(serde_json::Value),
    Binary(Vec<u8>),
    Miss,
}

#[derive(serde::Deserialize)]
#[serde(rename_all = "camelCase")]
struct CacheOptions {
    default_ttl: Option<f64>,
    max_entries: Option<f64>,
    max_bytes: Option<f64>,
}

fn runtime(context: &mut Context) -> JsResult<Arc<InnerExtension>> {
    let runtime: Option<ExtensionRuntimeDataContainer> = context.get_data().cloned();
    let runtime = runtime.ok_or_else(|| {
        JsError::from_native(JsNativeError::error().with_message("No runtime data"))
    })?;
    let Some(inner) = runtime.inner.upgrade() else {
        return Err(JsError::from_native(
            JsNativeError::error().with_message("Runtime container has been dropped"),
        ));
    };
    Ok(inner)
}

fn parse_options(value: &JsValue, context: &mut Context) -> JsResult<CacheOptions> {
    if value.is_undefined() || value.is_null() {
        return Ok(CacheOptions {
            default_ttl: None,
            max_entries: None,
            max_bytes: None,
        });
    }
    let json = value.to_json(context)?.unwrap_or(serde_json::Value::Null);
    serde_json::from_value(json).map_err(|e| {
        JsError::from_native(
            JsNativeError::error().with_message(format!("Invalid cache options: {e}")),
        )
    })
}

fn ttl_duration(seconds: f64) -> JsResult<Duration> {
    if !seconds.is_finite() || seconds <= 0.0 {
        return Err(JsError::from_native(
            JsNativeError::range().with_message("ttl must be a positive number of seconds"),
        ));
    }
    Ok(Duration::from_secs_f64(seconds))
}

fn cache_policy(options: CacheOptions, lru: bool) -> JsResult<CachePolicy> {
    let default_ttl = options.default_ttl.map(ttl_duration).transpose()?;
    let (max_entries, max_bytes) = if lru {
        let entries = match options.max_entries {
            Some(entries) if entries.is_finite() && entries >= 1.0 => Some(entries as usize),
            Some(_) => {
                return Err(JsError::from_native(
                    JsNativeError::range().with_message("maxEntries must be >= 1"),
                ));
            }
            None => None,
        };
        let bytes = match options.max_bytes {
            Some(bytes) if bytes.is_finite() && bytes >= 1.0 => Some(bytes as u64),
            Some(_) => {
                return Err(JsError::from_native(
                    JsNativeError::range().with_message("maxBytes must be >= 1"),
                ));
            }
            None => None,
        };
        (entries, bytes)
    } else {
        if options.max_entries.is_some() || options.max_bytes.is_some() {
            return Err(JsError::from_native(JsNativeError::error().with_message(
                "capacity limits belong to openLruCache; openKvCache only takes defaultTtl",
            )));
        }
        (None, None)
    };
    Ok(CachePolicy {
        default_ttl,
        max_entries,
        max_bytes,
    })
}

fn to_cache_value(value: &JsValue, context: &mut Context) -> JsResult<CacheValue> {
    if value.is_undefined() {
        return Err(JsError::from_native(
            JsNativeError::typ().with_message("cache values cannot be undefined; use null"),
        ));
    }
    if let Some(object) = value.as_object()
        && let Ok(array) = JsUint8Array::from_object(object.clone())
    {
        return Ok(CacheValue::Binary(array.to_vec(context)?));
    }
    let json = value.to_json(context)?.unwrap_or(serde_json::Value::Null);
    Ok(CacheValue::Json(json))
}

fn get_result_to_js(result: GetResult, context: &mut Context) -> JsResult<JsValue> {
    match result {
        GetResult::Json(value) => JsValue::from_json(&value, context),
        GetResult::Binary(bytes) => Ok(JsUint8Array::from_iter(bytes, context)?.into()),
        GetResult::Miss => Ok(JsValue::undefined()),
    }
}

fn open_cache(
    name: String,
    options: JsValue,
    lru: bool,
    context: &mut Context,
) -> JsResult<JsValue> {
    let options = parse_options(&options, context)?;
    let policy = cache_policy(options, lru)?;
    let manager: &CacheManager = &runtime(context)?.cache;
    let inner = manager
        .open(&name, policy)
        .map_err(|e| JsError::from_rust(&*e))?;
    Ok(Class::from_data(Cache { inner }, context)?.into())
}

/// Persistent key-value and LRU caches for extensions. Caches live below
/// the extension's private data directory and survive VM restarts; values
/// may be any JSON value or a `Uint8Array` (stored as raw bytes).
#[boa_module]
mod cache {
    use boa_engine::{Context, JsResult, JsValue};

    #[boa(rename = "openKvCache")]
    fn open_kv_cache(name: String, options: JsValue, context: &mut Context) -> JsResult<JsValue> {
        super::open_cache(name, options, false, context)
    }

    #[boa(rename = "openLruCache")]
    fn open_lru_cache(name: String, options: JsValue, context: &mut Context) -> JsResult<JsValue> {
        super::open_cache(name, options, true, context)
    }
}

#[boa_class(rename = "Cache")]
impl Cache {
    #[boa(constructor)]
    fn new() -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error().with_message(
            "Cache cannot be directly constructed; use openKvCache/openLruCache",
        )))
    }

    fn get(&self, key: String, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move {
                Ok(match inner.get(&key, true).await? {
                    Some(CacheValue::Json(value)) => GetResult::Json(value),
                    Some(CacheValue::Binary(bytes)) => GetResult::Binary(bytes),
                    None => GetResult::Miss,
                })
            },
            get_result_to_js,
        )
    }

    // Reads without refreshing LRU recency.
    fn peek(&self, key: String, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move {
                Ok(match inner.get(&key, false).await? {
                    Some(CacheValue::Json(value)) => GetResult::Json(value),
                    Some(CacheValue::Binary(bytes)) => GetResult::Binary(bytes),
                    None => GetResult::Miss,
                })
            },
            get_result_to_js,
        )
    }

    fn set(
        &self,
        key: String,
        value: JsValue,
        ttl: JsValue,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let value = to_cache_value(&value, context)?;
        let ttl = if ttl.is_undefined() || ttl.is_null() {
            None
        } else {
            match ttl.as_number() {
                Some(seconds) => Some(ttl_duration(seconds)?),
                None => {
                    return Err(JsError::from_native(
                        JsNativeError::typ().with_message("ttl must be a number of seconds"),
                    ));
                }
            }
        };
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { inner.set(&key, value, ttl).await },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    fn has(&self, key: String, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { inner.has(&key).await },
            |has: bool, _ctx| Ok(JsValue::from(has)),
        )
    }

    fn delete(&self, key: String, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { inner.delete(&key).await },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    fn keys(&self, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { inner.keys().await },
            |keys: Vec<String>, ctx| {
                let array = JsArray::new(ctx)?;
                for key in keys {
                    array.push(JsString::from(key), ctx)?;
                }
                Ok(array.into())
            },
        )
    }

    fn size(&self, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { inner.size().await },
            |size: usize, _ctx| Ok(JsValue::from(size)),
        )
    }

    fn clear(&self, context: &mut Context) -> JsResult<JsValue> {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { inner.clear().await },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }
}
