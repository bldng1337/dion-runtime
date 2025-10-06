use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ExtensionManagerData {
    pub name: String,
    pub icon: Option<String>,
    pub repo: Option<String>,
    pub api_version: u32,
}
