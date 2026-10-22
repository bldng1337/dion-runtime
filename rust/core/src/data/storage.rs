use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// How much storage an extension uses, split by what owns the bytes. Sizes
/// are bytes; they are `f64` (not a 64-bit int) so they stay a plain JSON
/// `number` / Dart `double` across every binding — exact up to 2^53 bytes,
/// far beyond any real extension.
///
/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, Copy, Default, PartialEq)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(rename_all = "camelCase")]
pub struct StorageUsage {
    /// Runtime-managed caches: the JS `cache` module's persistent caches and
    /// the HTTP cache. Safe to clear at any time (`clear_cache`).
    pub cache: f64,
    /// The extension bundle/module itself (the installed `.dion.js` file or
    /// mihon APK/JAR), in bytes.
    pub extension_bytes: f64,
    /// Everything else in the extension's private data directory: cookies,
    /// files the extension wrote via the `filesystem` module, ... Clearing
    /// requires uninstalling the extension.
    pub data: f64,
}
