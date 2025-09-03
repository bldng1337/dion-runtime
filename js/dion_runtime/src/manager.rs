use anyhow::Result;
use dion_extension::extension_manager::DionExtensionManager;
use dion_runtime::extension::ExtensionManager;
use napi_derive::napi;

use crate::{client::ClientManagerHandler, error::ErrorConverter, extension::ExtensionProxy};

#[napi(js_name = "ExtensionManager")]
pub struct ExtensionManagerProxy {
  manager: Box<dyn ExtensionManager>,
}

#[napi]
impl ExtensionManagerProxy {
  #[napi(factory)]
  pub async fn init(handler: &ClientManagerHandler) -> Result<Self, napi::Error> {
    let handler = (*handler).clone();
    Ok(Self {
      manager: Box::new(
        DionExtensionManager::new(Box::new(handler))
          .await
          .map_to_node()?,
      ),
    })
  }

  #[napi]
  pub async fn get_extension(&self) -> Result<Vec<ExtensionProxy>, napi::Error> {
    self
      .manager
      .get_extensions()
      .await
      .map(|v| v.into_iter().map(|e| e.into()).collect())
      .map_to_node()
  }
}
