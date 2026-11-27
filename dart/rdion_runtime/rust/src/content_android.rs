//! JNI-backed `content://` resolver (Android only).
//!
//! Resolves Android Storage Access Framework / ContentProvider URIs through
//! `ContentResolver` so JS extensions can read user-picked documents and
//! trees without a real filesystem path. Registered once from `JNI_OnLoad`,
//! after the Application context has been stored in `ndk_context`.

use anyhow::{bail, Context, Result};
use jni::objects::{JObject, JString, JValue};
use jni::sys::jint;
use std::sync::Arc;

const READ_CHUNK: jint = 64 * 1024;

/// Installs the process-wide handler in dion-extension.
pub fn install() {
    let _ = dion_extension::content::set_content_uri_handler(Arc::new(AndroidContentResolver));
}

struct AndroidContentResolver;

impl dion_extension::content::ContentUriHandler for AndroidContentResolver {
    fn read(&self, uri: &str) -> Result<Vec<u8>> {
        with_env(|env| {
            let mut scope = JniScope::new(env)?;
            let resolver = scope.content_resolver()?;
            let uri_obj = scope.parse_uri(uri)?;
            let stream = scope
                .env()
                .call_method(
                    &resolver,
                    "openInputStream",
                    "(Landroid/net/Uri;)Ljava/io/InputStream;",
                    &[JValue::Object(&uri_obj)],
                )
                .context("ContentResolver.openInputStream failed")?
                .l()
                .context("openInputStream returned non-object")?;
            if stream.is_null() {
                bail!("ContentResolver.openInputStream returned null for {uri}");
            }
            let result = read_stream(scope.env(), &stream);
            // Closed on every path; a pending exception from the read has to
            // be cleared first or the close call itself would abort.
            clear_exception(scope.env());
            let _ = scope.env().call_method(&stream, "close", "()V", &[]);
            clear_exception(scope.env());
            result
        })
    }

    fn stat(&self, uri: &str) -> Result<dion_extension::content::ContentStat> {
        with_env(|env| {
            let mut scope = JniScope::new(env)?;
            let resolver = scope.content_resolver()?;
            let uri_obj = scope.parse_uri(uri)?;

            let name_str = scope
                .env()
                .new_string("_display_name")
                .context("Failed to allocate projection string")?;
            let size_str = scope
                .env()
                .new_string("_size")
                .context("Failed to allocate projection string")?;
            let projection = scope
                .env()
                .new_object_array(2, "java/lang/String", &name_str)
                .context("Failed to allocate projection array")?;
            scope
                .env()
                .set_object_array_element(&projection, 1, &size_str)?;

            let cursor = scope
                .env()
                .call_method(
                    &resolver,
                    "query",
                    "(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;",
                    &[
                        JValue::Object(&uri_obj),
                        JValue::Object(&JObject::from(projection)),
                        JValue::Object(&JObject::null()),
                        JValue::Object(&JObject::null()),
                        JValue::Object(&JObject::null()),
                    ],
                )
                .context("ContentResolver.query failed")?
                .l()
                .context("query returned non-object")?;
            if cursor.is_null() {
                bail!("ContentResolver.query returned null for {uri}");
            }
            let result = read_stat_row(scope.env(), &cursor, &name_str, &size_str, uri);
            // The cursor holds a provider connection; close it on every path.
            clear_exception(scope.env());
            let _ = scope.env().call_method(&cursor, "close", "()V", &[]);
            clear_exception(scope.env());
            result
        })
    }
}

/// Copies an `InputStream` into a Rust buffer through one reusable Java
/// array, instead of collecting it in a `ByteArrayOutputStream` and copying
/// that out again (three copies of the whole file at once).
fn read_stream(env: &mut jni::JNIEnv, stream: &JObject) -> Result<Vec<u8>> {
    let buf = env
        .new_byte_array(READ_CHUNK)
        .context("Failed to allocate read buffer")?;
    let mut chunk = vec![0i8; READ_CHUNK as usize];
    let mut bytes = Vec::new();
    loop {
        let read: jint = env
            .call_method(stream, "read", "([B)I", &[JValue::Object(buf.as_ref())])
            .context("InputStream.read failed")?
            .i()
            .context("InputStream.read returned non-int")?;
        if read < 0 {
            break;
        }
        let read = read.min(READ_CHUNK) as usize;
        env.get_byte_array_region(&buf, 0, &mut chunk[..read])
            .context("Failed to copy read buffer")?;
        bytes.extend(chunk[..read].iter().map(|&b| b as u8));
    }
    env.delete_local_ref(buf)?;
    Ok(bytes)
}

