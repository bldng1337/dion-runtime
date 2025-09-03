use anyhow::{Context, Result};
use async_trait::async_trait;
use core::fmt::Debug;
use serde::{Deserialize, Serialize};
use specta::Type;
use std::{path::PathBuf, sync::Arc};
use tokio::fs;

#[derive(Debug)]
pub struct PermissionRequest {
    pub permission: Permission,
    pub msg: Option<String>,
    pub extensionid: String,
}
#[async_trait]
pub trait PermissionRequester: Debug {
    async fn request(&self, permission: PermissionRequest) -> bool;
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, Type)]
#[serde(tag = "id")]
pub enum Permission {
    Storage {
        path: String,
        #[serde(default)]
        write: bool,
    },
    Network {
        domain: String,
    },
    ActionPopup {},
    ArbitraryNetwork {},
}

#[derive(Debug)]
pub struct PermissionStore {
    savepath: PathBuf,
    requester: Arc<dyn PermissionRequester + Send + Sync>,
    permissions: Vec<Permission>,
}

impl PermissionStore {
    pub async fn new(
        savepath: PathBuf,
        requester: Arc<dyn PermissionRequester + Send + Sync>,
    ) -> Result<Self> {
        let mut store = PermissionStore {
            savepath,
            requester,
            permissions: Default::default(),
        };
        store
            .load()
            .await
            .context("Failed to load permission save file")?;
        Ok(store)
    }

    fn has_permission(tocheck: &Permission, permission: &Permission) -> bool {
        match (tocheck, permission) {
            (
                Permission::Network { domain: tocheck },
                Permission::Network { domain: permission },
            ) => tocheck == permission,
            (
                Permission::Storage {
                    path: tocheckpath,
                    write: tocheckwrite,
                },
                Permission::Storage {
                    path: permissionpath,
                    write: permissionwrite,
                },
            ) => {
                if *tocheckwrite && !*permissionwrite {
                    return false;
                }
                if tocheckpath.len() > permissionpath.len() {
                    return false;
                }
                if !tocheckpath.starts_with(permissionpath) {
                    return false;
                }
                true
            }
            _ => false,
        }
    }

    pub async fn save(&self) -> Result<()> {
        fs::write(
            &self.savepath,
            serde_json::to_string(&self.permissions).context("Failed to serialize Permissions")?,
        )
        .await
        .context("Failed to write Permissions to file")?;
        Ok(())
    }

    pub async fn load(&mut self) -> Result<()> {
        if !fs::try_exists(&self.savepath)
            .await
            .context("Failed to check if permission save exists")?
        {
            return Ok(());
        }
        let str = String::from_utf8(
            fs::read(&self.savepath)
                .await
                .context("Failed to read permission file")?,
        )
        .context("Failed to decode saved permissions from file")?;
        self.permissions = serde_json::from_str(&str).context("Failed to decode permissions")?;
        Ok(())
    }

    pub fn get_permissions(&self) -> &Vec<Permission> {
        &self.permissions
    }

    pub async fn add_permission(&mut self, permission: Permission) -> Result<()> {
        if !self.check_permission(&permission) {
            self.permissions.push(permission);
        }
        self.save().await.context("Failed to save permissions")?;
        Ok(())
    }

    pub async fn remove_permission(&mut self, permission: &Permission) -> Result<()> {
        self.permissions
            .retain(|cpermission: &Permission| !Self::has_permission(permission, cpermission));
        self.save().await.context("Failed to save permissions")?;
        Ok(())
    }

    pub fn check_permission(&self, tocheck: &Permission) -> bool {
        self.permissions
            .iter()
            .any(|permission| Self::has_permission(tocheck, permission))
    }

    pub async fn request_permission(
        &mut self,
        permission: Permission,
        msg: Option<String>,
    ) -> Result<bool> {
        if self.check_permission(&permission) {
            return Ok(true);
        }
        if self
            .requester
            .request(PermissionRequest {
                permission: permission.clone(),
                msg: msg,
                extensionid: "".to_string(),
            })
            .await
        {
            self.add_permission(permission).await?;
            Ok(true)
        } else {
            Ok(false)
        }
    }
    pub fn get_permission_requester(&self) -> Arc<dyn PermissionRequester + Send + Sync> {
        self.requester.clone()
    }
}
