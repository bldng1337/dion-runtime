mod error;
pub mod jsextension;
pub mod permission;
pub mod settings;
mod networking_js;
mod utils;
mod permission_js;
mod setting_js;
pub mod datastructs;

#[cfg(test)]
mod tests {
    use datastructs::Sort;
    use jsextension::ExtensionManager;
    use rquickjs::AsyncRuntime;

    use crate::{datastructs, error::Error, jsextension, permission::{PermissionRequester, PERMISSION}};
    
    #[derive(Debug,Default)]
    struct TestPermission;

    #[async_trait::async_trait]
    impl PermissionRequester for TestPermission {
        async fn request(&self, permission: &crate::permission::Permission, msg: Option<String>) -> bool {
            println!("Asked for: {}",msg.unwrap_or_default());
            return true;
        }
    }

    #[tokio::test]
    async fn my_test() -> Result<(), Error> {
        let rt = AsyncRuntime::new()?;
        let mut extm: ExtensionManager = Default::default();
        extm.add_from_file(r#".\test.dion.js"#).await?;
        {
            let mut a=PERMISSION.write().await;
            a.requester=Some(Box::new(TestPermission));
        }
        for ext in extm.iter_mut() {
            ext.enable(&rt).await?;
            println!("Enabled Extension");
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
