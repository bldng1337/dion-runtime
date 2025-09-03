use std::path::PathBuf;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::client_data::ClientExtensionData;
use anyhow::Result;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Permission {
    Storage {
        path: String,
        #[serde(default)]
        write: bool,
    },
    Network {
        domain: String,
    },
    ActionPopup,
    ArbitraryNetwork,
}

impl Permission {
    fn allows(&self, permission: &Permission) -> bool {
        match (self, permission) {
            (
                Permission::Storage {
                    path: self_path,
                    write: self_write,
                },
                Permission::Storage { path, write },
            ) => {
                let self_path = PathBuf::from(self_path);
                let path = PathBuf::from(path);
                path.starts_with(self_path) && (*self_write || self_write == write)
            }
            (
                Permission::Network {
                    domain: self_domain,
                },
                Permission::Network { domain },
            ) => self_domain == domain,
            (Permission::ActionPopup, Permission::ActionPopup) => true,
            (Permission::ArbitraryNetwork, Permission::ArbitraryNetwork) => true,
            _ => false,
        }
    }
}

/// flutter_rust_bridge:ignore
#[derive(Debug)]
pub struct PermissionStore {
    permissions: Vec<Permission>,
}

impl PermissionStore {
    pub async fn new(client: &dyn ClientExtensionData) -> Self {
        let mut ret = Self {
            permissions: Default::default(),
        };
        let _ = ret.load_data(client).await;
        ret
    }

    async fn load_data(&mut self, client: &dyn ClientExtensionData) -> Result<()> {
        self.permissions = serde_json::from_str(&client.load_data("permission").await?)?;
        Ok(())
    }

    pub async fn save_data(&self, client: &dyn ClientExtensionData) -> Result<()> {
        client
            .store_data("permission", serde_json::to_string(&self.permissions)?)
            .await
    }

    pub fn has_permission(&self, permission: &Permission) -> bool {
        self.permissions.iter().any(|p| p.allows(permission))
    }

    pub async fn request_permission(
        &mut self,
        client: &dyn ClientExtensionData,
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
