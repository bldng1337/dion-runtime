use crate::error::Error;
use core::fmt::Debug;
use serde::{Deserialize, Serialize};
use std::{path::PathBuf, sync::LazyLock};
use tokio::{fs, sync::RwLock};
use ts_rs::TS;
//TODO: Rework this 4am mess
/// flutter_rust_bridge:ignore
#[derive(Debug, Default)]
pub struct PermissionSingelton {
    pub requester: Option<Box<dyn PermissionRequester + Send + Sync>>,
}
/// flutter_rust_bridge:ignore
pub static PERMISSION: LazyLock<RwLock<PermissionSingelton>> =
    LazyLock::new(|| RwLock::new(PermissionSingelton::default()));
/// flutter_rust_bridge:non_opaque
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
/// flutter_rust_bridge:ignore
#[async_trait::async_trait]
pub trait PermissionRequester: Debug {
    async fn request(&self, permission: &Permission, msg: Option<String>) -> bool;
}
/// flutter_rust_bridge:opaque
#[derive(Serialize, Deserialize, Debug)]
pub struct PermissionStore {
    savepath: PathBuf,
    permissions: Vec<Permission>,
}

impl PermissionStore {
    pub async fn new(savepath: PathBuf) -> Result<Self, Error> {
        let mut store = PermissionStore {
            savepath: savepath,
            permissions: Default::default(),
        };
        store.load().await?;
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

    pub async fn save(&self) -> Result<(), Error> {
        fs::write(&self.savepath, serde_json::to_string(&self.permissions)?).await?;
        Ok(())
    }

    pub async fn load(&mut self) -> Result<(), Error> {
        if !fs::try_exists(&self.savepath).await? {
            return Ok(());
        }
        let str = String::from_utf8(fs::read(&self.savepath).await?)?;
        self.permissions = serde_json::from_str(&str)?;
        Ok(())
    }

    pub fn get_permissions(&self) -> std::slice::Iter<'_, Permission> {
        self.permissions.iter()
    }

    pub fn add_permission(&mut self, permission: Permission) {
        if !self.check_permission(&permission) {
            self.permissions.push(permission);
        }
        //TODO Save state
    }

    pub fn remove_permission(&mut self, permission: &Permission) {
        self.permissions
            .retain(|cpermission: &Permission| !Self::has_permission(permission, cpermission));
        //TODO Save state
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
    ) -> Result<bool, Error> {
        match &PERMISSION.read().await.requester {
            Some(requester) => {
                if requester.as_ref().request(&permission, msg).await {
                    self.add_permission(permission);
                    return Ok(true);
                }
                Ok(false)
            }
            None => Err(Error::ExtensionError(
                "Runtime hasnt registered an ExtensionHandler".to_string(),
            )),
        }
    }
}
