pub mod cache;
pub mod content;
pub(crate) mod extension;
mod extension_executor;
pub mod extension_manager;
mod filesystem;
mod js;
mod metadata;
mod network;
mod proxy;
mod range_file;
mod specta;
mod utils;

#[cfg(test)]
#[allow(unused_variables)]
mod tests {

    use anyhow::{Result, bail};
    use dion_runtime::client_data::{AdapterClient, ExtensionClient};
    use dion_runtime::data::action::Action;
    use dion_runtime::data::activity::EntryActivity;
    use dion_runtime::data::extension::ExtensionData;
    use dion_runtime::data::permission::Permission;
    use dion_runtime::data::settings::{Setting, SettingKind, SettingValue};
    use dion_runtime::data::source::{Entry, EntryDetailed, EntryId, EpisodeId, Source};
    use dion_runtime::extension::{Adapter, Extension};
    use httpmock::Method::GET;
    use httpmock::MockServer;

    use crate::extension_manager::DionExtensionAdapter;

    struct TestAdapterClient {
        path: String,
    }

    #[async_trait::async_trait()]
    impl AdapterClient for TestAdapterClient {
        async fn get_extension_client(
            &self,
            _extension: ExtensionData,
        ) -> Result<Box<dyn ExtensionClient>> {
            Ok(Box::new(TestExtensionClient {
                path: self.path.clone() + "/data",
            }))
        }

        async fn get_path(&self) -> Result<String> {
            Ok(self.path.clone())
        }
    }

    #[derive(Debug)]
    struct TestExtensionClient {
        path: String,
    }

    #[async_trait::async_trait()]
    impl ExtensionClient for TestExtensionClient {
        async fn load_data(&self, _key: &str) -> Result<String> {
            bail!("No loading implemented")
        }

        async fn set_entry_setting(
            &self,
            _entry: EntryId,
            _key: String,
            _value: SettingValue,
        ) -> Result<()> {
            Ok(())
        }

        async fn store_data(&self, _key: &str, _data: String) -> Result<()> {
            Ok(())
        }

        async fn load_data_secure(&self, _key: &str) -> Result<String> {
            bail!("No loading implemented")
        }

        async fn store_data_secure(&self, _key: &str, _data: String) -> Result<()> {
            Ok(())
        }

        async fn do_action(&self, _action: &Action) -> Result<()> {
            Ok(())
        }

        async fn store_set(&self, _key: &str, _value: serde_json::Value) -> Result<()> {
            Ok(())
        }

        async fn request_permission(
            &self,
            _permission: &Permission,
            _msg: Option<String>,
        ) -> Result<bool> {
            Ok(true)
        }

        async fn get_path(&self) -> Result<String> {
            Ok(self.path.clone())
        }
    }

    async fn setup_extension(path: &str, server: &MockServer) -> Result<Box<dyn Extension>> {
        let manager = DionExtensionAdapter::new(Box::new(TestAdapterClient {
            path: path.to_string(),
        }))
        .await?;
        let exts = manager.get_extensions().await?;
        if let Some(mut extension) = exts.into_iter().next() {
            extension
                .get_data()
                .write()
                .await
                .settings
                .merge_setting_definition(
                    "testdataserver".to_string(),
                    &SettingKind::Extension,
                    Setting {
                        label: "Server".to_string(),
                        value: SettingValue::String {
                            data: server.base_url(),
                        },
                        default: SettingValue::String {
                            data: server.base_url(),
                        },
                        visible: true,
                        ui: None,
                    },
                )?;
            extension.set_enabled(true).await?;
            return Ok(extension);
        }
        if let Ok(read_dir) = std::fs::read_dir(path) {
            for entry in read_dir.flatten() {
                let path = entry.path();
                println!("{:?}", path);
            }
        }
        panic!("No Extension found")
    }

    mod install {
        use super::*;
        use crate::extension_manager::ExtensionMetadata;
        use dion_runtime::data::extension_repo::ExtensionRepo;
        use std::path::{Path, PathBuf};

        const CODE: &str = "export default class {}";

        fn manifest(id: &str) -> ExtensionMetadata {
            ExtensionMetadata {
                id: id.to_string(),
                version: "1.0.0".to_string(),
                api_version: "*".to_string(),
                ..Default::default()
            }
        }

        fn setting(label: &str) -> Setting {
            let value = SettingValue::String {
                data: label.to_string(),
            };
            Setting {
                label: label.to_string(),
                value: value.clone(),
                default: value,
                visible: true,
                ui: None,
            }
        }

        fn with_setting(mut manifest: ExtensionMetadata, id: &str) -> ExtensionMetadata {
            manifest.settings.insert(
                SettingKind::Extension,
                [(id.to_string(), setting(id))].into(),
            );
            manifest
        }

