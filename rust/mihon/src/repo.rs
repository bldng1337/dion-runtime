//! Mihon/Tachiyomi extension repository index parsing and mapping.
//!
//! A Mihon repo serves a JSON array at `{repo_base}/index.min.json`. Each
//! element describes one extension APK available at
//! `{repo_base}/apk/{apk}` with an icon at `{repo_base}/icon/{pkg}.png`.
//!
//! Unlike dion's own repo format, the Mihon index carries no top-level repo
//! metadata (name/description/...), so [`build_extension_repo`] derives a
//! best-effort name from the URL.

use serde::Deserialize;

use dion_runtime::data::{
    extension_repo::{ExtensionRepo, RemoteExtension, RemoteExtensionResult},
    source::Link,
};

// ---------------------------------------------------------------------------
// URL helpers
// ---------------------------------------------------------------------------

/// Normalize a user-provided repo URL to the `index.min.json` URL.
///
/// Accepts both bare repo URLs (`…/repo`) and full index URLs
/// (`…/repo/index.min.json`).
pub(crate) fn normalize_index_url(url: &str) -> String {
    if url.ends_with(".json") {
        url.to_string()
    } else {
        let trimmed = url.trim_end_matches('/');
        format!("{}/index.min.json", trimmed)
    }
}

/// Return the directory portion of an index URL — everything before the final
/// path segment. Used to build `apk/` and `icon/` download URLs.
pub(crate) fn repo_base_url(index_url: &str) -> String {
    match index_url.rfind('/') {
        Some(pos) => index_url[..pos].to_string(),
        None => index_url.to_string(),
    }
}

/// Best-effort human-readable name derived from a repo URL.
///
/// For GitHub raw URLs this yields `owner/repo`; otherwise the hostname.
fn derive_repo_name(url: &str) -> String {
    let stripped = url
        .strip_prefix("https://")
        .or_else(|| url.strip_prefix("http://"))
        .unwrap_or(url);

    if let Some(rest) = stripped.strip_prefix("raw.githubusercontent.com/") {
        let mut parts = rest.split('/');
        if let (Some(owner), Some(repo)) = (parts.next(), parts.next()) {
            if !owner.is_empty() && !repo.is_empty() {
                return format!("{}/{}", owner, repo);
            }
        }
    }

    // Fall back to the hostname.
    stripped.split('/').next().unwrap_or(stripped).to_string()
}

/// Build an [`ExtensionRepo`] from a normalized index URL.
pub(crate) fn build_extension_repo(index_url: &str) -> ExtensionRepo {
    let base = repo_base_url(index_url);
    ExtensionRepo {
        remote_id: index_url.to_string(),
        name: derive_repo_name(&base),
        description: String::new(),
        url: base,
    }
}

// ---------------------------------------------------------------------------
// Wire types — match the JSON shape of `index.min.json`.
//
// Unknown fields are silently ignored by serde, so forward-compatible
// additions to the index format won't break deserialization.
// ---------------------------------------------------------------------------

/// One entry in the repo index.
#[derive(Debug, Deserialize, Clone)]
#[allow(dead_code)] // wire-format fields kept for future use (lang/code filtering, nsfw toggle)
pub(crate) struct RepoExtension {
    /// Display name (e.g. `"Tachiyomi: AHottie"`).
    pub name: String,
    /// Package name (e.g. `"eu.kanade.tachiyomi.extension.all.ahottie"`).
    pub pkg: String,
    /// APK file name (e.g. `"tachiyomi-all.ahottie-v1.4.3.apk"`).
    pub apk: String,
    /// Primary language code.
    #[serde(default)]
    pub lang: String,
    /// Version code (integer).
    #[serde(default)]
    pub code: u32,
    /// Version string (e.g. `"1.4.3"`).
    #[serde(default)]
    pub version: String,
    /// NSFW flag (0 = SFW, 1 = NSFW).
    #[serde(default)]
    pub nsfw: u8,
    /// Sources provided by this extension.
    #[serde(default)]
    pub sources: Vec<RepoSource>,
}

/// A source listed inside a [`RepoExtension`].
#[derive(Debug, Deserialize, Clone)]
#[allow(dead_code)] // wire-format fields kept for future use
pub(crate) struct RepoSource {
    pub name: String,
    #[serde(default)]
    pub lang: String,
    /// Mihon source id (a large integer serialized as a string).
    pub id: String,
    #[serde(rename = "baseUrl", default)]
    pub base_url: String,
}

impl RepoExtension {
    /// Whether this entry is marked NSFW.
    #[allow(dead_code)] // exposed for future nsfw filtering
    pub(crate) fn is_nsfw(&self) -> bool {
        self.nsfw != 0
    }

    /// Convert to a [`RemoteExtension`] resolved against `base_url`
    /// (the repo directory that contains `apk/` and `icon/`).
    pub(crate) fn to_remote(&self, base_url: &str) -> RemoteExtension {
        RemoteExtension {
            id: self.pkg.clone(),
            remote_id: format!("{}/apk/{}", base_url, self.apk),
            name: self.name.clone(),
            url: self
                .sources
                .first()
                .map(|s| s.base_url.clone())
                .unwrap_or_default(),
            cover: Some(Link {
                url: format!("{}/icon/{}.png", base_url, self.pkg),
                header: None,
            }),
            version: self.version.clone(),
            // The index has no lib_version field, so we can't pre-check
            // compatibility. Default to compatible — this mirrors
            // MihonExtensionMetadata::is_compatible() which treats a missing
            // lib_version as compatible.
            compatible: true,
        }
    }
}

