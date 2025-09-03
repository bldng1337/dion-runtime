// pub mod auth;
pub mod client_data;
pub mod datastructs;
pub mod extension;
pub mod permission;
pub mod settings;
mod specta;

#[allow(unused_variables)]
#[allow(dead_code)]
#[cfg(test)]
mod test {

    use std::{collections::HashMap, sync::Arc};

    use crate::{
        client_data::{ClientExtensionData, ClientManagerData},
        datastructs::{
            Action, EntryActivity, EntryDetailed, EntryDetailedResult, EntryList, ExtensionData,
            ExtensionRepo, Link, RemoteExtension, Source, SourceResult,
        },
        extension::{Extension, ExtensionManager, ExtensionStore},
        permission::PermissionStore,
        settings::{Setting, SettingStore},
    };

    use anyhow::{bail, Result};
    use tokio::sync::RwLock;
    use tokio_util::sync::CancellationToken;

    struct TestExtensionManager {
        manager: Box<dyn ClientManagerData>,
    }

    impl TestExtensionManager {
        fn new(client: Box<dyn ClientManagerData>) -> Self {
            Self { manager: client }
        }
    }

    #[async_trait::async_trait()]
    impl ExtensionManager for TestExtensionManager {
        async fn get_extensions(&self) -> Result<Vec<Box<dyn Extension>>> {
            let client = self
                .manager
                .get_client(ExtensionData {
                    ..Default::default()
                })
                .await?;
            Ok(vec![Box::new(
                TestExtension::new("Some Extension".to_string(), client).await,
            )])
        }

        async fn install(&self, location: &RemoteExtension) -> Result<Box<dyn Extension>> {
            let client = self
                .manager
                .get_client(ExtensionData {
                    ..Default::default()
                })
                .await?;
            Ok(Box::new(
                TestExtension::new(location.extension_url.clone(), client).await,
            ))
        }

        async fn install_single(&self, url: &str) -> Result<Box<dyn Extension>> {
            let client = self
                .manager
                .get_client(ExtensionData {
                    ..Default::default()
                })
                .await?;
            Ok(Box::new(TestExtension::new(url.to_string(), client).await))
        }

        async fn uninstall(&self, ext: Box<dyn Extension>) -> Result<()> {
            Ok(())
        }

        async fn get_repo(&self, url: &str) -> Result<ExtensionRepo> {
            Ok(ExtensionRepo {
                name: "TestRepo".to_string(),
                description: "Test".to_string(),
                id: "someid3234".to_string(),
                extensions: vec![RemoteExtension {
                    extension_url: url.to_string(),
                    ..Default::default()
                }],
            })
        }
    }

    struct TestExtension {
        enabled: bool,
        name: String,
        client: Box<dyn ClientExtensionData>,
        store: Arc<RwLock<ExtensionStore>>,
    }

    impl TestExtension {
        async fn new(name: String, client: Box<dyn ClientExtensionData>) -> Self {
            Self {
                enabled: false,
                name,
                store: Arc::new(RwLock::new(ExtensionStore {
                    data: ExtensionData::default(),
                    permission: PermissionStore::new(client.as_ref()).await,
                    settings: SettingStore::new(client.as_ref()).await,
                })),
                client,
            }
        }
    }

    #[async_trait::async_trait()]
    impl Extension for TestExtension {
        fn is_enabled(&self) -> bool {
            self.enabled
        }

        fn get_data(&self) -> &RwLock<ExtensionStore> {
            &self.store
        }

        async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
            self.enabled = enabled;
            Ok(())
        }

        async fn reload(&mut self) -> Result<()> {
            Ok(())
        }

        async fn browse(&self, page: i32, token: Option<CancellationToken>) -> Result<EntryList> {
            Ok(EntryList {
                ..Default::default()
            })
        }

        async fn search(
            &self,
            page: i32,
            filter: String,
            token: Option<CancellationToken>,
        ) -> Result<EntryList> {
            Ok(EntryList {
                ..Default::default()
            })
        }

        async fn fromurl(&self, url: String, token: Option<CancellationToken>) -> Result<bool> {
            Ok(true)
        }

        async fn detail(
            &self,
            entryid: String,
            settings: HashMap<String, Setting>,
            token: Option<CancellationToken>,
        ) -> Result<EntryDetailedResult> {
            Ok(EntryDetailedResult {
                entry: EntryDetailed {
                    ..Default::default()
                },
                settings,
            })
        }

        async fn source(
            &self,
            epid: String,
            settings: HashMap<String, Setting>,
            token: Option<CancellationToken>,
        ) -> Result<SourceResult> {
            Ok(SourceResult {
                source: Source::Pdf {
                    link: Link {
                        url: "some".to_string(),
                        header: None,
                    },
                },
                settings,
            })
        }

        async fn map_entry(
            &self,
            entry: EntryDetailed,
            settings: HashMap<String, Setting>,
            token: Option<CancellationToken>,
        ) -> Result<EntryDetailedResult> {
            Ok(EntryDetailedResult { entry, settings })
        }

        async fn on_entry_activity(
            &self,
            activity: EntryActivity,
            entry: EntryDetailed,
            settings: HashMap<String, Setting>,
            token: Option<CancellationToken>,
        ) -> Result<()> {
            Ok(())
        }

        async fn map_source(
            &self,
            source: Source,
            settings: HashMap<String, Setting>,
            token: Option<CancellationToken>,
        ) -> Result<SourceResult> {
            Ok(SourceResult { source, settings })
        }

        fn get_client(&self) -> &dyn ClientExtensionData {
            self.client.as_ref()
        }
    }

    struct TestClientManagerData {}

    #[async_trait::async_trait()]
    impl ClientManagerData for TestClientManagerData {
        async fn get_client(
            &self,
            extension: ExtensionData,
        ) -> Result<Box<dyn ClientExtensionData>> {
            Ok(Box::new(TestClientExtensionData {}))
        }

        async fn get_path(&self) -> Result<String> {
            Ok(String::new())
        }
    }

    #[derive(Debug)]
    struct TestClientExtensionData {}

    #[async_trait::async_trait()]
    impl ClientExtensionData for TestClientExtensionData {
        async fn load_data(&self, key: &str) -> Result<String> {
            bail!("No loading implemented")
        }

        async fn store_data(&self, key: &str, data: String) -> Result<()> {
            Ok(())
        }

        async fn do_action(&self, action: &Action) -> Result<()> {
            Ok(())
        }

        async fn request_permission(
            &self,
            permission: &crate::permission::Permission,
            msg: Option<String>,
        ) -> Result<bool> {
            Ok(true)
        }

        async fn get_path(&self) -> Result<String> {
            Ok(String::new())
        }
    }

    #[tokio::test]
    async fn simple_test() {
        let testclient = TestExtensionManager::new(Box::new(TestClientManagerData {}));
        for mut extension in testclient.get_extensions().await.unwrap() {
            assert!(!extension.is_enabled());
            extension.set_enabled(true).await.unwrap();
            assert!(extension.is_enabled());
        }
    }
}
