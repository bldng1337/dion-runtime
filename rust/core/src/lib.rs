mod convert_js;
pub mod datastructs;
pub mod error;
pub mod extension;
pub mod extension_container;
pub mod extension_manager;
mod networking_js;
pub mod permission;
mod permission_js;
mod setting_js;
pub mod settings;
mod utils;

#[cfg(test)]
mod tests {
    use std::time::Instant;

    use datastructs::Sort;
    use extension_manager::ExtensionManager;

    use crate::{
        datastructs,
        error::Error,
        extension::{TExtension, TExtensionManager},
        extension_manager,
        permission::{PermissionRequester, PERMISSION},
        settings::Settingvalue,
    };

    #[derive(Debug, Default)]
    struct TestPermission;

    #[async_trait::async_trait]
    impl PermissionRequester for TestPermission {
        async fn request(
            &self,
            _permission: &crate::permission::Permission,
            msg: Option<String>,
        ) -> bool {
            println!("Asked for: {}", msg.unwrap_or_default());
            return true;
        }
    }

    async fn extension_full(path: &str) -> Result<(), Error> {
        let start = Instant::now();
        let extm: ExtensionManager = ExtensionManager::new(path);
        let mut exts = extm.get_extensions().await.unwrap();
        println!("Init for {} took {} ms", path, start.elapsed().as_millis());
        for ext in exts.iter_mut() {
            let start = Instant::now();
            ext.set_enabled(true).await?;
            println!("Extension enable took {} ms", start.elapsed().as_millis());

            if ext
                .get_extension()
                .await
                .setting
                .get_settings_ids()
                .any(|e| e == "someid")
            {
                let start = Instant::now();
                assert!(
                    ext.get_extension()
                        .await
                        .setting
                        .get_setting(&"someid".to_string())?
                        .val
                        .get_string()?
                        == "somevalue"
                );
                ext.get_extension_mut()
                    .await
                    .setting
                    .get_setting_mut(&"someid".to_string())?
                    .val
                    .overwrite(Settingvalue::String {
                        val: "othervalue".to_string(),
                        default_val: String::default(),
                    })?;
                println!("Setting mutation took {} ms", start.elapsed().as_millis());
            }
            let start = Instant::now();
            let entries = ext.browse(0, Sort::Latest, None).await?;
            println!("browse took {} ms", start.elapsed().as_millis());
            let start = Instant::now();
            let detail = ext.detail(&entries[0].id, None).await?;
            println!("detail took {} ms", start.elapsed().as_millis());
            let start = Instant::now();
            let _src = ext.source(&detail.episodes[0].episodes[0].id, None).await?;
            println!("source took {} ms", start.elapsed().as_millis());
        }
        Ok(())
    }

    #[tokio::test]
    async fn my_test() -> Result<(), Error> {
        // console_subscriber::init();
        println!("Print test");
        {
            let mut a = PERMISSION.write().await;
            a.requester = Some(Box::new(TestPermission));
        }
        let start = Instant::now();
        extension_full(r#"./../../testextensions"#).await?;
        extension_full(r#"./../../testextensions/otherextensions"#).await?;
        let elapsed = start.elapsed();
        println!("Millis: {} ms", elapsed.as_millis());
        Ok(())
    }
}
