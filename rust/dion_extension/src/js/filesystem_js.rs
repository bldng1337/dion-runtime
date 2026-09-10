use std::rc::Rc;

use anyhow::Result;
use boa_engine::Context;
use boa_engine::boa_module;

use crate::utils::VirtualModuleLoader;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    loader.insert(
        "filesystem".to_string(),
        filesystem::boa_module(None, context),
    );
    Ok(())
}

#[derive(Default, serde::Deserialize)]
#[serde(rename_all = "camelCase")]
struct WriteOptions {
    append: Option<bool>,
    create_parents: Option<bool>,
}

#[derive(Default, serde::Deserialize)]
#[serde(rename_all = "camelCase")]
struct DirOptions {
    recursive: Option<bool>,
}

struct DirEntry {
    name: String,
    path: String,
    is_dir: bool,
    is_file: bool,
}

fn parse_options<T: serde::de::DeserializeOwned + Default>(
    value: &boa_engine::JsValue,
    context: &mut Context,
) -> boa_engine::JsResult<T> {
    use boa_engine::{JsError, JsNativeError};
    if value.is_undefined() || value.is_null() {
        return Ok(T::default());
    }
    let json = value.to_json(context)?.unwrap_or(serde_json::Value::Null);
    serde_json::from_value(json).map_err(|e| {
        JsError::from_native(
            JsNativeError::error().with_message(format!("Invalid options object: {e}")),
        )
    })
}

fn type_error(message: &str) -> boa_engine::JsError {
    boa_engine::JsError::from_native(
        boa_engine::JsNativeError::typ().with_message(message.to_owned()),
    )
}

async fn write_bytes(
    path: std::path::PathBuf,
    bytes: &[u8],
    options: WriteOptions,
) -> anyhow::Result<()> {
    if options.create_parents.unwrap_or(false)
        && let Some(parent) = path.parent()
    {
        tokio::fs::create_dir_all(parent).await?;
    }
    if options.append.unwrap_or(false) {
        use tokio::io::AsyncWriteExt;
        let mut file = tokio::fs::OpenOptions::new()
            .create(true)
            .append(true)
            .open(&path)
            .await?;
        file.write_all(bytes).await?;
    } else {
        tokio::fs::write(&path, bytes).await?;
    }
    Ok(())
}

fn os_error(action: &str, path: &std::path::Path, err: std::io::Error) -> anyhow::Error {
    anyhow::anyhow!("Failed to {action} {}: {err}", path.to_string_lossy())
}

fn to_ms(time: std::io::Result<std::time::SystemTime>) -> Option<f64> {
    time.ok()?
        .duration_since(std::time::UNIX_EPOCH)
        .ok()
        .map(|d| d.as_millis() as f64)
}

/// Permission-gated filesystem access for extensions. Paths inside the
/// extension's private data directory (`getDataDir()`) need no permission;
/// anything outside requires a granted `Permission::Storage` for the
/// containing directory (or the directory itself for directory operations),
/// prompting the user once per directory root through the host client.
#[boa_module]
mod filesystem {
    use super::{
        DirEntry, DirOptions, WriteOptions, os_error, parse_options, to_ms, type_error, write_bytes,
    };
    use crate::filesystem as fslib;
    use crate::utils::enqueue_job;
    use boa_engine::{
        Context, JsError, JsNativeError, JsResult, JsString, JsValue,
        object::builtins::{JsArray, JsUint8Array},
    };
    use std::sync::Arc;

    use crate::extension::container::InnerExtension;

