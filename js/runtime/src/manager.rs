use anyhow::Result;
use dion_extension::extension_manager::DionExtensionAdapter;
use dion_runtime::{
  data::extension_repo::{ExtensionRepo, RemoteExtensionResult},
  extension::Adapter,
};
use napi_derive::napi;
use serde_json;

use crate::{client::ClientManagerHandler, error::ErrorConverter, extension::ExtensionProxy};

#[napi(js_name = "Adapter")]
pub struct AdapterProxy {
  manager: Box<dyn Adapter>,
}

#[napi]
impl AdapterProxy {
  #[napi(factory)]
  pub async fn init(handler: &ClientManagerHandler) -> Result<Self, napi::Error> {
    let handler = (*handler).clone();
    Ok(Self {
      manager: Box::new(
        DionExtensionAdapter::new(Box::new(handler))
          .await
          .map_to_node()?,
      ),
    })
  }

  #[napi]
  pub async fn get_extensions(&self) -> Result<Vec<ExtensionProxy>, napi::Error> {
    self
      .manager
      .get_extensions()
      .await
      .map(|v| v.into_iter().map(|e| e.into()).collect())
      .map_to_node()
  }

  #[napi]
  pub async fn install(&self, url: String) -> Result<ExtensionProxy, napi::Error> {
    self
      .manager
      .install(&url)
      .await
      .map(|e| e.into())
      .map_to_node()
  }

  #[napi]
  pub async fn uninstall(&self, ext: &ExtensionProxy) -> Result<(), napi::Error> {
    self.manager.uninstall(&ext.extension).await.map_to_node()
  }

  #[napi(ts_return_type = "Promise<ExtensionRepo>")]
  pub async fn get_repo(&self, url: String) -> Result<serde_json::Value, napi::Error> {
    let repo = self.manager.get_repo(&url).await.map_to_node()?;
    serde_json::to_value(repo).map_to_node()
  }

  #[napi(
    ts_args_type = "repo: ExtensionRepo, page: number",
    ts_return_type = "Promise<RemoteExtensionResult>"
  )]
  pub async fn browse_repo(
    &self,
    repo: serde_json::Value,
    page: i32,
  ) -> Result<serde_json::Value, napi::Error> {
    let repo: ExtensionRepo = serde_json::from_value(repo).map_to_node()?;
    let res: RemoteExtensionResult = self.manager.browse_repo(&repo, page).await.map_to_node()?;
    serde_json::to_value(res).map_to_node()
  }
}
