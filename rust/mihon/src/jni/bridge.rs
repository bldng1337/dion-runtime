//! JNI bridge for calling Kotlin MihonBridge methods
//!
//! This module provides a unified interface for calling the Kotlin bridge
//! on both desktop and Android:
//!
//! - **Desktop**: Calls `dion.mihon.MihonBridge` (from the compat JAR)
//! - **Android**: Calls `dion.mihon.AndroidMihonBridge` (from compat-android aar)
//!
//! The JSON API is identical on both platforms.
//!
//! ## Android classloader handling
//!
//! On Android, `FindClass` from native-attached threads uses the system
//! classloader, which cannot find application classes. To work around this,
//! the bridge class is cached as a `GlobalRef` during `JNI_OnLoad` (which
//! runs on a Java thread with the app classloader). All bridge methods use
//! this cached reference via `get_bridge_class()`.

use crate::jni::JvmHandle;
use crate::mapping::dto::*;
use anyhow::{bail, Context, Result};
use jni::objects::{JObject, JString, JValue};
use std::sync::Arc;

/// The bridge class name differs between platforms
#[cfg(not(target_os = "android"))]
const BRIDGE_CLASS: &str = "dion/mihon/MihonBridge";

/// Wrapper for calling MihonBridge methods via JNI
pub struct MihonBridge {
    jvm: Arc<JvmHandle>,
}

impl MihonBridge {
    pub fn new(jvm: Arc<JvmHandle>) -> Self {
        Self { jvm }
    }

