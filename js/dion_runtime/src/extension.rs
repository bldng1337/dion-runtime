use std::collections::HashMap;

use dion_runtime::{
  datastructs::{EntryActivity, EntryDetailed, Source},
  extension::Extension,
  permission::Permission,
  settings::{Setting, SettingKind, SettingValue},
};
use napi_derive::napi;

use crate::{cancel::CancelTokenProxy, error::ErrorConverter};

#[napi(js_name = "Extension")]
pub struct ExtensionProxy {
  extension: Box<dyn Extension>,
}

impl From<Box<dyn Extension>> for ExtensionProxy {
  fn from(value: Box<dyn Extension>) -> Self {
    Self { extension: value }
  }
}

#[napi]
impl ExtensionProxy {
  #[napi(getter)]
  pub fn enabled(&self) -> bool {
    self.extension.is_enabled()
  }
  /// # Safety
  /// Safety is handled by napi
  #[napi]
  pub async unsafe fn set_enabled(&mut self, enabled: bool) -> Result<(), napi::Error> {
    self.extension.set_enabled(enabled).await.map_to_node()
  }
  /// # Safety
  /// Safety is handled by napi
  #[napi]
  pub async unsafe fn reload(&mut self) -> Result<(), napi::Error> {
    self.extension.reload().await.map_to_node()
  }

  #[napi(ts_return_type = "Promise<EntryList>")]
  pub async fn browse(
    &self,
    page: i32,
    token: Option<&CancelTokenProxy>,
  ) -> Result<serde_json::Value, napi::Error> {
    let token = token.map(|v| v.take_token());
    let inner = self.extension.browse(page, token).await.map_to_node()?;
    serde_json::to_value(inner).map_to_node()
  }

  #[napi(ts_return_type = "Promise<EntryList>")]
  pub async fn search(
    &self,
    page: i32,
    filter: String,
    token: Option<&CancelTokenProxy>,
  ) -> Result<serde_json::Value, napi::Error> {
    let token = token.map(|v| v.take_token());
    let inner = self
      .extension
      .search(page, filter, token)
      .await
      .map_to_node()?;
    serde_json::to_value(inner).map_to_node()
  }

  #[napi]
  pub async fn fromurl(
    &self,
    url: String,
    token: Option<&CancelTokenProxy>,
  ) -> Result<bool, napi::Error> {
    let token = token.map(|v| v.take_token());
    self.extension.fromurl(url, token).await.map_to_node()
  }

