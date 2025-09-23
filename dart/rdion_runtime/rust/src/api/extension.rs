use crate::api::cancel::CancelToken;
use crate::api::client::*;
use crate::api::ext_wrap::WrapperExtension;
use crate::api::ext_wrap::WrapperExtensionManager;
use anyhow::Result;
use dion_extension::extension_manager::DionExtensionManager;
use dion_runtime::datastructs::ExtensionRepo;
use dion_runtime::datastructs::RemoteExtension;
use dion_runtime::datastructs::*;
pub use dion_runtime::extension::Extension;
pub use dion_runtime::extension::ExtensionManager;
use dion_runtime::permission::Permission;
use dion_runtime::settings::*;
use flutter_rust_bridge::frb;
use std::collections::HashMap;

#[frb(opaque)]
pub struct ProxyExtension {
    #[frb(ignore)]
    pub(super) inner: WrapperExtension,
}

impl ProxyExtension {
    pub fn is_enabled(&self) -> bool {
        self.inner.inner.is_enabled()
    }

    pub async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        self.inner.inner.set_enabled(enabled).await
    }

    pub async fn reload(&mut self) -> Result<()> {
        self.inner.inner.reload().await
    }

    #[frb(serialize)]
    pub async fn get_setting(&self, id: String, kind: SettingKind) -> Result<Setting> {
        self.inner
            .inner
            .get_data()
            .read()
            .await
            .settings
            .get_setting(id.as_str(), &kind)
            .cloned()
    }

    #[frb(serialize)]
    pub async fn set_setting(
        &self,
        id: String,
        kind: SettingKind,
        value: SettingValue,
    ) -> Result<()> {
        let mut store = self.inner.inner.get_data().write().await;
        store.settings.set_setting(id.as_str(), &kind, value)?;
        Ok(())
    }

    #[frb(serialize)]
    pub async fn remove_setting(&self, id: String, kind: SettingKind) -> Result<()> {
        let mut store = self.inner.inner.get_data().write().await;
        store.settings.remove_setting(id.as_str(), &kind)?;
        Ok(())
    }

    #[frb(serialize)]
    pub async fn get_setting_ids(&self, kind: SettingKind) -> Vec<String> {
        let store = self.inner.inner.get_data().read().await;
        store.settings.get_setting_ids(&kind)
    }

    #[frb(serialize)]
    pub async fn merge_setting_definition(
        &self,
        id: String,
        kind: SettingKind,
        definition: Setting,
    ) -> Result<()> {
        let mut store = self.inner.inner.get_data().write().await;
        store
            .settings
            .merge_setting_definition(id, &kind, definition)?;
        Ok(())
    }

    #[frb(serialize)]
    pub async fn get_settings(&self, kind: SettingKind) -> Result<HashMap<String, Setting>> {
        let store = self.inner.inner.get_data().read().await;
        let settings_map = store.settings.get_settings(&kind);
        Ok(settings_map.clone())
    }

    #[frb(serialize)]
    pub async fn get_extension_data(&self) -> Result<ExtensionData> {
        let store = self.inner.inner.get_data().read().await;
        Ok(store.data.clone())
    }

    #[frb(serialize)]
    pub async fn has_permission(&self, permission: Permission) -> bool {
        let store = self.inner.inner.get_data().read().await;
        store.permission.has_permission(&permission)
    }

    #[frb(serialize)]
    pub async fn get_permissions(&self) -> Result<Vec<Permission>> {
        let store = self.inner.inner.get_data().read().await;
        Ok(store.permission.get_permissions().clone())
    }

    #[frb(serialize)]
    pub async fn remove_permission(&self, permission: Permission) -> Result<()> {
        let mut store = self.inner.inner.get_data().write().await;
        store.permission.remove_permission(permission);
        Ok(())
    }

    // SourceProvider
    #[frb(serialize)]
    pub async fn browse(&self, page: i32, token: Option<CancelToken>) -> Result<EntryList> {
        self.inner
            .inner
            .browse(page, token.map(|token| token.into()))
            .await
    }

    #[frb(serialize)]
    pub async fn search(
        &self,
        page: i32,
        filter: String,
        token: Option<CancelToken>,
    ) -> Result<EntryList> {
        self.inner
            .inner
            .search(page, filter, token.map(|token| token.into()))
            .await
    }

    pub async fn fromurl(&self, url: String, token: Option<CancelToken>) -> Result<bool> {
        self.inner
            .inner
            .fromurl(url, token.map(|token| token.into()))
            .await
    }

    #[frb(serialize)]
    pub async fn detail(
        &self,
        entryid: String,
        settings: HashMap<String, Setting>,
        token: Option<CancelToken>,
    ) -> Result<EntryDetailedResult> {
        self.inner
            .inner
            .detail(entryid, settings, token.map(|token| token.into()))
            .await
    }

    #[frb(serialize)]
    pub async fn source(
        &self,
        epid: String,
        settings: HashMap<String, Setting>,
        token: Option<CancelToken>,
    ) -> Result<SourceResult> {
        self.inner
            .inner
            .source(epid, settings, token.map(|token| token.into()))
            .await
    }

    // Entry Extension
    #[frb(serialize)]
    pub async fn map_entry(
        &self,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancelToken>,
    ) -> Result<EntryDetailedResult> {
        self.inner
            .inner
            .map_entry(entry, settings, token.map(|token| token.into()))
            .await
    }

    #[frb(serialize)]
    pub async fn on_entry_activity(
        &self,
        activity: EntryActivity,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancelToken>,
    ) -> Result<()> {
        self.inner
            .inner
            .on_entry_activity(activity, entry, settings, token.map(|token| token.into()))
            .await
    }

    // SourceProcessorExtension
    #[frb(serialize)]
    pub async fn map_source(
        &self,
        source: Source,
        settings: HashMap<String, Setting>,
        token: Option<CancelToken>,
    ) -> Result<SourceResult> {
        self.inner
            .inner
            .map_source(source, settings, token.map(|token| token.into()))
            .await
    }
}

#[frb(opaque)]
pub struct ProxyExtensionManager {
    #[frb(ignore)]
    inner: WrapperExtensionManager,
}

impl ProxyExtensionManager {
    pub async fn init_dion(client: &ManagerClient) -> Result<ProxyExtensionManager> {
        DionExtensionManager::new(Box::new(client.clone()))
            .await
            .map(|ext| ProxyExtensionManager {
                inner: Box::new(ext).into(),
            })
    }

    pub async fn get_extensions(&self) -> Result<Vec<ProxyExtension>> {
        self.inner
            .inner
            .get_extensions()
            .await
            .map(|vec| vec.into_iter().map(|ext| ext.into()).collect())
    }

    pub async fn install(&self, location: &RemoteExtension) -> Result<ProxyExtension> {
        self.inner
            .inner
            .install(location)
            .await
            .map(|ext| ext.into())
    }

    pub async fn install_single(&self, url: String) -> Result<ProxyExtension> {
        self.inner
            .inner
            .install_single(url.as_str())
            .await
            .map(|ext| ext.into())
    }

    pub async fn uninstall(&self, ext: ProxyExtension) -> Result<()> {
        self.inner.inner.uninstall(ext.into()).await
    }

    pub async fn get_repo(&self, url: &str) -> Result<ExtensionRepo> {
        self.inner.inner.get_repo(url).await
    }
}