    /// Get the bridge class reference.
    ///
    /// On Android, uses the cached `GlobalRef` from `JNI_OnLoad` to bypass
    /// the `FindClass` classloader restriction on native-attached threads.
    /// On desktop, uses `FindClass` directly (the embedded JVM has the JAR
    /// on its classpath).
    fn get_bridge_class<'local>(
        env: &mut jni::JNIEnv<'local>,
    ) -> Result<jni::objects::JClass<'local>> {
        #[cfg(target_os = "android")]
        {
            crate::jni::android::get_bridge_class(env)
        }
        #[cfg(not(target_os = "android"))]
        {
            env.find_class(BRIDGE_CLASS)
                .context("Failed to find bridge class")
        }
    }

    /// On Android, set the Android Context before calling initialize.
    /// This calls `AndroidMihonBridge.setContext(context)` with the Context
    /// obtained from the `GlobalRef` cache populated during `JNI_OnLoad`.
    ///
    /// On desktop, this is a no-op.
    #[cfg(target_os = "android")]
    pub fn set_android_context(&self) -> Result<()> {
        let mut env = self.jvm.attach_current_thread()?;

        // Get the Application context from the GlobalRef cache rather than
        // from ndk_context. The cache holds the actual GlobalRef alive, so
        // the reference is guaranteed to remain valid. Using ndk_context's
        // raw pointer can lead to a stale reference because ndk_context
        // stores a detached raw pointer with no lifetime tracking.
        let context = crate::jni::android::get_app_context()
            .context("Application context cache not initialized")?;

        let class = Self::get_bridge_class(&mut env)?;

        env.call_static_method(
            &class,
            "setContext",
            "(Landroid/content/Context;)V",
            &[JValue::Object(context.as_obj())],
        )
        .context("Failed to call AndroidMihonBridge.setContext()")?;

        log::info!("Android context set successfully");
        Ok(())
    }

    /// Initialize the MihonBridge with extensions directory
    pub fn initialize(&self, extensions_dir: &str) -> Result<()> {
        // On Android, set the context first
        #[cfg(target_os = "android")]
        {
            self.set_android_context()?;
        }

        let result = self.call_bridge_method_one_string(
            "initialize",
            "(Ljava/lang/String;)Ljava/lang/String;",
            extensions_dir,
        )?;
        self.check_success(&result)
    }

    /// Install extension: APK -> JAR conversion (desktop) or metadata extraction (Android)
    pub fn install_extension(&self, apk_path: &str) -> Result<InstallResult> {
        let result = self.call_bridge_method_one_string(
            "installExtension",
            "(Ljava/lang/String;)Ljava/lang/String;",
            apk_path,
        )?;
        self.parse_result(&result)
    }

    /// Discover extensions already installed on the device (Android only).
    /// Returns a list of InstallResult with jarPath pointing to installed APKs.
    pub fn get_installed_extensions(&self) -> Result<Vec<InstallResult>> {
        let result = self.call_bridge_method_no_args(
            "getInstalledExtensions",
            "()Ljava/lang/String;",
        )?;
        self.parse_result(&result)
    }

    /// Load extension from JAR/APK, returns source IDs
    pub fn load_extension(&self, jar_path: &str, class_name: &str) -> Result<Vec<i64>> {
        let result = self.call_bridge_method_two_strings(
            "loadExtension",
            "(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;",
            jar_path,
            class_name,
        )?;
        let response: SourceIdsResult = self.parse_result(&result)?;
        Ok(response.source_ids)
    }

    /// Unload extension JAR/APK
    pub fn unload_extension(&self, jar_path: &str) -> Result<()> {
        let result = self.call_bridge_method_one_string(
            "unloadExtension",
            "(Ljava/lang/String;)Ljava/lang/String;",
            jar_path,
        )?;
        self.check_success(&result)
    }

    /// Unload a specific source
    pub fn unload_source(&self, source_id: i64) -> Result<()> {
        let result =
            self.call_bridge_method_long("unloadSource", "(J)Ljava/lang/String;", source_id)?;
        self.check_success(&result)
    }

    /// Get source info
    pub fn get_source_info(&self, source_id: i64) -> Result<SourceInfo> {
        let result =
            self.call_bridge_method_long("getSourceInfo", "(J)Ljava/lang/String;", source_id)?;
        self.parse_result(&result)
    }

    /// Get source type ("manga" or "anime")
    pub fn get_source_type(&self, source_id: i64) -> Result<String> {
        let result =
            self.call_bridge_method_long("getSourceType", "(J)Ljava/lang/String;", source_id)?;
        let response: SourceTypeResponse = self.parse_result(&result)?;
        Ok(response.r#type)
    }

    /// Get popular manga/anime
    pub fn get_popular(&self, source_id: i64, page: i32) -> Result<MangasPageDto> {
        let result = self.call_bridge_method_long_int(
            "getPopular",
            "(JI)Ljava/lang/String;",
            source_id,
            page,
        )?;
        self.parse_result(&result)
    }

    /// Get latest updates
    #[allow(dead_code)]
    pub fn get_latest(&self, source_id: i64, page: i32) -> Result<MangasPageDto> {
        let result = self.call_bridge_method_long_int(
            "getLatest",
            "(JI)Ljava/lang/String;",
            source_id,
            page,
        )?;
        self.parse_result(&result)
    }

    /// Search manga/anime
    pub fn search(
        &self,
        source_id: i64,
        page: i32,
        query: &str,
        filters_json: &str,
    ) -> Result<MangasPageDto> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let query_str = env.new_string(query)?;
        let filters_str = env.new_string(filters_json)?;

        let query_obj: JObject = query_str.into();
        let filters_obj: JObject = filters_str.into();

        let result = env
            .call_static_method(
                &class,
                "search",
                "(JILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;",
                &[
                    JValue::Long(source_id),
                    JValue::Int(page),
                    JValue::Object(&query_obj),
                    JValue::Object(&filters_obj),
                ],
            )
            .context("Failed to call search")?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        self.parse_result(&rust_string)
    }

    /// Get manga/anime details
    pub fn get_details(&self, source_id: i64, entry_json: &str) -> Result<MangaDto> {
        let result = self.call_bridge_method_long_string(
            "getDetails",
            "(JLjava/lang/String;)Ljava/lang/String;",
            source_id,
            entry_json,
        )?;
        self.parse_result(&result)
    }

    /// Get chapter list
    pub fn get_chapter_list(&self, source_id: i64, manga_json: &str) -> Result<Vec<ChapterDto>> {
        let result = self.call_bridge_method_long_string(
            "getChapterList",
            "(JLjava/lang/String;)Ljava/lang/String;",
            source_id,
            manga_json,
        )?;
        let response: ChapterListResult = self.parse_result(&result)?;
        Ok(response.chapters)
    }

    /// Get page list for chapter
    pub fn get_page_list(&self, source_id: i64, chapter_json: &str) -> Result<Vec<PageDto>> {
        let result = self.call_bridge_method_long_string(
            "getPageList",
            "(JLjava/lang/String;)Ljava/lang/String;",
            source_id,
            chapter_json,
        )?;
        let response: PageListResult = self.parse_result(&result)?;
        Ok(response.pages)
    }

    /// Get filter list for source
    #[allow(dead_code)]
    pub fn get_filter_list(&self, source_id: i64) -> Result<Vec<FilterDto>> {
        let result =
            self.call_bridge_method_long("getFilterList", "(J)Ljava/lang/String;", source_id)?;
        self.parse_result(&result)
    }

    // ========== Helper Methods ==========

    fn call_bridge_method_no_args(&self, method: &str, sig: &str) -> Result<String> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let result = env
            .call_static_method(&class, method, sig, &[])
            .context(format!("Failed to call bridge method {}", method))?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        Ok(rust_string)
    }

    fn call_bridge_method_one_string(&self, method: &str, sig: &str, arg: &str) -> Result<String> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let jstring = env.new_string(arg)?;
        let obj: JObject = jstring.into();

        let result = env
            .call_static_method(&class, method, sig, &[JValue::Object(&obj)])
            .context(format!("Failed to call bridge method {}", method))?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        Ok(rust_string)
    }

    fn call_bridge_method_two_strings(
        &self,
        method: &str,
        sig: &str,
        arg1: &str,
        arg2: &str,
    ) -> Result<String> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let jstring1 = env.new_string(arg1)?;
        let jstring2 = env.new_string(arg2)?;

        let obj1: JObject = jstring1.into();
        let obj2: JObject = jstring2.into();

        let result = env
            .call_static_method(
                &class,
                method,
                sig,
                &[JValue::Object(&obj1), JValue::Object(&obj2)],
            )
            .context(format!("Failed to call bridge method {}", method))?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        Ok(rust_string)
    }

    fn call_bridge_method_long(&self, method: &str, sig: &str, arg: i64) -> Result<String> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let result = env
            .call_static_method(&class, method, sig, &[JValue::Long(arg)])
            .context(format!("Failed to call bridge method {}", method))?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        Ok(rust_string)
    }

    fn call_bridge_method_long_int(
        &self,
        method: &str,
        sig: &str,
        arg1: i64,
        arg2: i32,
    ) -> Result<String> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let result = env
            .call_static_method(
                &class,
                method,
                sig,
                &[JValue::Long(arg1), JValue::Int(arg2)],
            )
            .context(format!("Failed to call bridge method {}", method))?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        Ok(rust_string)
    }

    fn call_bridge_method_long_string(
        &self,
        method: &str,
        sig: &str,
        arg1: i64,
        arg2: &str,
    ) -> Result<String> {
        let mut env = self.jvm.attach_current_thread()?;

        let class = Self::get_bridge_class(&mut env)?;

        let jstring_arg = env.new_string(arg2)?;
        let obj: JObject = jstring_arg.into();

        let result = env
            .call_static_method(
                &class,
                method,
                sig,
                &[JValue::Long(arg1), JValue::Object(&obj)],
            )
            .context(format!("Failed to call bridge method {}", method))?;

        let jstring = JString::from(result.l()?);
        let rust_string: String = env.get_string(&jstring)?.into();

        Ok(rust_string)
    }

    fn parse_result<T: serde::de::DeserializeOwned>(&self, json: &str) -> Result<T> {
        // First check if it's an error response
        if let Ok(error) = serde_json::from_str::<ErrorResponse>(json) {
            if let Some(err_msg) = error.error {
                bail!("JVM error: {}", err_msg);
            }
        }

        serde_json::from_str(json).context(format!("Failed to parse JSON response: {}", json))
    }

    fn check_success(&self, json: &str) -> Result<()> {
        // Check for error
        if let Ok(error) = serde_json::from_str::<ErrorResponse>(json) {
            if let Some(err_msg) = error.error {
                bail!("JVM error: {}", err_msg);
            }
        }

        // Check for success
        if let Ok(success) = serde_json::from_str::<SuccessResponse>(json) {
            if success.success {
                return Ok(());
            }
        }

        bail!("Unexpected response: {}", json)
    }
}

#[derive(serde::Deserialize)]
struct ErrorResponse {
    error: Option<String>,
    #[serde(rename = "stackTrace")]
    #[allow(dead_code)]
    stack_trace: Option<String>,
}

#[derive(serde::Deserialize)]
struct SuccessResponse {
    success: bool,
}

#[derive(serde::Deserialize)]
struct SourceTypeResponse {
    r#type: String,
}

#[derive(serde::Deserialize)]
struct SourceIdsResult {
    #[serde(rename = "sourceIds")]
    source_ids: Vec<i64>,
}

#[derive(serde::Deserialize)]
struct ChapterListResult {
    chapters: Vec<ChapterDto>,
}

#[derive(serde::Deserialize)]
struct PageListResult {
    pages: Vec<PageDto>,
}