use anyhow::{anyhow, Context, Result};
use core::fmt::Debug;
use serde::{Deserialize, Serialize};
use std::{future::Future, path::PathBuf, sync::LazyLock};
use tokio::{fs, sync::RwLock};
use ts_rs::TS;

#[derive(Debug, Default)]
pub struct PermissionSingelton {
    pub requester: Option<Box<dyn PermissionRequester + Send + Sync>>,
}

pub static PERMISSION: LazyLock<RwLock<PermissionSingelton>> =
    LazyLock::new(|| RwLock::new(PermissionSingelton::default()));

pub async fn set_permission_request(
    requester: Box<impl PermissionRequester + Send + Sync + 'static>,
) {
    PERMISSION.write().await.requester = Some(requester);
}
#[async_trait::async_trait]
pub trait PermissionRequester: Debug {
    async fn request(&self, permission: &Permission, msg: Option<String>) -> bool;
}

// #[derive(Debug, Default)]
// pub struct PermissionCallback {
//     inner: Box<
//         dyn (Fn(Permission, Option<String>) -> dyn Future<Output = bool>) + Send + Sync + 'static,
//     >,
// }
// impl PermissionCallback {
//     pub fn wrap(
//         fnc: Box<
//             dyn (Fn(Permission, Option<String>) -> dyn Future<Output = bool>)
//                 + Send
//                 + Sync
//                 + 'static,
//         >,
//     ) -> Self {
//         PermissionCallback { inner: fnc }
//     }
// }
// #[async_trait::async_trait]
// impl PermissionRequester for PermissionCallback {
//     async fn request(&self, permission: &Permission, msg: Option<String>) -> bool {
//         (self.inner)(permission.clone(), msg).await
//     }
// }

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "id")]
pub enum Permission {
    #[serde(alias = "storage")]
    StoragePermission {
        path: String,
        #[serde(default)]
        write: bool,
    },
}

impl std::fmt::Display for Permission {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Permission::StoragePermission { path, write } => {
                write!(f, "StoragePermission(path:{}, write:{})", path, write)
            }
        }
    }
}

#[derive(Serialize, Deserialize, Debug)]
pub struct PermissionStore {
    savepath: PathBuf,
    permissions: Vec<Permission>,
}

impl PermissionStore {
    pub async fn new(savepath: PathBuf) -> Result<Self> {
        let mut store = PermissionStore {
            savepath: savepath,
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
                Permission::StoragePermission {
                    path: tocheckpath,
                    write: tocheckwrite,
                },
                Permission::StoragePermission {
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

    pub fn get_permissions(&self) -> std::slice::Iter<'_, Permission> {
        self.permissions.iter()
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
        match &PERMISSION.read().await.requester {
            Some(requester) => {
                if requester.as_ref().request(&permission, msg).await {
                    self.add_permission(permission).await?;
                    return Ok(true);
                }
                Ok(false)
            }
            None => Err(anyhow!("Runtime hasnt registered an ExtensionHandler",)),
        }
    }
}
