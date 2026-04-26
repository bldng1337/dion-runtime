//! MihonExtension - Implements the Extension trait for a single Mihon source

use dion_runtime::{
    extension::Extension,
    client_data::ExtensionClient,
    data::{
        extension::ExtensionData,
        action::{EventData, EventResult},
        activity::EntryActivity,
        auth::Account,
        settings::Setting,
        source::{
            EntryDetailed, EntryDetailedResult, EntryId, EntryList, EpisodeId, Source, SourceResult,
        },
    },
    store::ExtensionStore,
};
use std::collections::HashMap;
use std::sync::Arc;
use std::sync::atomic::{AtomicBool, Ordering};
use tokio::sync::RwLock;
use tokio_util::sync::CancellationToken;
use anyhow::{Result, bail};
use async_trait::async_trait;

use crate::jni::MihonBridge;
use crate::mapping::dto::*;

/// Source type (Manga or Anime)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MihonSourceType {
    Manga,
    Anime,
}

impl MihonSourceType {
    pub fn from_str(s: &str) -> Self {
        match s {
            "anime" => Self::Anime,
            _ => Self::Manga,
        }
    }
}

/// A Mihon/Tachiyomi extension source
pub struct MihonExtension {
    /// JVM source instance ID
    source_id: i64,
    
    /// Source type (manga or anime)
    source_type: MihonSourceType,
    
    /// Whether extension is enabled
    enabled: AtomicBool,
    
    /// Extension state store
    store: RwLock<ExtensionStore>,
    
    /// Extension client (from host)
    client: Box<dyn ExtensionClient>,
    
    /// JNI bridge
    bridge: Arc<MihonBridge>,
}

impl MihonExtension {
    pub async fn new(
        source_id: i64,
        source_type: &str,
        data: ExtensionData,
        client: Box<dyn ExtensionClient>,
        bridge: Arc<MihonBridge>,
    ) -> Result<Self> {
        // Initialize store
        let store = ExtensionStore {
            data,
            settings: dion_runtime::store::settings::SettingStore::new(client.as_ref()).await,
            permission: dion_runtime::store::permission::PermissionStore::new(client.as_ref()).await,
            auth: dion_runtime::store::auth::AuthStore::new(client.as_ref()).await,
        };
        
        Ok(Self {
            source_id,
            source_type: MihonSourceType::from_str(source_type),
            enabled: AtomicBool::new(true),
            store: RwLock::new(store),
            client,
            bridge,
        })
    }
}

#[async_trait]
impl Extension for MihonExtension {
    fn is_enabled(&self) -> bool {
        self.enabled.load(Ordering::SeqCst)
    }
    
    fn get_data(&self) -> &RwLock<ExtensionStore> {
        &self.store
    }
    
    fn get_client(&self) -> &dyn ExtensionClient {
        self.client.as_ref()
    }
    
