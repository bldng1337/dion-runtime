pub mod auth;
pub mod permission;
pub mod settings;
use crate::{
    data::extension::ExtensionData,
    store::{permission::PermissionStore, settings::SettingStore},
};

#[derive(Debug)]
pub struct ExtensionStore {
    pub data: ExtensionData,
    pub settings: SettingStore,
    pub permission: PermissionStore,
    // pub auth: AuthStore,
}
