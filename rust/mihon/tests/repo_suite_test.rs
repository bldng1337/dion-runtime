//! Repo suite harness — keeps the local extension corpus fresh and exercises it.
//!
//! Resolves each configured repo index ([`REPO_INDEX_URLS`]) through the
//! adapter's own repo fetching (legacy `index.min.json` arrays, `repo.json` →
//! `index_v2` redirects, gzipped protobuf stores), downloads/updates every
//! listed extension APK into a local cache, and runs the full integration
//! workflow (install → browse → search → detail → source → uninstall, see
//! `tests/common`) against each one.
//!
//! Run:
//!
//! ```text
//! cargo test -p mihon-adapter --test repo_suite_test -- --ignored --nocapture
//! ```
//!
//! Environment knobs:
//! - `REPO_SUITE_LIMIT` — test at most N extensions per repo (smoke runs).
//! - `REPO_SUITE_REPOS` — comma-separated substrings; only matching repo URLs
//!   are resolved (e.g. `keiyoushi` or `yuzono,NovelSourcery`).
//!
//! # Skip state
//!
//! `testdata/repo_suite/state.json` records every extension together with the
//! version it was last tested at and its outcome. Extensions that completed
//! the workflow successfully (network/server errors tolerated, exactly like
//! `integration_test.rs`) are **skipped on subsequent runs** unless the repo
//! ships a newer version. Failed extensions are re-tried on every run.
//!
//! **Delete `state.json` to reset** and re-test everything. The APK cache in
//! `testdata/repo_suite/apks/` survives a state reset, so re-testing does not
//! re-download unchanged APKs. Delete the whole `testdata/repo_suite/`
//! directory to also force re-downloading.

mod common;

use std::collections::BTreeMap;
use std::io::ErrorKind as IoErrorKind;
use std::path::{Path, PathBuf};
use std::time::{Duration, SystemTime, UNIX_EPOCH};

use anyhow::{bail, Context, Result};
use mihon_adapter::repo::{derive_repo_name, fetch_repo, repo_base_url, RepoExtension, RepoIndex};
use mihon_adapter::MihonAdapter;
use serde::{Deserialize, Serialize};

use common::{run_extension_workflow, MockAdapterClient, WorkflowOutcome};

/// Repo indexes the suite pulls extensions from.
const REPO_INDEX_URLS: &[&str] = &[
    // Aniyomi anime extensions.
    "https://raw.githubusercontent.com/yuzono/anime-repo/repo/index.min.json",
    // Novel extensions (index redirects to the new-style protobuf store).
    "https://raw.githubusercontent.com/NovelSourcery/extensions/refs/heads/repo/index.min.json",
    // Tachiyomi/Mihon manga extensions.
    "https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.min.json",
];

/// Downloaded APKs, one subdirectory per repo.
const APK_DIR: &str = "testdata/repo_suite/apks";
/// Skip state — delete this file to re-test every extension.
const STATE_FILE: &str = "testdata/repo_suite/state.json";

/// Packages that are never downloaded or tested. Unlike compat failures these
/// cannot be tolerated: they kill the whole JVM process. See
/// `testdata/skipped/README.md` for the details of each entry.
const SKIPPED_PKGS: &[&str] = &["eu.kanade.tachiyomi.animeextension.en.hanime"];

/// Total time budget for a single APK download.
const DOWNLOAD_TIMEOUT: Duration = Duration::from_secs(300);

// ---------------------------------------------------------------------------
// Skip state
// ---------------------------------------------------------------------------

