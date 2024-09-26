pub mod datastructs;
pub mod error;
pub mod jsextension;
mod networking_js;
pub mod permission;
mod permission_js;
mod setting_js;
pub mod settings;
mod utils;

#[cfg(test)]
mod tests {
    use datastructs::Sort;
    use jsextension::ExtensionManager;
    use rquickjs::AsyncRuntime;

    use crate::{
        datastructs,
        error::Error,
        jsextension,
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

    #[tokio::test]
    async fn my_test() -> Result<(), Error> {
        let rt = AsyncRuntime::new()?;
        let mut extm: ExtensionManager = Default::default();
        extm.add_from_file(r#"./../../testextensions/test.dion.js"#)
            .await?;
        {
            let mut a = PERMISSION.write().await;
            a.requester = Some(Box::new(TestPermission));
        }
        for ext in extm.iter_mut() {
            ext.enable(&rt).await?;
            println!("Enabled Extension");
            assert!(
                ext.get_extension().await.setting.get_setting(&"someid".to_string())?.val.get_string()?=="somevalue"
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
            let entries = ext.browse(0, Sort::Latest, None).await?;
            dbg!(&entries);
            let detail = ext.detail(&entries[0].id, None).await?;
            dbg!(&detail);
            let src = ext.source(&detail.episodes[0].episodes[0].id, None).await?;
            dbg!(src);
        }
        Ok(())
    }
}
