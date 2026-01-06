use crate::api::cancel::CancelToken;
use crate::api::client::*;
use crate::api::ext_wrap::WrapperAdapter;
use crate::api::ext_wrap::WrapperExtension;
use anyhow::Result;

use dion_extension::extension_manager::DionExtensionAdapter;
use dion_runtime::data::action::EventData;
use dion_runtime::data::action::EventResult;
use dion_runtime::data::activity::EntryActivity;
use dion_runtime::data::auth::Account;
use dion_runtime::data::extension::ExtensionData;
use dion_runtime::data::extension_repo::ExtensionRepo;
use dion_runtime::data::extension_repo::RemoteExtensionResult;
use dion_runtime::data::permission::Permission;
use dion_runtime::data::settings::Setting;
use dion_runtime::data::settings::SettingKind;
use dion_runtime::data::settings::SettingValue;
use dion_runtime::data::source::EntryDetailed;
use dion_runtime::data::source::EntryDetailedResult;
use dion_runtime::data::source::EntryId;
use dion_runtime::data::source::EntryList;
use dion_runtime::data::source::EpisodeId;
use dion_runtime::data::source::Source;
use dion_runtime::data::source::SourceResult;
pub use dion_runtime::extension::Extension;

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

    pub async fn save_settings(&self) -> Result<()> {
        let store = self.inner.inner.get_data().read().await;
        let client = self.inner.inner.get_client();
        store.settings.save_state(client).await?;
        Ok(())
    }

    pub async fn save_permissions(&self) -> Result<()> {
        let store = self.inner.inner.get_data().read().await;
        let client = self.inner.inner.get_client();
        store.permission.save_state(client).await?;
        Ok(())
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

    #[frb(serialize)]
    pub async fn event(
        &self,
        event: EventData,
        token: Option<CancelToken>,
    ) -> Result<Option<EventResult>> {
        self.inner
            .inner
            .event(event, token.map(|token| token.into()))
            .await
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

    pub async fn handle_url(&self, url: String, token: Option<CancelToken>) -> Result<bool> {
        self.inner
            .inner
            .handle_url(url, token.map(|token| token.into()))
            .await
    }

    #[frb(serialize)]
    pub async fn detail(
        &self,
        entryid: EntryId,
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
        epid: EpisodeId,
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
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        token: Option<CancelToken>,
    ) -> Result<SourceResult> {
        self.inner
            .inner
            .map_source(source, epid, settings, token.map(|token| token.into()))
            .await
    }

    // Auth
    #[frb(serialize)]
    pub async fn get_accounts(&self) -> Vec<Account> {
        let store = self.inner.inner.get_data().read().await;
        store.auth.get_accounts().clone()
    }

    pub async fn is_logged_in(&self, domain: String) -> bool {
        let store = self.inner.inner.get_data().read().await;
        store.auth.is_logged_in(&domain)
    }

    pub async fn invalidate(&mut self, domain: String) {
        let mut store = self.inner.inner.get_data().write().await;
        store.auth.invalidate(&domain);
    }

    pub async fn merge_auth(&mut self, account: Account) {
        let mut store = self.inner.inner.get_data().write().await;
        store.auth.merge_auth(&account);
    }

    pub async fn save_auth_state(&self) -> Result<()> {
        let store = self.inner.inner.get_data().read().await;
        let client = self.inner.inner.get_client();
        store.auth.save_state(client).await?;
        Ok(())
    }
}

#[frb(opaque)]
pub struct ProxyAdapter {
    #[frb(ignore)]
    inner: WrapperAdapter,
}

impl ProxyAdapter {
    pub async fn init_dion(client: &ManagerClient) -> Result<ProxyAdapter> {
        DionExtensionAdapter::new(Box::new(client.clone()))
            .await
            .map(|ext| ProxyAdapter {
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

    pub async fn install(&self, location: &str) -> Result<ProxyExtension> {
        self.inner
            .inner
            .install(location)
            .await
            .map(|ext| ext.into())
    }

    pub async fn uninstall(&self, ext: &ProxyExtension) -> Result<()> {
        self.inner.inner.uninstall(&ext.inner.inner).await
    }

    pub async fn get_repo(&self, url: &str) -> Result<ExtensionRepo> {
        self.inner.inner.get_repo(url).await
    }

    pub async fn browse_repo(
        &self,
        repo: &ExtensionRepo,
        page: i32,
    ) -> Result<RemoteExtensionResult> {
        self.inner.inner.browse_repo(repo, page).await
    }
}