  #[napi(
    ts_args_type = "entryid: string, settings: Record<string, Setting>, token?: CancelToken",
    ts_return_type = "Promise<EntryDetailedResult>"
  )]
  pub async fn detail(
    &self,
    entryid: String,
    settings: HashMap<String, serde_json::Value>,
    token: Option<&CancelTokenProxy>,
  ) -> Result<serde_json::Value, napi::Error> {
    let token = token.map(|v| v.take_token());
    let mut mapsettings: HashMap<String, Setting> = HashMap::with_capacity(settings.capacity());
    for (key, value) in settings.into_iter() {
      let value = serde_json::from_value(value).map_to_node()?;
      mapsettings.insert(key, value);
    }
    let inner = self
      .extension
      .detail(entryid, mapsettings, token)
      .await
      .map_to_node()?;
    serde_json::to_value(inner).map_to_node()
  }

  #[napi(
    ts_args_type = "epid: string, settings: Record<string, Setting>, token?: CancelToken",
    ts_return_type = "Promise<SourceResult>"
  )]
  pub async fn source(
    &self,
    epid: String,
    settings: HashMap<String, serde_json::Value>,
    token: Option<&CancelTokenProxy>,
  ) -> Result<serde_json::Value, napi::Error> {
    let token = token.map(|v| v.take_token());
    let mut mapsettings: HashMap<String, Setting> = HashMap::with_capacity(settings.capacity());
    for (key, value) in settings.into_iter() {
      let value = serde_json::from_value(value).map_to_node()?;
      mapsettings.insert(key, value);
    }
    let inner = self
      .extension
      .source(epid, mapsettings, token)
      .await
      .map_to_node()?;
    serde_json::to_value(inner).map_to_node()
  }

  #[napi(
    ts_args_type = "entry:EntryDetailed, settings: Record<string, Setting>, token?: CancelToken",
    ts_return_type = "Promise<EntryDetailedResult>"
  )]
  pub async fn map_entry(
    &self,
    entry: serde_json::Value,
    settings: HashMap<String, serde_json::Value>,
    token: Option<&CancelTokenProxy>,
  ) -> Result<serde_json::Value, napi::Error> {
    let token = token.map(|v| v.take_token());
    let mut mapsettings: HashMap<String, Setting> = HashMap::with_capacity(settings.capacity());
    let entry: EntryDetailed = serde_json::from_value(entry).map_to_node()?;
    for (key, value) in settings.into_iter() {
      let value = serde_json::from_value(value).map_to_node()?;
      mapsettings.insert(key, value);
    }
    let inner = self
      .extension
      .map_entry(entry, mapsettings, token)
      .await
      .map_to_node()?;
    serde_json::to_value(inner).map_to_node()
  }

  #[napi(
    ts_args_type = "activity: EntryActivity, entry: EntryDetailed, settings: Record<string, Setting>, token?: CancelToken"
  )]
  pub async fn on_entry_activity(
    &self,
    activity: serde_json::Value,
    entry: serde_json::Value,
    settings: HashMap<String, serde_json::Value>,
    token: Option<&CancelTokenProxy>,
  ) -> Result<(), napi::Error> {
    let token = token.map(|v| v.take_token());
    let mut mapsettings: HashMap<String, Setting> = HashMap::with_capacity(settings.capacity());
    let entry: EntryDetailed = serde_json::from_value(entry).map_to_node()?;
    let activity: EntryActivity = serde_json::from_value(activity).map_to_node()?;
    for (key, value) in settings.into_iter() {
      let value = serde_json::from_value(value).map_to_node()?;
      mapsettings.insert(key, value);
    }
    self
      .extension
      .on_entry_activity(activity, entry, mapsettings, token)
      .await
      .map_to_node()?;
    Ok(())
  }

  #[napi(
    ts_args_type = "source: Source, settings: Record<string, Setting>, token?: CancelToken",
    ts_return_type = "Promise<Source>"
  )]
  pub async fn map_source(
    &self,
    source: serde_json::Value,
    settings: HashMap<String, serde_json::Value>,
    token: Option<&CancelTokenProxy>,
  ) -> Result<serde_json::Value, napi::Error> {
    let token = token.map(|v| v.take_token());
    let mut mapsettings: HashMap<String, Setting> = HashMap::with_capacity(settings.capacity());
    let source: Source = serde_json::from_value(source).map_to_node()?;
    for (key, value) in settings.into_iter() {
      let value = serde_json::from_value(value).map_to_node()?;
      mapsettings.insert(key, value);
    }
    let inner = self
      .extension
      .map_source(source, mapsettings, token)
      .await
      .map_to_node()?;
    serde_json::to_value(inner).map_to_node()
  }

  #[napi(ts_return_type = "Promise<ExtensionData>")]
  pub async fn get_data(&self) -> Result<serde_json::Value, napi::Error> {
    let res = self.extension.get_data().read().await.data.clone();
    serde_json::to_value(res).map_to_node()
  }

  #[napi]
  pub async fn save(&self) -> Result<(), napi::Error> {
    let client = self.extension.get_client();
    let extdata = self.extension.get_data().read().await;
    extdata.settings.save_state(client).await.map_to_node()?;
    extdata.permission.save_data(client).await.map_to_node()?;
    Ok(())
  }

  #[napi(ts_return_type = "Promise<Permission[]>")]
  pub async fn get_permissions(&self) -> Result<serde_json::Value, napi::Error> {
    let extdata = self.extension.get_data().read().await;
    let perms = extdata.permission.get_permissions().clone();
    serde_json::to_value(perms).map_to_node()
  }

  #[napi(ts_args_type = "permission: Permission")]
  pub async fn has_permission(&self, permission: serde_json::Value) -> Result<bool, napi::Error> {
    let extdata = self.extension.get_data().read().await;
    let permission: Permission = serde_json::from_value(permission).map_to_node()?;
    Ok(extdata.permission.has_permission(&permission))
  }

  #[napi(ts_args_type = "permission:Permission, msg?: string")]
  pub async fn request_permission(
    &self,
    permission: serde_json::Value,
    msg: Option<String>,
  ) -> Result<bool, napi::Error> {
    let permission: Permission = serde_json::from_value(permission).map_to_node()?;
    let client = self.extension.get_client();
    let mut extdata = self.extension.get_data().write().await;
    extdata
      .permission
      .request_permission(client, permission, msg)
      .await
      .map_to_node()
  }

  #[napi(ts_args_type = "permission: Permission")]
  pub async fn remove_permission(&self, permission: serde_json::Value) -> Result<(), napi::Error> {
    let permission: Permission = serde_json::from_value(permission).map_to_node()?;
    let mut extdata = self.extension.get_data().write().await;
    extdata.permission.remove_permission(permission);
    Ok(())
  }

  #[napi(
    ts_return_type = "Promise<Setting>",
    ts_args_type = "id: string, kind: SettingKind"
  )]
  pub async fn get_setting(
    &self,
    id: String,
    kind: String,
  ) -> Result<serde_json::Value, napi::Error> {
    let extdata = self.extension.get_data().read().await;
    let kind: SettingKind = match kind.to_lowercase().as_str() {
      "extension" => SettingKind::Extension,
      "search" => SettingKind::Search,
      _ => return Err(napi::Error::from_reason("Incorrect SettingKind")),
    };
    let res = extdata
      .settings
      .get_setting(id.as_str(), &kind)
      .map_to_node()?;
    serde_json::to_value(res).map_to_node()
  }

  #[napi(
    ts_return_type = "Promise<Record<string, Setting>>",
    ts_args_type = "kind: SettingKind"
  )]
  pub async fn get_settings(&self, kind: String) -> Result<serde_json::Value, napi::Error> {
    let extdata = self.extension.get_data().read().await;
    let kind_parsed: SettingKind = match kind.to_lowercase().as_str() {
      "extension" => SettingKind::Extension,
      "search" => SettingKind::Search,
      _ => return Err(napi::Error::from_reason("Incorrect SettingKind")),
    };
    let settings_map = extdata.settings.get_settings(&kind_parsed);
    serde_json::to_value(settings_map).map_to_node()
  }

  #[napi(ts_args_type = "id: string, kind: SettingKind, value: SettingValue")]
  pub async fn set_setting(
    &self,
    id: String,
    kind: String,
    value: serde_json::Value,
  ) -> Result<(), napi::Error> {
    let mut extdata = self.extension.get_data().write().await;
    let kind_parsed: SettingKind = match kind.to_lowercase().as_str() {
      "extension" => SettingKind::Extension,
      "search" => SettingKind::Search,
      _ => return Err(napi::Error::from_reason("Incorrect SettingKind")),
    };
    let setting_value: SettingValue = serde_json::from_value(value).map_to_node()?;
    extdata
      .settings
      .set_setting(id.as_str(), &kind_parsed, setting_value)
      .map_to_node()?;
    Ok(())
  }

  #[napi(ts_args_type = "id: string, kind: SettingKind")]
  pub async fn remove_setting(&self, id: String, kind: String) -> Result<(), napi::Error> {
    let mut extdata = self.extension.get_data().write().await;
    let kind_parsed: SettingKind = match kind.to_lowercase().as_str() {
      "extension" => SettingKind::Extension,
      "search" => SettingKind::Search,
      _ => return Err(napi::Error::from_reason("Incorrect SettingKind")),
    };
    extdata
      .settings
      .remove_setting(id.as_str(), &kind_parsed)
      .map_to_node()?;
    Ok(())
  }

  #[napi(
    ts_return_type = "Promise<string[]>",
    ts_args_type = "kind: SettingKind"
  )]
  pub async fn get_setting_ids(&self, kind: String) -> Result<serde_json::Value, napi::Error> {
    let extdata = self.extension.get_data().read().await;
    let kind_parsed: SettingKind = match kind.to_lowercase().as_str() {
      "extension" => SettingKind::Extension,
      "search" => SettingKind::Search,
      _ => return Err(napi::Error::from_reason("Incorrect SettingKind")),
    };
    let ids = extdata.settings.get_setting_ids(&kind_parsed);
    serde_json::to_value(ids).map_to_node()
  }

  #[napi(ts_args_type = "id: string, kind: SettingKind, definition: Setting")]
  pub async fn merge_setting_definition(
    &self,
    id: String,
    kind: String,
    definition: serde_json::Value,
  ) -> Result<(), napi::Error> {
    let mut extdata = self.extension.get_data().write().await;
    let kind_parsed: SettingKind = match kind.to_lowercase().as_str() {
      "extension" => SettingKind::Extension,
      "search" => SettingKind::Search,
      _ => return Err(napi::Error::from_reason("Incorrect SettingKind")),
    };
    let setting_def: Setting = serde_json::from_value(definition).map_to_node()?;
    extdata
      .settings
      .merge_setting_definition(id, &kind_parsed, setting_def)
      .map_to_node()?;
    Ok(())
  }
}
