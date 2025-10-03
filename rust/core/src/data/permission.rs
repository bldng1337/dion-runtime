use std::path::PathBuf;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
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
    /// flutter_rust_bridge:ignore
    pub fn allows(&self, permission: &Permission) -> bool {
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
