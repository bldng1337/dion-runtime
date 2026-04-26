//! Android-specific JVM attachment
//!
//! On Android, we're already running inside the ART/Dalvik VM.
//! Instead of creating a new JVM, we attach to the existing one
//! using the JavaVM pointer from ndk_context.
//!
//! ## Class caching for native threads
//!
//! On Android, `JNI FindClass` uses the classloader of the calling thread.
//! Threads attached via `AttachCurrentThread` get the system classloader,
//! which does NOT include application classes like `AndroidMihonBridge`.
//!
//! To work around this, we cache the bridge class as a `GlobalRef` during
//! `JNI_OnLoad` (which runs on a Java thread with the app classloader).
//! The cached reference can then be used from any attached native thread.

use anyhow::{bail, Context, Result};
use jni::objects::{JClass, JObject};
use std::sync::OnceLock;

/// The bridge class JNI name (package path with / separators).
const BRIDGE_CLASS: &str = "dion/mihon/AndroidMihonBridge";

/// Cached bridge class as a global reference.
///
/// Initialized during `JNI_OnLoad` and used by `get_bridge_class()` to
/// provide the class reference from any thread, including native-attached
/// threads that would otherwise fail with `FindClass`.
static BRIDGE_CLASS_CACHE: OnceLock<jni::objects::GlobalRef> = OnceLock::new();

/// Cached Application context as a global reference.
///
/// The `GlobalRef` must be kept alive for the entire process lifetime;
/// otherwise the raw pointer stored in `ndk_context` becomes a stale
/// reference once the `GlobalRef` is dropped.
static APP_CONTEXT_CACHE: OnceLock<jni::objects::GlobalRef> = OnceLock::new();

/// Perform all Android JNI initialization from `JNI_OnLoad`.
///
/// This **must** be called from `JNI_OnLoad`, which runs on a Java thread
/// with the application classloader. It performs two critical tasks:
///
/// 1. **Obtains the Android Application context** via
///    `ActivityThread.currentActivityThread().getApplication()` and stores it
///    in `ndk_context`. The context is later retrieved by
///    `MihonBridge::set_android_context()` to pass to
///    `AndroidMihonBridge.setContext()`.
///
/// 2. **Caches the `AndroidMihonBridge` class** as a JNI `GlobalRef`.
///    Native-attached threads (e.g. tokio-runtime-worker) only have the
///    system classloader, so `FindClass` would fail for application classes.
///    The cached `GlobalRef` bypasses this restriction.
///
/// # Safety
///
/// `vm_ptr` must be a valid, non-null `JavaVM*` pointer provided by the
/// Android runtime during `JNI_OnLoad`.
pub unsafe fn init_android(vm_ptr: *mut jni::sys::JavaVM) -> Result<()> {
    let jvm = unsafe { jni::JavaVM::from_raw(vm_ptr) }
        .context("Failed to wrap JavaVM pointer")?;

    let mut env = jvm
        .get_env()
        .context("Failed to get JNIEnv during JNI_OnLoad")?;

    // --- 1. Obtain the Application context via ActivityThread reflection ---
    let context = get_application_context(&mut env);
    let has_context = context.is_some();

    // Store in ndk_context so MihonBridge::set_android_context() can retrieve it.
    // The context pointer must be a valid jobject; we store the raw pointer from
    // the global reference. ndk_context expects (*mut JavaVM, *mut android::Context).
    let context_ptr = match context {
        Some(global_ref) => {
            let ptr = global_ref.as_raw() as *mut std::ffi::c_void;
            // Store the GlobalRef in a static so it outlives this function call.
            // Without this, the GlobalRef would be dropped here and the raw
            // pointer stored in ndk_context would become a stale reference.
            let _ = APP_CONTEXT_CACHE.set(global_ref);
            ptr
        }
        None => std::ptr::null_mut(),
    };

    ndk_context::initialize_android_context(vm_ptr as *mut std::ffi::c_void, context_ptr);

    if has_context {
        log::info!("JNI_OnLoad: stored Application context in ndk_context");
    } else {
        log::error!("JNI_OnLoad: failed to obtain Application context, ndk_context context is null");
    }

    // --- 2. Cache the bridge class as a GlobalRef ---
    cache_bridge_class(&mut env)?;

    Ok(())
}

