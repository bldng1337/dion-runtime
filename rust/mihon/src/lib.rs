//! Mihon/Tachiyomi extension adapter for dion-runtime
//!
//! This crate provides an `Adapter` implementation that can load and execute
//! Mihon/Tachiyomi Android extensions (APK files) on desktop platforms.
//!
//! # Requirements
//!
//! - Java 8+ installed and available (JAVA_HOME or on PATH)
//!
//! # Usage
//!
//! ```rust,no_run
//! use mihon_adapter::MihonAdapter;
//! use dion_runtime::client_data::AdapterClient;
//!
//! async fn example(client: Box<dyn AdapterClient>) {
//!     let adapter = MihonAdapter::new(client).await.unwrap();
//!     // adapter.get_extensions().await...
//! }
//! ```

mod adapter;
mod extension;
pub mod apk;
pub mod jni;
mod mapping;

pub use adapter::MihonAdapter;
pub use extension::{MihonExtension, MihonSourceType};
pub use apk::MihonExtensionMetadata;
