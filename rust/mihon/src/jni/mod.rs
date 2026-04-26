//! JNI module for JVM interaction
//!
//! This module provides platform-specific JVM access:
//!
//! - **Desktop**: Creates an embedded JVM with the compat JAR classpath.
//!   Requires JAVA_HOME to point to a valid JDK/JRE installation.
//!
//! - **Android**: Attaches to the existing ART/Dalvik VM that the app
//!   is already running in. Uses ndk_context to obtain the JavaVM pointer.
//!
//! Both platforms expose the same `JvmHandle` interface for thread attachment
//! and the same `MihonBridge` for calling Kotlin bridge methods via JNI.

#[cfg(not(target_os = "android"))]
mod jvm;

#[cfg(target_os = "android")]
mod android;

pub mod bridge;

#[cfg(not(target_os = "android"))]
pub use jvm::JvmHandle;

#[cfg(target_os = "android")]
pub use android::JvmHandle;

#[cfg(target_os = "android")]
pub use android::{get_bridge_class, init_android};

pub use bridge::MihonBridge;