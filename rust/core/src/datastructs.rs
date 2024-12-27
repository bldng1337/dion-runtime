use std::collections::HashMap;
use ts_rs::TS;
use rquickjs::{prelude::Opt, Ctx, IntoJs, Value};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug, Default, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct ExtensionData {
    pub id: String,
    #[ts(optional)]
    pub repo: Option<String>,
    pub name: String,
    #[ts(optional)]
    #[serde(alias = "type")]
    pub media_type: Option<Vec<MediaType>>,
    #[ts(optional)]
    pub giturl: Option<String>,
    #[ts(optional)]
    pub version: Option<String>,
    #[ts(optional)]
    pub desc: Option<String>,
    #[ts(optional)]
    pub author: Option<String>,
    #[ts(optional)]
    pub license: Option<String>,
    #[ts(optional)]
    pub tags: Option<Vec<String>>,
    #[ts(optional)]
    pub nsfw: Option<bool>,
    pub lang: Vec<String>,
    #[ts(optional)]
    pub url: Option<String>,
    #[ts(optional)]
    pub icon: Option<String>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
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
    Unknown,
}


/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct Entry {
    pub id: String,
    pub url: String,
    pub title: String,
    #[serde(alias = "type")]
    pub media_type: MediaType,
    #[ts(optional)]
    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    #[ts(optional)]
    pub cover_header: Option<HashMap<String, String>>,
    #[ts(optional)]
    pub author: Option<Vec<String>>,
    #[ts(optional)]
    pub rating: Option<f32>,
    #[ts(optional)]
    pub views: Option<f32>,
    #[ts(optional)]
    pub length: Option<i32>,
}


/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct Episode {
    pub id: String,
    pub name: String,
    pub url: String,
    #[ts(optional)]
    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    #[ts(optional)]
    pub cover_header: Option<HashMap<String, String>>,
    #[ts(optional)]
    pub timestamp: Option<String>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct EpisodeList {
    pub title: String,
    pub episodes: Vec<Episode>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub enum ReleaseStatus {
    #[serde(alias = "releasing")]
    Releasing,
    #[serde(alias = "complete")]
    Complete,
    #[serde(alias = "unknown")]
    Unknown,
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS,Default)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub enum TimestampType{
    #[default]
    Relative,
    Absolute
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "type")]
pub enum CustomUI{
    Text {
        text:String
    },
    Image {
        image:String,
        #[ts(optional)]
        header:Option<HashMap<String, String>>
    },
    Link {
        link:String,
        #[ts(optional)]
        label:Option<String>
    },
    TimeStamp {
        timestamp:String,
        #[serde(default)]
        display: TimestampType,
    },
    EntryCard {
        entry:Entry
    },
    Column {
        children:Vec<CustomUI>
    },
    Row {
        children:Vec<CustomUI>
    }
}
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct MetaData {
    key:String,
    value:serde_json::Value,
}

#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct EntryDetailed {
    pub id: String,
    pub url: String,
    pub title: String,
    #[ts(optional)]
    pub author: Option<Vec<String>>,

    #[ts(optional)]
    pub ui: Option<CustomUI>,
    #[ts(optional)]
    pub meta: Option<Vec<MetaData>>,

    #[serde(alias = "type")]
    pub media_type: MediaType,
    pub status: ReleaseStatus,
    pub description: String,
    pub language: String,

    #[ts(optional)]
    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    #[ts(optional)]
    pub cover_header: Option<HashMap<String, String>>,
    
    pub episodes: Vec<EpisodeList>,
    #[ts(optional)]
    pub genres: Option<Vec<String>>,
    #[ts(optional)]
    pub alttitles: Option<Vec<String>>,
    #[ts(optional)]
    pub rating: Option<f32>,
    #[ts(optional)]
    pub views: Option<f32>,
    #[ts(optional)]
    pub length: Option<i32>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub enum Sort {
    Popular,
    Latest,
    Updated,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "sourcetype")]
pub enum Source {
    #[serde(alias = "data")] Data {
        sourcedata: DataSource,
    },
    #[serde(alias = "directlink")] Directlink {
        sourcedata: LinkSource,
    },
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "type")]
pub enum LinkSource {
    #[serde(alias = "epub")] Epub {
        link: String,
    },
    #[serde(alias = "pdf")] Pdf {
        link: String,
    },
    #[serde(alias = "imagelist")] Imagelist {
        links: Vec<String>,
        #[ts(optional)]
        header: Option<HashMap<String, String>>,
        #[ts(optional)]
        audio: Option<Vec<ImageListAudio>>,
    },
    #[serde(alias = "m3u8")] M3u8 {
        link: String,
        sub: Vec<Subtitles>,
    },
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct Subtitles {
    pub title: String,
    pub url: String,
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
pub struct ImageListAudio {
    pub link: String,
    pub from: i32,
    pub to: i32,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone,TS)]
#[ts(export, export_to = "RuntimeTypes.ts")]
#[serde(tag = "type")]
pub enum DataSource {
    #[serde(alias = "paragraphlist")] Paragraphlist {
        paragraphs: Vec<String>,
    },
}


impl<'js> IntoJs<'js> for Sort {
    
    fn into_js(self, ctx: &Ctx<'js>) -> rquickjs::Result<Value<'js>> {
        match self {
            Sort::Popular => "popular".into_js(ctx),
            Sort::Latest => "latest".into_js(ctx),
            Sort::Updated => "updated".into_js(ctx),
        }
    }
}