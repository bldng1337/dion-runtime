use rquickjs::Object;
use serde::{ Deserialize, Serialize };
use tokio::sync::RwLock;
use core::fmt::Debug;
use std::sync::LazyLock;

use crate::error::Error;
//TODO: Rework this 4am mess
/// flutter_rust_bridge:ignore
#[derive(Debug, Default)]
pub struct PermissionSingelton {
    pub requester: Option<Box<dyn PermissionRequester + Send + Sync>>,
}
/// flutter_rust_bridge:ignore
pub static PERMISSION: LazyLock<RwLock<PermissionSingelton>> = LazyLock::new(||
    RwLock::new(PermissionSingelton::default())
);
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug,Clone)]
#[serde(tag = "id")]
pub enum Permission {
    #[serde(alias = "storage")] StoragePermission {
        path: String,
        #[serde(default)]
        write: bool,
    }
}

impl std::fmt::Display for Permission {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Permission::StoragePermission { path, write } =>
                write!(f, "StoragePermission(path:{}, write:{})", path, write),
        }
    }
}
/// flutter_rust_bridge:ignore
#[async_trait::async_trait]
pub trait PermissionRequester: Debug {
    async fn request(&self, permission: &Permission, msg: Option<String>) -> bool;
}
/// flutter_rust_bridge:opaque
#[derive(Serialize, Deserialize, Debug, Default)]
pub struct PermissionStore {
    permissions: Vec<Permission>,
}

impl PermissionStore {

    fn has_permission(tocheck: &Permission, permission: &Permission) -> bool {
        match (tocheck, permission) {
            (
                Permission::StoragePermission { path: tocheckpath, write: tocheckwrite },
                Permission::StoragePermission { path: permissionpath, write: permissionwrite },
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

    pub fn get_permissions(&self)->std::slice::Iter<'_, Permission>{
        self.permissions.iter()
    }

    pub fn add_permission(&mut self, permission: Permission) {
        if !self.check_permission(&permission) {
            self.permissions.push(permission);
        }
        //TODO Save state
    }

    pub fn remove_permission(&mut self, permission: &Permission) {
        self.permissions.retain(
            |cpermission: &Permission| !Self::has_permission(permission, cpermission)
        );
        //TODO Save state
    }

    pub fn check_permission(&self, tocheck: &Permission) -> bool {
        self.permissions.iter().any(|permission| Self::has_permission(tocheck, permission))
    }

    pub async fn request_permission(
        &mut self,
        permission: Permission,
        msg: Option<String>
    ) -> Result<bool, Error> {
        match &PERMISSION.read().await.requester {
            Some(requester) => {
                if requester.as_ref().request(&permission, msg).await {
                    self.add_permission(permission);
                    return Ok(true);
                }
                Ok(false)
            }
            None =>
                Err(
                    Error::ExtensionError(
                        "Runtime hasnt registered an ExtensionHandler".to_string()
                    )
                ),
        }
    }

    pub fn get_permission(permission: Object) -> Result<Permission, Error> {
        if !permission.contains_key("method")? || !permission.contains_key("args")? {
            return Err(Error::ExtensionError("Malformed Permission".to_string()));
        }
        let args = permission.get::<_, Object>("args")?;
        Ok(match permission.get::<_, String>("method")?.as_str() {
            "storage" =>
                Permission::StoragePermission {
                    path: args.get("path")?,
                    write: if args.contains_key("write")? {
                        args.get("write")?
                    } else {
                        false
                    },
                },
            _str => {
                return Err(Error::ExtensionError(format!("Unknown Permission type {}", _str)));
            }
        })
    }
}