fn read_stat_row(
    env: &mut jni::JNIEnv,
    cursor: &JObject,
    name_str: &JString,
    size_str: &JString,
    uri: &str,
) -> Result<dion_extension::content::ContentStat> {
    let moved: bool = env
        .call_method(cursor, "moveToFirst", "()Z", &[])?
        .z()
        .unwrap_or(false);
    if !moved {
        bail!("no rows for {uri}");
    }
    let column = |env: &mut jni::JNIEnv, column: &JString| -> Result<jint> {
        env.call_method(
            cursor,
            "getColumnIndex",
            "(Ljava/lang/String;)I",
            &[JValue::Object(column)],
        )?
        .i()
        .context("getColumnIndex returned non-int")
    };
    let name_idx = column(env, name_str)?;
    let size_idx = column(env, size_str)?;
    let is_null = |env: &mut jni::JNIEnv, idx: jint| -> Result<bool> {
        Ok(env
            .call_method(cursor, "isNull", "(I)Z", &[JValue::Int(idx)])?
            .z()
            .unwrap_or(true))
    };

    let name = if name_idx >= 0 && !is_null(env, name_idx)? {
        let value = env
            .call_method(
                cursor,
                "getString",
                "(I)Ljava/lang/String;",
                &[JValue::Int(name_idx)],
            )?
            .l()?;
        if value.is_null() {
            None
        } else {
            let value = JString::from(value);
            let name = env
                .get_string(&value)
                .ok()
                .map(|s| s.to_string_lossy().into_owned());
            env.delete_local_ref(value)?;
            name
        }
    } else {
        None
    };
    // A NULL `_size` reads as 0 through getLong and providers report -1 for
    // unknown sizes; neither is a real size.
    let size = if size_idx >= 0 && !is_null(env, size_idx)? {
        let size = env
            .call_method(cursor, "getLong", "(I)J", &[JValue::Int(size_idx)])?
            .j()?;
        u64::try_from(size).ok()
    } else {
        None
    };
    Ok(dion_extension::content::ContentStat { size, name })
}

/// Describes and clears a pending Java exception. Any further JNI call with
/// an exception pending aborts the process on ART.
fn clear_exception(env: &mut jni::JNIEnv) -> bool {
    if env.exception_check().unwrap_or(false) {
        let _ = env.exception_describe();
        let _ = env.exception_clear();
        return true;
    }
    false
}

/// Runs `work` with a JNIEnv for the current thread (attaching it to the JVM
/// if needed), inside a local frame so every local reference it creates is
/// released on return, and with any exception it left pending cleared.
fn with_env<T>(work: impl FnOnce(&mut jni::JNIEnv) -> Result<T>) -> Result<T> {
    let ctx = ndk_context::android_context();
    let vm_ptr = ctx.vm();
    if vm_ptr.is_null() {
        bail!("JavaVM is not available (ndk_context not initialized)");
    }
    let vm = unsafe { jni::JavaVM::from_raw(vm_ptr as *mut _) }.context("Failed to wrap JavaVM")?;
    let mut guard = vm
        .attach_current_thread()
        .context("Failed to attach thread to the JVM")?;
    let result = guard.with_local_frame(32, |env| {
        let result = work(env);
        // Inside the frame: popping it with an exception pending is itself
        // an illegal JNI call.
        let thrown = clear_exception(env);
        Ok::<_, anyhow::Error>((result, thrown))
    });
    let (result, thrown) = result?;
    match result {
        Err(err) if thrown => Err(err.context("Java exception thrown")),
        other => other,
    }
}

/// Bundles the JNIEnv with a cached Application context and Uri class.
///
/// The borrow lifetime and the `JNIEnv` lifetime are separate parameters:
/// `&mut JNIEnv<'e>` is invariant in `'e`, so tying both to one `'a` makes
/// `JniScope::new` unusable inside a closure over an anonymous `JNIEnv`.
struct JniScope<'env, 'env_ref> {
    env: &'env_ref mut jni::JNIEnv<'env>,
    context: JObject<'env>,
}

impl<'env, 'env_ref> JniScope<'env, 'env_ref> {
    fn new(env: &'env_ref mut jni::JNIEnv<'env>) -> Result<Self> {
        let context_ptr = ndk_context::android_context().context();
        if context_ptr.is_null() {
            bail!("Application context is not available (ndk_context not initialized)");
        }
        Ok(Self {
            env,
            // The stored pointer is a GlobalRef to the Application; it stays
            // alive for the whole process, so borrowing it is safe.
            context: unsafe { JObject::from_raw(context_ptr as *mut _) },
        })
    }

    fn env(&mut self) -> &mut jni::JNIEnv<'env> {
        self.env
    }

    fn content_resolver(&mut self) -> Result<JObject<'env>> {
        // Field access, not `self.env()`: the method would mutably borrow
        // all of `self` and conflict with the `&self.context` argument.
        self.env
            .call_method(
                &self.context,
                "getContentResolver",
                "()Landroid/content/ContentResolver;",
                &[],
            )?
            .l()
            .context("getContentResolver returned non-object")
    }

    fn parse_uri(&mut self, uri: &str) -> Result<JObject<'env>> {
        let uri_str = self.env().new_string(uri)?;
        let class = self.env().find_class("android/net/Uri")?;
        self.env()
            .call_static_method(
                &class,
                "parse",
                "(Ljava/lang/String;)Landroid/net/Uri;",
                &[JValue::Object(&uri_str.into())],
            )?
            .l()
            .context("Uri.parse returned non-object")
    }
}