    async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        self.enabled.store(enabled, Ordering::SeqCst);
        Ok(())
    }
    
    async fn reload(&mut self) -> Result<()> {
        // Re-fetch filter list, etc.
        Ok(())
    }
    
    // ========== Content Discovery ==========
    
    async fn browse(&self, page: i32, _token: Option<CancellationToken>) -> Result<EntryList> {
        // Mihon/Tachiyomi uses 1-indexed pages, but the runtime uses 0-indexed
        let mihon_page = page + 1;
        let result = match self.source_type {
            MihonSourceType::Manga => self.bridge.get_popular(self.source_id, mihon_page)?,
            MihonSourceType::Anime => {
                bail!("Anime not yet implemented")
            }
        };
        
        Ok(result.into_entry_list(self.source_type))
    }
    
    async fn search(
        &self,
        page: i32,
        filter: String,
        _token: Option<CancellationToken>,
    ) -> Result<EntryList> {
        // Parse filter string - for now, treat entire filter as query
        let (query, filters_json) = parse_filter_string(&filter);
        
        // Mihon/Tachiyomi uses 1-indexed pages, but the runtime uses 0-indexed
        let mihon_page = page + 1;
        let result = match self.source_type {
            MihonSourceType::Manga => {
                self.bridge.search(self.source_id, mihon_page, &query, &filters_json)?
            }
            MihonSourceType::Anime => {
                bail!("Anime not yet implemented")
            }
        };
        
        Ok(result.into_entry_list(self.source_type))
    }
    
    async fn handle_url(&self, _url: String, _token: Option<CancellationToken>) -> Result<bool> {
        // TODO: Implement URL handling
        Ok(false)
    }
    
    // ========== Content Details ==========
    
    async fn detail(
        &self,
        entryid: EntryId,
        settings: HashMap<String, Setting>,
        _token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult> {
        let entry_json = serde_json::to_string(&MangaDto::from_entry_id(&entryid))?;
        
        match self.source_type {
            MihonSourceType::Manga => {
                let details = self.bridge.get_details(self.source_id, &entry_json)?;
                let chapters = self.bridge.get_chapter_list(self.source_id, &entry_json)?;
                
                let detailed = details.into_entry_detailed(chapters);
                Ok(EntryDetailedResult { entry: detailed, settings })
            }
            MihonSourceType::Anime => {
                bail!("Anime not yet implemented")
            }
        }
    }
    
    // ========== Source Resolution ==========
    
    async fn source(
        &self,
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        _token: Option<CancellationToken>,
    ) -> Result<SourceResult> {
        match self.source_type {
            MihonSourceType::Manga => {
                let chapter_json = serde_json::to_string(&ChapterDto::from_episode_id(&epid))?;
                let pages = self.bridge.get_page_list(self.source_id, &chapter_json)?;
                Ok(SourceResult { 
                    source: pages_to_source(pages),
                    settings,
                })
            }
            MihonSourceType::Anime => {
                bail!("Anime not yet implemented")
            }
        }
    }
    
    // ========== Processors ==========
    
    async fn map_entry(
        &self,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        _token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult> {
        Ok(EntryDetailedResult { entry, settings })
    }
    
    async fn map_source(
        &self,
        source: Source,
        _epid: EpisodeId,
        settings: HashMap<String, Setting>,
        _token: Option<CancellationToken>,
    ) -> Result<SourceResult> {
        Ok(SourceResult { source, settings })
    }
    
    // ========== Activity & Events ==========
    
    async fn validate(
        &self,
        _account: Account,
        _token: Option<CancellationToken>,
    ) -> Result<Option<Account>> {
        Ok(None)
    }
    
    async fn on_entry_activity(
        &self,
        _activity: EntryActivity,
        _entry: EntryDetailed,
        _settings: HashMap<String, Setting>,
        _token: Option<CancellationToken>,
    ) -> Result<()> {
        Ok(())
    }
    
    async fn event(
        &self,
        _event: EventData,
        _token: Option<CancellationToken>,
    ) -> Result<Option<EventResult>> {
        Ok(None)
    }
}

/// Parse filter string into query and filters JSON.
///
/// Supports two formats:
/// 1. Plain text → used directly as query, no filters
/// 2. JSON object → `{"query": "text", "filters": [...]}` or `{"query": "text"}`
/// 3. JSON array  → `[{"type":"Text","name":"...","state":"..."}]` → no query, filters passed through
fn parse_filter_string(filter: &str) -> (String, String) {
    if filter.starts_with('{') {
        // Structured JSON object with optional query + filters
        if let Ok(obj) = serde_json::from_str::<serde_json::Value>(filter) {
            let query = obj.get("query")
                .and_then(|v| v.as_str())
                .unwrap_or("")
                .to_string();
            let filters = obj.get("filters")
                .and_then(|v| serde_json::to_string(v).ok())
                .unwrap_or_default();
            return (query, filters);
        }
    } else if filter.starts_with('[') {
        // Bare JSON array of FilterDto — no query, filters as-is
        return (String::new(), filter.to_string());
    }

    // Plain text → query only
    (filter.to_string(), String::new())
}
