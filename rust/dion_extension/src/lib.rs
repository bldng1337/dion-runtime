pub(crate) mod extension;
mod extension_executor;
pub mod extension_manager;
mod js;
mod network;
mod utils;

#[cfg(test)]
mod tests {

    use anyhow::{Result, bail};
    use dion_runtime::client_data::{ClientExtensionData, ClientManagerData};
    use dion_runtime::datastructs::{
        Action, Entry, EntryActivity, EntryDetailed, ExtensionData, Source,
    };
    use dion_runtime::extension::ExtensionManager;
    use dion_runtime::permission::Permission;
    use dion_runtime::settings::{Setting, SettingKind, SettingValue};
    use httpmock::Method::GET;
    use httpmock::MockServer;

    use crate::extension_manager::DionExtensionManager;

    struct TestClientManagerData {
        path: String,
    }

    #[async_trait::async_trait()]
    impl ClientManagerData for TestClientManagerData {
        async fn get_client(
            &self,
            _extension: ExtensionData,
        ) -> Result<Box<dyn ClientExtensionData>> {
            Ok(Box::new(TestClientExtensionData {
                path: self.path.clone() + "/data",
            }))
        }

        async fn get_path(&self) -> Result<String> {
            Ok(self.path.clone())
        }
    }

    #[derive(Debug)]
    struct TestClientExtensionData {
        path: String,
    }

    #[async_trait::async_trait()]
    impl ClientExtensionData for TestClientExtensionData {
        async fn load_data(&self, _key: &str) -> Result<String> {
            bail!("No loading implemented")
        }

        async fn store_data(&self, _key: &str, _data: String) -> Result<()> {
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

    async fn extension_full(path: &str, server: &MockServer) -> Result<()> {
        let manager = DionExtensionManager::new(Box::new(TestClientManagerData {
            path: path.to_string(),
        }))
        .await?;
        let mut exts = manager.get_extensions().await?;
        assert!(!exts.is_empty(), "No Extension found");
        for extension in exts.iter_mut() {
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
            extension.browse(1, None).await?;
            extension.search(1, "".to_string(), None).await?;
            extension.fromurl("Some".to_string(), None).await?;
            let entry = extension
                .detail("Some".to_string(), Default::default(), None)
                .await?;
            extension
                .map_entry(entry.entry, Default::default(), None)
                .await?;
            extension
                .on_entry_activity(
                    EntryActivity::EpisodeActivity { progress: 43 },
                    Default::default(),
                    Default::default(),
                    None,
                )
                .await?;
            let source = extension
                .source("epid".to_string(), Default::default(), None)
                .await?;
            extension
                .map_source(source.source, Default::default(), None)
                .await?;
            extension.reload().await?;
        }
        Ok(())
    }

    #[tokio::test]
    async fn my_test() -> Result<()> {
        let server: MockServer = MockServer::start();

        // Create a mock on the server.
        let _ = server.mock(|when, then| {
            when.method(GET).path("/getEntry");
            then.status(200)
                .header("content-type", "application/json")
                .body(serde_json::to_string(&EntryDetailed::default()).unwrap());
        });
        let _ = server.mock(|when, then| {
            when.method(GET).path("/getEntries");
            then.status(200)
                .header("content-type", "application/json")
                .body(serde_json::to_string(&vec![Entry::default()]).unwrap());
        });
        let _ = server.mock(|when, then| {
            when.method(GET).path("/getSource");
            then.status(200)
                .header("content-type", "application/json")
                .body(
                    serde_json::to_string(&Source::Paragraphlist { paragraphs: vec![] }).unwrap(),
                );
        });
        extension_full(r#"../../tests/dion/native"#, &server).await?;
        Ok(())
    }
}
