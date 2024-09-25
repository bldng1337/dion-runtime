use std::collections::HashMap;

use rquickjs::{Ctx, IntoJs, Value};
use serde::{Deserialize, Serialize};


/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
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
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Entry {
    pub id: String,
    pub url: String,
    pub title: String,
    #[serde(alias = "type")]
    pub media_type: MediaType,

    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    pub cover_header: Option<HashMap<String, String>>,

    pub auther: Option<Vec<String>>,
    pub rating: Option<f32>,
    pub views: Option<f32>,
    pub length: Option<i64>,
}


/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Episode {
    pub id: String,
    pub name: String,
    pub url: String,
    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    pub cover_header: Option<HashMap<String, String>>,
    pub timestamp: Option<String>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct EpisodeList {
    pub title: String,
    pub episodes: Vec<Episode>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub enum ReleaseStatus {
    #[serde(alias = "releasing")]
    Releasing,
    #[serde(alias = "complete")]
    Complete,
    #[serde(alias = "unknown")]
    Unknown,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct EntryDetailed {
    pub id: String,
    pub url: String,
    pub title: String,
    #[serde(alias = "type")]
    pub media_type: MediaType,
    pub status: ReleaseStatus,

    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    pub cover_header: Option<HashMap<String, String>>,
    
    pub episodes: Vec<EpisodeList>,
    pub genres: Option<Vec<String>>,
    pub alttitles: Option<Vec<String>>,
    pub auther: Option<Vec<String>>,
    pub rating: Option<f32>,
    pub views: Option<f32>,
    pub length: Option<i64>,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub enum Sort {
    Popular,
    Latest,
    Updated,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
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
#[derive(Serialize, Deserialize, Debug, Clone)]
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
        header: HashMap<String, String>,
        audio: Vec<ImageListAudio>,
    },
    #[serde(alias = "m3u8")] M3u8 {
        link: String,
        sub: Vec<Subtitles>,
    },
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Subtitles {
    pub title: String,
    pub url: String,
}
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct ImageListAudio {
    pub link: String,
    pub from: i64,
    pub to: i64,
}

/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Clone)]
#[serde(tag = "type")]
pub enum DataSource {
    #[serde(alias = "paragraphlist")] Paragraphlist {
        paragraphs: Vec<String>,
    },
}

/// flutter_rust_bridge:ignore
impl<'js> IntoJs<'js> for Sort {
    /// flutter_rust_bridge:ignore
    fn into_js(self, ctx: &Ctx<'js>) -> rquickjs::Result<Value<'js>> {
        match self {
            Sort::Popular => "popular".into_js(ctx),
            Sort::Latest => "latest".into_js(ctx),
            Sort::Updated => "updated".into_js(ctx),
        }
    }
}