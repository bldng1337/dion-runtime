use std::collections::HashMap;
use std::sync::Arc;

use anyhow::Result;
use serde_json::Value;
use tokio::sync::RwLock;
use tokio_util::sync::CancellationToken;

use crate::data::datastructs::{Entry, EntryDetailed, ExtensionRepo, RemoteExtension, Source};
use crate::data::extension::ExtensionStore;
use crate::data::settings::Setting;

#[async_trait::async_trait()]
pub trait ExtensionManager {
    async fn get_extensions(&self) -> Result<Vec<ExtensionContainer>>;

    async fn install(&self, location: &RemoteExtension) -> Result<ExtensionContainer>;
    async fn install_local(&self, location: &str) -> Result<ExtensionContainer>;
    async fn uninstall(&self, ext: Box<dyn Extension>) -> Result<()>;
    async fn get_repo(&self, url: &str) -> Result<ExtensionRepo>;
}

pub enum ExtensionContainer {
    Entry(Box<dyn EntryExtension>),
    Source(Box<dyn SourceExtension>),
    SourceProcessor(Box<dyn SourceProcessorExtension>),
}

#[async_trait::async_trait()]
impl Extension for ExtensionContainer {
    fn is_enabled(&self) -> bool {
        match self {
            ExtensionContainer::Entry(ext) => ext.is_enabled(),
            ExtensionContainer::Source(ext) => ext.is_enabled(),
            ExtensionContainer::SourceProcessor(ext) => ext.is_enabled(),
        }
    }

    fn get_data(&self) -> &Arc<RwLock<ExtensionStore>> {
        match self {
            ExtensionContainer::Entry(ext) => ext.get_data(),
            ExtensionContainer::Source(ext) => ext.get_data(),
            ExtensionContainer::SourceProcessor(ext) => ext.get_data(),
        }
    }

    async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        match self {
            ExtensionContainer::Entry(ext) => ext.set_enabled(enabled).await,
            ExtensionContainer::Source(ext) => ext.set_enabled(enabled).await,
            ExtensionContainer::SourceProcessor(ext) => ext.set_enabled(enabled).await,
        }
    }

    async fn reload(&mut self) -> Result<()> {
        match self {
            ExtensionContainer::Entry(ext) => ext.reload().await,
            ExtensionContainer::Source(ext) => ext.reload().await,
            ExtensionContainer::SourceProcessor(ext) => ext.reload().await,
        }
    }
}

#[async_trait::async_trait()]
pub trait Extension: Send + Sync {
    fn is_enabled(&self) -> bool;
    fn get_data(&self) -> &Arc<RwLock<ExtensionStore>>;
    async fn set_enabled(&mut self, enabled: bool) -> Result<()>;
    async fn reload(&mut self) -> Result<()>;
}

#[async_trait::async_trait()]
pub trait EntryExtension: Extension {
    async fn refresh(
        &self,
        entry: EntryDetailed,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed>;

    async fn entry_event(
        &self,
        event: String,
        data: Value,
        entry: EntryDetailed,
        token: Option<CancellationToken>,
    ) -> Result<()>;
}

#[async_trait::async_trait()]
#[async_trait::async_trait()]
pub trait SourceProcessorExtension: Extension {
    async fn process(&self, source: Source, token: Option<CancellationToken>) -> Result<Source>;
}

#[async_trait::async_trait()]
pub trait SourceExtension: Extension {
    async fn browse(&self, page: i32, token: Option<CancellationToken>) -> Result<Vec<Entry>>;

    async fn search(
        &self,
        page: i32,
        filter: &str,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>>;

    async fn fromurl(&self, url: &str, token: Option<CancellationToken>) -> Result<Option<Entry>>;

    async fn detail(
        &self,
        entryid: &str,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed>;

    async fn source(
        &self,
        epid: &str,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<Source>;
}
