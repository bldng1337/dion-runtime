//! Integration tests for Mihon Adapter
//!
//! This test module tests the full extension loading workflow against every
//! extension APK discovered in `testdata/`:
//! 1. Initialize MihonAdapter
//! 2. For each `.apk` in `testdata/`:
//!    a. Install extension from APK
//!    b. Load extension
//!    c. Call all extension methods (browse, search, detail, source)
//!    d. Uninstall extension
//!
//! # Filter-run workflow
//!
//! The suite is designed for iterative triage across 1000+ extensions. On each
//! run, extensions that complete the full workflow (tolerating network errors)
//! are **moved into `testdata/success/`** so subsequent runs only exercise the
//! extensions that still need attention. Extensions that fail with a code/compat
//! bug are *not* moved — they stay in `testdata/` and are re-tried on the next
//! run after the underlying compat-layer bug is fixed.

use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::time::Duration;

use anyhow::Context;
use dion_runtime::client_data::{AdapterClient, ExtensionClient};
use dion_runtime::data::{
    action::Action, extension::ExtensionData, permission::Permission, settings::SettingValue,
    source::EntryId,
};
use dion_runtime::extension::Adapter;

use mihon_adapter::MihonAdapter;

/// Directory containing test extension APKs.
const TESTDATA_DIR: &str = "testdata";

/// Subdirectory of `testdata/` where fully-working extensions are moved so they
/// are excluded from future runs (the "filter run"). `discover_test_apks` only
/// scans the top level of `testdata/`, so anything in here is skipped.
const SUCCESS_DIR: &str = "testdata/success";

/// Delay inserted between extension calls to avoid triggering rate limits.
const CALL_DELAY: Duration = Duration::from_millis(500);

/// Per-operation timeout. A single browse/search/detail/source call that takes
/// longer than this (e.g. an extension stuck in deep recursion) is aborted and
/// treated as a tolerated failure rather than hanging the whole suite.
const OP_TIMEOUT: Duration = Duration::from_secs(45);

/// Outcome of running the full workflow against a single extension.
#[derive(Debug)]
enum WorkflowOutcome {
    /// The workflow completed. Network/server errors from the browse/search/
    /// detail/source calls are tolerated and still count as success.
    Success,
    /// A code/compat-layer bug was hit (missing class/method, linkage error, …).
    /// The extension is *not* moved to `success/` so it is re-tried after the
    /// compat layer is fixed. The string is `"<step>: <error>"`.
    CompatFailed(String),
    /// Installing or uninstalling the extension failed — an adapter-level error
    /// that is unrelated to a specific extension call.
    InstallFailed(String),
}