        fn write_extension(path: &Path, manifest: &ExtensionMetadata) -> String {
            let contents = format!("//{}\n{CODE}", serde_json::to_string(manifest).unwrap());
            std::fs::write(path, &contents).unwrap();
            contents
        }

        async fn adapter(name: &str) -> (DionExtensionAdapter, PathBuf) {
            let dir = std::env::temp_dir().join(format!("dion-{name}-{}", std::process::id()));
            let _ = std::fs::remove_dir_all(&dir);
            std::fs::create_dir_all(&dir).unwrap();
            let adapter = DionExtensionAdapter::new(Box::new(TestAdapterClient {
                path: dir.to_string_lossy().into_owned(),
            }))
            .await
            .unwrap();
            (adapter, dir)
        }

        fn file_url(path: &Path) -> String {
            format!("file://{}", path.display())
        }

        #[tokio::test]
        async fn failed_update_keeps_the_installed_version() {
            let (adapter, dir) = adapter("update").await;
            let source = dir.join("source.js");
            let good = write_extension(&source, &manifest("updated"));
            adapter.install(&file_url(&source)).await.unwrap();
            let installed = dir.join("updated.dion.js");
            assert_eq!(std::fs::read_to_string(&installed).unwrap(), good);

            // Ids containing '/' are rejected while the extension is created.
            write_extension(&source, &with_setting(manifest("updated"), "bad/id"));
            assert!(adapter.install(&file_url(&source)).await.is_err());

            assert_eq!(std::fs::read_to_string(&installed).unwrap(), good);
            assert!(!dir.join("updated.dion.js.installing").exists());
            let _ = std::fs::remove_dir_all(dir);
        }

        #[tokio::test]
        async fn reload_applies_the_new_manifest_and_survives_a_missing_file() {
            let (adapter, dir) = adapter("reload").await;
            let source = dir.join("source.js");
            write_extension(&source, &manifest("reloaded"));
            let mut extension = adapter.install(&file_url(&source)).await.unwrap();
            extension.set_enabled(true).await.unwrap();
            let installed = dir.join("reloaded.dion.js");

            write_extension(&installed, &with_setting(manifest("reloaded"), "added"));
            extension.reload().await.unwrap();
            assert!(
                extension
                    .get_data()
                    .read()
                    .await
                    .settings
                    .get_setting("added", &SettingKind::Extension)
                    .is_ok()
            );

            std::fs::remove_file(&installed).unwrap();
            assert!(extension.reload().await.is_err());
            assert!(extension.is_enabled());
            let _ = std::fs::remove_dir_all(dir);
        }

        
    }

    fn setup_mock_server() -> MockServer {
        let server: MockServer = MockServer::start();

        // Create a mock on the server.
        let _ = server.mock(|when, then| {
            when.method(GET).path("/getEntry");
            then.status(200)
                .header("content-type", "application/json")
                .body(
                    serde_json::to_string(&EntryDetailed {
                        id: EntryId {
                            uid: "Some".to_string(),
                            iddata: Default::default(),
                        },
                        poster: Default::default(),
                        url: Default::default(),
                        titles: Default::default(),
                        author: Default::default(),
                        ui: Default::default(),
                        meta: Default::default(),
                        media_type: Default::default(),
                        status: Default::default(),
                        description: Default::default(),
                        language: Default::default(),
                        cover: Default::default(),
                        episodes: Default::default(),
                        genres: Default::default(),
                        rating: Default::default(),
                        views: Default::default(),
                        length: Default::default(),
                    })
                    .unwrap(),
                );
        });
        let _ = server.mock(|when, then| {
            when.method(GET).path("/getEntries");
            then.status(200)
                .header("content-type", "application/json")
                .body(
                    serde_json::to_string(&vec![Entry {
                        author: Default::default(),
                        cover: Default::default(),
                        id: EntryId {
                            uid: "Some".to_string(),
                            iddata: Default::default(),
                        },
                        length: Default::default(),
                        media_type: Default::default(),
                        rating: Default::default(),
                        title: Default::default(),
                        views: Default::default(),
                        url: Default::default(),
                    }])
                    .unwrap(),
                );
        });
        let _ = server.mock(|when, then| {
            when.method(GET).path("/getSource");
            then.status(200)
                .header("content-type", "application/json")
                .body(
                    serde_json::to_string(&Source::Paragraphlist {
                        paragraphs: vec![],
                        audio: None,
                    })
                    .unwrap(),
                );
        });
        server
    }

    const EXTENSION_PATH: &str = r#"../../tests/extensions/native/.dist"#;
    const ARGUMENTS_EXTENSION_PATH: &str = r#"../../tests/extensions/arguments/.dist"#;

    #[tokio::test]
    async fn browse() -> Result<()> {
        simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        extension.browse(1, None).await?;
        Ok(())
    }

