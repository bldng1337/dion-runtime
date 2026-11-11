//! [`LnReaderAdapter`]: the `Adapter` for LNReader plugins.

use std::{collections::HashMap, path::PathBuf, sync::Arc, time::Duration};

use anyhow::{Context, Result, anyhow, bail};
use async_trait::async_trait;
use dion_extension::extension_manager::{DionExtensionAdapter, HostModule};
use dion_runtime::{
    client_data::{AdapterClient, ExtensionClient},
    data::{
        extension::ExtensionData,
        extension_repo::{ExtensionRepo, RemoteExtension, RemoteExtensionResult},
    },
    extension::{Adapter, Extension},
    file_url::path_from_file_url,
};
use tokio::sync::RwLock;

use crate::plugin::{HOST_MODULE, PluginPackage, SHIM_SOURCE, read_plugin_info};
use crate::repo::RepoIndex;

const CONNECT_TIMEOUT: Duration = Duration::from_secs(30);
const READ_TIMEOUT: Duration = Duration::from_secs(60);

/// Where installed plugins live, below the adapter's path.
const PLUGIN_DIR: &str = "plugins";

/// Runs LNReader plugins (<https://github.com/lnreader/lnreader-plugins>).
///
/// Each installed plugin becomes a Dion JS extension: the adapter generates a
/// small module that hands the plugin code to the bundled `lnreader` host
/// module, which emulates LNReader's plugin environment (`require` with
/// cheerio, htmlparser2, dayjs and `@libs/*`) and maps the plugin API onto
/// the Dion extension API. The extensions run on the regular Dion runtime,
/// so they get its networking, permission prompts, settings and storage.
///
/// Repositories are LNReader plugin indexes such as
/// `https://raw.githubusercontent.com/LNReader/lnreader-plugins/plugins/v3.0.0/.dist/plugins.min.json`;
/// `install` takes a plugin's code URL (`RemoteExtension::remote_id`) or a
/// `file://` location.
pub struct LnReaderAdapter {
    runtime: DionExtensionAdapter,
    http: reqwest::Client,
    repos: RwLock<HashMap<String, Arc<RepoIndex>>>,
}

/// Gives the Dion runtime the plugin directory as its path while extension
/// clients still come from the host.
struct PluginDirClient {
    host: Box<dyn AdapterClient>,
    path: String,
}

#[async_trait]
impl AdapterClient for PluginDirClient {
    async fn get_extension_client(
        &self,
        extension: ExtensionData,
    ) -> Result<Box<dyn ExtensionClient>> {
        self.host.get_extension_client(extension).await
    }

    async fn get_path(&self) -> Result<String> {
        Ok(self.path.clone())
    }
}

impl LnReaderAdapter {
    pub async fn new(client: Box<dyn AdapterClient>) -> Result<Self> {
        let base = PathBuf::from(
            client
                .get_path()
                .await
                .context("Failed to get adapter path")?,
        );
        let plugin_dir = base.join(PLUGIN_DIR);
        tokio::fs::create_dir_all(&plugin_dir)
            .await
            .with_context(|| format!("Failed to create {plugin_dir:?}"))?;
        let plugin_dir = plugin_dir
            .to_str()
            .ok_or_else(|| anyhow!("Plugin directory {plugin_dir:?} is not valid UTF-8"))?
            .to_string();
        let runtime = DionExtensionAdapter::with_host_modules(
            Box::new(PluginDirClient {
                host: client,
                path: plugin_dir,
            }),
            vec![HostModule::new(HOST_MODULE, SHIM_SOURCE)],
        )
        .await?;
        let http = reqwest::Client::builder()
            .connect_timeout(CONNECT_TIMEOUT)
            .read_timeout(READ_TIMEOUT)
            .build()
            .context("Failed to build HTTP client")?;
        Ok(Self {
            runtime,
            http,
            repos: RwLock::new(HashMap::new()),
        })
    }

    async fn fetch_text(&self, url: &str) -> Result<String> {
        let response = self
            .http
            .get(url)
            .header("pragma", "no-cache")
            .header("cache-control", "no-cache")
            .send()
            .await
            .with_context(|| format!("Failed to fetch {url}"))?;
        let status = response.status();
        if !status.is_success() {
            bail!("Failed to fetch {url}: HTTP {status}");
        }
        response
            .text()
            .await
            .with_context(|| format!("Failed to read {url}"))
    }

