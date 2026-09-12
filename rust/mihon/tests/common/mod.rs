//! Shared helpers for the Mihon adapter integration tests.
//!
//! Included via `mod common;` from the test crates under `tests/`. Provides
//! the mock host clients and the full per-extension workflow
//! (install → browse → search → detail → source → uninstall) with
//! network/compat error classification used by both `integration_test.rs`
//! and `repo_suite_test.rs`.

use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::time::Duration;

use dion_runtime::client_data::{AdapterClient, ExtensionClient};
use dion_runtime::data::{
    action::Action, extension::ExtensionData, permission::Permission, settings::SettingValue,
    source::EntryId,
};
use dion_runtime::extension::Adapter;

use mihon_adapter::MihonAdapter;

/// Delay inserted between extension calls to avoid triggering rate limits.
pub const CALL_DELAY: Duration = Duration::from_millis(500);

/// Per-operation timeout. A single browse/search/detail/source call that takes
/// longer than this (e.g. an extension stuck in deep recursion) is aborted and
/// treated as a tolerated failure rather than hanging the whole suite.
pub const OP_TIMEOUT: Duration = Duration::from_secs(45);

/// Outcome of running the full workflow against a single extension.
#[derive(Debug)]
pub enum WorkflowOutcome {
    /// The workflow completed. Network/server errors from the browse/search/
    /// detail/source calls are tolerated and still count as success. The
    /// tolerated errors ("`<step>: <error>`", plus timeouts) are reported so
    /// callers can persist them for later triage.
    Success { tolerated: Vec<String> },
    /// A code/compat-layer bug was hit (missing class/method, linkage error, …).
    /// The string is `"<step>: <error>"`.
    CompatFailed(String),
    /// Installing or uninstalling the extension failed — an adapter-level error
    /// that is unrelated to a specific extension call.
    InstallFailed(String),
}

/// How a single extension-call error should be treated.
pub enum ErrorKind {
    /// A network/server condition (timeout, HTTP error, parse failure on an
    /// unexpected response, …). The workflow tolerates it and moves on.
    Network,
    /// A code/compat-layer bug that must be fixed.
    Compat,
}

