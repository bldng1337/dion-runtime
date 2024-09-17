use std::collections::HashMap;

use rquickjs::IntoJs;
use serde::{ Deserialize, Serialize };

use crate::error::Error;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub enum Settingvalue {
    String {
        val: String,
        default: String,
    },
    Number {
        val: f64,
        default: f64,
    },
    Boolean {
        val: bool,
        default: bool,
    },
}

/// flutter_rust_bridge:ignore
impl<'js> IntoJs<'js> for Settingvalue{
    fn into_js(self, ctx: &rquickjs::Ctx<'js>) -> rquickjs::Result<rquickjs::Value<'js>> {
        match self {
            Settingvalue::String { val, .. } => val.into_js(ctx),
            Settingvalue::Number { val, .. } => val.into_js(ctx),
            Settingvalue::Boolean { val, .. } => val.into_js(ctx),
        }
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
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
        options: Vec<(String, String)>,
    },
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub enum Settingtype {
    Extension,
    Entry,
    Search
}


#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Setting {
    pub val: Settingvalue,
    pub settingtype: Settingtype,
    pub ui: Option<SettingUI>,
}
/// flutter_rust_bridge:opaque
#[derive(Serialize, Deserialize, Debug, Default)]
pub struct SettingStore {
    settings: HashMap<String, Setting>,
}

impl SettingStore {
    

    pub fn set_setting(&mut self,name: String,setting:Setting){
        self.settings.insert(name, setting);
    }

    pub fn frb_override_get_setting(&self, name: &String)-> Result<Setting, Error> {
        match self.settings.get(name) {
            Some(setting) => Ok(setting.clone()),
            None => Err(Error::ExtensionError(format!("Couldnt find id {} in settings ", name))),
        }
    }



    /// flutter_rust_bridge:ignore
    pub fn get_setting_mut(&mut self, name: &String) -> Result<&mut Setting, Error> {
        match self.settings.get_mut(name) {
            Some(setting) => Ok(setting),
            None => Err(Error::ExtensionError(format!("Couldnt find id {} in settings ", name))),
        }
    }

    pub(crate) fn add_setting(&mut self, name: String,mut setting:Setting) {
        if self.settings.contains_key(&name) {
            //TODO: Technically not correct since it overwrites default
            setting.val=self.settings.remove(&name).unwrap().val
        }
        self.settings.insert(name, setting);
    }

    /// flutter_rust_bridge:ignore
    pub fn get_setting(&self, name: &String) -> Result<&Setting, Error> {
        match self.settings.get(name) {
            Some(setting) => Ok(setting),
            None => Err(Error::ExtensionError(format!("Couldnt find id {} in settings ", name))),
        }
    }
}
