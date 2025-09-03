use std::{collections::HashMap, fmt::Display};

use crate::client_data::ClientExtensionData;
use anyhow::{anyhow, bail, Result};
use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum SettingValue {
    String { data: String },
    Number { data: f32 },
    Boolean { data: bool },
    StringList { data: Vec<String> },
}

impl SettingValue {
    /// flutter_rust_bridge:ignore
    pub fn overwrite(&mut self, setting: &SettingValue) -> Result<()> {
        match (self, setting) {
            (
                SettingValue::String { data: overwritten },
                SettingValue::String { data: overwrite },
            ) => {
                *overwritten = overwrite.clone();
                Ok(())
            }
            (
                SettingValue::Number { data: overwritten },
                SettingValue::Number { data: overwrite },
            ) => {
                *overwritten = *overwrite;
                Ok(())
            }
            (
                SettingValue::Boolean { data: overwritten },
                SettingValue::Boolean { data: overwrite },
            ) => {
                *overwritten = *overwrite;
                Ok(())
            }
            (val, other) => Err(anyhow!(
                "Wrong Settingtype {} and {}",
                val.get_type_name(),
                other.get_type_name()
            )),
        }
    }
    /// flutter_rust_bridge:ignore
    pub fn get_type_name(&self) -> &str {
        match self {
            SettingValue::String { .. } => "String",
            SettingValue::Number { .. } => "Number",
            SettingValue::Boolean { .. } => "Boolean",
            SettingValue::StringList { .. } => "StringList",
        }
    }
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct DropdownOption {
    pub label: String,
    pub value: String,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum SettingsUI {
    CheckBox,
    Slider { min: f64, max: f64, step: i32 },
    Dropdown { options: Vec<DropdownOption> },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Setting {
    pub label: String,
    pub value: SettingValue,
    pub default: SettingValue,
    pub visible: bool,
    #[cfg_attr(feature = "type", specta(optional))]
    pub ui: Option<SettingsUI>,
}

/// flutter_rust_bridge:ignore
#[derive(Debug)]
pub struct SettingStore {
    extension_setting: HashMap<String, Setting>,
    search_setting: HashMap<String, Setting>,
}

impl SettingStore {
    pub async fn new(client: &dyn ClientExtensionData) -> Self {
        let mut ret = SettingStore {
            extension_setting: Default::default(),
            search_setting: Default::default(),
        };
        let _ = ret.load_state(client).await;
        ret
    }

    async fn load_state(&mut self, client: &dyn ClientExtensionData) -> Result<()> {
        self.extension_setting =
            serde_json::from_str(&client.load_data("extension_settings").await?)?;
        self.search_setting = serde_json::from_str(&client.load_data("search_settings").await?)?;
        Ok(())
    }

    pub async fn save_state(&self, client: &dyn ClientExtensionData) -> Result<()> {
        client
            .store_data(
                "extension_settings",
                serde_json::to_string(&self.extension_setting)?,
            )
            .await?;
        client
            .store_data(
                "search_settings",
                serde_json::to_string(&self.search_setting)?,
            )
            .await?;
        Ok(())
    }

    pub fn get_settings(&self, kind: &SettingKind) -> &HashMap<String, Setting> {
        match kind {
            SettingKind::Extension => &self.extension_setting,
            SettingKind::Search => &self.search_setting,
        }
    }

    fn get_settings_mut(&mut self, kind: &SettingKind) -> &mut HashMap<String, Setting> {
        match kind {
            SettingKind::Extension => &mut self.extension_setting,
            SettingKind::Search => &mut self.search_setting,
        }
    }

    pub fn remove_setting(&mut self, id: &str, kind: &SettingKind) -> Result<()> {
        let map = self.get_settings_mut(kind);
        map.remove(id)
            .ok_or(anyhow!("Couldnt find {} Setting: {}", kind, id))?;
        Ok(())
    }

    pub fn set_setting(&mut self, id: &str, kind: &SettingKind, value: SettingValue) -> Result<()> {
        let map = self.get_settings_mut(kind);
        map.get_mut(id)
            .ok_or(anyhow!("Couldnt find {} Setting: {}", kind, id))?
            .value = value;
        Ok(())
    }

    pub fn get_setting(&self, id: &str, kind: &SettingKind) -> Result<&Setting> {
        let map = self.get_settings(kind);
        map.get(id)
            .ok_or(anyhow!("Couldnt find {} Setting: {}", kind, id))
    }

    pub fn get_setting_ids(&self, kind: &SettingKind) -> Vec<String> {
        let map = self.get_settings(kind);
        map.keys().cloned().collect()
    }

    pub fn merge_setting_definition(
        &mut self,
        id: String,
        kind: &SettingKind,
        mut definition: Setting,
    ) -> Result<()> {
        if id.contains("/") {
            bail!("Failed merging setting with id {}: id cant include '/'", id);
        }
        let map = self.get_settings_mut(kind);
        if let Some(current) = map.get(&id) {
            let _ = definition.value.overwrite(&current.value);
        }
        map.insert(id, definition);
        Ok(())
    }
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum SettingKind {
    Extension,
    Search,
}

impl Display for SettingKind {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            SettingKind::Extension => f.write_str("Extension"),
            SettingKind::Search => f.write_str("Search"),
        }
    }
}
