use super::{extension::TSourceExtensionManager, extension_container::ExtensionContainer};
use anyhow::{Context, Result};
use tokio::fs::read_dir;

#[derive(Clone)]
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
impl TSourceExtensionManager<ExtensionContainer> for ExtensionManager {
    async fn get_extensions(&self) -> Result<Vec<ExtensionContainer>> {
        let mut dir = read_dir(&self.path)
            .await
            .context("Failed to read directory")?;
        let mut ret = Vec::new();
        while let Some(file) = dir
            .next_entry()
            .await
            .context("Failed to get next Directory")?
        {
            if !file
                .file_name()
                .into_string()
                .map_or(false, |str| str.ends_with(".dion.js"))
            {
                continue;
            }
            ret.push(ExtensionContainer::create(file.path()).await?);
        }
        Ok(ret)
    }
}
