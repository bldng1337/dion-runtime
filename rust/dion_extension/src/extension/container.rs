use std::collections::HashMap;
use std::collections::HashSet;
use std::path::PathBuf;
use std::sync::Arc;

use anyhow::{Context as ErrorContext, Result, anyhow, bail};
use arc_swap::ArcSwapOption;
use dion_runtime::client_data::ExtensionClient;
use dion_runtime::data::action::EventData;
use dion_runtime::data::action::EventResult;
use dion_runtime::data::activity::EntryActivity;
use dion_runtime::data::auth::Account;
use dion_runtime::data::permission::Permission;
use dion_runtime::data::settings::Setting;
use dion_runtime::data::source::EntryDetailed;
use dion_runtime::data::source::EntryDetailedResult;
use dion_runtime::data::source::EntryId;
use dion_runtime::data::source::EntryList;
use dion_runtime::data::source::EpisodeId;
use dion_runtime::data::source::Source;
use dion_runtime::data::source::SourceResult;
use dion_runtime::extension::Extension;
use dion_runtime::store::ExtensionStore;
use dion_runtime::store::auth::AuthStore;
use dion_runtime::store::permission::PermissionStore;
use dion_runtime::store::settings::SettingStore;
use tokio::fs;
use tokio::sync::Notify;
use tokio::sync::RwLock;
use tokio::sync::oneshot;
use tokio_util::sync::CancellationToken;

use crate::extension::executor::{ExtensionExecutor, Task};
use crate::extension_executor::ThreadedJSContext;
use crate::extension_manager::{DionExtensionAdapter, ExtensionMetadata};
use crate::network::DionNetworkManager;
use crate::proxy::Proxy;
use crate::proxy::ProxyExtensionRef;

#[derive(Debug)]
pub struct InnerExtension {
    pub(crate) store: RwLock<ExtensionStore>,
    pub(crate) client: Box<dyn ExtensionClient>,
    pub(crate) network: DionNetworkManager,
    pub(crate) context: ArcSwapOption<ThreadedJSContext<Task>>,
    pub(crate) proxy: Arc<RwLock<Proxy>>,
    pub(crate) network_permissions: tokio::sync::Mutex<NetworkPermissionCache>,
}

#[derive(Debug, Default)]
pub(crate) struct NetworkPermissionCache {
    inflight: HashMap<String, Arc<Notify>>,
    denied: HashSet<String>,
}

impl InnerExtension {
    pub(crate) async fn ensure_network_permission(&self, host: &str) -> Result<bool> {
        let permission = Permission::Network {
            domains: vec![host.to_string()],
        };
        if self
            .store
            .read()
            .await
            .permission
            .has_permission(&permission)
        {
            return Ok(true);
        }
        let mut cache = self.network_permissions.lock().await;
        // Re-check: a prompt may have completed while we waited for the cache.
        if self
            .store
            .read()
            .await
            .permission
            .has_permission(&permission)
        {
            return Ok(true);
        }
        if cache.denied.contains(host) {
            return Ok(false);
        }
        if let Some(notify) = cache.inflight.get(host).cloned() {
            // Another fetch is already prompting for this host; wait for it.
            // The `notified()` future must be created before dropping the
            // cache lock so the promoter's `notify_waiters` wakes us.
            let notified = notify.notified();
            drop(cache);
            notified.await;
            return Ok(self
                .store
                .read()
                .await
                .permission
                .has_permission(&permission));
        }
        let notify = Arc::new(Notify::new());
        cache.inflight.insert(host.to_string(), notify.clone());
        drop(cache);
        let ext_name = self.store.read().await.data.name.clone();
        let prompt = self
            .client
            .request_permission(
                &permission,
                Some(format!("Extension \"{ext_name}\" wants to access {host}")),
            )
            .await;
        let granted = match prompt {
            Ok(granted) => granted,
            Err(err) => {
                // Clean up so waiters and future fetches are not stuck on a
                // dead prompt.
                let mut cache = self.network_permissions.lock().await;
                cache.inflight.remove(host);
                drop(cache);
                notify.notify_waiters();
                return Err(err);
            }
        };
        if granted {
            {
                let mut store = self.store.write().await;
                store.permission.grant(permission);
            }
            // Persist via a snapshot, without holding the store lock: the
            // host round-trip may re-enter the runtime.
            let snapshot = self.store.read().await.permission.get_permissions().clone();
            if let Err(err) = PermissionStore::persist(&snapshot, self.client.as_ref()).await {
                log::warn!("Failed to persist granted permissions: {err:?}");
            }
        }
        let mut cache = self.network_permissions.lock().await;
        cache.inflight.remove(host);
        if granted {
            cache.denied.remove(host);
        } else {
            cache.denied.insert(host.to_string());
        }
        drop(cache);
        notify.notify_waiters();
        Ok(granted)
    }
}

