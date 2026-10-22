//! JNI-backed `content://` resolver (Android only).
//!
//! Resolves Android Storage Access Framework / ContentProvider URIs through
//! `ContentResolver` so JS extensions can read user-picked documents and
//! trees without a real filesystem path. Registered once from `JNI_OnLoad`,
//! after the Application context has been stored in `ndk_context`.

use anyhow::{bail, Context, Result};
use jni::objects::JObject;
use jni::objects::JValue;
use jni::sys::{jint, jlong};
use std::sync::Arc;

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
            // Copy the stream through a ByteArrayOutputStream so arbitrary
            // InputStream implementations work (not just file descriptors).
            let baos = scope
                .env()
                .new_object("java/io/ByteArrayOutputStream", "()V", &[])
                .context("Failed to allocate ByteArrayOutputStream")?;
            let buf = scope
                .env()
                .new_byte_array(64 * 1024)
                .context("Failed to allocate read buffer")?;
            loop {
                let read: jint = scope
                    .env()
                    .call_method(
                        &stream,
                        "read",
                        "([B)I",
                        &[JValue::Object(&JObject::from(buf))],
                    )
                    .context("InputStream.read failed")?
                    .i()
                    .context("InputStream.read returned non-int")?;
                if read == -1 {
                    break;
                }
                scope
                    .env()
                    .call_method(
                        &baos,
                        "write",
                        "([BII)V",
                        &[
                            JValue::Object(&JObject::from(buf)),
                            JValue::Int(0),
                            JValue::Int(read),
                        ],
                    )
                    .context("ByteArrayOutputStream.write failed")?;
            }
            let _ = scope.env().call_method(&stream, "close", "()V", &[]);
            let array = scope
                .env()
                .call_method(&baos, "toByteArray", "()[B", &[])?
                .l()
                .context("toByteArray returned non-object")?;
            let bytes = scope
                .env()
                .convert_byte_array(&array.into())
                .context("Failed to convert byte array")?;
            Ok(bytes)
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
                .new_object_array(2, "java/lang/String", &JObject::from(name_str))
                .context("Failed to allocate projection array")?;
            scope
                .env()
                .set_object_array_element(&projection, 1, JObject::from(size_str))?;

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
            let moved: bool = scope
                .env()
                .call_method(&cursor, "moveToFirst", "()Z", &[])?
                .z()
                .unwrap_or(false);
            if !moved {
                let _ = scope.env().call_method(&cursor, "close", "()V", &[]);
                bail!("no rows for {uri}");
            }
            let name_idx = scope
                .env()
                .call_method(
                    &cursor,
                    "getColumnIndex",
                    "(Ljava/lang/String;)I",
                    &[{
                        let s = scope.env().new_string("_display_name")?;
                        JValue::Object(&JObject::from(s))
                    }],
                )?
                .i()
                .context("getColumnIndex returned non-int")?;
            let size_idx = scope
                .env()
                .call_method(
                    &cursor,
                    "getColumnIndex",
                    "(Ljava/lang/String;)I",
                    &[{
                        let s = scope.env().new_string("_size")?;
                        JValue::Object(&JObject::from(s))
                    }],
                )?
                .i()
                .context("getColumnIndex returned non-int")?;

            let name = if name_idx >= 0 {
                scope
                    .env()
                    .call_method(
                        &cursor,
                        "getString",
                        "(I)Ljava/lang/String;",
                        &[JValue::Int(name_idx)],
                    )?
                    .l()
                    .ok()
                    .and_then(|s| scope.env().get_string(&s.into()).ok())
                    .map(|s| s.to_string_lossy().into_owned())
            } else {
                None
            };
            let size = if size_idx >= 0 {
                scope
                    .env()
                    .call_method(&cursor, "getLong", "(I)J", &[JValue::Int(size_idx)])?
                    .j()
                    .ok()
                    .map(|v: jlong| v as u64)
            } else {
                None
            };
            let _ = scope.env().call_method(&cursor, "close", "()V", &[]);
            Ok(dion_extension::content::ContentStat { size, name })
        })
    }
}

/// Runs `work` with a JNIEnv for the current thread (attaching it to the JVM
/// if needed).
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
    work(&mut guard)
}

/// Bundles the JNIEnv with a cached Application context and Uri class.
struct JniScope<'a> {
    env: &'a mut jni::JNIEnv<'a>,
    context: JObject<'a>,
}

impl<'a> JniScope<'a> {
    fn new(env: &'a mut jni::JNIEnv<'a>) -> Result<Self> {
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

    fn env(&mut self) -> &mut jni::JNIEnv<'a> {
        self.env
    }

    fn content_resolver(&mut self) -> Result<JObject<'a>> {
        self.env()
            .call_method(
                &self.context,
                "getContentResolver",
                "()Landroid/content/ContentResolver;",
                &[],
            )?
            .l()
            .context("getContentResolver returned non-object")
    }

    fn parse_uri(&mut self, uri: &str) -> Result<JObject<'a>> {
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
