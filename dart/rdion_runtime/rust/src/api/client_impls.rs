use core::fmt;
use std::fmt::Debug;

use anyhow::Result;
use dion_runtime::client_data::{AdapterClient, ExtensionClientExtensionClient};
use dion_runtime::datastructs::{Action, ExtensionData};
use dion_runtime::permission::Permission;

use crate::api::client::{ExtensionClient, ManagerClient};

// #[frb(ignore)]
impl Clone for ExtensionClient {
    fn clone(&self) -> Self {
        Self {
            cload_data: self.cload_data.clone(),
            cstore_data: self.cstore_data.clone(),
            cdo_action: self.cdo_action.clone(),
            crequest_permission: self.crequest_permission.clone(),
            cget_path: self.cget_path.clone(),
        }
    }
}

#[async_trait::async_trait]
impl ExtensionClientExtensionClient for ExtensionClient {
    // #[frb(ignore)]
    async fn load_data(&self, key: &str) -> Result<String> {
        let res = (self.cload_data.as_ref())(key.to_string()).await;
        Ok(res)
    }

    // #[frb(ignore)]
    async fn store_data(&self, key: &str, data: String) -> Result<()> {
        (self.cstore_data.as_ref())(key.to_string(), data).await;
        Ok(())
    }
    // #[frb(ignore)]
    async fn do_action(&self, action: &Action) -> Result<()> {
        (self.cdo_action.as_ref())(action.clone()).await;
        Ok(())
    }
    // #[frb(ignore)]
    async fn request_permission(
        &self,
        permission: &Permission,
        msg: Option<String>,
    ) -> Result<bool> {
        let res = (self.crequest_permission.as_ref())(permission.clone(), msg).await;
        Ok(res)
    }
    // #[frb(ignore)]
    async fn get_path(&self) -> Result<String> {
        let res = (self.cget_path.as_ref())().await;
        Ok(res)
    }
}

// #[frb(ignore)]
impl Debug for ExtensionClient {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("ExtensionClient").finish()
    }
}

// #[frb(ignore)]
impl Clone for ManagerClient {
    fn clone(&self) -> Self {
        Self {
            cget_path: self.cget_path.clone(),
            cget_client: self.cget_client.clone(),
        }
    }
}

#[async_trait::async_trait]
// #[frb(ignore)]
impl AdapterClient for ManagerClient {
    // #[frb(ignore)]
    async fn get_client(
        &self,
        extension: ExtensionData,
    ) -> Result<Box<dyn ExtensionClientExtensionClient>> {
        let res = self.cget_client.as_ref()(extension).await;
        Ok(Box::new(res))
    }

    // #[frb(ignore)]
    async fn get_path(&self) -> Result<String> {
        let res = self.cget_path.as_ref()().await;
        Ok(res)
    }
}
