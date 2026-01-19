use std::fmt::Debug;

use anyhow::Result;

use crate::data::{
    action::Action, extension::ExtensionData, permission::Permission, settings::SettingValue,
    source::EntryId,
};

#[async_trait::async_trait]
pub trait AdapterClient: Send + Sync {
    async fn get_extension_client(
        &self,
        extension: ExtensionData,
    ) -> Result<Box<dyn ExtensionClient>>;

    async fn get_path(&self) -> Result<String>;
}

#[async_trait::async_trait]
pub trait ExtensionClient: Send + Sync + Debug {
    async fn load_data(&self, key: &str) -> Result<String>;
    async fn store_data(&self, key: &str, data: String) -> Result<()>;

    async fn load_data_secure(&self, key: &str) -> Result<String>;
    async fn store_data_secure(&self, key: &str, data: String) -> Result<()>;

    async fn do_action(&self, action: &Action) -> Result<()>;

    async fn set_entry_setting(
        &self,
        entry: EntryId,
        key: String,
        value: SettingValue,
    ) -> Result<()>;
    async fn request_permission(
        &self,
        permission: &Permission,
        msg: Option<String>,
    ) -> Result<bool>;

    async fn get_path(&self) -> Result<String>;
}
