use anyhow::Result;
use std::collections::HashMap;
use tokio::sync::RwLock;
use tokio_util::sync::CancellationToken;

use crate::{
    client_data::ExtensionClient,
    data::{
        action::{EventData, EventResult},
        activity::EntryActivity,
        extension_repo::{ExtensionRepo, RemoteExtensionResult},
        settings::Setting,
        source::{
            EntryDetailed, EntryDetailedResult, EntryId, EntryList, EpisodeId, Source, SourceResult,
        },
    },
    store::ExtensionStore,
};

#[async_trait::async_trait()]
pub trait Adapter: Send + Sync {
    async fn get_extensions(&self) -> Result<Vec<Box<dyn Extension>>>;

    async fn install(&self, url: &str) -> Result<Box<dyn Extension>>;
    async fn uninstall(&self, ext: &Box<dyn Extension>) -> Result<()>;

    async fn get_repo(&self, url: &str) -> Result<ExtensionRepo>;
    async fn browse_repo(&self, repo: &ExtensionRepo, page: i32) -> Result<RemoteExtensionResult>;
}

#[async_trait::async_trait()]
pub trait Extension: Send + Sync {
    fn is_enabled(&self) -> bool;
    fn get_data(&self) -> &RwLock<ExtensionStore>;
    fn get_client(&self) -> &dyn ExtensionClient;
    async fn set_enabled(&mut self, enabled: bool) -> Result<()>;
    async fn reload(&mut self) -> Result<()>;

    async fn event(
        &self,
        event: EventResult,
        token: Option<CancellationToken>,
    ) -> Result<Option<EventData>>;

    async fn browse(&self, page: i32, token: Option<CancellationToken>) -> Result<EntryList>;

    async fn search(
        &self,
        page: i32,
        filter: String,
        token: Option<CancellationToken>,
    ) -> Result<EntryList>;

    async fn handle_url(&self, url: String, token: Option<CancellationToken>) -> Result<bool>;

    async fn detail(
        &self,
        entryid: EntryId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult>;

    async fn source(
        &self,
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<SourceResult>;

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

    async fn map_source(
        &self,
        source: Source,
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<SourceResult>;
}