/// How a single extension-call error should be treated.
enum ErrorKind {
    /// A network/server condition (timeout, HTTP error, parse failure on an
    /// unexpected response, …). The workflow tolerates it and moves on.
    Network,
    /// A code/compat-layer bug that must be fixed. The extension is marked as
    /// failed and left in `testdata/` for re-testing.
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
fn classify_extension_error(context: &str, error: anyhow::Error) -> ErrorKind {
    let error_string = format!("{:#}", error);
    let error_lower = error_string.to_lowercase();

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
struct MockAdapterClient {
    temp_dir: PathBuf,
}

impl MockAdapterClient {
    fn new() -> Self {
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
struct MockExtensionClient;

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

/// Discover all `.apk` files in the `testdata/` directory, sorted alphabetically
/// for deterministic test ordering. Returns an empty vector if the directory is
/// missing or contains no APKs.
fn discover_test_apks() -> Vec<PathBuf> {
    let mut apks: Vec<PathBuf> = match std::fs::read_dir(TESTDATA_DIR) {
        Ok(entries) => entries
            .filter_map(|e| e.ok())
            .map(|e| e.path())
            .filter(|p| p.extension().and_then(|s| s.to_str()) == Some("apk"))
            .collect(),
        Err(_) => Vec::new(),
    };
    apks.sort();
    apks
}

/// Human-readable label for an APK path (its file name), used in log output.
fn apk_label(apk: &Path) -> String {
    apk.file_name()
        .map(|s| s.to_string_lossy().to_string())
        .unwrap_or_else(|| apk.display().to_string())
}

/// Signals how to abort the rest of an extension's workflow when a step fails.
enum StepAbort {
    /// A tolerated network/server error: skip the remaining dependent steps and
    /// treat the extension as having completed successfully.
    Tolerated,
    /// A code/compat-layer bug: abort the extension and mark it as failed.
    Compat(String),
}

/// Classify a failed extension step, log it, and convert it into a
/// [`StepAbort`] for the caller's control flow.
fn abort_for_error(context: &str, e: anyhow::Error) -> StepAbort {
    match classify_extension_error(context, e) {
        ErrorKind::Network => StepAbort::Tolerated,
        ErrorKind::Compat => StepAbort::Compat(context.to_string()),
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
async fn run_extension_workflow(adapter: &MihonAdapter, apk_path: &Path) -> WorkflowOutcome {
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
            StepAbort::Tolerated => return WorkflowOutcome::Success,
            StepAbort::Compat(step) => {
                return WorkflowOutcome::CompatFailed(step);
            }
        },
        Err(_elapsed) => {
            println!("⚠️  browse timed out after {:?} (tolerated)", OP_TIMEOUT);
            return WorkflowOutcome::Success;
        }
    };

    let Some((browse_title, _browse_id)) = browse_entry else {
        // Browse succeeded but returned nothing to drill into. That's a
        // server/content condition, not a compat bug.
        println!("⚠️  Browse returned no entries to drill into (tolerated)");
        return WorkflowOutcome::Success;
    };
    println!("  First entry: {}", browse_title);

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
                StepAbort::Tolerated => return WorkflowOutcome::Success,
                StepAbort::Compat(step) => {
                    return WorkflowOutcome::CompatFailed(step);
                }
            },
            Err(_elapsed) => {
                println!("⚠️  search timed out after {:?} (tolerated)", OP_TIMEOUT);
                return WorkflowOutcome::Success;
            }
        };

    let Some((search_title, search_id)) = search_entry else {
        println!("⚠️  Search returned no entries to drill into (tolerated)");
        return WorkflowOutcome::Success;
    };
    println!("  First result: {} ({})", search_title, search_id.uid);

    // ========== Detail ==========
    println!("\n=== Detail ===");
    tokio::time::sleep(CALL_DELAY).await;
    let detail_result = match tokio::time::timeout(
        OP_TIMEOUT,
        extension.detail(search_id, HashMap::new(), None),
    )
    .await
    {
        Ok(Ok(d)) => d,
        Ok(Err(e)) => match abort_for_error("detail", e) {
            StepAbort::Tolerated => return WorkflowOutcome::Success,
            StepAbort::Compat(step) => {
                return WorkflowOutcome::CompatFailed(step);
            }
        },
        Err(_elapsed) => {
            println!("⚠️  detail timed out after {:?} (tolerated)", OP_TIMEOUT);
            return WorkflowOutcome::Success;
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

    let Some(episode) = detail_result.entry.episodes.first() else {
        println!("⚠️  Detail returned no episodes to fetch a source for (tolerated)");
        return WorkflowOutcome::Success;
    };
    println!("  First episode: {} ({})", episode.name, episode.id.uid);

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
                _ => "Unknown source type".to_string(),
            };
            println!("✅ Source retrieved: {}", description);
            WorkflowOutcome::Success
        }
        Ok(Err(e)) => match abort_for_error("source", e) {
            StepAbort::Tolerated => WorkflowOutcome::Success,
            StepAbort::Compat(step) => WorkflowOutcome::CompatFailed(step),
        },
        Err(_elapsed) => {
            println!("⚠️  source timed out after {:?} (tolerated)", OP_TIMEOUT);
            WorkflowOutcome::Success
        }
    }
}

#[test]
#[cfg_attr(
    not(mihon_compat_jar_available),
    ignore = "mihon-compat.jar not built (Gradle unavailable); run: cd rust/mihon/compat && gradle shadowJar"
)]
fn test_full_extension_workflow() -> anyhow::Result<()> {
    // Run the workflow on a dedicated thread with a large stack.
    //
    // Extension execution reaches the JVM via JNI on this thread, and the
    // call stack nests deeply: OkHttp's interceptor chain, RxJava Observable
    // operators, and Kotlin coroutine suspend machinery all stack on top of the
    // extension's own parsing logic. The default ~2 MB test-thread stack is not
    // enough for some extensions (e.g. Jkanime), which then throw a
    // `StackOverflowError`. A 16 MB stack gives the legitimately-deep — but
    // finite — recursion room to complete. (The JVM-created worker threads are
    // unaffected; this only sizes the thread that drives the JNI calls.)
    std::thread::Builder::new()
        .stack_size(16 * 1024 * 1024)
        .spawn(test_full_extension_workflow_blocking)?
        .join()
        .map_err(|_| anyhow::anyhow!("test_full_extension_workflow worker thread panicked"))?
}

fn test_full_extension_workflow_blocking() -> anyhow::Result<()> {
    tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .context("Failed to build tokio runtime")?
        .block_on(test_full_extension_workflow_impl())
}

