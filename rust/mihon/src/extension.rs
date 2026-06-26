//! MihonExtension - Implements the Extension trait for a single Mihon source

use anyhow::Result;
use async_trait::async_trait;
use dion_runtime::{
    client_data::ExtensionClient,
    data::{
        action::{EventData, EventResult},
        activity::EntryActivity,
        auth::Account,
        extension::ExtensionData,
        settings::{DropdownOption, Setting, SettingKind, SettingValue, SettingsUI},
        source::{
            EntryDetailed, EntryDetailedResult, EntryId, EntryList, EpisodeId, MediaType, Source,
            SourceResult,
        },
    },
    extension::Extension,
    store::ExtensionStore,
};
use std::collections::HashMap;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;
use tokio::sync::RwLock;
use tokio_util::sync::CancellationToken;

use crate::jni::MihonBridge;
use crate::mapping::dto::*;

/// Source type (Manga or Anime)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MihonSourceType {
    Manga,
    Anime,
}

impl MihonSourceType {
    pub fn parse(s: &str) -> Self {
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
            permission: dion_runtime::store::permission::PermissionStore::new(client.as_ref())
                .await,
            auth: dion_runtime::store::auth::AuthStore::new(client.as_ref()).await,
        };

        Ok(Self {
            source_id,
            source_type: MihonSourceType::parse(source_type),
            enabled: AtomicBool::new(true),
            store: RwLock::new(store),
            client,
            bridge,
        })
    }

    /// Push the source's configurable preferences to the JVM.
    ///
    /// The values applied are the union of the stored `Extension` settings and
    /// any overrides present in `overrides` (matching by setting id). The
    /// setting id is the SharedPreferences key the source reads. Only settings
    /// whose values map onto a preference value are forwarded; failures to push
    /// are logged and swallowed so a preference problem can't abort a content
    /// operation.
    async fn apply_preferences(&self, overrides: &HashMap<String, Setting>) {
        // Build the JSON payload while holding the store read lock, then drop
        // the lock before the (blocking) JNI call so we don't hold it across a
        // potentially slow bridge round-trip.
        let json = {
            let store = self.store.read().await;
            let stored = store.settings.get_settings(&SettingKind::Extension);

            // Start from the stored preferences, then overlay caller overrides.
            let mut merged: HashMap<String, Setting> = stored.clone();
            for (k, v) in overrides {
                merged.insert(k.clone(), v.clone());
            }

            let prefs: Vec<PreferenceDto> = merged
                .into_iter()
                .filter_map(|(key, setting)| {
                    setting_value_to_pref(&setting.value).map(|value| PreferenceDto {
                        key,
                        title: String::new(),
                        kind: String::new(),
                        value: value.clone(),
                        default: value,
                        options: None,
                        visible: true,
                    })
                })
                .collect();

            if prefs.is_empty() {
                // Nothing to apply — skip the JNI call entirely.
                return;
            }
            serde_json::to_string(&prefs).ok()
        };

        match json {
            Some(json) => {
                if let Err(e) = self.bridge.apply_preferences(self.source_id, &json) {
                    log::warn!("Failed to apply preferences: {e:#}");
                }
            }
            None => log::warn!("Failed to serialize preferences"),
        }
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
        // Re-fetch the source's filter list and configurable preferences,
        // merging them as setting definitions into the store. The host UI
        // reads these definitions back via `get_settings()` and writes user
        // values via `set_setting()`; `search()` then forwards the stored
        // search values to the bridge, and preferences are pushed back to the
        // JVM before content operations.
        let filters = self
            .bridge
            .get_filter_list(self.source_id)
            .unwrap_or_default();
        let preferences = self
            .bridge
            .get_preference_list(self.source_id)
            .unwrap_or_default();

        {
            let mut store = self.store.write().await;
            for filter in filters {
                if let Some((id, setting)) = filter_to_setting(&filter) {
                    store
                        .settings
                        .merge_setting_definition(id, &SettingKind::Search, setting)?;
                }
            }
            for pref in preferences {
                if let Some((id, setting)) = preference_to_setting(&pref) {
                    store.settings.merge_setting_definition(
                        id,
                        &SettingKind::Extension,
                        setting,
                    )?;
                }
            }
        }

        // Persist the refreshed definitions and any previously stored values.
        {
            let store = self.store.read().await;
            store.settings.save_state(self.client.as_ref()).await?;
        }

        Ok(())
    }

    // ========== Content Discovery ==========

    async fn browse(&self, page: i32, _token: Option<CancellationToken>) -> Result<EntryList> {
        // Mihon/Tachiyomi uses 1-indexed pages, but the runtime uses 0-indexed
        let mihon_page = page + 1;
        let result = match self.source_type {
            MihonSourceType::Manga => self.bridge.get_popular(self.source_id, mihon_page)?,
            MihonSourceType::Anime => self.bridge.get_popular_anime(self.source_id, mihon_page)?,
        };

        Ok(result.into_entry_list(self.source_type))
    }

    async fn search(
        &self,
        page: i32,
        filter: String,
        _token: Option<CancellationToken>,
    ) -> Result<EntryList> {
        // Parse the caller-supplied filter string. It may be a plain query,
        // a `{"query":..,"filters":[..]}` object, or a bare `[FilterDto..]` array.
        let (query, filters_json) = parse_filter_string(&filter);

        // If no filters were supplied explicitly, fall back to the user's stored
        // Search settings so saved filter choices still apply to plain-text and
        // bare-query searches.
        let filters_json = if filters_json.is_empty() {
            let store = self.store.read().await;
            settings_to_filter_json(store.settings.get_settings(&SettingKind::Search))
        } else {
            filters_json
        };

        // Mihon/Tachiyomi uses 1-indexed pages, but the runtime uses 0-indexed
        let mihon_page = page + 1;
        let result = match self.source_type {
            MihonSourceType::Manga => {
                self.bridge
                    .search(self.source_id, mihon_page, &query, &filters_json)?
            }
            MihonSourceType::Anime => {
                self.bridge
                    .search_anime(self.source_id, mihon_page, &query, &filters_json)?
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
        // Push the source's configurable preferences (union of the stored
        // Extension settings and any overrides the caller supplied) to the JVM
        // before fetching details, so the source observes the current values.
        self.apply_preferences(&settings).await;

        let entry_json = serde_json::to_string(&MangaDto::from_entry_id(&entryid))?;

        match self.source_type {
            MihonSourceType::Manga => {
                let details = self.bridge.get_details(self.source_id, &entry_json)?;
                let mut chapters = self.bridge.get_chapter_list(self.source_id, &entry_json)?;
                chapters.reverse();
                let detailed = details.into_entry_detailed(chapters, MediaType::Comic);
                Ok(EntryDetailedResult {
                    entry: detailed,
                    settings,
                })
            }
            MihonSourceType::Anime => {
                let details = self.bridge.get_anime_details(self.source_id, &entry_json)?;
                let mut episodes = self.bridge.get_episode_list(self.source_id, &entry_json)?;
                episodes.reverse();

                // Anime episodes share the same JSON shape as manga chapters
                // (url/name/dateUpload/scanlator), so we reuse ChapterDto's
                // conversion into dion Episodes by transmuting the fields.
                let chapters: Vec<ChapterDto> = episodes
                    .into_iter()
                    .map(|e| ChapterDto {
                        url: e.url,
                        name: e.name,
                        date_upload: e.date_upload,
                        chapter_number: e.episode_number,
                        scanlator: e.scanlator,
                    })
                    .collect();

                let detailed = details.into_entry_detailed(chapters, MediaType::Video);
                Ok(EntryDetailedResult {
                    entry: detailed,
                    settings,
                })
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
        // Ensure the source observes the current preferences before resolving
        // the episode's content.
        self.apply_preferences(&settings).await;

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
                let episode_json = serde_json::to_string(&EpisodeDto::from_episode_id(&epid))?;
                let videos = self.bridge.get_video_list(self.source_id, &episode_json)?;
                Ok(SourceResult {
                    source: videos_to_source(videos),
                    settings,
                })
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
            let query = obj
                .get("query")
                .and_then(|v| v.as_str())
                .unwrap_or("")
                .to_string();
            let filters = obj
                .get("filters")
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

// ============================================================================
// Settings <-> bridge DTO conversions
//
// These map the bridge's neutral `FilterDto`/`PreferenceDto` onto dion's
// `Setting`/`SettingValue`/`SettingsUI`, and back. Filters become
// `SettingKind::Search` settings (id = filter name, matching the bridge's
// name-based filter matching); preferences become `SettingKind::Extension`
// settings (id = SharedPreferences key).
// ============================================================================

/// Convert a search filter into a `SettingKind::Search` setting definition.
///
/// `Header` and `Separator` filters carry no user-editable state and are
/// dropped (returns `None`).
fn filter_to_setting(filter: &FilterDto) -> Option<(String, Setting)> {
    let id = filter.name.clone();
    let label = filter.name.clone();
    let state = filter.state.clone();

    let (value, ui) = match filter.filter_type.as_str() {
        // Non-editable presentation filters.
        "Header" | "Separator" => return None,

        // Free-text filter → string value, no constrained UI.
        "Text" => (
            SettingValue::String {
                data: state.clone(),
            },
            None,
        ),

        // Boolean filter → checkbox.
        "CheckBox" => {
            let b = state.eq_ignore_ascii_case("true");
            (
                SettingValue::Boolean { data: b },
                Some(SettingsUI::CheckBox),
            )
        }

        // TriState (0=ignore, 1=include, 2=exclude) → dropdown.
        "TriState" => {
            let options = vec![
                DropdownOption {
                    label: "Ignore".to_string(),
                    value: "0".to_string(),
                },
                DropdownOption {
                    label: "Include".to_string(),
                    value: "1".to_string(),
                },
                DropdownOption {
                    label: "Exclude".to_string(),
                    value: "2".to_string(),
                },
            ];
            let cur = if state.is_empty() {
                "0".to_string()
            } else {
                state
            };
            (
                SettingValue::String { data: cur },
                Some(SettingsUI::Dropdown { options }),
            )
        }

        // Select filter → dropdown of its values.
        "Select" => {
            let options = filter
                .values
                .as_ref()
                .map(|vals| {
                    vals.iter()
                        .enumerate()
                        .map(|(i, v)| DropdownOption {
                            label: v.clone(),
                            value: i.to_string(),
                        })
                        .collect()
                })
                .unwrap_or_default();
            let cur = if state.is_empty() {
                "0".to_string()
            } else {
                state
            };
            (
                SettingValue::String { data: cur },
                Some(SettingsUI::Dropdown { options }),
            )
        }

        // Sort filter → dropdown of "field (asc)" / "field (desc)". The option
        // value encodes the bridge's "index;ascending" state, so the round-trip
        // through `settings_to_filter_json` reproduces it exactly.
        "Sort" => {
            let fields = filter.values.clone().unwrap_or_default();
            let mut options = Vec::with_capacity(fields.len() * 2);
            for (i, field) in fields.iter().enumerate() {
                options.push(DropdownOption {
                    label: format!("{} (asc)", field),
                    value: format!("{};true", i),
                });
                options.push(DropdownOption {
                    label: format!("{} (desc)", field),
                    value: format!("{};false", i),
                });
            }
            // Default to the first ascending option if the source provided no
            // initial selection.
            let cur = if state.is_empty() {
                options.first().map(|o| o.value.clone()).unwrap_or_default()
            } else {
                state
            };
            (
                SettingValue::String { data: cur },
                Some(SettingsUI::Dropdown { options }),
            )
        }

        // Unknown filter types (e.g. Group) → expose as a plain text field so
        // the state is still visible/editable rather than silently dropped.
        _ => (
            SettingValue::String {
                data: state.clone(),
            },
            None,
        ),
    };

    let default = value.clone();
    Some((
        id,
        Setting {
            label,
            value,
            default,
            visible: true,
            ui,
        },
    ))
}

/// Convert a configurable preference into a `SettingKind::Extension` setting
/// definition. The setting id is the SharedPreferences key the source reads.
fn preference_to_setting(pref: &PreferenceDto) -> Option<(String, Setting)> {
    let id = pref.key.clone();
    let value = pref_value_to_setting(&pref.value)?;
    let default = pref_value_to_setting(&pref.default).unwrap_or_else(|| value.clone());

    let ui = match pref.kind.as_str() {
        "switch" => Some(SettingsUI::CheckBox),
        "list" => pref.options.as_ref().map(|opts| SettingsUI::Dropdown {
            options: opts
                .iter()
                .map(|o| DropdownOption {
                    label: o.label.clone(),
                    value: o.value.clone(),
                })
                .collect(),
        }),
        "multiselect" => pref.options.as_ref().map(|opts| SettingsUI::MultiDropdown {
            options: opts
                .iter()
                .map(|o| DropdownOption {
                    label: o.label.clone(),
                    value: o.value.clone(),
                })
                .collect(),
        }),
        // "text" and anything else → no constrained UI.
        _ => None,
    };

    Some((
        id,
        Setting {
            label: if pref.title.is_empty() {
                pref.key.clone()
            } else {
                pref.title.clone()
            },
            value,
            default,
            visible: pref.visible,
            ui,
        },
    ))
}

/// Map a bridge preference value onto a dion setting value.
fn pref_value_to_setting(value: &PrefValue) -> Option<SettingValue> {
    Some(match value {
        PrefValue::String { data } => SettingValue::String { data: data.clone() },
        PrefValue::Number { data } => SettingValue::Number { data: *data },
        PrefValue::Boolean { data } => SettingValue::Boolean { data: *data },
        PrefValue::StringList { data } => SettingValue::StringList { data: data.clone() },
    })
}

/// Map a dion setting value onto a bridge preference value for `applyPreferences`.
fn setting_value_to_pref(value: &SettingValue) -> Option<PrefValue> {
    Some(match value {
        SettingValue::String { data } => PrefValue::String { data: data.clone() },
        SettingValue::Number { data } => PrefValue::Number { data: *data },
        SettingValue::Boolean { data } => PrefValue::Boolean { data: *data },
        SettingValue::StringList { data } => PrefValue::StringList { data: data.clone() },
    })
}

/// Serialize the stored search settings back into the `FilterDto` JSON array
/// the bridge's `search`/`searchAnime` expect. Each setting's value is
/// flattened to the string state the bridge parses (booleans/numbers/indices
/// as strings; string lists joined where applicable).
fn settings_to_filter_json(settings: &HashMap<String, Setting>) -> String {
    let dtos: Vec<FilterDto> = settings
        .iter()
        .map(|(id, setting)| FilterDto {
            filter_type: filter_ui_to_type(&setting.ui),
            name: id.clone(),
            state: setting_value_to_filter_state(&setting.value),
            values: filter_ui_to_values(&setting.ui),
        })
        .collect();

    serde_json::to_string(&dtos).unwrap_or_default()
}

/// Recover the filter type tag from a setting's UI. The bridge's
/// `applyFilterStates` matches filters by *name* and dispatches on the live
/// filter's runtime type, so this value is not actually consumed when
/// applying — it is kept only for round-trip fidelity/debuggability.
fn filter_ui_to_type(ui: &Option<SettingsUI>) -> String {
    match ui {
        Some(SettingsUI::CheckBox) => "CheckBox",
        Some(SettingsUI::Dropdown { .. }) => "Select",
        _ => "Text",
    }
    .to_string()
}

/// Extract the option list (as strings) from a dropdown-style setting UI, for
/// repopulating `FilterDto.values`. Only relevant for Select/Sort round-trips.
fn filter_ui_to_values(ui: &Option<SettingsUI>) -> Option<Vec<String>> {
    match ui {
        Some(SettingsUI::Dropdown { options }) => {
            Some(options.iter().map(|o| o.label.clone()).collect())
        }
        _ => None,
    }
}

/// Flatten a setting value into the string state the bridge's filter parser
/// expects (`"true"`/`"false"` for booleans, the raw string for text/select,
/// index-as-string, etc.).
fn setting_value_to_filter_state(value: &SettingValue) -> String {
    match value {
        SettingValue::String { data } => data.clone(),
        SettingValue::Number { data } => data.to_string(),
        SettingValue::Boolean { data } => data.to_string(),
        SettingValue::StringList { data } => data.first().cloned().unwrap_or_default(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn dto(filter_type: &str, name: &str, state: &str) -> FilterDto {
        FilterDto {
            filter_type: filter_type.to_string(),
            name: name.to_string(),
            state: state.to_string(),
            values: None,
        }
    }

    /// Assert a setting value is the expected string.
    macro_rules! assert_str_value {
        ($v:expr, $expected:expr) => {
            match &$v {
                SettingValue::String { data } => assert_eq!(data, $expected),
                other => panic!("expected String value, got {:?}", other),
            }
        };
    }

    /// Assert a setting value is the expected boolean.
    macro_rules! assert_bool_value {
        ($v:expr, $expected:expr) => {
            match &$v {
                SettingValue::Boolean { data } => assert_eq!(*data, $expected),
                other => panic!("expected Boolean value, got {:?}", other),
            }
        };
    }

    #[test]
    fn header_and_separator_filters_are_dropped() {
        assert!(filter_to_setting(&dto("Header", "Note", "")).is_none());
        assert!(filter_to_setting(&dto("Separator", "---", "")).is_none());
    }

    #[test]
    fn text_filter_maps_to_string_setting_without_ui() {
        let (id, setting) = filter_to_setting(&dto("Text", "Author", "glen")).unwrap();
        assert_eq!(id, "Author");
        assert_eq!(setting.label, "Author");
        assert!(setting.ui.is_none());
        assert_str_value!(setting.value, "glen");
        assert_str_value!(setting.default, "glen");
    }

    #[test]
    fn checkbox_filter_maps_to_boolean_with_checkbox_ui() {
        let (_, setting) = filter_to_setting(&dto("CheckBox", "Completed", "true")).unwrap();
        assert_bool_value!(setting.value, true);
        assert!(matches!(setting.ui, Some(SettingsUI::CheckBox)));

        let (_, setting) = filter_to_setting(&dto("CheckBox", "Completed", "false")).unwrap();
        assert_bool_value!(setting.value, false);
    }

    #[test]
    fn tristate_filter_maps_to_dropdown_with_three_options() {
        let (_, setting) = filter_to_setting(&dto("TriState", "Genre", "1")).unwrap();
        match setting.ui {
            Some(SettingsUI::Dropdown { options }) => {
                assert_eq!(options.len(), 3);
                assert_eq!(options[1].value, "1");
            }
            other => panic!("expected Dropdown, got {:?}", other),
        }
        assert_str_value!(setting.value, "1");
    }

    #[test]
    fn select_filter_maps_to_dropdown_with_values_as_options() {
        let mut f = dto("Select", "Status", "0");
        f.values = Some(vec!["Ongoing".into(), "Completed".into()]);
        let (_, setting) = filter_to_setting(&f).unwrap();
        match setting.ui {
            Some(SettingsUI::Dropdown { options }) => {
                assert_eq!(options.len(), 2);
                assert_eq!(options[0].label, "Ongoing");
                assert_eq!(options[0].value, "0");
                assert_eq!(options[1].label, "Completed");
            }
            other => panic!("expected Dropdown, got {:?}", other),
        }
    }

    #[test]
    fn sort_filter_emits_asc_desc_option_pairs() {
        let mut f = dto("Sort", "Sort", "");
        f.values = Some(vec!["Name".into(), "Date".into()]);
        let (_, setting) = filter_to_setting(&f).unwrap();
        match setting.ui {
            Some(SettingsUI::Dropdown { options }) => {
                // Two fields x (asc, desc) = four options.
                assert_eq!(options.len(), 4);
                assert_eq!(options[0].label, "Name (asc)");
                assert_eq!(options[0].value, "0;true");
                assert_eq!(options[3].value, "1;false");
            }
            other => panic!("expected Dropdown, got {:?}", other),
        }
    }

    #[test]
    fn search_settings_round_trip_into_filter_json_by_name_and_state() {
        // The bridge's applyFilterStates matches by name and parses `state`,
        // so a round-trip must preserve both. Build a couple of settings and
        // confirm the produced JSON decodes back to the expected DTOs.
        let (_, text) = filter_to_setting(&dto("Text", "Author", "glen")).unwrap();
        let (_, cb) = filter_to_setting(&dto("CheckBox", "Done", "true")).unwrap();
        let mut settings = HashMap::new();
        settings.insert("Author".into(), text);
        settings.insert("Done".into(), cb);

        let json = settings_to_filter_json(&settings);
        let dtos: Vec<FilterDto> = serde_json::from_str(&json).unwrap();
        let by_name: HashMap<String, FilterDto> =
            dtos.into_iter().map(|d| (d.name.clone(), d)).collect();

        assert_eq!(by_name.get("Author").unwrap().state, "glen");
        assert_eq!(by_name.get("Done").unwrap().state, "true");
    }

    fn pref(key: &str, title: &str, kind: &str, value: PrefValue) -> PreferenceDto {
        PreferenceDto {
            key: key.into(),
            title: title.into(),
            kind: kind.into(),
            value: value.clone(),
            default: value,
            options: None,
            visible: true,
        }
    }

    #[test]
    fn switch_preference_maps_to_boolean_checkbox_setting() {
        let p = pref(
            "show_locked",
            "Show locked",
            "switch",
            PrefValue::Boolean { data: true },
        );
        let (id, setting) = preference_to_setting(&p).unwrap();
        assert_eq!(id, "show_locked");
        assert_eq!(setting.label, "Show locked");
        assert_bool_value!(setting.value, true);
        assert!(matches!(setting.ui, Some(SettingsUI::CheckBox)));
    }

    #[test]
    fn list_preference_maps_to_dropdown() {
        let mut p = pref(
            "quality",
            "Quality",
            "list",
            PrefValue::String {
                data: "1080".into(),
            },
        );
        p.options = Some(vec![
            PrefOption {
                label: "720p".into(),
                value: "720".into(),
            },
            PrefOption {
                label: "1080p".into(),
                value: "1080".into(),
            },
        ]);
        let (_, setting) = preference_to_setting(&p).unwrap();
        match setting.ui {
            Some(SettingsUI::Dropdown { options }) => {
                assert_eq!(options.len(), 2);
                assert_eq!(options[1].label, "1080p");
                assert_eq!(options[1].value, "1080");
            }
            other => panic!("expected Dropdown, got {:?}", other),
        }
        assert_str_value!(setting.value, "1080");
    }

    #[test]
    fn multiselect_preference_maps_to_multi_dropdown() {
        let mut p = pref(
            "genres",
            "Genres",
            "multiselect",
            PrefValue::StringList {
                data: vec!["a".into()],
            },
        );
        p.options = Some(vec![
            PrefOption {
                label: "A".into(),
                value: "a".into(),
            },
            PrefOption {
                label: "B".into(),
                value: "b".into(),
            },
        ]);
        let (_, setting) = preference_to_setting(&p).unwrap();
        assert!(matches!(setting.ui, Some(SettingsUI::MultiDropdown { .. })));
        match &setting.value {
            SettingValue::StringList { data } => assert_eq!(data, &vec!["a".to_string()]),
            other => panic!("expected StringList value, got {:?}", other),
        }
    }

    #[test]
    fn setting_value_round_trips_through_pref_value() {
        let check = |v: SettingValue| {
            let pv = setting_value_to_pref(&v).unwrap();
            let back = pref_value_to_setting(&pv).unwrap();
            // Re-serialize both and compare structurally via JSON, since
            // SettingValue doesn't derive PartialEq in the core crate.
            let a = serde_json::to_string(&v).unwrap();
            let b = serde_json::to_string(&back).unwrap();
            assert_eq!(a, b);
        };

        check(SettingValue::String { data: "hi".into() });
        check(SettingValue::Number { data: 3.5 });
        check(SettingValue::Boolean { data: true });
        check(SettingValue::StringList {
            data: vec!["x".into(), "y".into()],
        });
    }
}
