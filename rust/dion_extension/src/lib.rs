pub(crate) mod extension;
mod extension_executor;
pub mod extension_manager;
mod js;
mod network;
mod proxy;
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
        for mut extension in exts.into_iter() {
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
            for entry in read_dir {
                if let Ok(entry) = entry {
                    let path = entry.path();
                    println!("{:?}", path);
                }
            }
        }
        panic!("No Extension found")
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
                    serde_json::to_string(&Source::Paragraphlist { paragraphs: vec![] }).unwrap(),
                );
        });
        server
    }

    const EXTENSION_PATH: &str = r#"../../tests/extensions/native/.dist"#;

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
                Source::Paragraphlist { paragraphs: vec![] },
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