    async fn read_location(&self, location: &str) -> Result<String> {
        if let Some(path) = path_from_file_url(location) {
            if !path.is_absolute() {
                bail!("Malformed file location {location}: the path must be absolute");
            }
            return tokio::fs::read_to_string(&path)
                .await
                .with_context(|| format!("Failed to read {path:?}"));
        }
        if location.starts_with("http://") || location.starts_with("https://") {
            return self.fetch_text(location).await;
        }
        bail!("Unsupported plugin location: {location}")
    }

    /// Fetches (and caches) a repository index.
    async fn index(&self, url: &str) -> Result<Arc<RepoIndex>> {
        if let Some(index) = self.repos.read().await.get(url) {
            return Ok(index.clone());
        }
        let body = self.read_location(url).await?;
        let index = Arc::new(
            RepoIndex::parse(url, &body)
                .with_context(|| format!("Failed to parse LNReader repository {url}"))?,
        );
        self.repos
            .write()
            .await
            .insert(url.to_string(), index.clone());
        Ok(index)
    }

    /// Re-downloads a repository index, so browsing shows new versions.
    async fn refresh_index(&self, url: &str) -> Result<Arc<RepoIndex>> {
        self.repos.write().await.remove(url);
        self.index(url).await
    }

    /// The repository listing of the plugin at `source_url` (or with
    /// `plugin_id`), searching the repositories fetched so far.
    async fn find_listing(
        &self,
        source_url: &str,
        plugin_id: &str,
    ) -> Option<(crate::repo::PluginItem, String)> {
        let repos = self.repos.read().await;
        let by_url = repos.values().find_map(|index| {
            index
                .plugins
                .iter()
                .find(|plugin| plugin.url == source_url)
                .map(|plugin| (plugin.clone(), index.url.clone()))
        });
        by_url.or_else(|| {
            repos.values().find_map(|index| {
                index
                    .plugins
                    .iter()
                    .find(|plugin| plugin.id == plugin_id)
                    .map(|plugin| (plugin.clone(), index.url.clone()))
            })
        })
    }

    /// Reads a plugin and prepares the Dion extension for it.
    pub async fn package(&self, location: &str) -> Result<PluginPackage> {
        let code = self.read_location(location).await?;
        let info = read_plugin_info(code.clone())
            .await
            .with_context(|| format!("{location} is not a usable LNReader plugin"))?;
        let listing = self.find_listing(location, &info.id).await;
        let (item, repo_url) = match listing {
            Some((item, repo)) => (Some(item), Some(repo)),
            None => (None, None),
        };
        Ok(PluginPackage {
            info,
            item,
            repo_url,
            source_url: location.to_string(),
            code,
        })
    }
}

#[async_trait]
impl Adapter for LnReaderAdapter {
    async fn get_extensions(&self) -> Result<Vec<Box<dyn Extension>>> {
        self.runtime.get_extensions().await
    }

    async fn install(&self, url: &str) -> Result<Box<dyn Extension>> {
        let package = self.package(url).await?;
        self.runtime
            .install_source(package.extension_source()?)
            .await
            .with_context(|| format!("Failed to install LNReader plugin {}", package.info.id))
    }

    #[allow(clippy::borrowed_box)]
    async fn uninstall(&self, ext: &Box<dyn Extension>) -> Result<()> {
        self.runtime.uninstall(ext).await
    }

    async fn get_repo(&self, url: &str) -> Result<ExtensionRepo> {
        Ok(self.refresh_index(url).await?.to_repo())
    }

    async fn get_remote_extension(
        &self,
        repo: &ExtensionRepo,
        extension_id: String,
    ) -> Result<Option<RemoteExtension>> {
        let index = self.index(&repo.remote_id).await?;
        Ok(index.find(&extension_id).map(|plugin| plugin.to_remote()))
    }

    /// An index lists every plugin, so `page` is ignored and all of them are
    /// returned at once (`hasnext: false`), like the other adapters do.
    /// `get_repo` refreshes the cached index.
    async fn browse_repo(&self, repo: &ExtensionRepo, _page: i32) -> Result<RemoteExtensionResult> {
        Ok(self.index(&repo.remote_id).await?.to_result())
    }
}
