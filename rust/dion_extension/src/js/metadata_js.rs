use std::rc::Rc;
use std::sync::{Arc, Mutex};

use anyhow::{Context as ErrorContext, Result};
use boa_engine::Context;
use boa_engine::boa_class;
use boa_engine::boa_module;
use boa_engine::{
    JsData, JsError, JsNativeError, JsResult, JsString, JsValue,
    object::builtins::{JsArray, JsUint8Array},
};
use boa_gc::{Finalize, Trace};

use crate::extension::container::InnerExtension;
use crate::metadata::{ArchiveEntry, InspectOutput, MetadataArchive};
use crate::utils::{MapJsResult, VirtualModuleLoader, enqueue_job};

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    context
        .register_global_class::<Archive>()
        .map_anyhow_ctx(context)
        .context("Failed to register Archive class")?;
    loader.insert("metadata".to_string(), metadata::boa_module(None, context));
    Ok(())
}

/// Extracts the bytes of a `Uint8Array` argument.
fn expect_bytes(value: &JsValue, name: &str, context: &mut Context) -> JsResult<Vec<u8>> {
    let array = value.as_object().and_then(|object| {
        JsUint8Array::from_object(object)
            .ok()
            .map(|array| array.to_vec(context))
    });
    match array {
        Some(Ok(bytes)) => Ok(bytes),
        Some(Err(err)) => Err(err),
        None => Err(JsError::from_native(
            JsNativeError::typ().with_message(format!("{name} must be a Uint8Array")),
        )),
    }
}

/// Reads an optional string argument (`undefined`/`null` map to `None`).
fn opt_string(value: &JsValue) -> Option<String> {
    if value.is_undefined() || value.is_null() {
        return None;
    }
    value.as_string().map(|s| s.to_std_string_escaped())
}

/// Converts an `InspectOutput` to a JS value: the metadata rides the JSON
/// conversion, the artwork bytes are attached afterwards as a `Uint8Array`
/// (raw bytes cannot cross the JSON boundary).
fn inspect_to_js(output: InspectOutput, context: &mut Context) -> JsResult<JsValue> {
    let InspectOutput { metadata, artwork } = output;
    let json = serde_json::to_value(&metadata)
        .map_err(|e| JsError::from_native(JsNativeError::error().with_message(e.to_string())))?;
    let value = JsValue::from_json(&json, context)?;
    if let (Some(artwork), Some(object)) = (artwork, value.as_object()) {
        let artwork: JsValue = JsUint8Array::from_iter(artwork, context)?.into();
        object.set(JsString::from("artwork"), artwork, true, context)?;
    }
    Ok(value)
}

/// Metadata inspection for book and audio containers. `inspect` parses a
/// one-shot snapshot (metadata, chapters, artwork); `openArchive` returns a
/// reusable handle for reading entries (pages, covers, stylesheets) out of
/// EPUB and ZIP/CBZ containers. Both take the raw bytes — typically from
/// `filesystem.readFile` or a binary `network.fetch`.
#[boa_module]
mod metadata {
    use super::{Archive, expect_bytes, inspect_to_js, opt_string};
    use boa_engine::{Context, JsResult, JsValue};
    use std::sync::Arc;

    use crate::extension::container::InnerExtension;
    use crate::metadata::MetadataArchive;

    fn inspect(data: JsValue, hint: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let data = expect_bytes(&data, "data", context)?;
        let hint = opt_string(&hint);
        super::enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move {
                crate::metadata::inspect(data, hint.as_deref())
            },
            inspect_to_js,
        )
    }

    #[boa(rename = "openArchive")]
    fn open_archive(data: JsValue, hint: JsValue, context: &mut Context) -> JsResult<JsValue> {
        use boa_engine::class::Class;
        use std::sync::Mutex;

        let data = expect_bytes(&data, "data", context)?;
        let hint = opt_string(&hint);
        super::enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move { MetadataArchive::open(data, hint.as_deref()) },
            |archive: MetadataArchive, ctx| {
                let instance = Archive {
                    inner: Arc::new(Mutex::new(archive)),
                };
                Ok(Class::from_data(instance, ctx)?.into())
            },
        )
    }
}

#[derive(Debug, Trace, Finalize, JsData)]
struct Archive {
    #[unsafe_ignore_trace]
    inner: Arc<Mutex<MetadataArchive>>,
}

impl Archive {
    /// Runs `work` against the locked archive and resolves a promise with the
    /// converted result, mirroring the async API of the other modules.
    fn enqueue<T, F, C>(&self, context: &mut Context, work: F, convert: C) -> JsResult<JsValue>
    where
        T: 'static,
        F: FnOnce(&mut MetadataArchive) -> anyhow::Result<T> + 'static,
        C: FnOnce(T, &mut Context) -> JsResult<JsValue> + 'static,
    {
        let inner = self.inner.clone();
        enqueue_job(
            context,
            move |_ext: Arc<InnerExtension>| async move {
                let mut guard = inner
                    .lock()
                    .map_err(|_| anyhow::anyhow!("Archive lock is poisoned"))?;
                work(&mut guard)
            },
            convert,
        )
    }
}

#[boa_class(rename = "Archive")]
impl Archive {
    #[boa(constructor)]
    fn new() -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error().with_message(
            "Archive cannot be directly constructed; use openArchive",
        )))
    }

    fn entries(&self, context: &mut Context) -> JsResult<JsValue> {
        self.enqueue(
            context,
            |archive| archive.entries(),
            |entries: Vec<ArchiveEntry>, ctx| {
                let array = JsArray::new(ctx)?;
                for entry in entries {
                    let json = serde_json::to_value(&entry).map_err(|e| {
                        JsError::from_native(JsNativeError::error().with_message(e.to_string()))
                    })?;
                    array.push(JsValue::from_json(&json, ctx)?, ctx)?;
                }
                Ok(array.into())
            },
        )
    }

    fn read(&self, path: String, context: &mut Context) -> JsResult<JsValue> {
        self.enqueue(
            context,
            move |archive| archive.read(&path),
            |bytes: Vec<u8>, ctx| Ok(JsUint8Array::from_iter(bytes, ctx)?.into()),
        )
    }

    #[boa(rename = "readText")]
    fn read_text(&self, path: String, context: &mut Context) -> JsResult<JsValue> {
        self.enqueue(
            context,
            move |archive| archive.read_text(&path),
            |text: String, _ctx| Ok(JsValue::from(JsString::from(text))),
        )
    }

    #[boa(getter)]
    fn metadata(&self, context: &mut Context) -> JsResult<JsValue> {
        self.enqueue(context, |archive| archive.inspect(), inspect_to_js)
    }
}
