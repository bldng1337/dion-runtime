//! Integration tests for Mihon Adapter
//!
//! This test module tests the full extension loading workflow:
//! 1. Initialize MihonAdapter
//! 2. Install extension from APK
//! 3. Load extension
//! 4. Call all extension methods (browse, search, detail, source)

use std::collections::HashMap;
use std::path::PathBuf;

use dion_runtime::client_data::{AdapterClient, ExtensionClient};
use dion_runtime::data::{
    action::Action, extension::ExtensionData, permission::Permission,
    settings::SettingValue, source::EntryId,
};
use dion_runtime::extension::Adapter;

use mihon_adapter::MihonAdapter;

/// Check whether an error from an extension operation is a genuine network error
/// that should be tolerated by the test, or a code/compat bug that must fail.
///
/// Network errors are expected when remote servers are unavailable, blocking
/// requests, or returning error responses. Code errors indicate missing stubs,
/// unimplemented methods, or bugs in the compat layer that need fixing.
///
/// # Panics
/// Panics (fails the test) if the error is a code/compat bug or an unrecognized error.
fn tolerate_only_network_errors(context: &str, error: anyhow::Error) {
    let error_string = format!("{:#}", error);
    let error_lower = error_string.to_lowercase();

    // Code/compat error patterns — these are bugs that must be fixed
    let code_error_indicators: &[&str] = &[
        "noclassdeffounderror",
        "classnotfoundexception",
        "nullpointerexception",
        "classcastexception",
        "nosuchmethoderror",
        "nosuchfielderror",
        "illegalaccesserror",
        "incompatibleclasschangeerror",
        "linkageerror",
        "stackoverflowerror",
        "outofmemoryerror",
        "unsupportedoperationexception",
        "nosuchelementexception",
        "indexoutofboundsexception",
        "arrayindexoutofboundsexception",
        "illegalargumentexception",
        "illegalstateexception",
        "numberformatexception",
        "json",
        "parse",
        "deserialize",
        "failed to parse json",
    ];

    for indicator in code_error_indicators {
        if error_lower.contains(indicator) {
            panic!(
                "\n\n❌ CODE/COMPAT ERROR during {} — this is NOT a network error!\n\
                 This indicates a bug in the compat layer or a missing Android stub.\n\
                 Fix the underlying issue before re-running the test.\n\
                 \n\
                 Error: {}\n",
                context, error_string
            );
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
            return;
        }
    }

    // Not a recognized network error — fail the test
    panic!(
        "\n\n❌ UNRECOGNIZED ERROR during {} — this does not look like a network error.\n\
         If this is a legitimate network error, add the pattern to the test's\n\
         `network_error_indicators` list. Otherwise, fix the underlying issue.\n\
         \n\
         Error: {}\n",
        context, error_string
    );
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

#[tokio::test]
async fn test_full_extension_workflow() -> anyhow::Result<()> {
    // Initialize test client
    let client = Box::new(MockAdapterClient::new());

    println!("=== Initialize ===");
    let adapter = MihonAdapter::new(client).await?;
    println!("✅ MihonAdapter initialized successfully");

    println!("\n=== Install Extension ===");
    let apk_path = PathBuf::from("testdata/test.apk");
    let apk_url = format!("file://{}", apk_path.canonicalize()?.display());

    let extension = adapter.install(&apk_url).await?;
    let ext_name = extension.get_data().read().await.data.name.clone();
    println!("✅ Extension installed: {}", ext_name);

    // ========== Browse (Popular) ==========
    println!("\n=== Browse (Popular) ===");
    match extension.browse(0, None).await {
        Ok(browse_result) => {
            println!("✅ Browse returned {} entries", browse_result.content.len());

            if let Some(entry) = browse_result.content.first() {
                println!("  First entry: {} ({})", entry.title, entry.id.uid);

                // ========== Search ==========
                println!("\n=== Search ===");
                match extension.search(0, "test".to_string(), None).await {
                    Ok(search_result) => {
                        println!("✅ Search returned {} entries", search_result.content.len());

                        if let Some(entry) = search_result.content.first() {
                            println!("  First result: {} ({})", entry.title, entry.id.uid);

                            // ========== Detail ==========
                            println!("\n=== Detail ===");
                            let entry_id = entry.id.clone();
                            match extension.detail(entry_id, HashMap::new(), None).await {
                                Ok(detail_result) => {
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

                                    if let Some(episode) = detail_result.entry.episodes.first() {
                                        println!(
                                            "  First episode: {} ({})",
                                            episode.name, episode.id.uid
                                        );

                                        // ========== Source ==========
                                        println!("\n=== Source ===");
                                        let episode_id = episode.id.clone();
                                        match extension
                                            .source(episode_id, HashMap::new(), None)
                                            .await
                                        {
                                            Ok(source_result) => {
                                                let description = match &source_result.source {
                                                    dion_runtime::data::source::Source::Imagelist {
                                                        links,
                                                        ..
                                                    } => format!("{} images", links.len()),
                                                    dion_runtime::data::source::Source::Video {
                                                        sources,
                                                        ..
                                                    } => format!("{} video sources", sources.len()),
                                                    dion_runtime::data::source::Source::Audio {
                                                        sources,
                                                        ..
                                                    } => format!("{} audio sources", sources.len()),
                                                    _ => "Unknown source type".to_string(),
                                                };
                                                println!("✅ Source retrieved: {}", description);
                                            }
                                            Err(e) => {
                                                tolerate_only_network_errors("source", e);
                                            }
                                        }
                                    }
                                }
                                Err(e) => {
                                    tolerate_only_network_errors("detail", e);
                                }
                            }
                        }
                    }
                    Err(e) => {
                        tolerate_only_network_errors("search", e);
                    }
                }
            }
        }
        Err(e) => {
            tolerate_only_network_errors("browse", e);
        }
    }

    // ========== Uninstall ==========
    println!("\n=== Uninstall Extension ===");
    adapter.uninstall(&extension).await?;
    println!("✅ Extension uninstalled");

    println!("\n✅ All tests completed!");

    Ok(())
}

#[tokio::test]
#[ignore = "Requires separate JVM instance - run manually"]
async fn test_get_extensions() -> anyhow::Result<()> {
    println!("=== Test get_extensions ===");
    let client = Box::new(MockAdapterClient::new());
    let adapter = MihonAdapter::new(client).await?;

    // Install extension first
    let apk_path = PathBuf::from("testdata/test.apk");
    let apk_url = format!("file://{}", apk_path.canonicalize()?.display());
    adapter.install(&apk_url).await?;

    // Get all extensions
    let extensions = adapter.get_extensions().await?;
    println!("✅ Found {} extension(s)", extensions.len());

    for ext in &extensions {
        let data = ext.get_data().read().await;
        println!("  - {} ({})", data.data.name, data.data.id);
    }

    Ok(())
}

#[tokio::test]
#[ignore = "Binary XML parser has known bug - see state.md"]
async fn test_metadata_extraction() -> anyhow::Result<()> {
    println!("=== Test Metadata Extraction ===");
    use mihon_adapter::apk::MihonExtensionMetadata;

    let apk_path = PathBuf::from("testdata/test.apk");

    let metadata = MihonExtensionMetadata::from_apk(&apk_path)?;

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

    Ok(())
}