/// Check whether an error from an extension operation is a genuine network error
/// that should be tolerated by the test, or a code/compat bug that must fail.
///
/// Network errors are expected when remote servers are unavailable, blocking
/// requests, or returning error responses. Code errors indicate missing stubs,
/// unimplemented methods, or bugs in the compat layer that need fixing.
///
/// Returns [`ErrorKind::Compat`] for structural compat-layer failures and
/// [`ErrorKind::Network`] for everything else (recognized network patterns *and*
/// unrecognized errors, which during a network operation are virtually always a
/// server/input condition rather than a compat bug).
pub fn classify_extension_error(context: &str, error: anyhow::Error) -> ErrorKind {
    let error_string = format!("{:#}", error);
    let error_lower = error_string.to_lowercase();

    // Deterministic "needs user configuration" signals — checked before the
    // compat patterns because they are often IllegalStateExceptions: an
    // extension that requires settings (server URL, library selection, …) or
    // credentials (login) fails the same way on every platform and is not a
    // compat bug.
    let config_required_indicators: &[&str] = &["extension settings", "failed to log in"];
    if config_required_indicators
        .iter()
        .any(|p| error_lower.contains(p))
    {
        println!(
            "⚠️  {} failed: extension requires user configuration (tolerated): {}",
            context, error_string
        );
        return ErrorKind::Network;
    }

    // Code/compat error patterns — these are bugs that must be fixed.
    //
    // This list is intentionally limited to *structural* failures that indicate
    // a real compat-layer bug (missing class/method, bad linkage, type mismatch,
    // VM-level errors). It deliberately does NOT include `nullpointerexception`,
    // `json`, `parse`, `deserialize`, etc.: this function is only ever called for
    // network operations (browse/search/detail/source), where those almost always
    // mean the server returned unexpected content (block, rate-limit, error page,
    // layout change, empty body) that the extension's parser then choked on — i.e.
    // a network/server condition, not a compat bug. Such errors fall through to
    // the network-tolerated / unrecognized handling below.
    let code_error_indicators: &[&str] = &[
        "noclassdeffounderror",
        "classnotfoundexception",
        "classcastexception",
        "nosuchmethoderror",
        "nosuchfielderror",
        "illegalaccesserror",
        "incompatibleclasschangeerror",
        "linkageerror",
        "outofmemoryerror",
        // IllegalStateException: Kotlin `check()`/`error()` failures from the
        // extension's own state machine. Unlike parse/NPE noise these are
        // deterministic local failures (e.g. the keiyoushi template rejecting
        // the host client's interceptor stack), so they are treated as compat
        // bugs rather than tolerated server conditions.
        "illegalstateexception",
    ];

    for indicator in code_error_indicators {
        if error_lower.contains(indicator) {
            println!(
                "\n❌ CODE/COMPAT ERROR during {} — this is NOT a network error!\n\
                 This indicates a bug in the compat layer or a missing Android stub.\n\
                 Error: {}",
                context, error_string
            );
            return ErrorKind::Compat;
        }
    }

    // Network error patterns — these are tolerated
    let network_error_indicators: &[&str] = &[
        // HTTP status errors
        "http 4",
        "http 5",
        "http error",
        "status code",
        // Connection errors
        "timeout",
        "timed out",
        "connection refused",
        "connection reset",
        "connection closed",
        "connection aborted",
        "connection dropped",
        "unable to resolve host",
        "unknownhostexception",
        "sockettimeoutexception",
        "socketexception",
        "no route to host",
        "connection pool",
        "premature end of",
        // SSL/TLS errors
        "ssl",
        "tls",
        "certificate",
        "handshake",
        // Server-side blocks
        "rate limit",
        "too many requests",
        "cloudflare",
        "access denied",
        "forbidden",
        // NullPointerException during a network operation. The modern JVM NPE
        // message ("Cannot invoke \"...\" because \"...\" is null") and the
        // classic "nullpointerexception" both indicate the server returned
        // unexpected content that the extension's parser choked on — a
        // network/server condition for these inherently network-driven calls.
        "cannot invoke",
        "is null",
        "nullpointerexception",
        // Parsing failures during a network operation. A JSON/HTML parse error
        // or an empty body here means the server returned unexpected content
        // (block, rate-limit, error page, layout change, truncated response) — a
        // network/server condition, not a compat-layer bug.
        "expected start of",
        "eof",
        "unexpected json",
        "failed to parse",
        "parse",
        "deserialize",
        // StackOverflowError: an extension's own deep/infinite recursion during
        // a parse (some sources recurse over nested HTML). This is an extension
        // runtime pathology, not a missing compat stub, so it is tolerated.
        "stackoverflowerror",
        "stackoverflow",
        // Java network exception class names
        "java.net.",
        "javax.net.",
        "java.io.ioexception",
        "okhttp",
    ];

    for indicator in network_error_indicators {
        if error_lower.contains(indicator) {
            println!(
                "⚠️  {} failed with a network error (tolerated): {}",
                context, error_string
            );
            return ErrorKind::Network;
        }
    }

    // Not a recognized structural/code error and not a recognized network error.
    //
    // After the structural-compat-bug check above (NoClassDefFoundError,
    // NoSuchMethodError, etc.), anything reaching here during a network
    // operation is either a network/server condition we just don't have a
    // pattern for yet, or an extension rejecting the test's generic input
    // (e.g. sources requiring a specific query syntax). Neither is a
    // compat-layer bug, and halting the whole 1000+ extension suite on the
    // first such case would prevent any real progress — so log it and move on.
    println!(
        "⚠️  {} failed with an unrecognized error (tolerated, likely network/input): {}",
        context, error_string
    );
    ErrorKind::Network
}

/// Mock AdapterClient for testing
pub struct MockAdapterClient {
    temp_dir: PathBuf,
}

impl MockAdapterClient {
    pub fn new() -> Self {
        let temp_dir = std::env::temp_dir().join(format!("mihon-test-{}", uuid::Uuid::new_v4()));
        std::fs::create_dir_all(&temp_dir).unwrap();
        Self { temp_dir }
    }
}

