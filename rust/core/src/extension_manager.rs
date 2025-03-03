use tokio::fs::read_dir;

use crate::extension_container::ExtensionContainer;
use crate::{
    datastructs::ExtensionData,
    error::{Error, Result},
    extension::TExtensionManager,
    permission::PermissionStore,
    settings::SettingStore,
};

pub struct ExtensionManager {
    path: String,
}

impl ExtensionManager {
    pub fn new<T>(path: T) -> Self
    where
        T: Into<String>,
    {
        ExtensionManager { path: path.into() }
    }
}

#[async_trait::async_trait()]
impl TExtensionManager<ExtensionContainer> for ExtensionManager {
    async fn get_extensions(&self) -> Result<Vec<ExtensionContainer>> {
        let mut dir = read_dir(&self.path).await?;
        let mut ret = Vec::new();
        while let Some(file) = dir.next_entry().await? {
            if !file
                .file_name()
                .into_string()
                .or(Err(Error::ExtensionError(
                    "Filename conversion failed".to_string(),
                )))?
                .ends_with(".dion.js")
            {
                continue;
            }
            println!("Got Extension {}", file.file_name().to_str().unwrap());
            ret.push(ExtensionContainer::create(file.path()).await?);
        }
        Ok(ret)
    }
}

/// flutter_rust_bridge:opaque
pub struct JSExtension {
    pub data: ExtensionData,
    pub permission: PermissionStore,
    pub setting: SettingStore,
}