    #[boa(rename = "readTextFile")]
    fn read_text_file(path: String, context: &mut Context) -> JsResult<JsValue> {
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, false, false, "read").await?;
                tokio::fs::read_to_string(&path)
                    .await
                    .map_err(|e| os_error("read", &path, e))
            },
            |text: String, _ctx| Ok(JsValue::from(JsString::from(text))),
        )
    }

    #[boa(rename = "readFile")]
    fn read_file(path: String, context: &mut Context) -> JsResult<JsValue> {
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, false, false, "read").await?;
                tokio::fs::read(&path)
                    .await
                    .map_err(|e| os_error("read", &path, e))
            },
            |bytes: Vec<u8>, ctx| Ok(JsUint8Array::from_iter(bytes, ctx)?.into()),
        )
    }

    #[boa(rename = "writeTextFile")]
    fn write_text_file(
        path: String,
        contents: String,
        options: JsValue,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let options: WriteOptions = parse_options(&options, context)?;
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, true, false, "write").await?;
                write_bytes(path, contents.as_bytes(), options).await
            },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    #[boa(rename = "writeFile")]
    fn write_file(
        path: String,
        data: JsValue,
        options: JsValue,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let bytes: Vec<u8> = if let Some(object) = data.as_object() {
            let array = JsUint8Array::from_object(object.clone())
                .map_err(|_| type_error("data must be a Uint8Array or a string"))?;
            array.to_vec(context)?
        } else if let Some(text) = data.as_string() {
            text.to_std_string_escaped().into_bytes()
        } else {
            return Err(type_error("data must be a Uint8Array or a string"));
        };
        let options: WriteOptions = parse_options(&options, context)?;
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, true, false, "write").await?;
                write_bytes(path, &bytes, options).await
            },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    #[boa(rename = "deleteFile")]
    fn delete_file(path: String, context: &mut Context) -> JsResult<JsValue> {
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, true, false, "delete").await?;
                tokio::fs::remove_file(&path)
                    .await
                    .map_err(|e| os_error("delete", &path, e))
            },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    #[boa(rename = "exists")]
    fn exists(path: String, context: &mut Context) -> JsResult<JsValue> {
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, false, false, "access").await?;
                match tokio::fs::metadata(&path).await {
                    Ok(_) => Ok(true),
                    Err(err) if err.kind() == std::io::ErrorKind::NotFound => Ok(false),
                    Err(err) => Err(os_error("access", &path, err)),
                }
            },
            |exists: bool, _ctx| Ok(JsValue::from(exists)),
        )
    }

    #[boa(rename = "stat")]
    fn stat(path: String, context: &mut Context) -> JsResult<JsValue> {
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, false, false, "access").await?;
                let meta = tokio::fs::metadata(&path)
                    .await
                    .map_err(|e| os_error("stat", &path, e))?;
                Ok(serde_json::json!({
                    "size": meta.len(),
                    "isDir": meta.is_dir(),
                    "isFile": meta.is_file(),
                    "modifiedMs": to_ms(meta.modified()),
                    "createdMs": to_ms(meta.created()),
                }))
            },
            |stat: serde_json::Value, ctx| JsValue::from_json(&stat, ctx),
        )
    }

    #[boa(rename = "createDir")]
    fn create_dir(path: String, options: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let options: DirOptions = parse_options(&options, context)?;
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, true, true, "create").await?;
                let result = if options.recursive.unwrap_or(false) {
                    tokio::fs::create_dir_all(&path).await
                } else {
                    tokio::fs::create_dir(&path).await
                };
                result.map_err(|e| os_error("create directory", &path, e))
            },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    #[boa(rename = "removeDir")]
    fn remove_dir(path: String, options: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let options: DirOptions = parse_options(&options, context)?;
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, true, true, "remove").await?;
                let result = if options.recursive.unwrap_or(false) {
                    tokio::fs::remove_dir_all(&path).await
                } else {
                    tokio::fs::remove_dir(&path).await
                };
                result.map_err(|e| os_error("remove directory", &path, e))
            },
            |(), _ctx| Ok(JsValue::undefined()),
        )
    }

    #[boa(rename = "readDir")]
    fn read_dir(path: String, context: &mut Context) -> JsResult<JsValue> {
        enqueue_job(
            context,
            move |ext: Arc<InnerExtension>| async move {
                let path = fslib::ensure_access(&ext, &path, false, true, "list").await?;
                let mut reader = tokio::fs::read_dir(&path)
                    .await
                    .map_err(|e| os_error("list", &path, e))?;
                let mut entries = Vec::new();
                while let Some(entry) = reader
                    .next_entry()
                    .await
                    .map_err(|e| os_error("list", &path, e))?
                {
                    let file_type = entry.file_type().await.ok();
                    entries.push(DirEntry {
                        name: entry.file_name().to_string_lossy().into_owned(),
                        path: entry.path().to_string_lossy().into_owned(),
                        is_dir: file_type.as_ref().is_some_and(|t| t.is_dir()),
                        is_file: file_type.as_ref().is_some_and(|t| t.is_file()),
                    });
                }
                Ok(entries)
            },
            |entries: Vec<DirEntry>, ctx| {
                let array = JsArray::new(ctx)?;
                for entry in entries {
                    let obj = boa_engine::js_object!({
                        "name": JsString::from(entry.name),
                        "path": JsString::from(entry.path),
                        "isDir": entry.is_dir,
                        "isFile": entry.is_file,
                    }, ctx);
                    array.push(obj, ctx)?;
                }
                Ok(array.into())
            },
        )
    }

    // The extension's private data directory. Reading and writing below it
    // never requires a Storage permission.
    #[boa(rename = "getDataDir")]
    fn get_data_dir(context: &mut Context) -> JsResult<JsValue> {
        let runtime: Option<crate::extension::executor::ExtensionRuntimeDataContainer> =
            context.get_data().cloned();
        let runtime = runtime.ok_or_else(|| {
            JsError::from_native(JsNativeError::error().with_message("No runtime data"))
        })?;
        let Some(inner) = runtime.inner.upgrade() else {
            return Err(JsError::from_native(
                JsNativeError::error().with_message("Runtime container has been dropped"),
            ));
        };
        Ok(JsValue::from(JsString::from(
            inner.data_dir.to_string_lossy().into_owned(),
        )))
    }

    // Joins path fragments and normalizes the result (resolving `.`/`..`)
    // with the host platform's separator semantics.
    #[boa(rename = "joinPaths")]
    fn join_paths(parts: JsArray, context: &mut Context) -> JsResult<JsValue> {
        let length = parts.length(context)?;
        let mut list = Vec::with_capacity(length as usize);
        for index in 0..length {
            let value = parts.at(index as i64, context)?;
            let Some(text) = value.as_string() else {
                return Err(type_error("joinPaths expects an array of strings"));
            };
            list.push(text.to_std_string_escaped());
        }
        let joined = fslib::join_paths(&list).map_err(|e| JsError::from_rust(&*e))?;
        Ok(JsValue::from(JsString::from(joined)))
    }
}
