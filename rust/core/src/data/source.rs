use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;
use std::collections::HashMap;

use crate::data::{custom_ui::CustomUI, settings::Setting};

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Default, Clone, PartialEq, Eq, Hash)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum MediaType {
    Video,
    Comic,
    Audio,
    Book,
    #[default]
    Unknown,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Link {
    pub url: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub header: Option<HashMap<String, String>>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Entry {
    pub id: Vec<EntryId>,
    pub url: String,
    pub title: String,
    pub media_type: MediaType,
    #[cfg_attr(feature = "type", specta(optional))]
    pub cover: Option<Link>,

    #[cfg_attr(feature = "type", specta(optional))]
    pub author: Option<Vec<String>>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub rating: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub views: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub length: Option<i32>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EntryList {
    #[cfg_attr(feature = "type", specta(optional))]
    pub hasnext: Option<bool>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub length: Option<i32>,
    pub content: Vec<Entry>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EntryDetailedResult {
    pub entry: EntryDetailed,
    pub settings: HashMap<String, Setting>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct SourceResult {
    pub source: Source,
    pub settings: HashMap<String, Setting>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Episode {
    pub id: Vec<EpisodeId>,
    pub name: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub description: Option<String>,
    pub url: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub cover: Option<Link>,

    #[cfg_attr(feature = "type", specta(optional))]
    pub timestamp: Option<String>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ReleaseStatus {
    Releasing,
    Complete,
    #[default]
    Unknown,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EntryDetailed {
    pub id: Vec<EntryId>,
    pub url: String,
    pub titles: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub author: Option<Vec<String>>,

    #[cfg_attr(feature = "type", specta(optional))]
    pub ui: Option<CustomUI>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub meta: Option<HashMap<String, String>>,

    pub media_type: MediaType,
    pub status: ReleaseStatus,
    pub description: String,
    pub language: String,

    #[cfg_attr(feature = "type", specta(optional))]
    pub cover: Option<Link>,

    pub episodes: Vec<Episode>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub genres: Option<Vec<String>>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub rating: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub views: Option<f32>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub length: Option<i32>,
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone, Hash, PartialEq, Eq)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum SourceType {
    Epub,
    Pdf,
    Imagelist,
    M3u8,
    Mp3,
    Paragraphlist,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Source {
    Epub {
        link: Link,
    },
    Pdf {
        link: Link,
    },
    Imagelist {
        links: Vec<Link>,
        #[cfg_attr(feature = "type", specta(optional))]
        audio: Option<Vec<ImageListAudio>>,
    },
    M3u8 {
        link: Link,
        sub: Vec<Subtitles>,
    },
    Mp3 {
        chapters: Vec<Mp3Chapter>,
    },
    Paragraphlist {
        paragraphs: Vec<Paragraph>,
    },
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Paragraph {
    Text { content: String },
    CustomUI { ui: Box<CustomUI> },
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Mp3Chapter {
    pub title: String,
    pub url: Link,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Subtitles {
    pub title: String,
    pub url: Link,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ImageListAudio {
    pub link: Link,
    pub from: i32,
    pub to: i32,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EpisodeId {
    pub uid: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub iddata: Option<String>,
    #[serde(rename = "type")]
    pub id_type: String,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EntryId {
    pub uid: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub iddata: Option<String>,
    #[serde(rename = "type")]
    pub id_type: String,
}
