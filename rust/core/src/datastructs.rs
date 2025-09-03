use serde::{Deserialize, Serialize};
#[cfg(feature = "type")]
use specta::Type;
use std::collections::HashMap;

use crate::settings::Setting;

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct RemoteExtension {
    pub extension_url: String,
    pub compatible: bool,
    pub data: ExtensionData,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ExtensionRepo {
    pub name: String,
    pub description: String,
    pub id: String,
    pub extensions: Vec<RemoteExtension>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ExtensionData {
    pub id: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub repo: Option<String>,
    pub name: String,
    #[cfg_attr(feature = "type", specta(optional))]
    #[serde(alias = "mediaType")]
    pub media_type: Option<Vec<MediaType>>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub extension_type: Option<Vec<ExtensionType>>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub version: Option<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub desc: Option<String>,
    #[serde(default)]
    pub author: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub license: Option<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub tags: Option<Vec<String>>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub nsfw: Option<bool>,
    #[serde(default)]
    pub lang: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub url: Option<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub icon: Option<String>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ExtensionType {
    #[serde(alias = "sourceprovider")]
    SourceProvider,
    #[serde(alias = "urlresolve")]
    URLResolve,
    #[serde(alias = "sourceprocessor")]
    SourceProcessor,
    #[serde(alias = "entryextension")]
    EntryExtension,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum MediaType {
    #[serde(alias = "video")]
    Video,
    #[serde(alias = "comic")]
    Comic,
    #[serde(alias = "audio")]
    Audio,
    #[serde(alias = "book")]
    Book,
    #[serde(alias = "unknown")]
    #[default]
    Unknown,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Link {
    pub url: String,
    #[cfg_attr(feature = "type", specta(optional))]
    pub header: Option<HashMap<String, String>>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Entry {
    pub id: String,
    pub url: String,
    pub title: String,
    #[serde(alias = "mediaType")]
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
/// flutter_rust_bridge:json_serializable
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
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EntryDetailedResult {
    pub entry: EntryDetailed,
    pub settings: HashMap<String, Setting>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct SourceResult {
    pub source: Source,
    pub settings: HashMap<String, Setting>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Episode {
    pub id: String,
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
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum ReleaseStatus {
    #[serde(alias = "releasing")]
    Releasing,
    #[serde(alias = "complete")]
    Complete,
    #[serde(alias = "unknown")]
    #[default]
    Unknown,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone, Default)]
#[cfg_attr(feature = "type", derive(Type))]
pub enum TimestampType {
    #[serde(alias = "relative")]
    #[default]
    Relative,
    #[serde(alias = "absolute")]
    Absolute,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum CustomUI {
    Text {
        text: String,
    },
    Image {
        image: Link,
        #[cfg_attr(feature = "type", specta(optional))]
        width: Option<i32>,
        #[cfg_attr(feature = "type", specta(optional))]
        height: Option<i32>,
    },
    Link {
        link: String,
        #[cfg_attr(feature = "type", specta(optional))]
        label: Option<String>,
    },
    TimeStamp {
        timestamp: String,
        #[serde(default)]
        display: TimestampType,
    },
    EntryCard {
        entry: Entry,
    },
    Button {
        label: String,
        #[cfg_attr(feature = "type", specta(optional))]
        on_click: Option<Box<UIAction>>,
    },
    InlineSetting {
        setting_id: String,
        #[cfg_attr(feature = "type", specta(optional))]
        on_commit: Option<Box<UIAction>>,
    },
    Slot {
        id: String,
        child: Box<CustomUI>,
    },
    Column {
        children: Vec<CustomUI>,
    },
    Row {
        children: Vec<CustomUI>,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct PopupAction {
    pub label: String,
    pub onclick: Box<Action>,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Action {
    OpenBrowser {
        url: String,
    },
    Popup {
        title: String,
        content: CustomUI,
        actions: Vec<PopupAction>,
    },
    Nav {
        title: String,
        content: CustomUI,
    },
    TriggerEvent {
        event: String,
        data: String,
    },
    // NavEntry {
    //     entry: EntryDetailed,
    // },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum UIAction {
    Action {
        action: Action,
    },
    SwapContent {
        #[cfg_attr(feature = "type", specta(optional))]
        targetid: Option<String>,
        event: String,
        #[cfg_attr(feature = "type", specta(optional))]
        placeholder: Option<CustomUI>,
    },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Default, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct EntryDetailed {
    pub id: String,
    pub url: String,
    pub titles: Vec<String>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub author: Option<Vec<String>>,

    #[cfg_attr(feature = "type", specta(optional))]
    pub ui: Option<CustomUI>,
    #[cfg_attr(feature = "type", specta(optional))]
    pub meta: Option<HashMap<String, String>>,

    #[serde(alias = "mediaType")]
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
/// flutter_rust_bridge:json_serializable
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
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum Paragraph {
    Text { content: String },
    CustomUI { ui: Box<CustomUI> },
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Mp3Chapter {
    pub title: String,
    pub url: Link,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct Subtitles {
    pub title: String,
    pub url: Link,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
pub struct ImageListAudio {
    pub link: Link,
    pub from: i32,
    pub to: i32,
}

/// flutter_rust_bridge:non_opaque
/// flutter_rust_bridge:json_serializable
#[derive(Serialize, Deserialize, Debug, Clone)]
#[cfg_attr(feature = "type", derive(Type))]
#[serde(tag = "type")]
pub enum EntryActivity {
    EpisodeActivity { progress: i32 },
}
