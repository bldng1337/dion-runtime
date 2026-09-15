use std::collections::HashSet;

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::extension::ExtensionType;
use crate::data::permission::Permission;
use crate::data::source::{Link, MediaType};

/// Payload-free listing type mirroring the variants of [`ExtensionType`].
/// Store/browse UIs filter by what an extension does without needing the
/// per-variant configuration (url patterns, source types, ...).
#[derive(Serialize, Deserialize, Debug, Clone, Copy, PartialEq, Eq, Hash)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ExtensionKind {
    EntryProvider,
    SourceProcessor,
    EntryProcessor,
    UrlHandler,
}

impl From<&ExtensionType> for ExtensionKind {
    fn from(value: &ExtensionType) -> Self {
        match value {
            ExtensionType::EntryProvider { .. } => ExtensionKind::EntryProvider,
            ExtensionType::SourceProcessor { .. } => ExtensionKind::SourceProcessor,
            ExtensionType::EntryProcessor { .. } => ExtensionKind::EntryProcessor,
            ExtensionType::URLHandler { .. } => ExtensionKind::UrlHandler,
        }
    }
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:unignore
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct RemoteExtension {
    pub remote_id: String,
    pub id: String,
    pub name: String,
    pub url: String,
    pub cover: Option<Link>,
    pub version: String,
    pub compatible: bool,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub permissions: Option<Vec<Permission>>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub authors: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub lang: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub tags: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub nsfw: bool,
    /// Media the extension deals with. Only entry providers and source
    /// processors declare it; pure entry processors / URL handlers leave it
    /// empty rather than inheriting a misleading default.
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub media_type: HashSet<MediaType>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub extension_kinds: Vec<ExtensionKind>,
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
    pub remote_id: String,
    pub name: String,
    pub description: String,
    pub url: String,
}
