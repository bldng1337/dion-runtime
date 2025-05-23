use serde::{Deserialize, Serialize};
use std::{collections::HashMap, path::PathBuf};
use tokio::fs;
use ts_rs::TS;

use crate::error::{Error, Result};
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
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
            _ => Err(Error::ExtensionError("Setting not an int".to_string())),
        }
    }
    /// flutter_rust_bridge:ignore
    pub fn get_string(&self) -> Result<String> {
        match self {
            Self::String {
                val,
                default_val: _,
            } => Ok(val.clone()),
            _ => Err(Error::ExtensionError("Setting not an int".to_string())),
        }
    }
    /// flutter_rust_bridge:ignore
    pub fn get_number(&self) -> Result<f64> {
        match self {
            Self::Number {
                val,
                default_val: _,
            } => Ok(val.clone()),
            _ => Err(Error::ExtensionError("Setting not an int".to_string())),
        }
    }

    pub fn overwrite(&mut self, setting: Settingvalue) -> Result<()> {
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
                *overwritten = overwrite;
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
                *overwritten = overwrite;
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
                *overwritten = overwrite;
                Ok(())
            }
            _ => Err(Error::ExtensionError("Wrong Settingtype".to_string())),
        }
    }
}

/// flutter_rust_bridge:non_opaque
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
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct DropdownItem {
    label: String,
    value: String,
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub enum Settingtype {
    Extension,
    Entry,
    Search,
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Setting {
    pub val: Settingvalue,
    pub settingtype: Settingtype,
    pub ui: Option<SettingUI>,
}
#[derive(Serialize, Deserialize, Debug)]
pub struct SettingStore {
    savepath: PathBuf,
    settings: HashMap<String, Setting>,
}

impl SettingStore {
    pub async fn new(savepath: PathBuf) -> Result<Self> {
        let mut store = SettingStore {
            savepath: savepath,
            settings: Default::default(),
        };
        store.load().await?;
        Ok(store)
    }

    pub(crate) fn add_setting(&mut self, name: String, mut setting: Setting) {
        if self.settings.contains_key(&name) {
            //TODO: Handle this error more sensible
            let _ = setting
                .val
                .overwrite(self.settings.remove(&name).unwrap().val);
        }
        self.settings.insert(name, setting);
    }

    pub fn get_settings_ids(
        &self,
    ) -> std::collections::hash_map::Keys<'_, std::string::String, Setting> {
        self.settings.keys()
    }

    pub async fn save(&self) -> Result<()> {
        fs::write(&self.savepath, serde_json::to_string(&self.settings)?).await?;
        Ok(())
    }

    pub async fn load(&mut self) -> Result<()> {
        if !fs::try_exists(&self.savepath).await? {
            return Ok(())
        }
        let str = String::from_utf8(fs::read(&self.savepath).await?)?;
        self.settings = serde_json::from_str(&str)?;
        Ok(())
    }

    pub fn iter(&self) -> std::collections::hash_map::Iter<'_, std::string::String, Setting> {
        self.settings.iter()
    }

    pub fn get_setting_mut(&mut self, name: &String) -> Result<&mut Setting> {
        match self.settings.get_mut(name) {
            Some(setting) => Ok(setting),
            None => Err(Error::ExtensionError(format!(
                "Couldnt find id {} in settings ",
                name
            ))),
        }
    }

    pub fn get_setting(&self, name: &String) -> Result<&Setting> {
        match self.settings.get(name) {
            Some(setting) => Ok(setting),
            None => Err(Error::ExtensionError(format!(
                "Couldnt find id {} in settings ",
                name
            ))),
        }
    }
}
