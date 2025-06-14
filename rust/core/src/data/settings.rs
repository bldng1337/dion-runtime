use anyhow::{anyhow, Context, Result};
use serde::{Deserialize, Serialize};
use std::{collections::HashMap, path::PathBuf};
use tokio::fs;
use ts_rs::TS;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "type")]
pub enum Settingvalue {
    String { val: String, default_val: String },
    Number { val: f64, default_val: f64 },
    Boolean { val: bool, default_val: bool },
}

impl Settingvalue {
    /// flutter_rust_bridge:ignore
    pub fn get_bool(&self) -> Result<bool> {
        match self {
            Self::Boolean {
                val,
                default_val: _,
            } => Ok(val.clone()),
            val => Err(anyhow!(
                "Setting {} is not an Boolean ",
                val.get_type_name()
            )),
        }
    }
    /// flutter_rust_bridge:ignore
    pub fn get_string(&self) -> Result<String> {
        match self {
            Self::String {
                val,
                default_val: _,
            } => Ok(val.clone()),
            val => Err(anyhow!("Setting {} is not an String ", val.get_type_name())),
        }
    }
    /// flutter_rust_bridge:ignore
    pub fn get_number(&self) -> Result<f64> {
        match self {
            Self::Number {
                val,
                default_val: _,
            } => Ok(val.clone()),
            val => Err(anyhow!("Setting {} not an Number ", val.get_type_name())),
        }
    }

    pub fn overwrite(&mut self, setting: &Settingvalue) -> Result<()> {
        match (self, setting) {
            (
                Settingvalue::String {
                    val: overwritten,
                    default_val: _,
                },
                Settingvalue::String {
                    val: overwrite,
                    default_val: _,
                },
            ) => {
                *overwritten = overwrite.clone();
                Ok(())
            }
            (
                Settingvalue::Number {
                    val: overwritten,
                    default_val: _,
                },
                Settingvalue::Number {
                    val: overwrite,
                    default_val: _,
                },
            ) => {
                *overwritten = overwrite.clone();
                Ok(())
            }
            (
                Settingvalue::Boolean {
                    val: overwritten,
                    default_val: _,
                },
                Settingvalue::Boolean {
                    val: overwrite,
                    default_val: _,
                },
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

    pub fn get_type_name(&self) -> &str {
        match self {
            Settingvalue::String { .. } => "String",
            Settingvalue::Number { .. } => "Number",
            Settingvalue::Boolean { .. } => "Boolean",
        }
    }
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "type")]
pub enum SettingUI {
    //String
    PathSelection {
        label: String,
        pickfolder: bool,
    },
    Slider {
        label: String,
        min: f64,
        max: f64,
        step: f64,
    },
    //Bool
    Checkbox {
        label: String,
    },
    //String
    Textbox {
        label: String,
    },
    Dropdown {
        label: String,
        options: Vec<DropdownItem>,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct DropdownItem {
    pub label: String,
    pub value: String,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub enum Settingtype {
    Extension,
    Search,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct Setting {
    pub val: Settingvalue,
    pub ui: Option<SettingUI>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct ExtensionSetting {
    pub setting: Setting,
    pub settingtype: Settingtype,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug)]
pub struct SettingStore {
    savepath: PathBuf,
    settings: HashMap<String, ExtensionSetting>,
}

impl SettingStore {
    pub async fn new(savepath: PathBuf) -> Result<Self> {
        let mut store = SettingStore {
            savepath: savepath,
            settings: Default::default(),
        };
        //TODO: Log error and delete save file
        store
            .load()
            .await
            .context("Failed to load saved settings")?;
        Ok(store)
    }

    pub(crate) fn add_setting(&mut self, name: String, mut setting: ExtensionSetting) {
        if let Some(oldsetting) = self.settings.remove(&name) {
            let _ = setting.setting.val.overwrite(&oldsetting.setting.val);
        }
        self.settings.insert(name, setting);
    }

    pub fn get_settings_ids(
        &self,
    ) -> std::collections::hash_map::Keys<'_, std::string::String, ExtensionSetting> {
        self.settings.keys()
    }

    pub async fn save(&self) -> Result<()> {
        fs::write(
            &self.savepath,
            serde_json::to_string(&self.settings).context("Failed to serialize Settings")?,
        )
        .await
        .context("Failed to write Settings to file")?;
        Ok(())
    }

    pub async fn load(&mut self) -> Result<()> {
        if !fs::try_exists(&self.savepath)
            .await
            .context("Failed to check if settings save exists")?
        {
            return Ok(());
        }
        let str = String::from_utf8(
            fs::read(&self.savepath)
                .await
                .context("Failed to read settings file")?,
        )
        .context("Failed to decode saved settings from file")?;
        self.settings = serde_json::from_str(&str).context("Failed to decode settings")?;
        Ok(())
    }

    // pub fn iter(&self) -> std::collections::hash_map::Iter<'_, std::string::String, Setting> {
    //     self.settings.iter()
    // }

    pub fn get_setting_mut(&mut self, name: &String) -> Result<&mut ExtensionSetting> {
        match self.settings.get_mut(name) {
            Some(setting) => Ok(setting),
            None => Err(anyhow!("Couldnt find id {} in settings ", name)),
        }
    }

    pub fn get_setting(&self, name: &String) -> Result<&ExtensionSetting> {
        match self.settings.get(name) {
            Some(setting) => Ok(setting),
            None => Err(anyhow!("Couldnt find id {} in settings ", name)),
        }
    }
}
