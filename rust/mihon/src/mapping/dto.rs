//! Data Transfer Objects for JNI communication
//!
//! These DTOs match the Kotlin DTOs in dion.mihon.dto and are used
//! for JSON serialization between Rust and the JVM.

use dion_runtime::data::source::{
    Entry, EntryDetailed, EntryId, EntryList, Episode, EpisodeId, Link, MediaType, ReleaseStatus,
    Source,
};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

use crate::extension::MihonSourceType;

// ========== Install Result ==========

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct InstallResult {
    #[serde(rename = "jarPath")]
    pub jar_path: String,
    #[serde(rename = "className")]
    pub class_name: String,
    pub metadata: ExtensionMetadataDto,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ExtensionMetadataDto {
    #[serde(rename = "packageName")]
    pub package_name: String,
    #[serde(rename = "versionName")]
    pub version_name: String,
    #[serde(rename = "versionCode")]
    pub version_code: i32,
    pub label: String,
    pub nsfw: bool,
    #[serde(rename = "libVersion", default)]
    pub lib_version: String,
}

// ========== Source Info ==========

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SourceInfo {
    pub id: i64,
    pub name: String,
    pub lang: String,
    #[serde(rename = "baseUrl")]
    pub base_url: Option<String>,
    #[serde(rename = "supportsLatest")]
    pub supports_latest: bool,
    #[serde(rename = "isConfigurable")]
    pub is_configurable: bool,
}

// ========== Manga DTOs ==========

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MangasPageDto {
    pub mangas: Vec<MangaDto>,
    #[serde(rename = "hasNextPage")]
    pub has_next_page: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct MangaDto {
    pub url: String,
    pub title: String,
    #[serde(default)]
    pub artist: Option<String>,
    #[serde(default)]
    pub author: Option<String>,
    #[serde(default)]
    pub description: Option<String>,
    #[serde(default)]
    pub genre: Option<String>,
    #[serde(default)]
    pub status: i32,
    #[serde(rename = "thumbnailUrl", default)]
    pub thumbnail_url: Option<String>,
    #[serde(rename = "thumbnailHeaders", default)]
    pub thumbnail_headers: Option<HashMap<String, String>>,
    #[serde(default)]
    pub initialized: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct ChapterDto {
    pub url: String,
    pub name: String,
    #[serde(rename = "dateUpload", default)]
    pub date_upload: i64,
    #[serde(rename = "chapterNumber", default)]
    pub chapter_number: f32,
    #[serde(default)]
    pub scanlator: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PageDto {
    pub index: i32,
    pub url: String,
    #[serde(rename = "imageUrl", default)]
    pub image_url: Option<String>,
    #[serde(default)]
    pub headers: Option<HashMap<String, String>>,
}

// ========== Filter DTOs ==========

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FilterDto {
    #[serde(rename = "type")]
    pub filter_type: String,
    pub name: String,
    #[serde(default)]
    pub state: String,
}

// ========== Conversions ==========

impl MangasPageDto {
    pub fn into_entry_list(self, source_type: MihonSourceType) -> EntryList {
        let media_type = match source_type {
            MihonSourceType::Manga => MediaType::Comic,
            MihonSourceType::Anime => MediaType::Video,
        };

        EntryList {
            content: self
                .mangas
                .into_iter()
                .map(|m| m.into_entry(media_type.clone()))
                .collect(),
            hasnext: Some(self.has_next_page),
            length: None,
        }
    }
}

impl MangaDto {
    pub fn into_entry(self, media_type: MediaType) -> Entry {
        Entry {
            id: EntryId {
                uid: self.url.clone(),
                iddata: None,
            },
            url: self.url,
            title: self.title,
            media_type,
            cover: self.thumbnail_url.map(|u| Link {
                url: u,
                header: self.thumbnail_headers.clone(),
            }),
            author: self.author.map(|a| vec![a]),
            rating: None,
            views: None,
            length: None,
        }
    }

    pub fn into_entry_detailed(self, chapters: Vec<ChapterDto>) -> EntryDetailed {
        let status = match self.status {
            1 => ReleaseStatus::Releasing,
            2 => ReleaseStatus::Complete,
            _ => ReleaseStatus::Unknown,
        };

        EntryDetailed {
            id: EntryId {
                uid: self.url.clone(),
                iddata: None,
            },
            url: self.url,
            titles: vec![self.title],
            author: self.author.map(|a| vec![a]),
            ui: None,
            meta: None,
            media_type: MediaType::Comic,
            status,
            description: self.description.unwrap_or_default(),
            language: String::new(),
            cover: self.thumbnail_url.map(|u| Link {
                url: u,
                header: self.thumbnail_headers,
            }),
            poster: None,
            episodes: chapters
                .into_iter()
                .enumerate()
                .map(|(i, c)| c.into_episode(i))
                .collect(),
            genres: self
                .genre
                .map(|g| g.split(", ").map(|s| s.to_string()).collect()),
            rating: None,
            views: None,
            length: None,
        }
    }

    pub fn from_entry_id(id: &EntryId) -> Self {
        Self {
            url: id.uid.clone(),
            title: String::new(),
            artist: None,
            author: None,
            description: None,
            genre: None,
            status: 0,
            thumbnail_url: None,
            thumbnail_headers: None,
            initialized: false,
        }
    }
}

impl ChapterDto {
    pub fn into_episode(self, _index: usize) -> Episode {
        Episode {
            id: EpisodeId {
                uid: self.url.clone(),
                iddata: None,
            },
            name: self.name,
            description: self.scanlator,
            url: self.url,
            cover: None,
            timestamp: if self.date_upload > 0 {
                Some(self.date_upload.to_string())
            } else {
                None
            },
        }
    }

    pub fn from_episode_id(id: &EpisodeId) -> Self {
        Self {
            url: id.uid.clone(),
            name: String::new(),
            date_upload: 0,
            chapter_number: 0.0,
            scanlator: None,
        }
    }
}

impl PageDto {
    pub fn into_link(self) -> Link {
        Link {
            url: self.image_url.unwrap_or(self.url),
            header: self.headers,
        }
    }
}

/// Convert a list of pages into a Source
pub fn pages_to_source(pages: Vec<PageDto>) -> Source {
    Source::Imagelist {
        links: pages.into_iter().map(|p| p.into_link()).collect(),
        audio: None,
    }
}

#[cfg(test)]
mod tests {
    use super::{pages_to_source, MangaDto, PageDto};
    use dion_runtime::data::source::{MediaType, Source};
    use std::collections::HashMap;

    #[test]
    fn pages_to_source_propagates_page_headers() {
        let mut headers = HashMap::new();
        headers.insert("Referer".to_string(), "https://example.org/chapter/1".to_string());
        headers.insert("User-Agent".to_string(), "custom-agent".to_string());

        let page = PageDto {
            index: 0,
            url: "https://example.org/page".to_string(),
            image_url: Some("https://cdn.example.org/image.jpg".to_string()),
            headers: Some(headers.clone()),
        };

        let source = pages_to_source(vec![page]);

        match source {
            Source::Imagelist { links, .. } => {
                assert_eq!(links.len(), 1);
                assert_eq!(links[0].url, "https://cdn.example.org/image.jpg");
                assert_eq!(links[0].header.as_ref(), Some(&headers));
            }
            _ => panic!("expected Source::Imagelist"),
        }
    }

    #[test]
    fn pages_to_source_preserves_header_fallback_behavior() {
        let page = PageDto {
            index: 1,
            url: "https://example.org/page/2".to_string(),
            image_url: None,
            headers: None,
        };

        let source = pages_to_source(vec![page]);

        match source {
            Source::Imagelist { links, .. } => {
                assert_eq!(links.len(), 1);
                assert_eq!(links[0].url, "https://example.org/page/2");
                assert!(links[0].header.is_none());
            }
            _ => panic!("expected Source::Imagelist"),
        }
    }

    #[test]
    fn manga_cover_includes_thumbnail_headers() {
        let mut headers = HashMap::new();
        headers.insert("Referer".to_string(), "https://example.org".to_string());

        let manga = MangaDto {
            url: "/manga/slug".to_string(),
            title: "Title".to_string(),
            artist: None,
            author: None,
            description: None,
            genre: None,
            status: 0,
            thumbnail_url: Some("https://cdn.example.org/cover.jpg".to_string()),
            thumbnail_headers: Some(headers.clone()),
            initialized: true,
        };

        let entry = manga.into_entry(MediaType::Comic);
        let cover = entry.cover.expect("cover should be present");
        assert_eq!(cover.header.as_ref(), Some(&headers));
    }

    #[test]
    fn manga_detailed_cover_includes_thumbnail_headers() {
        let mut headers = HashMap::new();
        headers.insert("User-Agent".to_string(), "agent".to_string());

        let manga = MangaDto {
            url: "/manga/slug".to_string(),
            title: "Title".to_string(),
            artist: None,
            author: None,
            description: None,
            genre: None,
            status: 0,
            thumbnail_url: Some("https://cdn.example.org/cover.jpg".to_string()),
            thumbnail_headers: Some(headers.clone()),
            initialized: true,
        };

        let detailed = manga.into_entry_detailed(Vec::new());
        let cover = detailed.cover.expect("cover should be present");
        assert_eq!(cover.header.as_ref(), Some(&headers));
    }
}
