use rquickjs::Object;
use serde::{ Deserialize, Serialize };
use core::fmt::Debug;

use crate::error::Error;

#[derive(Serialize, Deserialize, Debug)]
pub enum Permission {
    StoragePermission {
        path: String,
        write: bool,
    },
}

trait PermissionRequester: Debug {
    fn request(&self, permission: &Permission, msg: Option<String>) -> bool;
}

#[derive(Serialize, Deserialize, Debug, Default)]
pub struct PermissionStore {
    permissions: Vec<Permission>,
    #[serde(skip)]
    requester: Option<Box<dyn PermissionRequester + Send + Sync>>,
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

    pub fn request_permission(
        &mut self,
        permission: Permission,
        msg: Option<String>
    ) -> Result<bool, Error> {
        match &self.requester {
            Some(requester) => {
                if requester.as_ref().request(&permission, msg) {
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
