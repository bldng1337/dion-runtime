use std::{
    collections::HashSet,
    path::{Path, PathBuf},
};

use anyhow::{Context, Result, anyhow, bail};
use dion_runtime::{
    client_data::AdapterClient,
    data::{
        extension::{ExtensionData, ExtensionType},
        extension_repo::{ExtensionRepo, RemoteExtensionResult},
        source::MediaType,
    },
    extension::{Adapter, Extension},
};
use log::error;
use semver::{Version, VersionReq};
use tokio::fs::{self, copy, read_dir, remove_file, write};

use crate::{extension::container::DionExtension, network::DionNetworkManager};

#[cfg(feature = "type")]
use specta::Type;

#[derive(serde::Serialize, serde::Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ExtensionMetadata {
    pub id: String,
    pub name: String,
    pub url: String,
    pub icon: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub desc: Option<String>,
    #[serde(default)]
    pub author: Vec<String>,
    #[serde(default)]
    pub tags: Vec<String>,
    #[serde(default)]
    pub lang: Vec<String>,
    pub nsfw: bool,

    pub media_type: HashSet<MediaType>,
    pub extension_type: HashSet<ExtensionType>,

    #[cfg_attr(feature = "type", specta(optional))]
    pub repo: Option<String>,
    pub version: String,
    pub license: String,

    pub api_version: String,
}

impl ExtensionMetadata {
    pub fn into_extension_data(self) -> ExtensionData {
        let compatible: bool = match Version::parse(env!("CARGO_PKG_VERSION")) {
            Ok(version) => match VersionReq::parse(&self.api_version) {
                Ok(req) => req.matches(&version),
                Err(_) => false,
            },
            Err(_) => false,
        };
        ExtensionData {
            id: self.id,
            name: self.name,
            url: self.url,
            icon: self.icon,
            desc: self.desc,
            author: self.author,
            tags: self.tags,
            lang: self.lang,
            nsfw: self.nsfw,
            media_type: self.media_type,
            extension_type: self.extension_type,
            repo: self.repo,
            version: self.version,
            license: self.license,
            compatible,
        }
    }
}

pub struct DionExtensionAdapter {
    pub(crate) network: DionNetworkManager,
    pub(crate) client: Box<dyn AdapterClient>,
}

impl DionExtensionAdapter {
    pub async fn new(client: Box<dyn AdapterClient>) -> Result<Self> {
        let path = client
            .get_path()
            .await
            .context("Failed to get Extension Path")?;
        Ok(DionExtensionAdapter {
            network: DionNetworkManager::new(path.into())?,
            client,
        })
    }
}

fn peek_manifest_string(contents: &str) -> Result<ExtensionData> {
    let first_line = contents
        .lines()
        .next()
        .ok_or_else(|| anyhow!("Extension file is empty"))?;
    let metadata_str = first_line
        .strip_prefix("//")
        .ok_or_else(|| anyhow!("Single File Extensions must start with '//' on the first line"))?;
    let data: ExtensionMetadata = serde_json::from_str(metadata_str)
        .context("Failed to parse ExtensionData from metadata comment")?;

    Ok(data.into_extension_data())
}

async fn peek_manifest(path: impl AsRef<Path>) -> Result<ExtensionData> {
    let contents: String = String::from_utf8(fs::read(path).await?)?;
    peek_manifest_string(&contents)
}

async fn create_extension(
    path: PathBuf,
    manager: &DionExtensionAdapter,
) -> Result<Box<DionExtension>> {
    let res = DionExtension::create(path, manager).await?;
    Ok(Box::new(res))
}