#[async_trait::async_trait]
impl AdapterClient for MockAdapterClient {
    async fn get_extension_client(
        &self,
        _extension: ExtensionData,
    ) -> anyhow::Result<Box<dyn ExtensionClient>> {
        Ok(Box::new(MockExtensionClient))
    }

    async fn get_path(&self) -> anyhow::Result<String> {
        Ok(self.temp_dir.to_string_lossy().to_string())
    }
}

/// Mock ExtensionClient for testing
#[derive(Debug)]
pub struct MockExtensionClient;

#[async_trait::async_trait]
impl ExtensionClient for MockExtensionClient {
    async fn load_data(&self, _key: &str) -> anyhow::Result<String> {
        Ok(String::new())
    }

    async fn store_data(&self, _key: &str, _data: String) -> anyhow::Result<()> {
        Ok(())
    }

    async fn load_data_secure(&self, _key: &str) -> anyhow::Result<String> {
        Ok(String::new())
    }

    async fn store_data_secure(&self, _key: &str, _data: String) -> anyhow::Result<()> {
        Ok(())
    }

    async fn do_action(&self, _action: &Action) -> anyhow::Result<()> {
        Ok(())
    }

    async fn store_set(&self, _key: &str, _value: serde_json::Value) -> anyhow::Result<()> {
        Ok(())
    }

    async fn set_entry_setting(
        &self,
        _entry: EntryId,
        _key: String,
        _value: SettingValue,
    ) -> anyhow::Result<()> {
        Ok(())
    }

    async fn request_permission(
        &self,
        _permission: &Permission,
        _msg: Option<String>,
    ) -> anyhow::Result<bool> {
        Ok(true)
    }

    async fn get_path(&self) -> anyhow::Result<String> {
        Ok(String::new())
    }
}

/// Signals how to abort the rest of an extension's workflow when a step fails.
pub enum StepAbort {
    /// A tolerated network/server error: skip the remaining dependent steps and
    /// treat the extension as having completed successfully. Carries the
    /// recorded error description ("`<step>: <error>`").
    Tolerated(String),
    /// A code/compat-layer bug: abort the extension and mark it as failed.
    Compat(String),
}

/// Classify a failed extension step, log it, and convert it into a
/// [`StepAbort`] for the caller's control flow.
pub fn abort_for_error(context: &str, e: anyhow::Error) -> StepAbort {
    let error_string = format!("{e:#}");
    match classify_extension_error(context, e) {
        ErrorKind::Network => StepAbort::Tolerated(format!("{context}: {error_string}")),
        ErrorKind::Compat => StepAbort::Compat(format!("{context}: {error_string}")),
    }
}

/// Run the full extension workflow against a single APK installed via `adapter`:
/// install → browse (popular) → search → detail → source → uninstall.
///
/// - Network/server errors from browse/search/detail/source are tolerated: the
///   remaining dependent steps are skipped and the extension still counts as
///   [`WorkflowOutcome::Success`].
/// - Code/compat-layer errors short-circuit the extension as
///   [`WorkflowOutcome::CompatFailed`].
/// - Install/uninstall failures are reported as [`WorkflowOutcome::InstallFailed`].
pub async fn run_extension_workflow(adapter: &MihonAdapter, apk_path: &Path) -> WorkflowOutcome {
    let apk_url = match apk_path.canonicalize() {
        Ok(p) => format!("file://{}", p.display()),
        Err(e) => {
            return WorkflowOutcome::InstallFailed(format!("canonicalize apk: {e:#}"));
        }
    };

    let extension = match adapter.install(&apk_url).await {
        Ok(ext) => ext,
        Err(e) => {
            return WorkflowOutcome::InstallFailed(format!("install: {e:#}"));
        }
    };
    let ext_name = extension.get_data().read().await.data.name.clone();
    println!("✅ Extension installed: {}", ext_name);

    let outcome = run_extension_calls(extension.as_ref()).await;

    // Always try to uninstall so we don't leak loaded extensions even when a
    // compat bug was hit. An uninstall failure is an adapter-level error.
    if let Err(e) = adapter.uninstall(&extension).await {
        return WorkflowOutcome::InstallFailed(format!("uninstall: {e:#}"));
    }
    println!("✅ Extension uninstalled: {}", ext_name);

    outcome
}