#[derive(Debug)]
pub struct DionExtension {
    pub(crate) data: Arc<InnerExtension>,
    pub(crate) code: String,
    pub(crate) path: PathBuf,
    pub(crate) _proxy_ref: Arc<ProxyExtensionRef>,
}

impl DionExtension {
    pub(crate) async fn create(path: PathBuf, manager: &DionExtensionAdapter) -> Result<Self> {
        let (extdata, code) = Self::read_extension(&path).await?;
        let client: Box<dyn ExtensionClient> = manager
            .client
            .get_extension_client(extdata.clone().into_extension_data())
            .await
            .context("Failed to get Extension Client Data")?;
        // Each extension gets its own network manager so cookie jars (and the
        // http cache) live in the per-extension data location the host picked:
        // the extension's client reports it via get_path. A shared jar would
        // let one extension's site credentials leak into another extension's
        // requests, so hosts should return a per-extension path here.
        let data_dir = client
            .get_path()
            .await
            .context("Failed to get extension data path")?;
        let network = DionNetworkManager::new(PathBuf::from(data_dir))?;
        let ext = ExtensionStore {
            data: extdata.clone().into_extension_data(),
            permission: PermissionStore::new(client.as_ref()).await,
            settings: SettingStore::new(client.as_ref()).await,
            auth: AuthStore::new(client.as_ref()).await,
        };
        let data = Arc::new(InnerExtension {
            client,
            proxy: manager.proxy.clone(),
            network,
            store: RwLock::new(ext),
            context: ArcSwapOption::from(None),
            network_permissions: Default::default(),
        });
        let proxy = manager.proxy.clone();
        let proxy_ref = ProxyExtensionRef::new(&proxy, Arc::downgrade(&data)).await;
        let extension = Self {
            _proxy_ref: proxy_ref,
            data,
            path,
            code,
        };
        // We should use into_iter to avoid clones but then we would need to remove the settings from the extension data, ideally we want to have another type of extension data for runtime that doesnt have the settings in it but then we would have the core extension data, the serialized extension data and the runtime extension data

        {
            let mut store = extension.data.store.write().await;
            extdata
                .settings
                .iter()
                .try_for_each(|(setting_kind, settings)| {
                    settings.iter().try_for_each(|(name, def)| {
                        store.settings.merge_setting_definition(
                            name.clone(),
                            setting_kind,
                            def.clone(),
                        )
                    })
                })?;

            for account in &extdata.accounts {
                store.auth.merge_auth(account);
            }
        }

        Ok(extension)
    }

    async fn read_extension(extpath: &PathBuf) -> Result<(ExtensionMetadata, String)> {
        let contents: String = String::from_utf8(fs::read(extpath).await?)?;
        let first_line = contents
            .lines()
            .next()
            .ok_or_else(|| anyhow!("Extension file is empty"))?;
        let metadata_str = first_line.strip_prefix("//").ok_or_else(|| {
            anyhow!("Single File Extensions must start with '//' on the first line")
        })?;
        let data: ExtensionMetadata = serde_json::from_str(metadata_str)
            .context("Failed to parse ExtensionData from metadata comment")?;

        Ok((data, contents))
    }
}

#[async_trait::async_trait()]
impl Extension for DionExtension {
    fn is_enabled(&self) -> bool {
        self.data.context.load().is_some()
    }

