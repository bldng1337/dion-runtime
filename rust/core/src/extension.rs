use anyhow::Result;
use std::collections::HashMap;
use tokio::sync::RwLock;
use tokio_util::sync::CancellationToken;

use crate::{
    client_data::ClientExtensionData,
    datastructs::{
        EntryActivity, EntryDetailed, EntryDetailedResult, EntryList, ExtensionData, ExtensionRepo,
        RemoteExtension, Source, SourceResult,
    },
    permission::PermissionStore,
    settings::{Setting, SettingStore},
};

#[derive(Debug)]
pub struct ExtensionStore {
    pub data: ExtensionData,
    pub settings: SettingStore,
    pub permission: PermissionStore,
    // pub auth: AuthStore,
}

#[async_trait::async_trait()]
pub trait ExtensionManager: Send + Sync {
    async fn get_extensions(&self) -> Result<Vec<Box<dyn Extension>>>;

    async fn install(&self, location: &RemoteExtension) -> Result<Box<dyn Extension>>;
    async fn install_single(&self, url: &str) -> Result<Box<dyn Extension>>;
    async fn uninstall(&self, ext: Box<dyn Extension>) -> Result<()>;
    async fn get_repo(&self, url: &str) -> Result<ExtensionRepo>;
}

#[async_trait::async_trait()]
pub trait Extension: Send + Sync {
    fn is_enabled(&self) -> bool;
    fn get_data(&self) -> &RwLock<ExtensionStore>;
    fn get_client(&self) -> &dyn ClientExtensionData;
    async fn set_enabled(&mut self, enabled: bool) -> Result<()>;
    async fn reload(&mut self) -> Result<()>;

    // SourceProvider

    async fn browse(&self, page: i32, token: Option<CancellationToken>) -> Result<EntryList>;

    async fn search(
        &self,
        page: i32,
        filter: String,
        token: Option<CancellationToken>,
    ) -> Result<EntryList>;

    async fn fromurl(&self, url: String, token: Option<CancellationToken>) -> Result<bool>;

    async fn detail(
        &self,
        entryid: String,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult>;

    async fn source(
        &self,
        epid: String,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<SourceResult>;

    // Entry Extension
    async fn map_entry(
        &self,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult>;

    async fn on_entry_activity(
        &self,
        activity: EntryActivity,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<()>;

    // SourceProcessorExtension
    async fn map_source(
        &self,
        source: Source,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<SourceResult>;
}