/// Last-known outcome for one extension, persisted across runs.
#[derive(Debug, Clone, Serialize, Deserialize)]
struct ExtensionState {
    /// Display name from the index (informative only).
    #[serde(default)]
    name: String,
    /// Index version this entry was recorded at.
    version: String,
    /// Index version code this entry was recorded at.
    code: i64,
    /// APK file name inside the repo's `apks/<repo_key>/` directory.
    #[serde(default)]
    apk: String,
    /// `success` | `compat_failed` | `install_failed` | `download_failed`.
    status: String,
    /// Last error for non-success statuses.
    #[serde(default, skip_serializing_if = "Option::is_none")]
    error: Option<String>,
    /// Errors that were tolerated while testing (network/server conditions)
    /// even though the extension overall counted as a success, recorded for
    /// later triage ("`<step>: <error>`").
    #[serde(default, skip_serializing_if = "Vec::is_empty")]
    tolerated_errors: Vec<String>,
    /// Unix timestamp (seconds) of the last test run.
    #[serde(default, skip_serializing_if = "Option::is_none")]
    tested_at: Option<u64>,
}

/// Per-repo extension map, keyed by package name.
#[derive(Debug, Default, Serialize, Deserialize)]
struct RepoState {
    extensions: BTreeMap<String, ExtensionState>,
}

/// The whole persisted skip state, keyed by repo key (see [`repo_key`]).
/// `BTreeMap` keeps the JSON deterministic and easy to diff/reset by hand.
#[derive(Debug, Default, Serialize, Deserialize)]
struct SuiteState {
    repos: BTreeMap<String, RepoState>,
}

impl SuiteState {
    fn entry(&self, repo: &str, pkg: &str) -> Option<&ExtensionState> {
        self.repos.get(repo)?.extensions.get(pkg)
    }

    fn set(&mut self, repo: &str, pkg: &str, entry: ExtensionState) {
        self.repos
            .entry(repo.to_string())
            .or_default()
            .extensions
            .insert(pkg.to_string(), entry);
    }
}

fn load_state() -> Result<SuiteState> {
    let bytes = match std::fs::read(STATE_FILE) {
        Ok(bytes) => bytes,
        Err(e) if e.kind() == IoErrorKind::NotFound => return Ok(SuiteState::default()),
        Err(e) => bail!("failed to read state file {STATE_FILE}: {e:#}"),
    };
    if bytes.is_empty() {
        return Ok(SuiteState::default());
    }
    serde_json::from_slice(&bytes)
        .with_context(|| format!("corrupt state file {STATE_FILE} — delete it to reset"))
}

fn save_state(state: &SuiteState) -> Result<()> {
    let json = serde_json::to_vec_pretty(state).context("failed to serialize state")?;
    std::fs::write(STATE_FILE, json)
        .with_context(|| format!("failed to write state file {STATE_FILE}"))
}

/// Whether an entry records a successful test of exactly this index version.
fn tested_current(entry: &ExtensionState, ext: &RepoExtension) -> bool {
    entry.status == "success" && entry.version == ext.version && entry.code == ext.code
}

fn now_secs() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .map(|d| d.as_secs())
        .unwrap_or(0)
}

// ---------------------------------------------------------------------------
// APK cache
// ---------------------------------------------------------------------------

/// Stable filesystem-safe key for a repo (e.g. `keiyoushi__extensions`).
fn repo_key(index_url: &str) -> String {
    derive_repo_name(&repo_base_url(index_url)).replace('/', "__")
}

/// Local APK file name for an index entry: the basename of its download URL
/// (which carries the version), falling back to a pkg-based name.
fn apk_file_name(ext: &RepoExtension) -> String {
    let base = ext.apk_url.rsplit('/').next().unwrap_or_default();
    if base.is_empty() || base == ext.apk_url {
        format!("{}-v{}.apk", ext.pkg, ext.version)
    } else {
        base.to_string()
    }
}