/// Convert a parsed index into a [`RemoteExtensionResult`].
pub(crate) fn index_to_result(index: &[RepoExtension], base_url: &str) -> RemoteExtensionResult {
    RemoteExtensionResult {
        content: index.iter().map(|e| e.to_remote(base_url)).collect(),
        hasnext: Some(false),
        length: Some(index.len() as i32),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn normalize_bare_repo_url() {
        let url = "https://raw.githubusercontent.com/keiyoushi/extensions/repo";
        assert_eq!(
            normalize_index_url(url),
            "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
        );
    }

    #[test]
    fn normalize_bare_repo_url_trailing_slash() {
        let url = "https://raw.githubusercontent.com/keiyoushi/extensions/repo/";
        assert_eq!(
            normalize_index_url(url),
            "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json"
        );
    }

    #[test]
    fn normalize_full_index_url() {
        let url = "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json";
        assert_eq!(normalize_index_url(url), url);
    }

    #[test]
    fn base_url_from_index() {
        let index = "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json";
        assert_eq!(
            repo_base_url(index),
            "https://raw.githubusercontent.com/keiyoushi/extensions/repo"
        );
    }

    #[test]
    fn derive_name_github() {
        let base = "https://raw.githubusercontent.com/keiyoushi/extensions/repo";
        assert_eq!(derive_repo_name(base), "keiyoushi/extensions");
    }

    #[test]
    fn derive_name_non_github() {
        let base = "https://example.com/some/repo";
        assert_eq!(derive_repo_name(base), "example.com");
    }

    #[test]
    fn parse_minimal_entry() {
        let json = r#"{
            "name": "Tachiyomi: AHottie",
            "pkg": "eu.kanade.tachiyomi.extension.all.ahottie",
            "apk": "tachiyomi-all.ahottie-v1.4.3.apk",
            "lang": "all",
            "code": 3,
            "version": "1.4.3",
            "nsfw": 1,
            "sources": [
                {"name": "AHottie", "lang": "all", "id": "6289731484943315811", "baseUrl": "https://ahottie.top"}
            ]
        }"#;
        let ext: RepoExtension = serde_json::from_str(json).unwrap();
        assert_eq!(ext.pkg, "eu.kanade.tachiyomi.extension.all.ahottie");
        assert_eq!(ext.version, "1.4.3");
        assert!(ext.is_nsfw());
        assert_eq!(ext.sources.len(), 1);
        assert_eq!(ext.sources[0].base_url, "https://ahottie.top");
    }

    #[test]
    fn parse_entry_with_defaults() {
        // Missing optional fields should default gracefully.
        let json = r#"{
            "name": "Test",
            "pkg": "eu.kanade.test",
            "apk": "test.apk"
        }"#;
        let ext: RepoExtension = serde_json::from_str(json).unwrap();
        assert_eq!(ext.lang, "");
        assert_eq!(ext.code, 0);
        assert_eq!(ext.version, "");
        assert!(!ext.is_nsfw());
        assert!(ext.sources.is_empty());
    }

    #[test]
    fn to_remote_builds_correct_urls() {
        let ext = RepoExtension {
            name: "Test".to_string(),
            pkg: "eu.kanade.test".to_string(),
            apk: "test-v1.0.apk".to_string(),
            lang: "en".to_string(),
            code: 1,
            version: "1.0".to_string(),
            nsfw: 0,
            sources: vec![RepoSource {
                name: "Test".to_string(),
                lang: "en".to_string(),
                id: "123".to_string(),
                base_url: "https://example.com".to_string(),
            }],
        };
        let base = "https://raw.githubusercontent.com/owner/repo/branch";
        let remote = ext.to_remote(base);
        assert_eq!(remote.id, "eu.kanade.test");
        assert_eq!(
            remote.remote_id,
            "https://raw.githubusercontent.com/owner/repo/branch/apk/test-v1.0.apk"
        );
        assert_eq!(
            remote.cover.as_ref().unwrap().url,
            "https://raw.githubusercontent.com/owner/repo/branch/icon/eu.kanade.test.png"
        );
        assert_eq!(remote.url, "https://example.com");
        assert_eq!(remote.version, "1.0");
        assert!(remote.compatible);
    }

    #[test]
    fn index_to_result_sets_length() {
        let index = vec![
            RepoExtension {
                name: "A".to_string(),
                pkg: "pkg.a".to_string(),
                apk: "a.apk".to_string(),
                lang: String::new(),
                code: 0,
                version: String::new(),
                nsfw: 0,
                sources: vec![],
            },
            RepoExtension {
                name: "B".to_string(),
                pkg: "pkg.b".to_string(),
                apk: "b.apk".to_string(),
                lang: String::new(),
                code: 0,
                version: String::new(),
                nsfw: 0,
                sources: vec![],
            },
        ];
        let result = index_to_result(&index, "https://example.com/repo");
        assert_eq!(result.content.len(), 2);
        assert_eq!(result.hasnext, Some(false));
        assert_eq!(result.length, Some(2));
    }
}
