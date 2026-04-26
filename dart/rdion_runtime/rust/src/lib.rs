pub mod api;
mod frb_generated;

/// Android-specific initialization.
///
/// When the native library is loaded via `System.loadLibrary()` (triggered by
/// the `RdionRuntimePlugin` ContentProvider during app startup), the Android
/// runtime calls `JNI_OnLoad`. This delegates
/// to `mihon_adapter::jni::init_android` which:
///
/// 1. Obtains the Android Application context via `ActivityThread` reflection
///    and stores it in `ndk_context`.
/// 2. Caches the `AndroidMihonBridge` class as a JNI `GlobalRef` so that
///    native-attached threads (e.g. tokio-runtime-worker) can call its static
///    methods without hitting the `FindClass` classloader restriction.
#[cfg(target_os = "android")]
mod android_init {
    /// JNI version 1.6 constant, returned from `JNI_OnLoad` to indicate
    /// the supported JNI version to the Android runtime.
    const JNI_VERSION_1_6: i32 = 0x0001_0006;

    /// Called by the Android runtime when the native library is loaded via
    /// `System.loadLibrary()`.
    ///
    /// Delegates all initialization to `mihon_adapter::jni::init_android`,
    /// which uses the `jni` crate (safe JNI bindings) to:
    /// - Get the Application context via `ActivityThread.currentActivityThread().getApplication()`
    /// - Store it in `ndk_context` for later use by `MihonBridge::set_android_context()`
    /// - Cache `AndroidMihonBridge` as a `GlobalRef` for native thread access
    ///
    /// # Safety
    /// Called by the Android JNI runtime. The `vm` parameter is a valid `JavaVM*`
    /// pointer provided by the Android system.
    #[no_mangle]
    pub unsafe extern "C" fn JNI_OnLoad(
        vm: *mut std::ffi::c_void,
        _reserved: *mut std::ffi::c_void,
    ) -> i32 {
        if let Err(e) = mihon_adapter::jni::init_android(vm as *mut _) {
            log::error!("JNI_OnLoad: init_android failed: {e}");
        }

        JNI_VERSION_1_6
    }
}