/// Download an APK to `dest` (via a `.part` file, overwriting `dest`).
/// Returns the size written, in bytes.
async fn download_apk(url: &str, dest: &Path) -> Result<u64> {
    let bytes = tokio::time::timeout(DOWNLOAD_TIMEOUT, async {
        let response = reqwest::get(url)
            .await
            .with_context(|| format!("failed to download {url}"))?;
        let status = response.status();
        if !status.is_success() {
            bail!("failed to download {url}: HTTP {status}");
        }
        Ok(response
            .bytes()
            .await
            .with_context(|| format!("failed to read body of {url}"))?
            .to_vec())
    })
    .await
    .with_context(|| format!("download of {url} timed out after {DOWNLOAD_TIMEOUT:?}"))??;

    if let Some(parent) = dest.parent() {
        std::fs::create_dir_all(parent)
            .with_context(|| format!("failed to create {}", parent.display()))?;
    }
    let mut part = dest.as_os_str().to_os_string();
    part.push(".part");
    let part = PathBuf::from(part);
    std::fs::write(&part, &bytes).with_context(|| format!("failed to write {}", part.display()))?;
    // std::fs::rename refuses to overwrite on Windows.
    if dest.exists() {
        std::fs::remove_file(dest).ok();
    }
    std::fs::rename(&part, dest)
        .with_context(|| format!("failed to move {} to {}", part.display(), dest.display()))?;
    Ok(bytes.len() as u64)
}

// ---------------------------------------------------------------------------
// Environment knobs
// ---------------------------------------------------------------------------

/// `REPO_SUITE_LIMIT`: cap on extensions per repo, for smoke runs.
fn env_limit() -> Option<usize> {
    std::env::var("REPO_SUITE_LIMIT")
        .ok()
        .and_then(|v| v.trim().parse().ok())
}

/// `REPO_SUITE_REPOS`: comma-separated substrings filtering the repo URLs.
fn env_repo_filter() -> Option<Vec<String>> {
    let value = std::env::var("REPO_SUITE_REPOS").ok()?;
    let patterns: Vec<String> = value
        .split(',')
        .map(|s| s.trim().to_string())
        .filter(|s| !s.is_empty())
        .collect();
    (!patterns.is_empty()).then_some(patterns)
}

// ---------------------------------------------------------------------------
// The suite
// ---------------------------------------------------------------------------

/// One extension selected for this run, with its cached APK path and whether
/// it still needs testing (false = already succeeded at this version).
struct PlannedExt {
    repo: String,
    ext: RepoExtension,
    apk_path: PathBuf,
    test: bool,
}

fn label_of(planned: &PlannedExt) -> String {
    format!(
        "{}/{} v{} ({})",
        planned.repo, planned.ext.name, planned.ext.version, planned.ext.pkg
    )
}

#[test]
#[ignore = "Downloads and tests every extension from the live repos - run manually with: cargo test --test repo_suite_test -- --ignored --nocapture"]
#[cfg_attr(
    not(mihon_compat_jar_available),
    ignore = "mihon-compat.jar not built (Gradle unavailable); run: cd rust/mihon/compat && gradle shadowJar"
)]
fn repo_extension_suite() -> anyhow::Result<()> {
    // Same large-stack thread as test_full_extension_workflow: the JNI call
    // chain (OkHttp + RxJava + Kotlin coroutines + the extension's own
    // parsing) overflows the default ~2 MB test-thread stack for some
    // extensions.
    std::thread::Builder::new()
        .stack_size(16 * 1024 * 1024)
        .spawn(repo_extension_suite_blocking)?
        .join()
        .map_err(|_| anyhow::anyhow!("repo_extension_suite worker thread panicked"))?
}

fn repo_extension_suite_blocking() -> anyhow::Result<()> {
    tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .context("Failed to build tokio runtime")?
        .block_on(repo_extension_suite_impl())
}