    #[tokio::test]
    async fn search() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        extension.search(1, "".to_string(), None).await?;
        Ok(())
    }

    #[tokio::test]
    async fn handle_url() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        extension.handle_url("Some".to_string(), None).await?;
        Ok(())
    }

    #[tokio::test]
    async fn detail() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        let entry = extension
            .detail(
                EntryId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        Ok(())
    }

    #[tokio::test]
    async fn refresh_fallback() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        let detail = extension
            .detail(
                EntryId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        // The native test extension exports no refresh, so this must fall
        // back to a plain detail fetch of the stored entry's id.
        let refreshed = extension
            .refresh(detail.entry, Default::default(), None)
            .await?;
        assert_eq!(refreshed.entry.id.uid, "Some");
        Ok(())
    }

    #[tokio::test]
    async fn refresh() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(ARGUMENTS_EXTENSION_PATH, &server).await?;
        let detail = extension
            .detail(
                EntryId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        // The arguments test extension refreshes by echoing the received
        // entry with an extra title, proving the stored entry reached JS.
        let refreshed = extension
            .refresh(detail.entry, Default::default(), None)
            .await?;
        assert!(
            refreshed
                .entry
                .titles
                .contains(&"refreshed by refresh".to_string())
        );
        Ok(())
    }

    #[tokio::test]
    async fn source() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        let source = extension
            .source(
                EpisodeId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        Ok(())
    }

    #[tokio::test]
    async fn map_entry() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        let entry = extension
            .map_entry(
                EntryDetailed {
                    id: EntryId {
                        uid: "Some".to_string(),
                        iddata: Default::default(),
                    },
                    poster: Default::default(),
                    url: Default::default(),
                    titles: Default::default(),
                    author: Default::default(),
                    ui: Default::default(),
                    meta: Default::default(),
                    media_type: Default::default(),
                    status: Default::default(),
                    description: Default::default(),
                    language: Default::default(),
                    cover: Default::default(),
                    episodes: Default::default(),
                    genres: Default::default(),
                    rating: Default::default(),
                    views: Default::default(),
                    length: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        Ok(())
    }

    #[tokio::test]
    async fn on_entry_activity() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        extension
            .on_entry_activity(
                EntryActivity::EpisodeActivity { progress: 43 },
                EntryDetailed {
                    id: EntryId {
                        uid: "Some".to_string(),
                        iddata: Default::default(),
                    },
                    poster: Default::default(),
                    url: Default::default(),
                    titles: Default::default(),
                    author: Default::default(),
                    ui: Default::default(),
                    meta: Default::default(),
                    media_type: Default::default(),
                    status: Default::default(),
                    description: Default::default(),
                    language: Default::default(),
                    cover: Default::default(),
                    episodes: Default::default(),
                    genres: Default::default(),
                    rating: Default::default(),
                    views: Default::default(),
                    length: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        Ok(())
    }

    #[tokio::test]
    async fn map_source() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        let source = extension
            .map_source(
                Source::Paragraphlist {
                    paragraphs: vec![],
                    audio: None,
                },
                EpisodeId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        Ok(())
    }

    #[tokio::test]
    async fn reload() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let mut extension = setup_extension(EXTENSION_PATH, &server).await?;
        extension.reload().await?;
        Ok(())
    }

    #[tokio::test]
    async fn get_data() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let extension = setup_extension(EXTENSION_PATH, &server).await?;
        let data = extension.get_data().read().await;
        Ok(())
    }

    #[tokio::test]
    async fn end_to_end() -> Result<()> {
        // simple_logger::SimpleLogger::new().env().init().unwrap();
        let server = setup_mock_server();
        let mut extension = setup_extension(EXTENSION_PATH, &server).await?;
        extension.browse(1, None).await?;
        extension.search(1, "".to_string(), None).await?;
        extension.handle_url("Some".to_string(), None).await?;
        let entry = extension
            .detail(
                EntryId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        extension
            .map_entry(entry.entry, Default::default(), None)
            .await?;
        extension
            .on_entry_activity(
                EntryActivity::EpisodeActivity { progress: 43 },
                EntryDetailed {
                    id: EntryId {
                        uid: "Some".to_string(),
                        iddata: Default::default(),
                    },
                    poster: Default::default(),
                    url: Default::default(),
                    titles: Default::default(),
                    author: Default::default(),
                    ui: Default::default(),
                    meta: Default::default(),
                    media_type: Default::default(),
                    status: Default::default(),
                    description: Default::default(),
                    language: Default::default(),
                    cover: Default::default(),
                    episodes: Default::default(),
                    genres: Default::default(),
                    rating: Default::default(),
                    views: Default::default(),
                    length: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        let source = extension
            .source(
                EpisodeId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        extension
            .map_source(
                source.source,
                EpisodeId {
                    uid: "Some".to_string(),
                    iddata: Default::default(),
                },
                Default::default(),
                None,
            )
            .await?;
        extension.reload().await?;
        Ok(())
    }
}
