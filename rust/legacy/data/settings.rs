use anyhow::{anyhow, Context, Result};
use serde::{Deserialize, Serialize};
use specta::Type;
use std::{collections::HashMap, path::PathBuf};
use tokio::fs;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, Type)]
#[serde(tag = "type")]
pub enum Settingvalue {
    String { val: String, default_val: String },
    Number { val: f64, default_val: f64 },
    Boolean { val: bool, default_val: bool },
    StringList { val: Vec<String> },
}

impl Settingvalue {
    /// flutter_rust_bridge:ignore
    pub fn get_bool(&self) -> Result<bool> {
        match self {
            Self::Boolean {
                val,
                default_val: _,
            } => Ok(*val),
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
            } => Ok(*val),
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
                *overwritten = *overwrite;
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
            Settingvalue::StringList { .. } => "StringList",
        }
    }
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, Type)]
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
#[derive(Serialize, Deserialize, Debug, Clone, Type)]
pub struct DropdownItem {
    pub label: String,
    pub value: String,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, Type)]
pub struct Setting {
    pub val: Settingvalue,
    pub ui: Option<SettingUI>,
    #[serde(default)]
    pub visible: bool,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, Type)]
pub enum Settingtype {
    Extension,
    Search,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, Type)]
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
            savepath,
            settings: Default::default(),
        };
        //TODO: Log error and delete save file
        store
            .load()
            .await
            .context("Failed to load saved settings")?;
        Ok(store)
    }

    pub(crate) fn merge_setting(&mut self, name: String, mut setting: ExtensionSetting) {
        if let Some(oldsetting) = self.settings.remove(&name) {
            let _ = setting.setting.val.overwrite(&oldsetting.setting.val);
        }
        self.settings.insert(name, setting);
    }

    pub fn get_settings(&self) -> &HashMap<String, ExtensionSetting> {
        &self.settings
    }

    pub fn get_settings_mut(&mut self) -> &mut HashMap<String, ExtensionSetting> {
        &mut self.settings
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
}
