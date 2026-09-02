//! Mihon/Tsundoku extension store index parsing and mapping.
//!
//! Mirrors tsundoku's `ExtensionStoreService`
//! (`data/src/main/java/mihon/data/extension/service/ExtensionStoreService.kt`).
//! A repo URL can resolve to any of these payloads:
//!
//! - legacy `index.min.json` — a plain JSON array of extensions. Repo
//!   metadata (name/signing key) lives in a sibling `repo.json`, which the
//!   fetch flow redirects to automatically.
//! - `repo.json` — legacy repo metadata, optionally pointing at an
//!   `index_v2` URL with the new-style store.
//! - new-style store (`index.pb` or its JSON form) — a `NetworkExtensionStore`
//!   message carrying repo metadata and the extension list, whose entries
//!   reference absolute APK/icon URLs instead of the old `apk/`+`icon/`
//!   directory layout.
//!
//! Payloads may be gzipped regardless of file extension (NovelSourcery serves
//! `index.pb` gzipped), and the format is detected by the first byte:
//! `[` = legacy JSON array, `{` = JSON, anything else = protobuf.

use std::collections::HashSet;
use std::future::Future;
use std::io::Read;
use std::pin::Pin;

use anyhow::{Context, Result, bail};
use flate2::read::GzDecoder;
use prost::Message;
use serde::{Deserialize, Deserializer, de};

use dion_runtime::data::{
    extension_repo::{ExtensionRepo, RemoteExtension, RemoteExtensionResult},
    source::Link,
};

use crate::apk::metadata::SUPPORTED_LIB_VERSIONS;

/// Generated protobuf types for the `index.pb` store format.
mod proto {
    include!(concat!(env!("OUT_DIR"), "/mihon.extension.rs"));
}

/// Package prefix identifying novel extensions (tsundoku fork convention).
const NOVEL_PKG_PREFIX: &str = "eu.kanade.tachiyomi.novelextension";
/// Legacy index display names are prefixed with this; stripped on mapping.
const LEGACY_NAME_PREFIX: &str = "Tachiyomi: ";
/// Guard against `index_v2` redirect loops between store payloads.
const MAX_STORE_REDIRECTS: usize = 10;

// ---------------------------------------------------------------------------
// URL helpers
// ---------------------------------------------------------------------------

/// Normalize a user-provided repo URL to an index URL.
///
/// Accepts bare repo URLs (`…/repo`, resolved to the legacy
/// `…/repo/index.min.json`) as well as full index URLs
/// (`…/repo/index.min.json`, `…/repo/repo.json`, `…/repo/index.pb`), which
/// are passed through; the fetch flow sniffs the actual payload format.
pub(crate) fn normalize_index_url(url: &str) -> String {
    const INDEX_SUFFIXES: [&str; 3] = [".json", ".pb", ".pb.gz"];
    if INDEX_SUFFIXES.iter().any(|s| url.ends_with(s)) {
        url.to_string()
    } else {
        format!("{}/index.min.json", url.trim_end_matches('/'))
    }
}

/// Return the directory portion of an index URL — everything before the final
/// path segment. Used to locate sibling payloads (`repo.json`,
/// `index.min.json`) and to build `apk/` and `icon/` download URLs for
/// legacy repos.
pub(crate) fn repo_base_url(index_url: &str) -> String {
    match index_url.rfind('/') {
        Some(pos) => index_url[..pos].to_string(),
        None => index_url.to_string(),
    }
}

