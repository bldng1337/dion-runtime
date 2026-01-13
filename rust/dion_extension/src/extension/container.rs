use std::collections::HashMap;
use std::path::PathBuf;
use std::sync::Arc;

use anyhow::{Context as ErrorContext, Result, anyhow, bail};
use arc_swap::ArcSwapOption;
use dion_runtime::client_data::ExtensionClient;
use dion_runtime::data::action::EventData;
use dion_runtime::data::action::EventResult;
use dion_runtime::data::activity::EntryActivity;
use dion_runtime::data::auth::Account;
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
        let ext = ExtensionStore {
            data: extdata.clone().into_extension_data(),
            permission: PermissionStore::new(client.as_ref()).await,
            settings: SettingStore::new(client.as_ref()).await,
            auth: AuthStore::new(client.as_ref()).await,
        };
        let data = Arc::new(InnerExtension {
            client,
            proxy: manager.proxy.clone(),
            network: manager.network.clone(),
            store: RwLock::new(ext),
            context: ArcSwapOption::from(None),
        });
        let proxy = manager.proxy.clone();
        let proxy_ref = ProxyExtensionRef::new(&proxy, Arc::downgrade(&data)).await;
        Ok(Self {
            _proxy_ref: proxy_ref,
            data,
            path,
            code,
        })
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
        let mut store = self.data.store.write().await;
        let store_account = store
            .auth
            .get_mut(&account.domain)
            .ok_or(anyhow!("Couldnt find the account"))?;
        // TODO: Potentially we could use less clones here but this is simpler for now
        let old = store_account.clone();
        *store_account = account.clone();
        drop(store);
        match &*self.data.context.load() {
            Some(context) => {
                let (send, response) = oneshot::channel();
                let task = Task::Validate {
                    account,
                    token,
                    send,
                };
                context
                    .send(task)
                    .context("Failed to send message to Extension Thread")?;
                let res = response.await??;
                let mut store = self.data.store.write().await;
                let store_account = store
                    .auth
                    .get_mut(&old.domain)
                    .ok_or(anyhow!("Couldnt find the account"))?;
                match &res {
                    Some(acc) => {
                        *store_account = acc.clone();
                    }
                    None => {
                        *store_account = old;
                    }
                }
                Ok(res)
            }
            None => bail!("Extension is not enabled"),
        }
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