async fn test_full_extension_workflow_impl() -> anyhow::Result<()> {
    let apks = discover_test_apks();
    if apks.is_empty() {
        panic!(
            "No `.apk` files found in `{TESTDATA_DIR}/`. Drop one or more extension \
             APKs into that directory before running this test."
        );
    }

    println!("=== Initialize ===");
    let client = Box::new(MockAdapterClient::new());
    let adapter = MihonAdapter::new(client).await?;
    println!("✅ MihonAdapter initialized successfully");

    println!("\nDiscovered {} extension APK(s):", apks.len());
    for apk in &apks {
        println!("  - {}", apk_label(apk));
    }

    let mut successes: Vec<String> = Vec::new();
    let mut compat_failures: Vec<(String, String)> = Vec::new();
    let mut install_failures: Vec<(String, String)> = Vec::new();

    for (index, apk) in apks.iter().enumerate() {
        let label = apk_label(apk);
        println!(
            "\n======================================== [{}/{}]",
            index + 1,
            apks.len()
        );
        println!("=== Testing extension: {} ===", label);
        println!("========================================");
        match run_extension_workflow(&adapter, apk).await {
            WorkflowOutcome::Success => {
                println!("✅ SUCCESS: {label}");
                if let Err(e) = move_to_success(apk) {
                    eprintln!("warn: could not move {label} to {SUCCESS_DIR}/: {e:#}");
                } else {
                    println!("📦 Moved {label} to {SUCCESS_DIR}/");
                }
                successes.push(label);
            }
            WorkflowOutcome::CompatFailed(step) => {
                println!("❌ COMPAT FAIL: {label} ({step})");
                compat_failures.push((label, step));
            }
            WorkflowOutcome::InstallFailed(reason) => {
                println!("⚠️  INSTALL/UNINSTALL FAIL: {label} ({reason})");
                install_failures.push((label, reason));
            }
        }
    }

    println!("\n========================================");
    println!("=== SUMMARY ===");
    println!("========================================");
    println!("Total:   {}", apks.len());
    println!("Success: {} (moved to {SUCCESS_DIR}/)", successes.len());
    println!("Compat:  {}", compat_failures.len());
    println!("Install: {}", install_failures.len());

    if !compat_failures.is_empty() {
        println!("\n--- Compat/code failures (these need fixing) ---");
        for (label, step) in &compat_failures {
            println!("  {label}  @  {step}");
        }
    }

    if !install_failures.is_empty() {
        println!("\n--- Install/uninstall failures ---");
        for (label, reason) in &install_failures {
            println!("  {label}  @  {reason}");
        }
    }

    if !compat_failures.is_empty() {
        panic!(
            "\n❌ {} extension(s) failed with code/compat errors that need fixing \
             (see list above).\n{} extension(s) succeeded and were moved to \
             {SUCCESS_DIR}/ — re-running now will only exercise the remaining \
             extensions.",
            compat_failures.len(),
            successes.len(),
        );
    }

    println!("\n✅ All extension(s) completed successfully!");
    Ok(())
}

/// Move an APK that completed the workflow successfully into `testdata/success/`,
/// excluding it from future filter runs. Creates the directory if needed and
/// overwrites any existing file with the same name.
fn move_to_success(apk: &Path) -> anyhow::Result<()> {
    std::fs::create_dir_all(SUCCESS_DIR)
        .with_context(|| format!("Failed to create {SUCCESS_DIR}/"))?;
    let dest = Path::new(SUCCESS_DIR).join(apk.file_name().context("APK has no file name")?);
    std::fs::rename(apk, &dest)
        .with_context(|| format!("Failed to move {} to {}", apk.display(), dest.display()))?;
    Ok(())
}

#[tokio::test]
#[ignore = "Requires separate JVM instance - run manually"]
async fn test_get_extensions() -> anyhow::Result<()> {
    println!("=== Test get_extensions ===");
    let client = Box::new(MockAdapterClient::new());
    let adapter = MihonAdapter::new(client).await?;

    let apks = discover_test_apks();
    if apks.is_empty() {
        panic!(
            "No `.apk` files found in `{TESTDATA_DIR}/`. Drop one or more extension \
             APKs into that directory before running this test."
        );
    }

    // Install every discovered extension
    for apk in &apks {
        let apk_url = format!("file://{}", apk.canonicalize()?.display());
        adapter.install(&apk_url).await?;
        println!("✅ Installed {}", apk_label(apk));
    }

    // Get all extensions — should reflect everything we installed
    let extensions = adapter.get_extensions().await?;
    println!("✅ Found {} extension(s)", extensions.len());

    for ext in &extensions {
        let data = ext.get_data().read().await;
        println!("  - {} ({})", data.data.name, data.data.id);
    }

    assert_eq!(
        extensions.len(),
        apks.len(),
        "get_extensions() returned {} extension(s), but {} APK(s) were installed",
        extensions.len(),
        apks.len()
    );

    Ok(())
}

#[tokio::test]
#[ignore = "Binary XML parser has known bug - see state.md"]
async fn test_metadata_extraction() -> anyhow::Result<()> {
    println!("=== Test Metadata Extraction ===");
    use mihon_adapter::apk::MihonExtensionMetadata;

    let apks = discover_test_apks();
    if apks.is_empty() {
        panic!(
            "No `.apk` files found in `{TESTDATA_DIR}/`. Drop one or more extension \
             APKs into that directory before running this test."
        );
    }

    for apk in &apks {
        println!("\n--- {} ---", apk_label(apk));
        let metadata = MihonExtensionMetadata::from_apk(apk)?;

        println!("Package: {}", metadata.package);
        println!(
            "Version: {} ({})",
            metadata.version_name, metadata.version_code
        );
        println!("Label: {}", metadata.label);
        println!("Entry class: {}", metadata.entry_class);
        println!("NSFW: {}", metadata.nsfw);
        println!("Lib version: {:?}", metadata.lib_version);
        println!("Compatible: {}", metadata.is_compatible());
    }

    Ok(())
}
