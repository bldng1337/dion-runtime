pub mod data;
pub mod extension;
pub(crate) mod js;

#[cfg(test)]
mod tests {
    use std::time::Instant;

    use crate::{
        data::{
            datastructs::Sort,
            permission::{set_permission_request, Permission, PermissionRequester},
            settings::Settingvalue,
        },
        extension::{
            extension::{TSourceExtension, TSourceExtensionManager},
            extension_manager::ExtensionManager,
        },
    };
    use anyhow::{anyhow, Context as ErrorContext, Result};

    #[derive(Debug, Default)]
    struct TestPermission;

    #[async_trait::async_trait]
    impl PermissionRequester for TestPermission {
        async fn request(&self, _permission: &Permission, msg: Option<String>) -> bool {
            let val = msg.unwrap_or_default();
            println!("Asked for: {}", &val);
            return val != "other";
        }
    }

    async fn extension_full(path: &str) -> Result<()> {
        let start = Instant::now();
        let extm: ExtensionManager = ExtensionManager::new(path);
        let mut exts = extm.get_extensions().await.unwrap();
        println!("Init for {} took {} ms", path, start.elapsed().as_millis());
        for ext in exts.iter_mut() {
            let start = Instant::now();
            ext.set_enabled(true).await?;
            println!("Extension enable took {} ms", start.elapsed().as_millis());
            println!("Extension enabled: {}", ext.is_enabled());
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
                        .setting
                        .val
                        .get_string()?
                        == "somevalue"
                );
                ext.get_extension_mut()
                    .await
                    .setting
                    .get_setting_mut(&"someid".to_string())?
                    .setting
                    .val
                    .overwrite(&Settingvalue::String {
                        val: "othervalue".to_string(),
                        default_val: String::default(),
                    })?;
                println!("Setting mutation took {} ms", start.elapsed().as_millis());
            }
            let start = Instant::now();
            let entries = ext.browse(0, Sort::Latest, None).await?;
            println!("browse took {} ms", start.elapsed().as_millis());
            let start = Instant::now();
            let detail = ext.detail(&entries[0].id, vec![], None).await?;
            println!("detail took {} ms", start.elapsed().as_millis());
            let start = Instant::now();
            let _src = ext.source(&detail.episodes[0].id, vec![], None).await?;
            println!("source took {} ms", start.elapsed().as_millis());
        }
        Ok(())
    }

    #[tokio::test]
    async fn my_test() -> Result<()> {
        // let fnc = Box::new(async move |_perm: Permission, msg: Option<String>| {
        //     let val = msg.unwrap_or_default();
        //     println!("Asked for: {}", &val);
        //     return val != "other";
        // });
        // set_permission_request(Box::new(PermissionCallback::wrap(fnc))).await;
        set_permission_request(Box::new(TestPermission)).await;
        let start = Instant::now();
        extension_full(r#"./../../testextensions"#).await?;
        extension_full(r#"./../../testextensions/otherextensions"#).await?;
        let elapsed = start.elapsed();
        println!("Millis: {} ms", elapsed.as_millis());
        Ok(())
    }
}
