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
//! The workflow itself (mock clients, error classification, the
//! browse/search/detail/source chain) lives in `tests/common/mod.rs` and is
//! shared with `repo_suite_test.rs`.
//!
//! # Filter-run workflow
//!
//! The suite is designed for iterative triage across 1000+ extensions. On each
//! run, extensions that complete the full workflow (tolerating network errors)
//! are **moved into `testdata/success/`** so subsequent runs only exercise the
//! extensions that still need attention. Extensions that fail with a code/compat
//! bug are *not* moved — they stay in `testdata/` and are re-tried on the next
//! run after the underlying compat-layer bug is fixed.
//!
//! For a suite that fetches extensions from the live repos itself and tracks
//! its skip state in a JSON file, see `repo_suite_test.rs`.

mod common;

use std::path::{Path, PathBuf};

use anyhow::Context;
use dion_runtime::extension::Adapter;

use mihon_adapter::MihonAdapter;

use common::{run_extension_workflow, MockAdapterClient, WorkflowOutcome};

/// Directory containing test extension APKs.
const TESTDATA_DIR: &str = "testdata";

/// Subdirectory of `testdata/` where fully-working extensions are moved so they
/// are excluded from future runs (the "filter run"). `discover_test_apks` only
/// scans the top level of `testdata/`, so anything in here is skipped.
const SUCCESS_DIR: &str = "testdata/success";

/// Human-readable label for an APK path (its file name), used in log output.
fn apk_label(apk: &Path) -> String {
    apk.file_name()
        .map(|s| s.to_string_lossy().to_string())
        .unwrap_or_else(|| apk.display().to_string())
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

#[test]
#[ignore = "Requires extension APKs in testdata/ - run manually with: cargo test -- --ignored test_full_extension_workflow"]
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
            WorkflowOutcome::Success { tolerated } => {
                println!("✅ SUCCESS: {label}");
                if !tolerated.is_empty() {
                    println!(
                        "   (tolerated {} network/server error(s), recorded in the log above)",
                        tolerated.len()
                    );
                }
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