async fn repo_extension_suite_impl() -> Result<()> {
    let limit = env_limit();
    let repo_filter = env_repo_filter();
    let mut state = load_state()?;
    let recorded: usize = state.repos.values().map(|r| r.extensions.len()).sum();
    println!(
        "=== Repo suite: {} index URL(s), {recorded} extension(s) in state ({STATE_FILE}) ===",
        REPO_INDEX_URLS.len()
    );

    // ---- Phase 1: resolve the repo indexes ----
    let mut repos: Vec<(String, RepoIndex)> = Vec::new();
    for url in REPO_INDEX_URLS {
        if let Some(patterns) = &repo_filter {
            if !patterns.iter().any(|p| url.contains(p)) {
                println!("⏭️  Skipping repo {url} (filtered by REPO_SUITE_REPOS)");
                continue;
            }
        }
        print!("\n=== Resolving index: {url} ");
        let index = fetch_repo(url)
            .await
            .with_context(|| format!("resolving {url}"))?;
        let key = repo_key(url);
        println!(
            "→ {key} ({}, {} extensions)",
            if index.store.is_legacy {
                "legacy"
            } else {
                "store"
            },
            index.extensions.len()
        );
        repos.push((key, index));
    }
    if repos.is_empty() {
        bail!("no repo index resolved — nothing to do");
    }

    // ---- Phase 2: download/update APKs, decide what to test ----
    println!("\n=== Syncing APK cache ({APK_DIR}) ===");
    let mut planned: Vec<PlannedExt> = Vec::new();
    let mut skipped_pkg = 0usize;
    let mut already_ok = 0usize;
    let mut downloaded = 0usize;
    let mut download_failures: Vec<(String, String)> = Vec::new();

    for (key, index) in &repos {
        let mut entries = index.extensions.clone();
        if let Some(limit) = limit {
            entries.truncate(limit);
        }
        for ext in entries {
            if SKIPPED_PKGS.contains(&ext.pkg.as_str()) {
                println!(
                    "⏭️  {key}: {} — package on the known-crasher list, never tested",
                    ext.name
                );
                skipped_pkg += 1;
                continue;
            }
            let label = format!("{key}/{} v{} ({})", ext.name, ext.version, ext.pkg);
            if ext.apk_url.is_empty() {
                println!("⚠️  {label}: index entry has no apk url");
                download_failures.push((label.clone(), "index entry has no apk url".into()));
                state.set(
                    key,
                    &ext.pkg,
                    ExtensionState {
                        name: ext.name.clone(),
                        version: ext.version.clone(),
                        code: ext.code,
                        apk: String::new(),
                        status: "download_failed".into(),
                        error: Some("index entry has no apk url".into()),
                        tolerated_errors: Vec::new(),
                        tested_at: Some(now_secs()),
                    },
                );
                continue;
            }

            let file = apk_file_name(&ext);
            let path = Path::new(APK_DIR).join(key).join(&file);
            let tested = state
                .entry(key, &ext.pkg)
                .map(|e| tested_current(e, &ext))
                .unwrap_or(false);

            // Download when the APK is missing, or when the index ships a
            // version we have not cached (same file name with different
            // contents is possible, so re-download on any version change).
            let version_changed = state
                .entry(key, &ext.pkg)
                .map(|e| e.version != ext.version || e.code != ext.code)
                .unwrap_or(false);
            if !path.exists() || version_changed {
                match download_apk(&ext.apk_url, &path).await {
                    Ok(size) => {
                        downloaded += 1;
                        println!("⬇️  {label}: {file} ({:.1} MB)", size as f64 / 1e6);
                    }
                    Err(e) => {
                        println!("❌ {label}: download failed: {e:#}");
                        download_failures.push((label.clone(), format!("{e:#}")));
                        state.set(
                            key,
                            &ext.pkg,
                            ExtensionState {
                                name: ext.name.clone(),
                                version: ext.version.clone(),
                                code: ext.code,
                                apk: file,
                                status: "download_failed".into(),
                                error: Some(format!("{e:#}")),
                                tolerated_errors: Vec::new(),
                                tested_at: Some(now_secs()),
                            },
                        );
                        continue;
                    }
                }
            }

            if tested {
                already_ok += 1;
                println!("✅ {label}: already tested successfully at this version — skipping");
            }
            planned.push(PlannedExt {
                repo: key.clone(),
                ext,
                apk_path: path,
                test: !tested,
            });
        }
    }
    save_state(&state)?;

    // ---- Phase 3: run the workflow ----
    let to_test: Vec<&PlannedExt> = planned.iter().filter(|p| p.test).collect();
    if to_test.is_empty() {
        println!(
            "\n✅ Nothing to test — every extension is already recorded as succeeding \
             at its current version.\n   Delete {STATE_FILE} to force a full re-run."
        );
        return Ok(());
    }

    println!("\n=== Initialize MihonAdapter ===");
    let client = Box::new(MockAdapterClient::new());
    let adapter = MihonAdapter::new(client).await?;
    println!("✅ MihonAdapter initialized successfully");

    let mut successes = 0usize;
    let mut compat_failures: Vec<(String, String)> = Vec::new();
    let mut install_failures: Vec<(String, String)> = Vec::new();

    for (index, p) in to_test.iter().enumerate() {
        let label = label_of(p);
        println!(
            "\n======================================== [{}/{}]",
            index + 1,
            to_test.len()
        );
        println!("=== Testing extension: {label} ===");
        println!("========================================");

        let (status, error, tolerated_errors) =
            match run_extension_workflow(&adapter, &p.apk_path).await {
                WorkflowOutcome::Success { tolerated } => {
                    successes += 1;
                    println!("✅ SUCCESS: {label}");
                    if !tolerated.is_empty() {
                        println!(
                            "   (tolerated {} network/server error(s), recorded in the log above)",
                            tolerated.len()
                        );
                    }
                    ("success".to_string(), None, tolerated)
                }
                WorkflowOutcome::CompatFailed(step) => {
                    println!("❌ COMPAT FAIL: {label} ({step})");
                    compat_failures.push((label.clone(), step.clone()));
                    ("compat_failed".to_string(), Some(step), Vec::new())
                }
                WorkflowOutcome::InstallFailed(reason) => {
                    println!("⚠️  INSTALL/UNINSTALL FAIL: {label} ({reason})");
                    install_failures.push((label.clone(), reason.clone()));
                    ("install_failed".to_string(), Some(reason), Vec::new())
                }
            };

        state.set(
            &p.repo,
            &p.ext.pkg,
            ExtensionState {
                name: p.ext.name.clone(),
                version: p.ext.version.clone(),
                code: p.ext.code,
                apk: p
                    .apk_path
                    .file_name()
                    .map(|s| s.to_string_lossy().to_string())
                    .unwrap_or_default(),
                status,
                error,
                tolerated_errors,
                tested_at: Some(now_secs()),
            },
        );
        // Persist after every extension so an interrupted run keeps its
        // progress (the full suite runs for hours).
        save_state(&state)?;
    }

    // ---- Phase 4: summary ----
    println!("\n========================================");
    println!("=== REPO SUITE SUMMARY ===");
    println!("========================================");
    println!("Repos resolved:     {}", repos.len());
    println!(
        "Extensions listed:  {}",
        planned.len() + skipped_pkg + download_failures.len()
    );
    println!("APKs downloaded:    {downloaded}");
    println!("Skipped (known crashers): {skipped_pkg}");
    println!("Skipped (already OK):    {already_ok}");
    println!("Tested:             {}", to_test.len());
    println!("  success:          {successes}");
    println!("  compat failures:  {}", compat_failures.len());
    println!("  install failures: {}", install_failures.len());
    println!("Download failures:  {}", download_failures.len());
    println!("State file:         {STATE_FILE} (delete to re-test everything)");

    if !download_failures.is_empty() {
        println!("\n--- Download failures (retried on the next run) ---");
        for (label, reason) in &download_failures {
            println!("  {label}  @  {reason}");
        }
    }
    if !install_failures.is_empty() {
        println!("\n--- Install/uninstall failures ---");
        for (label, reason) in &install_failures {
            println!("  {label}  @  {reason}");
        }
    }
    if !compat_failures.is_empty() {
        println!("\n--- Compat/code failures (these need fixing) ---");
        for (label, step) in &compat_failures {
            println!("  {label}  @  {step}");
        }
        panic!(
            "\n❌ {} extension(s) failed with code/compat errors that need fixing \
             (see list above). Successful extensions were recorded in {STATE_FILE} \
             and are skipped on the next run; the failures above are re-tried.",
            compat_failures.len(),
        );
    }

    println!("\n✅ All tested extension(s) completed successfully!");
    Ok(())
}
