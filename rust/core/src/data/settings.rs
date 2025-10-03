use anyhow::{anyhow, Result};
use serde::{Deserialize, Serialize};

#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum SettingKind {
    Extension,
    Search,
}

/// flutter_rust_bridge:non_opaque
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
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct DropdownOption {
    pub label: String,
    pub value: String,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum SettingsUI {
    CheckBox,
    Slider { min: f64, max: f64, step: i32 },
    Dropdown { options: Vec<DropdownOption> },
}

/// flutter_rust_bridge:non_opaque
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