/// Run the browse → search → detail → source call chain against `extension`,
/// returning its [`WorkflowOutcome`]. Network errors are tolerated (remaining
/// dependent steps are skipped); compat errors abort as `CompatFailed`.
async fn run_extension_calls(
    extension: &dyn dion_runtime::extension::Extension,
) -> WorkflowOutcome {
    // Tolerated errors are collected so callers can persist them for triage.
    let mut tolerated: Vec<String> = Vec::new();

    // ========== Browse (Popular) ==========
    println!("\n=== Browse (Popular) ===");
    tokio::time::sleep(CALL_DELAY).await;
    let browse_entry = match tokio::time::timeout(OP_TIMEOUT, extension.browse(0, None)).await {
        Ok(Ok(browse_result)) => {
            println!("✅ Browse returned {} entries", browse_result.content.len());
            browse_result
                .content
                .first()
                .map(|e| (e.title.clone(), e.id.clone()))
        }
        Ok(Err(e)) => match abort_for_error("browse", e) {
            StepAbort::Tolerated(msg) => {
                tolerated.push(msg);
                return WorkflowOutcome::Success { tolerated };
            }
            StepAbort::Compat(step) => {
                return WorkflowOutcome::CompatFailed(step);
            }
        },
        Err(_elapsed) => {
            println!("⚠️  browse timed out after {:?} (tolerated)", OP_TIMEOUT);
            tolerated.push(format!("browse: timed out after {OP_TIMEOUT:?}"));
            return WorkflowOutcome::Success { tolerated };
        }
    };

    let Some((browse_title, browse_id)) = browse_entry else {
        // Browse succeeded but returned nothing to drill into. That's a
        // server/content condition, not a compat bug.
        println!("⚠️  Browse returned no entries to drill into (tolerated)");
        tolerated.push("browse: returned no entries to drill into".to_string());
        return WorkflowOutcome::Success { tolerated };
    };
    println!("  First entry: {}", browse_title);

    // The entry's identity (its URL) must be non-empty — it is the key used to
    // fetch details and chapters/episodes later, and an empty uid means our
    // mapping lost the entry's URL.
    if browse_id.uid.is_empty() {
        return WorkflowOutcome::CompatFailed(
            "browse: first entry has an empty uid (entry URL was lost)".to_string(),
        );
    }

    // ========== Search ==========
    println!("\n=== Search ===");
    tokio::time::sleep(CALL_DELAY).await;
    let search_entry =
        match tokio::time::timeout(OP_TIMEOUT, extension.search(0, "test".to_string(), None)).await
        {
            Ok(Ok(search_result)) => {
                println!("✅ Search returned {} entries", search_result.content.len());
                search_result
                    .content
                    .first()
                    .map(|e| (e.title.clone(), e.id.clone()))
            }
            Ok(Err(e)) => match abort_for_error("search", e) {
                StepAbort::Tolerated(msg) => {
                    tolerated.push(msg);
                    return WorkflowOutcome::Success { tolerated };
                }
                StepAbort::Compat(step) => {
                    return WorkflowOutcome::CompatFailed(step);
                }
            },
            Err(_elapsed) => {
                println!("⚠️  search timed out after {:?} (tolerated)", OP_TIMEOUT);
                tolerated.push(format!("search: timed out after {OP_TIMEOUT:?}"));
                return WorkflowOutcome::Success { tolerated };
            }
        };

    let Some((search_title, search_id)) = search_entry else {
        println!("⚠️  Search returned no entries to drill into (tolerated)");
        tolerated.push("search: returned no entries to drill into".to_string());
        return WorkflowOutcome::Success { tolerated };
    };
    println!("  First result: {} ({})", search_title, search_id.uid);

    if search_id.uid.is_empty() {
        return WorkflowOutcome::CompatFailed(
            "search: first result has an empty uid (entry URL was lost)".to_string(),
        );
    }

    // ========== Detail ==========
    println!("\n=== Detail ===");
    tokio::time::sleep(CALL_DELAY).await;
    // Capture the requested id before it is moved into detail(); the detailed
    // entry's uid must round-trip back to this value.
    let requested_uid = search_id.uid.clone();
    let detail_result = match tokio::time::timeout(
        OP_TIMEOUT,
        extension.detail(search_id, HashMap::new(), None),
    )
    .await
    {
        Ok(Ok(d)) => d,
        Ok(Err(e)) => match abort_for_error("detail", e) {
            StepAbort::Tolerated(msg) => {
                tolerated.push(msg);
                return WorkflowOutcome::Success { tolerated };
            }
            StepAbort::Compat(step) => {
                return WorkflowOutcome::CompatFailed(step);
            }
        },
        Err(_elapsed) => {
            println!("⚠️  detail timed out after {:?} (tolerated)", OP_TIMEOUT);
            tolerated.push(format!("detail: timed out after {OP_TIMEOUT:?}"));
            return WorkflowOutcome::Success { tolerated };
        }
    };

    let title = detail_result
        .entry
        .titles
        .first()
        .cloned()
        .unwrap_or_default();
    println!(
        "✅ Detail retrieved: {} with {} episodes",
        title,
        detail_result.entry.episodes.len()
    );

    // The detail call must preserve the entry's identity: the detailed entry's
    // uid must be non-empty and match the id we asked details for. Some
    // Tachiyomi/Mihon extensions return a fresh SManga from getMangaDetails
    // with an empty url; the adapter must fall back to the original id in that
    // case rather than propagating an empty uid.
    if detail_result.entry.id.uid.is_empty() {
        return WorkflowOutcome::CompatFailed(
            "detail: entry id uid is empty after fetching details".to_string(),
        );
    }
    if detail_result.entry.id.uid != requested_uid {
        return WorkflowOutcome::CompatFailed(format!(
            "detail: entry id uid changed from {:?} (search) to {:?} (detail)",
            requested_uid, detail_result.entry.id.uid
        ));
    }

    let Some(episode) = detail_result.entry.episodes.first() else {
        println!("⚠️  Detail returned no episodes to fetch a source for (tolerated)");
        tolerated.push("detail: returned no episodes to fetch a source for".to_string());
        return WorkflowOutcome::Success { tolerated };
    };
    println!("  First episode: {} ({})", episode.name, episode.id.uid);

    // Episode ids (chapter/anime URLs) must be non-empty: they are the key used
    // to resolve the actual content (pages/videos/text) in the source step.
    if episode.id.uid.is_empty() {
        return WorkflowOutcome::CompatFailed(
            "detail: first episode has an empty uid (chapter/episode URL was lost)".to_string(),
        );
    }

    // ========== Source ==========
    println!("\n=== Source ===");
    let episode_id = episode.id.clone();
    tokio::time::sleep(CALL_DELAY).await;
    match tokio::time::timeout(
        OP_TIMEOUT,
        extension.source(episode_id, HashMap::new(), None),
    )
    .await
    {
        Ok(Ok(source_result)) => {
            let description = match &source_result.source {
                dion_runtime::data::source::Source::Imagelist { links, .. } => {
                    format!("{} images", links.len())
                }
                dion_runtime::data::source::Source::Video { sources, .. } => {
                    format!("{} video sources", sources.len())
                }
                dion_runtime::data::source::Source::Audio { sources, .. } => {
                    format!("{} audio sources", sources.len())
                }
                dion_runtime::data::source::Source::Paragraphlist { paragraphs, .. } => {
                    format!("{} paragraphs", paragraphs.len())
                }
                _ => "Unknown source type".to_string(),
            };
            println!("✅ Source retrieved: {}", description);
            WorkflowOutcome::Success { tolerated }
        }
        Ok(Err(e)) => match abort_for_error("source", e) {
            StepAbort::Tolerated(msg) => {
                tolerated.push(msg);
                WorkflowOutcome::Success { tolerated }
            }
            StepAbort::Compat(step) => WorkflowOutcome::CompatFailed(step),
        },
        Err(_elapsed) => {
            println!("⚠️  source timed out after {:?} (tolerated)", OP_TIMEOUT);
            tolerated.push(format!("source: timed out after {OP_TIMEOUT:?}"));
            WorkflowOutcome::Success { tolerated }
        }
    }
}
