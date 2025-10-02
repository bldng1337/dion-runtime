use std::{collections::HashMap, fmt::Display};

use crate::{
    client_data::ExtensionClient,
    data::settings::{Setting, SettingKind, SettingValue},
};
use anyhow::{anyhow, bail, Result};

#[derive(Debug)]
pub struct SettingStore {
    extension_setting: HashMap<String, Setting>,
    search_setting: HashMap<String, Setting>,
}

impl SettingStore {
    pub async fn new(client: &dyn ExtensionClient) -> Self {
        let mut ret = SettingStore {
            extension_setting: Default::default(),
            search_setting: Default::default(),
        };
        let _ = ret.load_state(client).await;
        ret
    }

    async fn load_state(&mut self, client: &dyn ExtensionClient) -> Result<()> {
        self.extension_setting =
            serde_json::from_str(&client.load_data("extension_settings").await?)?;
        self.search_setting = serde_json::from_str(&client.load_data("search_settings").await?)?;
        Ok(())
    }

    pub async fn save_state(&self, client: &dyn ExtensionClient) -> Result<()> {
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

impl Display for SettingKind {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            SettingKind::Extension => f.write_str("Extension"),
            SettingKind::Search => f.write_str("Search"),
        }
    }
}