/// Best-effort human-readable name derived from a repo URL.
///
/// For GitHub raw URLs this yields `owner/repo`; otherwise the hostname. Used
/// as a fallback when a store payload carries no name.
pub(crate) fn derive_repo_name(url: &str) -> String {
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

// ---------------------------------------------------------------------------
// Normalized types
// ---------------------------------------------------------------------------

/// Resolved repo metadata, mirroring tsudoku's `ExtensionStore` domain model.
pub(crate) struct RepoStore {
    /// URL the store payload itself was fetched from (after any redirects).
    pub index_url: String,
    pub name: String,
    #[allow(dead_code)] // wire-format fields kept for future use
    pub badge_label: String,
    #[allow(dead_code)] // kept for future extension signature verification
    pub signing_key: String,
    /// True for old `index.min.json`-era repos (metadata from `repo.json`).
    pub is_legacy: bool,
    /// Optional separate URL hosting just the extension list.
    pub extension_list_url: Option<String>,
}

/// A fully resolved repo: store metadata plus its parsed extension list.
pub(crate) struct RepoIndex {
    pub store: RepoStore,
    pub extensions: Vec<RepoExtension>,
}

/// One extension entry, normalized across the legacy and store formats.
/// APK/icon URLs are already absolute.
#[derive(Debug, Clone)]
pub(crate) struct RepoExtension {
    pub name: String,
    /// Package name (e.g. `"eu.kanade.tachiyomi.extension.all.ahottie"`).
    pub pkg: String,
    /// Absolute APK download URL.
    pub apk_url: String,
    /// Absolute icon URL.
    pub icon_url: String,
    #[allow(dead_code)] // wire-format field kept for future lang filtering
    pub lang: String,
    #[allow(dead_code)] // wire-format field kept for future use
    pub code: i64,
    pub version: String,
    #[allow(dead_code)] // kept for future nsfw filtering
    pub nsfw: bool,
    /// Extension API lib version (e.g. `1.6`), when the index carries one.
    pub lib_version: Option<f64>,
    pub sources: Vec<RepoSource>,
    #[allow(dead_code)] // kept for future novel/manga filtering
    pub is_novel: bool,
}

/// A source listed inside a [`RepoExtension`].
#[derive(Debug, Clone)]
pub(crate) struct RepoSource {
    /// Mihon source id.
    pub id: i64,
    #[allow(dead_code)] // wire-format fields kept for future use
    pub name: String,
    #[allow(dead_code)] // wire-format fields kept for future use
    pub lang: String,
    /// Source home page.
    pub base_url: String,
}

impl RepoExtension {
    /// Convert to a [`RemoteExtension`].
    ///
    /// The id is derived from the first source's Mihon source id as
    /// `mihon:{source_id}` so it matches the id assigned to the extension
    /// once installed (see `MihonAdapter::load_extension_from_jar`). This
    /// lets the host match a repo entry against its installed counterpart.
    /// When the entry lists no sources (no source id available) we fall back
    /// to the package name so the entry is still representable.
    pub(crate) fn to_remote(&self) -> RemoteExtension {
        let id = self
            .sources
            .first()
            .map(|s| format!("mihon:{}", s.id))
            .unwrap_or_else(|| self.pkg.clone());
        RemoteExtension {
            id,
            remote_id: self.apk_url.clone(),
            name: self.name.clone(),
            url: self
                .sources
                .first()
                .map(|s| s.base_url.clone())
                .unwrap_or_default(),
            cover: Some(Link {
                url: self.icon_url.clone(),
                header: None,
            }),
            version: self.version.clone(),
            compatible: is_lib_compatible(self.lib_version),
            permissions: None,
        }
    }
}

/// Whether a lib version from the index is one we can run.
///
/// Missing/unknown values are treated as compatible — we can't know better
/// before downloading the APK.
fn is_lib_compatible(lib_version: Option<f64>) -> bool {
    match lib_version {
        Some(v) => SUPPORTED_LIB_VERSIONS.contains(&v),
        None => true,
    }
}

/// Convert a parsed extension list into a [`RemoteExtensionResult`].
pub(crate) fn index_to_result(extensions: &[RepoExtension]) -> RemoteExtensionResult {
    RemoteExtensionResult {
        content: extensions.iter().map(|e| e.to_remote()).collect(),
        hasnext: Some(false),
        length: Some(extensions.len() as i32),
    }
}

/// Build an [`ExtensionRepo`] from a resolved index. Falls back to a
/// URL-derived name when the store payload carries none.
pub(crate) fn build_extension_repo(index_url: &str, store: &RepoStore) -> ExtensionRepo {
    let base = repo_base_url(index_url);
    let name = if store.name.is_empty() {
        derive_repo_name(&base)
    } else {
        store.name.clone()
    };
    ExtensionRepo {
        remote_id: index_url.to_string(),
        name,
        description: String::new(),
        url: base,
    }
}

// ---------------------------------------------------------------------------
// Fetch flow
// ---------------------------------------------------------------------------

/// Fetch a repo index and resolve it to a store plus its extension list.
pub(crate) async fn fetch_repo(index_url: &str) -> Result<RepoIndex> {
    let store = fetch_store(index_url.to_string()).await?;
    let extensions = fetch_extensions(&store).await?;
    Ok(RepoIndex { store, extensions })
}

/// The outcome of parsing a store payload: either a resolved store, or a
/// legacy repo to resolve further (upgrading to its `index_v2` store when
/// its `repo.json` points at one).
enum StoreResolution {
    Store(RepoStore),
    /// The parsed `repo.json`, when the payload was one. `None` for a plain
    /// legacy extension array.
    Legacy(Option<LegacyRepoJson>),
}

/// Boxed so the `index_v2` redirect can recurse.
fn fetch_store(index_url: String) -> Pin<Box<dyn Future<Output = Result<RepoStore>> + Send>> {
    Box::pin(fetch_store_inner(index_url, 0))
}

async fn fetch_store_inner(index_url: String, depth: usize) -> Result<RepoStore> {
    if depth >= MAX_STORE_REDIRECTS {
        bail!("too many index redirects while resolving {index_url}");
    }
    let body = get_bytes(&index_url).await?;
    match parse_store_payload(&index_url, &body)? {
        StoreResolution::Store(store) => Ok(store),
        StoreResolution::Legacy(repo_json) => {
            resolve_legacy_store(index_url, repo_json, depth).await
        }
    }
}

/// Resolve a legacy repo to a store.
///
/// Newer repos publish a `repo.json` pointing at a new-style store
/// (`index_v2`); older ones only serve the plain JSON array, possibly with
/// no `repo.json` at all. Prefer the pointed-at store when it exists, but
/// always degrade to the plain legacy index rather than failing the repo.
async fn resolve_legacy_store(
    index_url: String,
    repo_json: Option<LegacyRepoJson>,
    depth: usize,
) -> Result<RepoStore> {
    // When we only saw the extension array, opportunistically fetch the
    // sibling `repo.json`.
    let repo_json = match repo_json {
        Some(repo) => Some(repo),
        None => {
            let url = format!("{}/repo.json", repo_base_url(&index_url));
            match get_bytes(&url).await {
                Ok(body) => serde_json::from_slice::<LegacyRepoJson>(&body).ok(),
                // No repo.json — a repo that never migrated past the bare
                // legacy index.
                Err(_) => None,
            }
        }
    };

    if let Some(v2) = repo_json
        .as_ref()
        .and_then(|r| r.index_v2.as_deref())
        .filter(|v| !v.is_empty())
    {
        match Box::pin(fetch_store_inner(v2.to_string(), depth + 1)).await {
            Ok(store) => return Ok(store),
            Err(err) => log::warn!(
                "index_v2 store {v2} is unavailable, falling back to the legacy index: {err:#}"
            ),
        }
    }

    let (name, badge_label, signing_key) = match repo_json {
        Some(repo) => (
            repo.meta.name,
            repo.meta.short_name.unwrap_or_default(),
            repo.meta.signing_key_fingerprint,
        ),
        // No metadata available; the adapter falls back to a URL-derived name.
        None => (String::new(), String::new(), String::new()),
    };
    Ok(RepoStore {
        index_url,
        name,
        badge_label,
        signing_key,
        is_legacy: true,
        extension_list_url: None,
    })
}

/// Parse a store payload, detecting the format by its first byte (after
/// transparent gzip decompression).
fn parse_store_payload(index_url: &str, body: &[u8]) -> Result<StoreResolution> {
    let body = decompress_if_gzipped(body);
    match body.first() {
        // Legacy JSON array of extensions.
        Some(b'[') => Ok(StoreResolution::Legacy(None)),
        // JSON: either legacy repo metadata (`repo.json`) or a JSON-encoded
        // store (protobuf's canonical JSON mapping).
        Some(b'{') => match serde_json::from_slice::<LegacyRepoJson>(&body) {
            Ok(repo) => Ok(StoreResolution::Legacy(Some(repo))),
            Err(_) => {
                let store: StoreJson =
                    serde_json::from_slice(&body).context("invalid extension store JSON")?;
                Ok(StoreResolution::Store(store.into_store(index_url)))
            }
        },
        // Protobuf `NetworkExtensionStore`.
        Some(_) => {
            let store = proto::NetworkExtensionStore::decode(&body[..])
                .context("invalid extension store protobuf")?;
            Ok(StoreResolution::Store(store.into_store(index_url)))
        }
        None => bail!("empty index response from {index_url}"),
    }
}

/// Fetch the extension list for a resolved store.
async fn fetch_extensions(store: &RepoStore) -> Result<Vec<RepoExtension>> {
    if store.is_legacy {
        // Legacy stores keep serving the plain JSON array. `index_url` is
        // either the repo's `repo.json` (already the full path minus the
        // file name once stripped) or the index file itself — both reduce
        // to the repo directory here.
        let base = match store.index_url.strip_suffix("/repo.json") {
            Some(dir) => dir.to_string(),
            None => repo_base_url(&store.index_url),
        };
        let body = get_bytes(&format!("{}/index.min.json", base)).await?;
        let list: Vec<LegacyExtensionJson> =
            serde_json::from_slice(&body).context("invalid legacy index JSON")?;
        Ok(list
            .iter()
            .map(|e| repo_extension_from_legacy(e, &base))
            .collect())
    } else if let Some(list_url) = &store.extension_list_url {
        let body = get_bytes(list_url).await?;
        let list = extension_list_from_payload(&body)?;
        Ok(list
            .extensions
            .iter()
            .map(repo_extension_from_store)
            .collect())
    } else {
        // The store embeds its list; re-fetch the store payload to read it.
        // (Decoding as a bare list would misparse a store payload — the
        // field-1 meanings differ — so always decode as a store first.)
        let body = get_bytes(&store.index_url).await?;
        let list = store_extension_list_from_payload(&body)
            .context("extension store carries no embedded extension list")?;
        Ok(list
            .extensions
            .iter()
            .map(repo_extension_from_store)
            .collect())
    }
}

/// Extract the embedded extension list from a store payload (JSON or
/// protobuf). `None` when the payload is not a store or carries no list.
fn store_extension_list_from_payload(
    body: &[u8],
) -> Option<proto::network_extension_store::ExtensionList> {
    let body = decompress_if_gzipped(body);
    match body.first() {
        Some(b'{') => serde_json::from_slice::<StoreJson>(&body)
            .ok()?
            .extension_list
            .map(ExtensionListJson::into_proto),
        Some(_) => proto::NetworkExtensionStore::decode(&body[..])
            .ok()?
            .extension_list,
        None => None,
    }
}

/// Parse an extension list payload: JSON object or protobuf.
fn extension_list_from_payload(
    body: &[u8],
) -> Result<proto::network_extension_store::ExtensionList> {
    let body = decompress_if_gzipped(body);
    match body.first() {
        Some(b'{') => {
            let list: ExtensionListJson =
                serde_json::from_slice(&body).context("invalid extension list JSON")?;
            Ok(list.into_proto())
        }
        Some(_) => proto::network_extension_store::ExtensionList::decode(&body[..])
            .context("invalid extension list protobuf"),
        None => bail!("empty extension list response"),
    }
}

/// GET a URL and return its (gzip-decompressed) body.
async fn get_bytes(url: &str) -> Result<Vec<u8>> {
    let response = reqwest::get(url)
        .await
        .with_context(|| format!("Failed to fetch {url}"))?;
    let status = response.status();
    if !status.is_success() {
        bail!("Failed to fetch {url}: HTTP {status}");
    }
    let bytes = response
        .bytes()
        .await
        .with_context(|| format!("Failed to read body of {url}"))?;
    Ok(decompress_if_gzipped(&bytes))
}

/// Decompress gzipped payloads, detected by magic bytes — repos like
/// NovelSourcery serve `index.pb` gzipped under a plain `.pb` name.
fn decompress_if_gzipped(bytes: &[u8]) -> Vec<u8> {
    if bytes.starts_with(&[0x1f, 0x8b]) {
        let mut out = Vec::new();
        if GzDecoder::new(bytes).read_to_end(&mut out).is_ok() {
            return out;
        }
    }
    bytes.to_vec()
}

// ---------------------------------------------------------------------------
// Store mapping (protobuf types are the canonical intermediate)
// ---------------------------------------------------------------------------

impl proto::NetworkExtensionStore {
    fn into_store(self, index_url: &str) -> RepoStore {
        RepoStore {
            index_url: index_url.to_string(),
            name: self.name,
            badge_label: self.badge_label,
            signing_key: self.signing_key,
            is_legacy: false,
            extension_list_url: self.extension_list_url,
        }
    }
}

/// Map a store-format extension entry to a normalized [`RepoExtension`].
fn repo_extension_from_store(ext: &proto::network_extension_store::Extension) -> RepoExtension {
    let sources: Vec<RepoSource> = ext
        .sources
        .iter()
        .map(|s| RepoSource {
            id: s.id,
            name: s.name.clone(),
            lang: s.language.clone(),
            base_url: s.home_url.clone(),
        })
        .collect();
    // A single source language is the extension's lang; otherwise "all".
    let langs: HashSet<&str> = ext.sources.iter().map(|s| s.language.as_str()).collect();
    let lang = if langs.len() == 1 {
        langs.into_iter().next().unwrap().to_string()
    } else {
        "all".to_string()
    };
    RepoExtension {
        name: ext.name.clone(),
        pkg: ext.package_name.clone(),
        apk_url: ext
            .resources
            .as_ref()
            .map(|r| r.apk_url.clone())
            .unwrap_or_default(),
        icon_url: ext
            .resources
            .as_ref()
            .map(|r| r.icon_url.clone())
            .unwrap_or_default(),
        lang,
        code: ext.version_code,
        version: ext.version_name.clone(),
        nsfw: ext.content_warning() >= proto::ContentWarning::Mixed,
        lib_version: parse_lib_version(&ext.extension_lib),
        sources,
        // The real is_novel field is authoritative; the package-prefix check
        // is only a fallback for stores whose index predates it.
        is_novel: ext.is_novel || ext.package_name.starts_with(NOVEL_PKG_PREFIX),
    }
}

/// Parse an extension lib version string (e.g. `"1.6"`).
fn parse_lib_version(s: &str) -> Option<f64> {
    s.trim().parse().ok()
}

// ---------------------------------------------------------------------------
// Legacy `index.min.json` wire types
// ---------------------------------------------------------------------------

/// One entry in a legacy `index.min.json` array.
#[derive(Debug, Deserialize)]
struct LegacyExtensionJson {
    #[serde(default)]
    name: String,
    #[serde(default)]
    pkg: String,
    #[serde(default)]
    apk: String,
    #[serde(default)]
    lang: String,
    #[serde(default, deserialize_with = "de_lenient_i64")]
    code: i64,
    #[serde(default)]
    version: String,
    #[serde(default, deserialize_with = "de_lenient_i64")]
    nsfw: i64,
    /// Nullable in the tsundoku model; `null` is treated as no sources.
    #[serde(default)]
    sources: Option<Vec<LegacySourceJson>>,
}

/// A source listed inside a [`LegacyExtensionJson`].
#[derive(Debug, Deserialize)]
struct LegacySourceJson {
    #[serde(default, deserialize_with = "de_lenient_i64")]
    id: i64,
    #[serde(default)]
    lang: String,
    #[serde(default)]
    name: String,
    #[serde(rename = "baseUrl", default)]
    base_url: String,
}

impl LegacyExtensionJson {
    fn sources(&self) -> &[LegacySourceJson] {
        self.sources.as_deref().unwrap_or(&[])
    }
}

/// Map a legacy index entry to a normalized [`RepoExtension`], resolving
/// `apk/` and `icon/` URLs against `base` (the repo directory).
fn repo_extension_from_legacy(ext: &LegacyExtensionJson, base: &str) -> RepoExtension {
    let sources: Vec<RepoSource> = ext
        .sources()
        .iter()
        .map(|s| RepoSource {
            id: s.id,
            name: s.name.clone(),
            lang: s.lang.clone(),
            base_url: s.base_url.clone(),
        })
        .collect();
    RepoExtension {
        // tsundoku strips the legacy "Tachiyomi: " display prefix.
        name: ext
            .name
            .strip_prefix(LEGACY_NAME_PREFIX)
            .unwrap_or(&ext.name)
            .to_string(),
        pkg: ext.pkg.clone(),
        apk_url: format!("{}/apk/{}", base, ext.apk),
        icon_url: format!("{}/icon/{}.png", base, ext.pkg),
        lang: ext.lang.clone(),
        code: ext.code,
        version: ext.version.clone(),
        nsfw: ext.nsfw == 1,
        // The legacy index has no lib field; tsundoku approximates it from
        // the version string ("1.4.3" → 1.4). Anime repos use a different
        // versioning scheme ("14.10") where this yields nonsense like 14.0,
        // so only trust the estimate when it lands in the plausible 1.x lib
        // range; anything else means "unknown".
        lib_version: ext
            .version
            .rsplit_once('.')
            .and_then(|(major_minor, _)| major_minor.parse().ok())
            .filter(|v| (1.0..2.0).contains(v)),
        sources,
        // Legacy index carries no novel flag; novel extensions use the
        // novelextension package prefix.
        is_novel: ext.pkg.starts_with(NOVEL_PKG_PREFIX),
    }
}

/// `repo.json` — legacy repo metadata. Field names are mixed-case: `index_v2`
/// is explicit, the rest keep kotlinx camelCase naming.
#[derive(Debug, Deserialize)]
struct LegacyRepoJson {
    #[serde(rename = "index_v2", alias = "indexV2", default)]
    index_v2: Option<String>,
    meta: LegacyRepoMetaJson,
}

#[derive(Debug, Deserialize)]
struct LegacyRepoMetaJson {
    name: String,
    #[serde(rename = "shortName", default)]
    short_name: Option<String>,
    #[serde(default)]
    #[allow(dead_code)] // wire-format field kept for future use
    website: String,
    #[serde(rename = "signingKeyFingerprint", default)]
    signing_key_fingerprint: String,
}

// ---------------------------------------------------------------------------
// JSON-encoded store wire types
//
// Covers protobuf's canonical JSON mapping (used by repos like NovelSourcery
// for their `index.json`): lowerCamelCase names (with snake_case proto names
// accepted as aliases), int64s as quoted strings, and enum values as
// `CONTENT_WARNING_*` names.
// ---------------------------------------------------------------------------

#[derive(Debug, Clone, Deserialize, Default)]
#[serde(rename_all = "camelCase", default)]
struct StoreJson {
    #[serde(default)]
    name: String,
    #[serde(default, alias = "badge_label")]
    badge_label: String,
    #[serde(default, alias = "signing_key")]
    signing_key: String,
    contact: Option<ContactJson>,
    #[serde(alias = "extension_list")]
    extension_list: Option<ExtensionListJson>,
    #[serde(default, alias = "extension_list_url")]
    extension_list_url: Option<String>,
}

impl StoreJson {
    fn into_store(self, index_url: &str) -> RepoStore {
        RepoStore {
            index_url: index_url.to_string(),
            name: self.name,
            badge_label: self.badge_label,
            signing_key: self.signing_key,
            is_legacy: false,
            extension_list_url: self.extension_list_url,
        }
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
#[serde(rename_all = "camelCase", default)]
struct ContactJson {
    #[serde(default)]
    #[allow(dead_code)] // wire-format field kept for future use
    website: String,
    discord: Option<String>,
}

#[derive(Debug, Clone, Deserialize, Default)]
#[serde(rename_all = "camelCase", default)]
struct ExtensionListJson {
    #[serde(default)]
    extensions: Vec<ExtensionJson>,
}

impl ExtensionListJson {
    fn into_proto(self) -> proto::network_extension_store::ExtensionList {
        proto::network_extension_store::ExtensionList {
            extensions: self.extensions.into_iter().map(|e| e.into_proto()).collect(),
        }
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
#[serde(rename_all = "camelCase", default)]
struct ExtensionJson {
    #[serde(default)]
    name: String,
    #[serde(default, alias = "package_name")]
    package_name: String,
    resources: Option<ResourcesJson>,
    #[serde(default, alias = "extension_lib")]
    extension_lib: String,
    #[serde(default, deserialize_with = "de_lenient_i64", alias = "version_code")]
    version_code: i64,
    #[serde(default, alias = "version_name")]
    version_name: String,
    #[serde(
        default,
        deserialize_with = "de_content_warning",
        alias = "content_warning"
    )]
    content_warning: i32,
    #[serde(default)]
    sources: Vec<SourceJson>,
    #[serde(default, alias = "is_novel")]
    is_novel: bool,
}

impl ExtensionJson {
    fn into_proto(self) -> proto::network_extension_store::Extension {
        proto::network_extension_store::Extension {
            name: self.name,
            package_name: self.package_name,
            resources: self.resources.map(|r| r.into_proto()),
            extension_lib: self.extension_lib,
            version_code: self.version_code,
            version_name: self.version_name,
            content_warning: self.content_warning,
            sources: self.sources.into_iter().map(|s| s.into_proto()).collect(),
            is_novel: self.is_novel,
        }
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
#[serde(rename_all = "camelCase", default)]
struct ResourcesJson {
    #[serde(default, alias = "apk_url")]
    apk_url: String,
    #[serde(default, alias = "icon_url")]
    icon_url: String,
}

impl ResourcesJson {
    fn into_proto(self) -> proto::network_extension_store::Resources {
        proto::network_extension_store::Resources {
            apk_url: self.apk_url,
            icon_url: self.icon_url,
        }
    }
}

#[derive(Debug, Clone, Deserialize, Default)]
#[serde(rename_all = "camelCase", default)]
struct SourceJson {
    #[serde(default, deserialize_with = "de_lenient_i64")]
    id: i64,
    #[serde(default)]
    name: String,
    #[serde(default)]
    language: String,
    #[serde(default, alias = "home_url")]
    home_url: String,
}

impl SourceJson {
    fn into_proto(self) -> proto::network_extension_store::Source {
        proto::network_extension_store::Source {
            id: self.id,
            name: self.name,
            language: self.language,
            home_url: self.home_url,
            ..Default::default()
        }
    }
}

/// Deserialize an integer that may arrive quoted as a string (protobuf's
/// canonical JSON mapping renders int64s as strings).
fn de_lenient_i64<'de, D: Deserializer<'de>>(deserializer: D) -> Result<i64, D::Error> {
    struct V;
    impl de::Visitor<'_> for V {
        type Value = i64;
        fn expecting(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            f.write_str("an integer or integer string")
        }
        fn visit_i64<E: de::Error>(self, v: i64) -> Result<i64, E> {
            Ok(v)
        }
        fn visit_u64<E: de::Error>(self, v: u64) -> Result<i64, E> {
            i64::try_from(v).map_err(|_| E::custom(format!("integer out of range: {v}")))
        }
        fn visit_str<E: de::Error>(self, v: &str) -> Result<i64, E> {
            v.trim().parse().map_err(E::custom)
        }
    }
    deserializer.deserialize_any(V)
}

/// Deserialize a `ContentWarning` from its number or one of its names
/// (`"SAFE"`, `"CONTENT_WARNING_NSFW"`, ...).
fn de_content_warning<'de, D: Deserializer<'de>>(deserializer: D) -> Result<i32, D::Error> {
    struct V;
    impl de::Visitor<'_> for V {
        type Value = i32;
        fn expecting(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            f.write_str("a content warning number or name")
        }
        fn visit_i64<E: de::Error>(self, v: i64) -> Result<i32, E> {
            i32::try_from(v).map_err(|_| E::custom(format!("content warning out of range: {v}")))
        }
        fn visit_u64<E: de::Error>(self, v: u64) -> Result<i32, E> {
            i32::try_from(v).map_err(|_| E::custom(format!("content warning out of range: {v}")))
        }
        fn visit_str<E: de::Error>(self, v: &str) -> Result<i32, E> {
            let name = v.trim().strip_prefix("CONTENT_WARNING_").unwrap_or(v);
            match name {
                "UNSPECIFIED" | "0" => Ok(0),
                "SAFE" | "1" => Ok(1),
                "MIXED" | "2" => Ok(2),
                "NSFW" | "3" => Ok(3),
                other => Err(E::custom(format!("unknown content warning: {other}"))),
            }
        }
    }
    deserializer.deserialize_any(V)
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Write;

    fn fixture(name: &str) -> Vec<u8> {
        std::fs::read(
            std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                .join("tests/fixtures/repos")
                .join(name),
        )
        .unwrap()
    }

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
    fn normalize_full_index_urls_pass_through() {
        let base = "https://raw.githubusercontent.com/NovelSourcery/extensions/repo";
        for suffix in [
            "/index.min.json",
            "/index.json",
            "/repo.json",
            "/index.pb",
            "/index.pb.gz",
        ] {
            let url = format!("{base}{suffix}");
            assert_eq!(normalize_index_url(&url), url);
        }
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
    fn parses_gzipped_index_pb_fixture() {
        // The real NovelSourcery index.pb is gzipped despite the extension.
        let body = fixture("novelsourcery_index.pb");
        assert_eq!(&body[..2], &[0x1f, 0x8b]);
        let resolution = parse_store_payload("https://example.com/repo/index.pb", &body).unwrap();
        let StoreResolution::Store(store) = resolution else {
            panic!("expected store, got redirect");
        };
        assert!(!store.is_legacy);
        assert_eq!(store.name, "NovelSourcery");
        assert_eq!(store.badge_label, "NS");
        assert_eq!(
            store.signing_key,
            "4281820d4866bb71bed3dec5224aad9cf4633d44a113682cfb0c3b1cfd71702d"
        );
        assert!(store.extension_list_url.is_none());
    }

    #[test]
    fn parses_store_extension_list_from_pb_fixture() {
        let body = decompress_if_gzipped(&fixture("novelsourcery_index.pb"));
        let store = proto::NetworkExtensionStore::decode(&body[..]).unwrap();
        let extensions: Vec<RepoExtension> = store
            .extension_list
            .unwrap()
            .extensions
            .iter()
            .map(repo_extension_from_store)
            .collect();
        assert!(extensions.len() > 1);

        let calibre = extensions
            .iter()
            .find(|e| e.pkg == "eu.kanade.tachiyomi.novelextension.all.calibre")
            .expect("calibre extension missing");
        assert_eq!(calibre.name, "Calibre");
        assert_eq!(calibre.version, "1.6.3");
        assert_eq!(calibre.lib_version, Some(1.6));
        assert!(calibre.is_novel);
        assert!(!calibre.nsfw);
        assert_eq!(calibre.lang, "all");
        assert_eq!(calibre.sources.len(), 1);
        assert_eq!(calibre.sources[0].id, 4559036889793122925);

        let remote = calibre.to_remote();
        assert_eq!(remote.id, "mihon:4559036889793122925");
        assert_eq!(remote.remote_id, calibre.apk_url);
        assert!(remote.compatible);
        assert!(remote.remote_id.starts_with("https://cdn.jsdelivr.net/"));
        assert!(remote.cover.as_ref().unwrap().url.ends_with(".png"));
        assert_eq!(remote.version, "1.6.3");
    }

    #[test]
    fn parses_repo_json_fixture_with_index_v2() {
        // NovelSourcery's repo.json points at the new-style index.pb.
        let body = fixture("novelsourcery_repo.json");
        let resolution =
            parse_store_payload("https://example.com/repo/repo.json", &body).unwrap();
        let StoreResolution::Legacy(Some(repo)) = resolution else {
            panic!("expected legacy repo, got something else");
        };
        assert_eq!(
            repo.index_v2.as_deref(),
            Some("https://github.com/NovelSourcery/extensions/raw/repo/index.pb")
        );
    }

    #[test]
    fn resolves_repo_json_without_index_v2_as_legacy_store() {
        let body = br#"{
            "meta": {
                "name": "Legacy Repo",
                "shortName": "LR",
                "website": "https://example.com",
                "signingKeyFingerprint": "aabbcc"
            }
        }"#;
        let resolution =
            parse_store_payload("https://example.com/repo/repo.json", body).unwrap();
        let StoreResolution::Legacy(repo_json) = resolution else {
            panic!("expected legacy repo, got something else");
        };
        let rt = tokio::runtime::Runtime::new().unwrap();
        let store = rt
            .block_on(resolve_legacy_store(
                "https://example.com/repo/repo.json".to_string(),
                repo_json,
                0,
            ))
            .unwrap();
        assert!(store.is_legacy);
        assert_eq!(store.name, "Legacy Repo");
        assert_eq!(store.badge_label, "LR");
        assert_eq!(store.signing_key, "aabbcc");
        assert!(store.extension_list_url.is_none());
    }

    #[test]
    fn resolves_bare_legacy_store_without_repo_json() {
        // A plain `[`-array payload with no reachable repo.json (connection
        // refused on the loopback discard port) degrades to a bare legacy
        // store instead of failing the repo.
        let resolution = parse_store_payload(
            "http://127.0.0.1:9/repo/index.min.json",
            br#"[{"name":"X","pkg":"p.x","apk":"x.apk"}]"#,
        )
        .unwrap();
        let StoreResolution::Legacy(repo_json) = resolution else {
            panic!("expected legacy repo, got something else");
        };
        assert!(repo_json.is_none());
        let rt = tokio::runtime::Runtime::new().unwrap();
        let store = rt
            .block_on(resolve_legacy_store(
                "http://127.0.0.1:9/repo/index.min.json".to_string(),
                repo_json,
                0,
            ))
            .unwrap();
        assert!(store.is_legacy);
        assert_eq!(store.name, "");
        assert_eq!(store.index_url, "http://127.0.0.1:9/repo/index.min.json");
    }

    #[test]
    fn legacy_array_parses_as_legacy_resolution() {
        let body = fixture("novelsourcery_index.min.json");
        let url = "https://raw.githubusercontent.com/NovelSourcery/extensions/repo/index.min.json";
        let resolution = parse_store_payload(url, &body).unwrap();
        assert!(matches!(resolution, StoreResolution::Legacy(None)));
    }

    #[test]
    fn legacy_extension_base_derivation_skips_double_strip() {
        // Regression: for a store resolved from `…/repo/repo.json`, the
        // legacy branch used to strip "/repo.json" and then strip the "repo"
        // directory too, fetching `…/index.min.json` instead of
        // `…/repo/index.min.json`.
        let store = RepoStore {
            index_url: "https://example.com/anime-repo/repo/repo.json".to_string(),
            name: "Y".to_string(),
            badge_label: String::new(),
            signing_key: String::new(),
            is_legacy: true,
            extension_list_url: None,
        };
        let base = match store.index_url.strip_suffix("/repo.json") {
            Some(dir) => dir.to_string(),
            None => repo_base_url(&store.index_url),
        };
        assert_eq!(base, "https://example.com/anime-repo/repo");

        // A store resolved straight from the index file keeps working too.
        let store = RepoStore {
            index_url: "https://example.com/anime-repo/repo/index.min.json".to_string(),
            ..store
        };
        let base = match store.index_url.strip_suffix("/repo.json") {
            Some(dir) => dir.to_string(),
            None => repo_base_url(&store.index_url),
        };
        assert_eq!(base, "https://example.com/anime-repo/repo");
    }

    #[test]
    fn anime_versioning_does_not_implicate_lib_version() {
        // Anime repos version extensions "14.10"; the version-derived lib
        // estimate must stay None (→ compatible) outside the 1.x range.
        let json = r#"{
            "name": "Aniyomi: AnimeOnsen",
            "pkg": "eu.kanade.tachiyomi.animeextension.all.animeonsen",
            "apk": "aniyomi-all.animeonsen-v14.10.apk",
            "lang": "all",
            "code": 10,
            "version": "14.10",
            "nsfw": 0,
            "sources": [{"name": "AnimeOnsen", "lang": "all", "id": "8542735178285060053", "baseUrl": "https://www.animeonsen.xyz"}]
        }"#;
        let ext: LegacyExtensionJson = serde_json::from_str(json).unwrap();
        let mapped = repo_extension_from_legacy(&ext, "https://example.com/repo");
        assert_eq!(mapped.lib_version, None);
        assert!(mapped.to_remote().compatible);
    }

    #[test]
    fn parses_legacy_index_entries() {
        let body = fixture("novelsourcery_index.min.json");
        let list: Vec<LegacyExtensionJson> = serde_json::from_slice(&body).unwrap();
        assert_eq!(list.len(), 2);
        let base = "https://raw.githubusercontent.com/NovelSourcery/extensions/repo";
        let ext = repo_extension_from_legacy(&list[0], base);
        assert_eq!(ext.name, "Outdated App");
        assert_eq!(ext.pkg, "eu.kanade.tachiyomi.extension.all.keiyoushi");
        assert_eq!(
            ext.apk_url,
            format!("{base}/apk/tachiyomi-all.keiyoushi-v1.4.1.apk")
        );
        assert_eq!(
            ext.icon_url,
            format!("{base}/icon/eu.kanade.tachiyomi.extension.all.keiyoushi.png")
        );
        assert_eq!(ext.version, "1.4.1");
        assert_eq!(ext.lib_version, Some(1.4));
        assert!(!ext.is_novel);
        let remote = ext.to_remote();
        assert_eq!(remote.id, "mihon:1");
        assert!(remote.compatible);
    }

    #[test]
    fn strips_legacy_name_prefix() {
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
        let ext: LegacyExtensionJson = serde_json::from_str(json).unwrap();
        assert_eq!(ext.code, 3);
        assert_eq!(ext.nsfw, 1);
        let mapped = repo_extension_from_legacy(&ext, "https://example.com/repo");
        assert_eq!(mapped.name, "AHottie");
        assert!(mapped.nsfw);
        assert_eq!(mapped.sources[0].id, 6289731484943315811);
        assert!(!mapped.is_novel);
    }

    #[test]
    fn parses_protojson_store_fixture() {
        // index.json is protobuf's canonical JSON form: camelCase names,
        // quoted int64s, CONTENT_WARNING_* enums.
        let body = fixture("novelsourcery_index.json");
        let resolution = parse_store_payload("https://example.com/repo/index.json", &body).unwrap();
        let StoreResolution::Store(store) = resolution else {
            panic!("expected store, got redirect");
        };
        assert!(!store.is_legacy);
        assert_eq!(store.name, "NovelSourcery");
        assert_eq!(store.badge_label, "NS");

        let json: StoreJson = serde_json::from_slice(&body).unwrap();
        let list = json.extension_list.expect("extension list missing");
        let calibre = list
            .extensions
            .iter()
            .find(|e| e.package_name == "eu.kanade.tachiyomi.novelextension.all.calibre")
            .expect("calibre missing");
        assert_eq!(calibre.version_code, 3);
        assert_eq!(calibre.extension_lib, "1.6");
        assert_eq!(calibre.content_warning, 1);
        assert!(calibre.is_novel);
        assert_eq!(calibre.sources[0].id, 4559036889793122925);
    }

    #[test]
    fn json_store_accepts_snake_case_aliases() {
        let json = r#"{
            "name": "Test Store",
            "badge_label": "TS",
            "signing_key": "abc",
            "extension_list": {
                "extensions": [{
                    "name": "Ext",
                    "package_name": "eu.kanade.tachiyomi.extension.en.test",
                    "resources": {"apk_url": "https://x/a.apk", "icon_url": "https://x/i.png"},
                    "extension_lib": "1.4",
                    "version_code": 7,
                    "version_name": "1.2.3",
                    "content_warning": "SAFE",
                    "sources": [{"id": 42, "name": "S", "language": "en", "home_url": "https://s"}]
                }]
            }
        }"#;
        let store: StoreJson = serde_json::from_str(json).unwrap();
        assert_eq!(store.badge_label, "TS");
        assert_eq!(store.signing_key, "abc");
        let list = store.extension_list.unwrap();
        let ext = &list.extensions[0];
        assert_eq!(ext.package_name, "eu.kanade.tachiyomi.extension.en.test");
        assert_eq!(ext.version_code, 7);
        assert_eq!(ext.content_warning, 1);
        let mapped = repo_extension_from_store(&ext.clone().into_proto());
        assert_eq!(mapped.sources[0].id, 42);
        assert_eq!(mapped.lang, "en");
        assert_eq!(mapped.lib_version, Some(1.4));
    }

    #[test]
    fn mixed_source_languages_become_all() {
        let list = proto::network_extension_store::ExtensionList {
            extensions: vec![proto::network_extension_store::Extension {
                name: "Multi".into(),
                package_name: "pkg.multi".into(),
                sources: vec![
                    proto::network_extension_store::Source {
                        id: 1,
                        language: "en".into(),
                        ..Default::default()
                    },
                    proto::network_extension_store::Source {
                        id: 2,
                        language: "ja".into(),
                        ..Default::default()
                    },
                ],
                ..Default::default()
            }],
        };
        let ext = repo_extension_from_store(&list.extensions[0]);
        assert_eq!(ext.lang, "all");
        assert_eq!(ext.lib_version, None);
        assert!(ext.to_remote().compatible, "missing lib is compatible");
    }

    #[test]
    fn extension_list_proto_roundtrip() {
        let list = proto::network_extension_store::ExtensionList {
            extensions: vec![proto::network_extension_store::Extension {
                name: "Test".into(),
                package_name: "pkg.test".into(),
                resources: Some(proto::network_extension_store::Resources {
                    apk_url: "https://x/a.apk".into(),
                    icon_url: "https://x/i.png".into(),
                }),
                extension_lib: "1.6".into(),
                version_code: 9,
                version_name: "1.0.0".into(),
                content_warning: proto::ContentWarning::Nsfw as i32,
                ..Default::default()
            }],
        };
        let bytes = list.encode_to_vec();
        let parsed = extension_list_from_payload(&bytes).unwrap();
        let ext = repo_extension_from_store(&parsed.extensions[0]);
        assert!(ext.nsfw);
        assert_eq!(ext.apk_url, "https://x/a.apk");
        assert_eq!(ext.code, 9);

        // The same list as JSON.
        let json = br#"{"extensions":[{"name":"Test","pkg":"ignored"}]}"#;
        let parsed = extension_list_from_payload(json).unwrap();
        assert_eq!(parsed.extensions.len(), 1);
    }

    #[test]
    fn to_remote_falls_back_to_pkg_without_sources() {
        let ext = RepoExtension {
            name: "Test".to_string(),
            pkg: "eu.kanade.test".to_string(),
            apk_url: "https://example.com/repo/apk/test-v1.0.apk".to_string(),
            icon_url: "https://example.com/repo/icon/eu.kanade.test.png".to_string(),
            lang: String::new(),
            code: 0,
            version: String::new(),
            nsfw: false,
            lib_version: None,
            sources: vec![],
            is_novel: false,
        };
        let remote = ext.to_remote();
        assert_eq!(remote.id, "eu.kanade.test");
        assert_eq!(remote.remote_id, "https://example.com/repo/apk/test-v1.0.apk");
    }

    #[test]
    fn incompatible_lib_version_flagged() {
        let mut ext = RepoExtension {
            name: "Test".to_string(),
            pkg: "pkg.test".to_string(),
            apk_url: "https://x/a.apk".to_string(),
            icon_url: String::new(),
            lang: String::new(),
            code: 0,
            version: String::new(),
            nsfw: false,
            lib_version: Some(1.3),
            sources: vec![],
            is_novel: false,
        };
        assert!(!ext.to_remote().compatible);
        ext.lib_version = Some(1.4);
        assert!(ext.to_remote().compatible);
        ext.lib_version = Some(1.6);
        assert!(ext.to_remote().compatible);
        ext.lib_version = Some(1.5);
        assert!(!ext.to_remote().compatible);
    }

    #[test]
    fn index_to_result_sets_length() {
        let extensions = vec![
            RepoExtension {
                name: "A".to_string(),
                pkg: "pkg.a".to_string(),
                apk_url: "https://x/a.apk".to_string(),
                icon_url: String::new(),
                lang: String::new(),
                code: 0,
                version: String::new(),
                nsfw: false,
                lib_version: None,
                sources: vec![],
                is_novel: false,
            },
            RepoExtension {
                name: "B".to_string(),
                pkg: "pkg.b".to_string(),
                apk_url: "https://x/b.apk".to_string(),
                icon_url: String::new(),
                lang: String::new(),
                code: 0,
                version: String::new(),
                nsfw: false,
                lib_version: None,
                sources: vec![],
                is_novel: false,
            },
        ];
        let result = index_to_result(&extensions);
        assert_eq!(result.content.len(), 2);
        assert_eq!(result.hasnext, Some(false));
        assert_eq!(result.length, Some(2));
    }

    #[test]
    fn build_extension_repo_prefers_store_name() {
        let store = RepoStore {
            index_url: "https://example.com/repo/index.pb".to_string(),
            name: "My Repo".to_string(),
            badge_label: String::new(),
            signing_key: String::new(),
            is_legacy: false,
            extension_list_url: None,
        };
        let repo = build_extension_repo("https://example.com/repo/index.pb", &store);
        assert_eq!(repo.name, "My Repo");
        assert_eq!(repo.url, "https://example.com/repo");

        let unnamed = RepoStore {
            name: String::new(),
            ..store
        };
        let repo = build_extension_repo(
            "https://raw.githubusercontent.com/owner/repo/repo/index.pb",
            &unnamed,
        );
        assert_eq!(repo.name, "owner/repo");
    }

    #[test]
    fn decompresses_gzip_and_passes_through_plain() {
        let plain = b"hello";
        assert_eq!(decompress_if_gzipped(plain), b"hello".to_vec());

        let mut buf = Vec::new();
        flate2::write::GzEncoder::new(&mut buf, flate2::Compression::default())
            .write_all(plain)
            .unwrap();
        assert_eq!(decompress_if_gzipped(&buf), b"hello".to_vec());
    }

    #[test]
    #[ignore = "hits the live NovelSourcery repo"]
    fn fetches_live_novelsourcery_repo() {
        // Full resolution chain: legacy index.min.json → repo.json →
        // index_v2 (gzipped index.pb) → embedded extension list.
        let rt = tokio::runtime::Runtime::new().unwrap();
        let index = rt
            .block_on(fetch_repo(
                "https://raw.githubusercontent.com/NovelSourcery/extensions/repo/index.min.json",
            ))
            .unwrap();
        assert!(!index.store.is_legacy);
        assert_eq!(index.store.name, "NovelSourcery");
        assert!(index.extensions.len() > 1);
        let calibre = index
            .extensions
            .iter()
            .find(|e| e.pkg.contains("calibre"))
            .expect("calibre missing");
        assert!(calibre.to_remote().compatible);
    }

    #[test]
    #[ignore = "hits the live yuzono anime repo"]
    fn fetches_live_yuzono_legacy_anime_repo() {
        // Legacy repo with a repo.json that has NO index_v2: must resolve to
        // a legacy store serving the plain JSON array.
        let rt = tokio::runtime::Runtime::new().unwrap();
        let index = rt
            .block_on(fetch_repo(
                "https://raw.githubusercontent.com/yuzono/anime-repo/repo/index.min.json",
            ))
            .unwrap();
        assert!(index.store.is_legacy);
        assert_eq!(index.store.name, "Yūzōnō");
        assert!(!index.extensions.is_empty());
        let remote = index.extensions[0].to_remote();
        assert_eq!(remote.id, "mihon:8542735178285060053");
        assert!(remote.remote_id.ends_with(".apk"));
        assert!(remote.compatible);
    }
}