/// Get the Android Application context via `ActivityThread` reflection.
///
/// Uses `ActivityThread.currentActivityThread().getApplication()` — a well-known
/// technique to obtain the Application context from native code without requiring
/// the Java side to pass it explicitly.
///
/// Returns the Application as a `GlobalRef` (so it survives across JNI calls),
/// or an error on failure.
fn get_application_context(env: &mut jni::JNIEnv) -> Option<jni::objects::GlobalRef> {
    // Find ActivityThread class
    let at_class = match env.find_class("android/app/ActivityThread") {
        Ok(c) => c,
        Err(e) => {
            log::error!("Failed to find ActivityThread class: {e}");
            return None;
        }
    };

    // Call static method: ActivityThread.currentActivityThread()
    let current_thread = match env.call_static_method(
        &at_class,
        "currentActivityThread",
        "()Landroid/app/ActivityThread;",
        &[],
    ) {
        Ok(v) => v,
        Err(e) => {
            log::error!("Failed to call ActivityThread.currentActivityThread(): {e}");
            return None;
        }
    };

    let thread_obj = match current_thread.l() {
        Ok(o) => o,
        Err(e) => {
            log::error!("currentActivityThread() returned non-object: {e}");
            return None;
        }
    };

    if thread_obj.is_null() {
        log::error!("ActivityThread.currentActivityThread() returned null");
        return None;
    }

    // Call instance method: activityThread.getApplication()
    let application = match env.call_method(
        &thread_obj,
        "getApplication",
        "()Landroid/app/Application;",
        &[],
    ) {
        Ok(v) => v,
        Err(e) => {
            log::error!("Failed to call ActivityThread.getApplication(): {e}");
            return None;
        }
    };

    let app_obj = match application.l() {
        Ok(o) => o,
        Err(e) => {
            log::error!("getApplication() returned non-object: {e}");
            return None;
        }
    };

    if app_obj.is_null() {
        log::error!("ActivityThread.getApplication() returned null");
        return None;
    }

    // Create a global reference so the Application survives across JNI calls.
    // The Application lives for the entire process lifetime anyway, so leaking
    // this global ref is harmless.
    match env.new_global_ref(&app_obj) {
        Ok(global) => {
            log::info!("Obtained Application context via ActivityThread");
            Some(global)
        }
        Err(e) => {
            log::error!("Failed to create GlobalRef for Application: {e}");
            None
        }
    }
}

/// Cache the bridge class as a `GlobalRef`.
///
/// `FindClass` works here because this is called during `JNI_OnLoad`, which
/// runs on the main Java thread with the application classloader. Later,
/// native-attached threads use `get_bridge_class()` to retrieve the cached
/// reference instead of calling `FindClass` (which would fail).
fn cache_bridge_class(env: &mut jni::JNIEnv) -> Result<()> {
    let class = env
        .find_class(BRIDGE_CLASS)
        .context("Failed to find AndroidMihonBridge class during JNI_OnLoad. \
                  Ensure the compat-android Kotlin sources are compiled into the APK")?;

    // Create a global reference so the class survives across threads.
    // JClass -> JObject conversion is safe (jclass IS jobject in JNI).
    let class_obj: JObject = unsafe { JObject::from_raw(class.into_raw() as jni::sys::jobject) };
    let global_ref = env
        .new_global_ref(&class_obj)
        .context("Failed to create GlobalRef for bridge class")?;

    BRIDGE_CLASS_CACHE
        .set(global_ref)
        .map_err(|_| anyhow::anyhow!("Bridge class cache already initialized"))?;

    log::info!("Cached {} as GlobalRef for native thread access", BRIDGE_CLASS);
    Ok(())
}

/// Get the cached bridge class as a `JClass`.
///
/// Returns the `AndroidMihonBridge` class that can be used with
/// `call_static_method` etc. Uses the `GlobalRef` cached during
/// `init_android` to bypass the `FindClass` classloader restriction
/// on native-attached threads.
///
/// Falls back to `FindClass` if the cache is not initialized (will
/// only work when called from a Java thread).
///
/// # Safety of the returned `JClass`
///
/// The returned `JClass<'a>` borrows from the `JNIEnv<'a>`, but the underlying
/// reference is held by a `GlobalRef` in `BRIDGE_CLASS_CACHE` (a `OnceLock`,
/// never cleared). Because the `GlobalRef` outlives any `JNIEnv` lifetime `'a`,
/// the `JClass<'a>` is guaranteed to remain valid for the entirety of `'a`.
pub fn get_bridge_class<'a>(env: &mut jni::JNIEnv<'a>) -> Result<JClass<'a>> {
    if let Some(global_ref) = BRIDGE_CLASS_CACHE.get() {
        // Convert the GlobalRef (jobject) to JClass.
        //
        // Safety:
        // 1. The GlobalRef was created from a JClass obtained via FindClass,
        //    so the underlying jobject IS a valid jclass.
        // 2. In JNI C headers, jclass is typedef'd to jobject (both are _jobject*),
        //    so the pointer cast is sound.
        // 3. The GlobalRef is stored in a OnceLock and is never dropped, so the
        //    underlying reference is valid for the entire program lifetime.
        // 4. The JClass<'a> returned here is tied to the env's lifetime 'a, which
        //    is fine because the GlobalRef keeps the reference alive beyond 'a.
        // 5. We pass env as an explicit parameter to make the lifetime dependency
        //    clear at the call site, even though we don't call any env methods here.
        let _ = env; // Ensure the caller holds a valid JNIEnv for lifetime 'a
        let class =
            unsafe { JClass::from_raw(global_ref.as_raw() as jni::sys::jclass) };
        Ok(class)
    } else {
        log::warn!(
            "Bridge class cache not initialized, falling back to FindClass \
             (this will fail from native-attached threads)"
        );
        env.find_class(BRIDGE_CLASS)
            .context("Failed to find bridge class (cache not initialized)")
    }
}