    fn get_data(&self) -> &RwLock<ExtensionStore> {
        &self.data.store
    }

    fn get_client(&self) -> &dyn ExtensionClient {
        self.data.client.as_ref()
    }

    async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        match (enabled, self.is_enabled()) {
            (true, false) => {
                let executor = ExtensionExecutor::create(self);
                let context = ThreadedJSContext::create(executor).await?;
                self.data.context.store(Some(Arc::new(context)));
            }
            (false, true) => self.data.context.store(None),
            (false, false) | (true, true) => (),
        }
        Ok(())
    }

    async fn reload(&mut self) -> Result<()> {
        let enabled = self.is_enabled();
        self.set_enabled(false).await?;
        let (ext, code) = Self::read_extension(&self.path).await?;
        {
            let mut store = self.data.store.write().await;
            store.data = ext.clone().into_extension_data();
        }
        self.code = code;
        self.set_enabled(enabled).await?;
        Ok(())
    }

    async fn validate(
        &self,
        account: Account,
        token: Option<CancellationToken>,
    ) -> Result<Option<Account>> {
        let old = {
            let mut store = self.data.store.write().await;
            let store_account = store
                .auth
                .get_mut(&account.domain)
                .ok_or(anyhow!("Couldnt find the account"))?;
            // TODO: Potentially we could use less clones here but this is simpler for now
            let old = store_account.clone();
            // Extensions typically read the new credentials from the store
            // during validation (getAuthSecret), so the candidate account must
            // be visible in the store for the JS round-trip below. `old` is
            // restored on EVERY failure path so failed validations never
            // leave unvalidated credentials persisted.
            *store_account = account.clone();
            old
        };
        let auth_creds = account.creds.clone();
        let res: Result<Option<Account>> = match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Validate {
                    account,
                    token,
                    send,
                };
                match context
                    .send(task)
                    .context("Failed to send message to Extension Thread")
                {
                    Ok(()) => match response.await {
                        Ok(inner) => inner.map(|opt| {
                            opt.map(|acc| Account {
                                creds: auth_creds,
                                ..acc
                            })
                        }),
                        Err(e) => Err(anyhow!("Extension validate task was dropped: {e}")),
                    },
                    Err(e) => Err(e),
                }
            }
            None => Err(anyhow!("Extension is not enabled")),
        };
        let mut store = self.data.store.write().await;
        let store_account = store
            .auth
            .get_mut(&old.domain)
            .ok_or(anyhow!("Couldnt find the account"))?;
        match &res {
            Ok(Some(acc)) => {
                *store_account = acc.clone();
            }
            _ => {
                *store_account = old;
            }
        }
        res
    }

    async fn browse(&self, page: i32, token: Option<CancellationToken>) -> Result<EntryList> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Browse { page, token, send };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn event(
        &self,
        event: EventData,
        token: Option<CancellationToken>,
    ) -> Result<Option<EventResult>> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Event { event, token, send };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn search(
        &self,
        page: i32,
        filter: String,
        token: Option<CancellationToken>,
    ) -> Result<EntryList> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Search {
                    page,
                    filter,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn handle_url(&self, url: String, token: Option<CancellationToken>) -> Result<bool> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::HandleUrl { url, token, send };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn on_entry_activity(
        &self,
        activity: EntryActivity,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<()> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::OnEntryActivity {
                    activity,
                    entry,
                    settings,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn detail(
        &self,
        entryid: EntryId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Detail {
                    entryid,
                    settings,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn refresh(
        &self,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Refresh {
                    entry,
                    settings,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn source(
        &self,
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<SourceResult> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Source {
                    epid,
                    settings,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn map_entry(
        &self,
        entry: EntryDetailed,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailedResult> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::MapEntry {
                    entry,
                    settings,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }

    async fn map_source(
        &self,
        source: Source,
        epid: EpisodeId,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<SourceResult> {
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::ProcessSource {
                    source,
                    settings,
                    epid,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                response.await?
            }
            None => bail!("Extension is not enabled"),
        }
    }
}
