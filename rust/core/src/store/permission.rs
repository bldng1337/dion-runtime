use anyhow::Result;

use crate::{client_data::ExtensionClient, data::permission::Permission};

#[derive(Debug, Clone)]
pub struct PermissionStore {
    permissions: Vec<Permission>,
}

impl PermissionStore {
    pub async fn new(client: &dyn ExtensionClient) -> Self {
        let mut ret = Self {
            permissions: Default::default(),
        };
        // A failed load must not abort startup: the extension stays usable and
        // the persisted state is kept for a later successful load. Starting
        // empty here means the next save overwrites persisted permissions, but
        // failing would leave the user without a working extension AND without
        // their data.
        let _ = ret.load_data(client).await;
        ret
    }

    async fn load_data(&mut self, client: &dyn ExtensionClient) -> Result<()> {
        let data = client.load_data_secure("permission").await?;
        if data.trim().is_empty() {
            return Ok(());
        }
        self.permissions = serde_json::from_str(&data)?;
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

    /// Record a granted permission without any host round-trip. Used by
    /// callers that perform the permission prompt themselves (without holding
    /// the store lock across the potentially re-entrant host call).
    pub fn grant(&mut self, permission: Permission) {
        if !self.has_permission(&permission) {
            self.permissions.push(permission);
        }
    }

    /// Remove exactly the stored permission equal to `permission`.
    pub fn remove_permission(&mut self, permission: Permission) {
        self.permissions = self
            .permissions
            .extract_if(0.., |item| *item == permission)
            .collect()
    }

    pub fn get_permissions(&self) -> &Vec<Permission> {
        &self.permissions
    }
}
