use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::source::Link;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct RemoteExtension {
    pub id: String,
    pub exturl: String,
    pub name: String,
    pub cover: Option<Link>,
    pub version: String,
    pub compatible: bool,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct RemoteExtensionResult {
    pub content: Vec<RemoteExtension>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub hasnext: Option<bool>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub length: Option<i32>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ExtensionRepo {
    pub name: String,
    pub description: String,
    pub url: String,
    pub id: String,
}
