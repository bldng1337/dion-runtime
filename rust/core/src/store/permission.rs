use anyhow::Result;

use crate::{client_data::ExtensionClient, data::permission::Permission};

#[derive(Debug)]
pub struct PermissionStore {
    permissions: Vec<Permission>,
}

impl PermissionStore {
    pub async fn new(client: &dyn ExtensionClient) -> Self {
        let mut ret = Self {
            permissions: Default::default(),
        };
        let _ = ret.load_data(client).await;
        ret
    }

    async fn load_data(&mut self, client: &dyn ExtensionClient) -> Result<()> {
        self.permissions = serde_json::from_str(&client.load_data_secure("permission").await?)?;
        Ok(())
    }

    pub async fn save_state(&self, client: &dyn ExtensionClient) -> Result<()> {
        client
            .store_data_secure("permission", serde_json::to_string(&self.permissions)?)
            .await
    }

    pub fn has_permission(&self, permission: &Permission) -> bool {
        self.permissions.iter().any(|p| p.allows(permission))
    }

    pub async fn request_permission(
        &mut self,
        client: &dyn ExtensionClient,
        permission: Permission,
        msg: Option<String>,
    ) -> Result<bool> {
        if self.has_permission(&permission) {
            return Ok(true);
        }
        if client.request_permission(&permission, msg).await? {
            self.permissions.push(permission);
            return Ok(true);
        }
        Ok(false)
    }

    pub fn remove_permission(&mut self, permission: Permission) {
        self.permissions = self
            .permissions
            .extract_if(0.., |item| item.allows(&permission))
            .collect()
    }

    pub fn get_permissions(&self) -> &Vec<Permission> {
        &self.permissions
    }
}