/// Get the cached Application context as a `GlobalRef`.
///
/// Returns a reference to the `GlobalRef` cached during `init_android`.
/// The `GlobalRef` keeps the underlying JNI global reference alive,
/// preventing it from becoming stale.
///
/// Using this instead of the raw pointer from `ndk_context` avoids stale
/// reference issues because `ndk_context` stores a detached raw pointer
/// with no lifetime tracking.
///
/// Returns `None` if the context cache has not been initialized (i.e.
/// `init_android` was not called or failed to obtain the context).
pub fn get_app_context() -> Option<&'static jni::objects::GlobalRef> {
    APP_CONTEXT_CACHE.get()
}

/// Handle to the existing Android JVM (ART/Dalvik)
pub struct JvmHandle {
    jvm: jni::JavaVM,
}

impl JvmHandle {
    /// Attach to the existing Android JVM.
    ///
    /// On Android, the JVM is already running. We obtain the JavaVM pointer
    /// from ndk_context (which is set up by the Android native activity or
    /// the app's JNI_OnLoad).
    ///
    /// # Errors
    /// Returns error if:
    /// - ndk_context is not initialized (app not properly set up)
    /// - The VM pointer is null
    /// - Wrapping the VM pointer fails
    pub fn new() -> Result<Self> {
        let vm_ptr = get_java_vm_ptr()?;

        // Safety: The vm_ptr comes from ndk_context, which is set by the
        // Android runtime during JNI_OnLoad or native activity creation.
        // It is a valid, non-null JavaVM* pointer.
        let jvm = unsafe { jni::JavaVM::from_raw(vm_ptr) }
            .context("Failed to wrap JavaVM pointer")?;

        log::info!("Successfully attached to existing Android JVM");
        Ok(Self { jvm })
    }

    /// Get JNIEnv for current thread (attaches if needed).
    /// Returns an AttachGuard that will detach when dropped.
    pub fn attach_current_thread(&self) -> Result<jni::AttachGuard<'_>> {
        self.jvm
            .attach_current_thread()
            .context("Failed to attach thread to Android JVM")
    }

    /// Check if current thread is already attached to the JVM.
    pub fn is_attached(&self) -> bool {
        self.jvm.get_env().is_ok()
    }

    /// Get a reference to the underlying JavaVM.
    #[allow(dead_code)]
    pub fn raw_jvm(&self) -> &jni::JavaVM {
        &self.jvm
    }
}

// JVM is Send + Sync (thread-safe)
unsafe impl Send for JvmHandle {}
unsafe impl Sync for JvmHandle {}

/// Get the JavaVM pointer from ndk_context.
///
/// ndk_context stores the JavaVM pointer that was set during the app's
/// initialization (typically in JNI_OnLoad or by the native activity).
fn get_java_vm_ptr() -> Result<*mut jni::sys::JavaVM> {
    let android_context = ndk_context::android_context();

    let vm_ptr: *mut jni::sys::JavaVM = android_context.vm().cast();

    if vm_ptr.is_null() {
        bail!(
            "JavaVM pointer is null. The Android app may not have properly \
             initialized the native context."
        );
    }

    log::debug!("Obtained JavaVM pointer from ndk_context: {:?}", vm_ptr);
    Ok(vm_ptr)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    #[ignore] // Can only run on Android
    fn test_android_jvm_attach() {
        let handle = JvmHandle::new();
        assert!(
            handle.is_ok(),
            "Failed to create JvmHandle: {:?}",
            handle.err()
        );
    }
}