#[async_trait::async_trait()]
impl Adapter for DionExtensionAdapter {
    async fn get_extensions(&self) -> Result<Vec<Box<dyn Extension>>> {
        let path = self
            .client
            .get_path()
            .await
            .context("Failed to get Extension Path")?;
        let path = PathBuf::from(path);
        let mut dir = read_dir(path).await.context("Failed to read directory")?;
        let mut ret: Vec<Box<dyn Extension>> = Vec::new();
        while let Some(file) = dir
            .next_entry()
            .await
            .context("Failed to get next Entry in Directory")?
        {
            if !file
                .file_name()
                .into_string()
                .is_ok_and(|str| str.ends_with(".dion.js"))
            {
                continue;
            }
            let res = create_extension(file.path(), self).await;
            match res {
                Ok(val) => ret.push(val),
                Err(err) => error!("Failed to load extension at {:?}: {:?}", file.path(), err),
            }
        }
        Ok(ret)
    }

    async fn install(&self, url: &str) -> Result<Box<dyn Extension>> {
        let path = self
            .client
            .get_path()
            .await
            .context("Failed to get Extension Path")?;
        let path = PathBuf::from(path);
        match url {
            location if location.starts_with("http://") || location.starts_with("https://") => {
                let res = self.network.nclient.get(location).send().await?;
                let body = res.text().await?;
                let manifest = peek_manifest_string(&body)?;
                let extpath = path.join(format!("{}.dion.js", manifest.id));
                write(extpath.clone(), body).await?;
                let ext = create_extension(extpath.clone(), self).await;
                match ext {
                    Ok(val) => Ok(val),
                    Err(err) => {
                        remove_file(extpath).await.map_err(|fileerr| anyhow!("While removing extension due to error: {err} failed to remove extension due to error {fileerr}"))?;
                        Err(err.context("Failed to load Extension"))
                    }
                }
            }
            location if location.starts_with("file://") => {
                let path = PathBuf::from(
                    location
                        .strip_prefix("file://")
                        .ok_or(anyhow!("Malformed file location: {location}"))?,
                );
                if !path.is_absolute() {
                    bail!(
                        "Malformed file location: {location}, Please only provide absolute file locations"
                    )
                }
                let manifest = peek_manifest(&path).await?;
                let extpath = path.join(format!("{}.dion.js", manifest.id));
                copy(path, &extpath)
                    .await
                    .context("Failed to Copy Extension")?;
                let ext = create_extension(extpath.clone(), self).await;
                match ext {
                    Ok(val) => Ok(val),
                    Err(err) => {
                        remove_file(extpath).await
                        .map_err(|fileerr| anyhow!("While removing extension due to error: {err} failed to remove extension due to error {fileerr}"))?;
                        Err(err.context("Failed to load Extension"))
                    }
                }
            }
            _ => {
                bail!("Unknown protocol: {url}")
            }
        }
    }

    async fn uninstall(&self, ext: &Box<dyn Extension>) -> Result<()> {
        let data = ext.get_data().read().await;
        let id = &data.data.id;
        let path = self
            .client
            .get_path()
            .await
            .context("Failed to get Extension Path")?;
        let path = PathBuf::from(path);
        let extpath = path.join(format!("{}.dion.js", id));
        if let Ok(peek) = peek_manifest(&extpath).await
            && peek.id == *id
        {
            remove_file(extpath).await?;
            return Ok(());
        }
        let mut dir = read_dir(path).await.context("Failed to read directory")?;
        while let Some(file) = dir
            .next_entry()
            .await
            .context("Failed to get next Entry in Directory")?
        {
            if !file
                .file_name()
                .into_string()
                .is_ok_and(|str| str.ends_with(".dion.js"))
            {
                continue;
            }
            let path = file.path();
            let peek = peek_manifest(&path).await;
            if let Ok(peek) = peek
                && peek.id == *id
            {
                remove_file(path).await?;
                return Ok(());
            }
        }
        Err(anyhow!("Couldnt find Extension with id {id}"))
    }

    async fn get_repo(&self, url: &str) -> Result<ExtensionRepo> {
        let res = self.network.nclient.get(url).send().await?;
        Ok(res.json().await?)
    }

    async fn browse_repo(&self, repo: &ExtensionRepo, _page: i32) -> Result<RemoteExtensionResult> {
        let res = self.network.nclient.get(&repo.url).send().await?;
        Ok(res.json().await?)
    }
}
