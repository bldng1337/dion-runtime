use std::path::PathBuf;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, Eq)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Permission {
    Storage {
        path: String,
        #[serde(default)]
        write: bool,
    },
    Network {
        domains: Vec<String>,
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
                // An empty base path would prefix-match everything, so a
                // malformed (host-supplied) grant must match nothing.
                if self_path.is_empty() {
                    return false;
                }
                let self_path = PathBuf::from(self_path);
                let path = PathBuf::from(path);
                path.starts_with(self_path) && (*self_write || self_write == write)
            }
            (
                Permission::Network {
                    domains: self_domain,
                },
                Permission::Network { domains },
            ) => domains.iter().all(|d| self_domain.contains(d)),
            (Permission::ActionPopup, Permission::ActionPopup) => true,
            (Permission::ArbitraryNetwork, Permission::Network { .. }) => true,
            (Permission::ArbitraryNetwork, Permission::ArbitraryNetwork) => true,
            _ => false,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::Permission;

    #[test]
    fn empty_storage_path_matches_nothing() {
        let granted = Permission::Storage {
            path: String::new(),
            write: false,
        };
        let asked = Permission::Storage {
            path: "/data/movie.mp4".into(),
            write: false,
        };
        assert!(!granted.allows(&asked));
    }

    #[test]
    fn storage_prefix_and_write_rules() {
        let granted = Permission::Storage {
            path: "/storage/emulated/0/Download".into(),
            write: false,
        };
        let inside = Permission::Storage {
            path: "/storage/emulated/0/Download/book.epub".into(),
            write: false,
        };
        let write_inside = Permission::Storage {
            path: "/storage/emulated/0/Download/book.epub".into(),
            write: true,
        };
        assert!(granted.allows(&inside));
        assert!(!granted.allows(&write_inside));
    }
}
