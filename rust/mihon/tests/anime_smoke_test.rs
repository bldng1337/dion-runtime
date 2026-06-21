//! Focused integration test that exercises a single anime extension from
//! `testdata/`. This is useful for quickly validating the anime code path
//! (browse/search/detail/source) without running the full multi-hundred-APK
//! suite in `integration_test.rs`.
//!
//! Run with:
//!   cargo test --test anime_smoke_test -- --nocapture --ignored

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

const CALL_DELAY: Duration = Duration::from_millis(500);

struct MockAdapterClient {
    temp_dir: PathBuf,
}

impl MockAdapterClient {
    fn new() -> Self {
        let temp_dir = std::env::temp_dir().join(format!("mihon-anime-{}", uuid::Uuid::new_v4()));
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

fn tolerate_network_errors(context: &str, error: anyhow::Error) {
    let s = format!("{:#}", error).to_lowercase();
    let code_error_indicators: &[&str] = &[
        "noclassdeffounderror",
        "classnotfoundexception",
        "classcastexception",
        "nosuchmethoderror",
        "nosuchfielderror",
        "illegalaccesserror",
        "incompatibleclasschangeerror",
        "linkageerror",
        "stackoverflowerror",
        "outofmemoryerror",
    ];
    for indicator in code_error_indicators {
        if s.contains(indicator) {
            panic!(
                "\n\n❌ CODE/COMPAT ERROR during {} — this is NOT a network error!\n{}\n",
                context, s
            );
        }
    }
    println!("⚠️  {} failed (tolerated): {}", context, s);
}

#[tokio::test]
#[ignore = "Smoke test - run manually against a single anime APK"]
async fn anime_smoke_test() -> anyhow::Result<()> {
    // Pick one APK from testdata. Override with the ANIME_APK env var to try
    // a different one.
    let apk: PathBuf = std::env::var("ANIME_APK")
        .map(PathBuf::from)
        .unwrap_or_else(|_| PathBuf::from("testdata/aniyomi-en.anikage-v14.2.apk"));

    println!("=== Anime smoke test: {} ===", apk.display());

    let client = Box::new(MockAdapterClient::new());
    let adapter = MihonAdapter::new(client).await?;

    let apk_url = format!("file://{}", apk.canonicalize()?.display());
    let extension = adapter.install(&apk_url).await?;
    let ext_name = extension.get_data().read().await.data.name.clone();
    println!("✅ Installed: {}", ext_name);

    // browse
    println!("\n=== Browse (Popular) ===");
    tokio::time::sleep(CALL_DELAY).await;
    match extension.browse(0, None).await {
        Ok(browse_result) => {
            println!("✅ Browse returned {} entries", browse_result.content.len());
            if let Some(entry) = browse_result.content.first().cloned() {
                println!("  First entry: {} ({})", entry.title, entry.id.uid);

                // search
                println!("\n=== Search ===");
                tokio::time::sleep(CALL_DELAY).await;
                match extension.search(0, entry.title.clone(), None).await {
                    Ok(search_result) => {
                        println!("✅ Search returned {} entries", search_result.content.len());
                        let target = search_result.content.first().cloned().unwrap_or(entry);
                        // detail
                        println!("\n=== Detail ===");
                        tokio::time::sleep(CALL_DELAY).await;
                        match extension
                            .detail(target.id.clone(), HashMap::new(), None)
                            .await
                        {
                            Ok(detail_result) => {
                                println!(
                                    "✅ Detail: {} episodes, {} genres",
                                    detail_result.entry.episodes.len(),
                                    detail_result
                                        .entry
                                        .genres
                                        .as_ref()
                                        .map(Vec::len)
                                        .unwrap_or(0)
                                );
                                if let Some(episode) = detail_result.entry.episodes.first().cloned()
                                {
                                    println!(
                                        "  First episode: {} ({})",
                                        episode.name, episode.id.uid
                                    );
                                    // source
                                    println!("\n=== Source ===");
                                    tokio::time::sleep(CALL_DELAY).await;
                                    match extension.source(episode.id, HashMap::new(), None).await {
                                        Ok(source_result) => {
                                            let description = match &source_result.source {
                                                dion_runtime::data::source::Source::Video {
                                                    sources,
                                                    ..
                                                } => format!("{} video sources", sources.len()),
                                                dion_runtime::data::source::Source::Imagelist {
                                                    links,
                                                    ..
                                                } => format!("{} images (unexpected)", links.len()),
                                                _ => "unknown".to_string(),
                                            };
                                            println!("✅ Source retrieved: {}", description);
                                        }
                                        Err(e) => tolerate_network_errors("source", e),
                                    }
                                }
                            }
                            Err(e) => tolerate_network_errors("detail", e),
                        }
                    }
                    Err(e) => tolerate_network_errors("search", e),
                }
            }
        }
        Err(e) => tolerate_network_errors("browse", e),
    }

    adapter.uninstall(&extension).await?;
    println!("\n✅ Uninstalled: {}", ext_name);
    Ok(())
}

#[tokio::test]
#[ignore = "Smoke test - run manually against a batch of anime APKs"]
async fn anime_batch_smoke_test() -> anyhow::Result<()> {
    // Test a handful of anime extensions end-to-end.
    let apks: Vec<PathBuf> = std::env::var("ANIME_APKS")
        .ok()
        .map(|s| s.split(',').map(PathBuf::from).collect())
        .unwrap_or_else(|| {
            [
                "testdata/aniyomi-en.anikage-v14.2.apk",
                "testdata/aniyomi-en.zoro-v14.74.apk",
                "testdata/aniyomi-en.aniwatch-v14.20.apk",
                "testdata/aniyomi-all.animeonsen-v14.10.apk",
            ]
            .iter()
            .map(PathBuf::from)
            .collect()
        });

    println!("=== Anime batch smoke test: {} APKs ===", apks.len());

    let client = Box::new(MockAdapterClient::new());
    let adapter = MihonAdapter::new(client).await?;

    for apk in &apks {
        println!("\n========================================");
        println!("=== {} ===", apk.display());
        println!("========================================");
        let apk_url = format!("file://{}", apk.canonicalize()?.display());
        match adapter.install(&apk_url).await {
            Ok(extension) => {
                let name = extension.get_data().read().await.data.name.clone();
                println!("✅ Installed: {}", name);
                tokio::time::sleep(CALL_DELAY).await;
                match extension.browse(0, None).await {
                    Ok(result) => {
                        println!("✅ Browse returned {} entries", result.content.len());
                        if let Some(entry) = result.content.first().cloned() {
                            println!("  First: {} ({})", entry.title, entry.id.uid);
                            tokio::time::sleep(CALL_DELAY).await;
                            match extension.detail(entry.id, HashMap::new(), None).await {
                                Ok(detail) => {
                                    println!("✅ Detail: {} episodes", detail.entry.episodes.len());
                                    if let Some(ep) = detail.entry.episodes.first().cloned() {
                                        tokio::time::sleep(CALL_DELAY).await;
                                        match extension.source(ep.id, HashMap::new(), None).await {
                                            Ok(source) => match &source.source {
                                                dion_runtime::data::source::Source::Video {
                                                    sources,
                                                    ..
                                                } => println!(
                                                    "✅ Source: {} video sources",
                                                    sources.len()
                                                ),
                                                _ => println!("ℹ️  Source: non-video"),
                                            },
                                            Err(e) => tolerate_network_errors("source", e),
                                        }
                                    }
                                }
                                Err(e) => tolerate_network_errors("detail", e),
                            }
                        }
                    }
                    Err(e) => tolerate_network_errors("browse", e),
                }
                adapter.uninstall(&extension).await?;
                println!("✅ Uninstalled: {}", name);
            }
            Err(e) => {
                println!("❌ Install failed for {}: {:#}", apk.display(), e);
            }
        }
    }

    Ok(())
}

// Silence unused warning for Path import on some builds.
#[allow(dead_code)]
fn _path_use(_p: &Path) {}
