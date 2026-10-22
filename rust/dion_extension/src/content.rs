//! Android `content://` URI support for the `filesystem` module.
//!
//! The runtime itself has no Android bindings, so resolving SAF/provider
//! URIs goes through a process-wide handler the embedding app installs at
//! startup (the Flutter plugin registers a JNI-backed implementation backed
//! by `ContentResolver`; see rdion_runtime's Android init). Without a
//! handler, `content://` paths fail with a clear error instead of being
//! silently misinterpreted as relative filesystem paths.
//!
//! `content://` URIs are exempt from `Permission::Storage` prompts: access
//! is already scoped by the OS to the URI grant the user made in the system
//! picker.

use std::sync::{Arc, OnceLock};

use anyhow::{Result, anyhow};

/// File facts resolved from a `content://` URI.
#[derive(Debug, Clone, Default)]
pub struct ContentStat {
    /// Byte size when the provider reports one (OpenableColumns.SIZE).
    pub size: Option<u64>,
    /// Display name when the provider reports one (OpenableColumns.DISPLAY_NAME).
    pub name: Option<String>,
}

/// Reads and stats `content://` URIs. Implementations must be callable from
/// any thread (the JS executor runs on tokio workers).
pub trait ContentUriHandler: Send + Sync {
    fn read(&self, uri: &str) -> Result<Vec<u8>>;
    fn stat(&self, uri: &str) -> Result<ContentStat>;
}

static HANDLER: OnceLock<Arc<dyn ContentUriHandler>> = OnceLock::new();

/// Whether `path` is an Android content URI.
pub(crate) fn is_content_uri(path: &str) -> bool {
    path.trim().starts_with("content://")
}

/// Installs the process-wide content URI handler. The first registration
/// wins; later calls are ignored and return the already-installed handler.
pub fn set_content_uri_handler(
    handler: Arc<dyn ContentUriHandler>,
) -> Option<Arc<dyn ContentUriHandler>> {
    HANDLER.set(handler).err()
}

fn handler() -> Result<&'static Arc<dyn ContentUriHandler>> {
    HANDLER.get().ok_or_else(|| {
        anyhow!(
            "content:// URIs are not supported here: the host app did not \
             register a content resolver (Android only)"
        )
    })
}

pub(crate) fn read_content(uri: &str) -> Result<Vec<u8>> {
    handler()?.read(uri)
}

pub(crate) fn stat_content(uri: &str) -> Result<ContentStat> {
    handler()?.stat(uri)
}

#[cfg(test)]
mod tests {
    use super::*;

    struct Fixed;

    impl ContentUriHandler for Fixed {
        fn read(&self, uri: &str) -> Result<Vec<u8>> {
            Ok(uri.as_bytes().to_vec())
        }
        fn stat(&self, _uri: &str) -> Result<ContentStat> {
            Ok(ContentStat {
                size: Some(3),
                name: Some("a.txt".into()),
            })
        }
    }

    #[test]
    fn detects_content_uris() {
        assert!(is_content_uri("content://com.android/tree/abc"));
        assert!(is_content_uri("  content://x"));
        assert!(!is_content_uri("content:/nope"));
        assert!(!is_content_uri("/plain/path"));
    }

    #[test]
    fn first_handler_wins() {
        // Not registering in unit tests when another test already did: the
        // handler is process-global, so only assert the fallback error when
        // none is installed yet.
        if HANDLER.get().is_none() {
            assert!(read_content("content://x").is_err());
            let existing = set_content_uri_handler(Arc::new(Fixed));
            assert!(existing.is_none());
            assert_eq!(read_content("content://x").unwrap(), b"content://x");
        }
    }
}
