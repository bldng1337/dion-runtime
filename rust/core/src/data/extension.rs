use std::{collections::HashSet, hash::Hash};

use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;

use crate::data::source::{MediaType, SourceType};

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ExtensionData {
    pub id: String,
    pub name: String,
    pub url: String,
    pub icon: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub desc: Option<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub author: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(default)]
    pub tags: Vec<String>,
    #[serde(default)]
    pub lang: Vec<String>,
    pub nsfw: bool,

    pub media_type: HashSet<MediaType>,
    pub extension_type: HashSet<ExtensionType>,

    #[cfg_attr(feature = "type", specta(optional))]
    pub repo: Option<String>,
    pub version: String,
    pub license: String,
    pub compatible: bool,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone, Hash, PartialEq, Eq)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum SourceOpenType {
    Download,
    #[default]
    Stream,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, PartialEq, Eq)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum ExtensionType {
    EntryProvider {
        has_search: bool,
    },
    EntryDetailedProvider {
        id_types: Vec<String>,
    },
    SourceProvider {
        id_types: Vec<String>,
    },
    SourceProcessor {
        sourcetypes: HashSet<SourceType>,
        opentype: HashSet<SourceOpenType>,
    },
    EntryProcessor {
        trigger_map_entry: bool,
        trigger_on_entry_activity: bool,
    },
    URLHandler {},
}

impl Hash for ExtensionType {
    fn hash<H: std::hash::Hasher>(&self, state: &mut H) {
        core::mem::discriminant(self).hash(state);
    }
}
