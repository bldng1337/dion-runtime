//! Data Transfer Objects for JNI communication
//!
//! These DTOs match the Kotlin DTOs in dion.mihon.dto and are used
//! for JSON serialization between Rust and the JVM.

use dion_runtime::data::source::{
    Entry, EntryDetailed, EntryId, EntryList, Episode, EpisodeId, Link, MediaType, ReleaseStatus,
    Source, StreamSource, Subtitles,
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
    /// Absolute path to the extracted extension icon file, if one was found.
    /// Used by the adapter to build a `file://` icon URL that the host image
    /// loader can resolve (the legacy `mihon://icon/{id}` placeholder is kept
    /// as a fallback when no icon could be extracted).
    #[serde(rename = "iconPath", default)]
    pub icon_path: Option<String>,
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

// ========== Anime DTOs ==========

/// DTO for an anime episode. Mirrors the Kotlin `EpisodeDto` in `dion.mihon.dto`
/// (which itself mirrors `SEpisode`). Structurally identical to [ChapterDto]
/// except for the `episode_number` field name, so it serializes to/from the
/// same JSON shape.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct EpisodeDto {
    pub url: String,
    pub name: String,
    #[serde(rename = "dateUpload", default)]
    pub date_upload: i64,
    #[serde(rename = "episodeNumber", default)]
    pub episode_number: f32,
    #[serde(default)]
    pub scanlator: Option<String>,
}

/// Wrapper for the JSON payload returned by `MihonBridge.getEpisodeList`.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EpisodeListResult {
    pub episodes: Vec<EpisodeDto>,
}

/// DTO for a video stream returned by `MihonBridge.getVideoList`.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct VideoDto {
    pub url: String,
    #[serde(default)]
    pub quality: Option<String>,
    #[serde(rename = "videoUrl", default)]
    pub video_url: Option<String>,
    #[serde(default)]
    pub headers: Option<HashMap<String, String>>,
    /// Soft subtitle tracks attached to this video by the source.
    ///
    /// Aniyomi extractors attach a [Track] list per [Video]; we surface it
    /// here as [SubtitleTrackDto]s so the player can offer them as external
    /// subtitle tracks. Older sources that never set the field deserialize
    /// to `None`.
    #[serde(rename = "subtitleTracks", default)]
    pub subtitle_tracks: Option<Vec<SubtitleTrackDto>>,
}

/// DTO for a single soft subtitle track.
///
/// Mirrors the Kotlin `SubtitleTrackDto` in `dion.mihon.dto`, which itself is
/// a serializable view of Aniyomi's `eu.kanade.tachiyomi.animesource.model.Track`.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct SubtitleTrackDto {
    pub url: String,
    #[serde(default)]
    pub lang: String,
}

/// Wrapper for the JSON payload returned by `MihonBridge.getVideoList`.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VideoListResult {
    pub videos: Vec<VideoDto>,
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

    pub fn into_entry_detailed(
        self,
        chapters: Vec<ChapterDto>,
        media_type: MediaType,
    ) -> EntryDetailed {
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
            media_type,
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

// ========== Anime Conversions ==========

impl EpisodeDto {
    /// Convert an [EpisodeDto] (from `MihonBridge.getEpisodeList`) into a
    /// dion [Episode]. Behaves identically to [ChapterDto::into_episode] but
    /// operates on the anime episode payload.
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

    /// Reconstruct a minimal [EpisodeDto] from an [EpisodeId] for the
    /// `MihonBridge.getVideoList` round-trip. Only `url` is meaningful.
    pub fn from_episode_id(id: &EpisodeId) -> Self {
        Self {
            url: id.uid.clone(),
            name: String::new(),
            date_upload: 0,
            episode_number: 0.0,
            scanlator: None,
        }
    }
}

impl VideoDto {
    /// Convert a [VideoDto] into a [StreamSource] for the dion runtime.
    ///
    /// `video_url` (the resolved, directly playable stream URL) is preferred
    /// when present; otherwise we fall back to `url` (the page/embed URL).
    /// The `quality` label becomes the stream name, which the player surfaces
    /// to the user when picking a source. Any HTTP headers attached to the
    /// video (e.g. `Referer`, custom `User-Agent`) are propagated onto the
    /// [Link] so the player can fetch the stream successfully.
    pub fn into_stream_source(self) -> StreamSource {
        StreamSource {
            name: self.quality.unwrap_or_else(|| "Default".to_string()),
            lang: String::new(),
            url: Link {
                url: self.video_url.unwrap_or(self.url),
                header: self.headers,
            },
        }
    }
}

/// Convert a list of videos into a [Source::Video], collecting soft subtitle
/// tracks across all videos.
///
/// Anime sources map naturally onto dion's [Source::Video] variant: each
/// [VideoDto] becomes one [StreamSource] (e.g. one quality/server). Aniyomi
/// extractors attach their [Track]s per video, but dion models subtitles at
/// the [Source::Video] level, so we flatten them into a single `sub` list.
///
/// Many extractors attach the same subtitle set to every quality/server in
/// the list, so tracks are deduplicated by URL to avoid presenting the player
/// with duplicate entries. Each subtitle's [Link] inherits the headers of the
/// video it came from, since subtitle files are usually served from the same
/// origin and need the same `Referer` / `User-Agent`.
pub fn videos_to_source(videos: Vec<VideoDto>) -> Source {
    // Collect subtitle tracks across all videos, deduping by URL. dion's
    // `Source::Video` keeps subtitles at the source level rather than
    // per-stream, and Aniyomi extractors commonly attach the same set to
    // every video, so deduping avoids surfacing duplicate tracks.
    let mut seen_sub_urls = std::collections::HashSet::new();
    let mut subs: Vec<Subtitles> = Vec::new();
    for video in &videos {
        let Some(tracks) = video.subtitle_tracks.as_ref() else {
            continue;
        };
        for track in tracks {
            if !seen_sub_urls.insert(track.url.clone()) {
                continue;
            }
            subs.push(Subtitles {
                // Aniyomi's `Track.lang` is a human-readable label (e.g.
                // "English"), which maps best to the display title. We don't
                // have an ISO code to populate `lang` with.
                title: if track.lang.is_empty() {
                    "Subtitle".to_string()
                } else {
                    track.lang.clone()
                },
                lang: String::new(),
                url: Link {
                    url: track.url.clone(),
                    // Subtitle files typically share the origin/CDN of the
                    // video, so forward the same headers used to fetch it.
                    header: video.headers.clone(),
                },
            });
        }
    }

    Source::Video {
        sources: videos.into_iter().map(|v| v.into_stream_source()).collect(),
        sub: subs,
    }
}

#[cfg(test)]
mod tests {
    use super::{pages_to_source, videos_to_source, MangaDto, PageDto, SubtitleTrackDto, VideoDto};
    use dion_runtime::data::source::{MediaType, Source};
    use std::collections::HashMap;

    #[test]
    fn pages_to_source_propagates_page_headers() {
        let mut headers = HashMap::new();
        headers.insert(
            "Referer".to_string(),
            "https://example.org/chapter/1".to_string(),
        );
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

        let detailed = manga.into_entry_detailed(Vec::new(), MediaType::Comic);
        let cover = detailed.cover.expect("cover should be present");
        assert_eq!(cover.header.as_ref(), Some(&headers));
    }

    fn video_with_subs(url: &str, subs: Vec<(&str, &str)>) -> VideoDto {
        VideoDto {
            url: url.to_string(),
            quality: Some("1080p".to_string()),
            video_url: Some(url.to_string()),
            headers: None,
            subtitle_tracks: Some(
                subs.into_iter()
                    .map(|(u, l)| SubtitleTrackDto {
                        url: u.to_string(),
                        lang: l.to_string(),
                    })
                    .collect(),
            ),
        }
    }

    #[test]
    fn videos_to_source_collects_subtitle_tracks() {
        let videos = vec![
            video_with_subs(
                "https://cdn.example.org/v1.m3u8",
                vec![
                    ("https://cdn.example.org/en.vtt", "English"),
                    ("https://cdn.example.org/es.vtt", "Spanish"),
                ],
            ),
            video_with_subs("https://cdn.example.org/v2.m3u8", Vec::new()),
        ];

        let source = videos_to_source(videos);

        match source {
            Source::Video { sources, sub } => {
                assert_eq!(sources.len(), 2);
                assert_eq!(sub.len(), 2);
                assert_eq!(sub[0].title, "English");
                assert_eq!(sub[0].url.url, "https://cdn.example.org/en.vtt");
                assert_eq!(sub[1].title, "Spanish");
                assert_eq!(sub[1].url.url, "https://cdn.example.org/es.vtt");
            }
            _ => panic!("expected Source::Video"),
        }
    }

    #[test]
    fn videos_to_source_dedupes_subtitle_tracks_by_url() {
        // Extractors commonly attach the same subtitle set to every quality.
        let videos = vec![
            video_with_subs(
                "https://cdn.example.org/1080.m3u8",
                vec![("https://cdn.example.org/en.vtt", "English")],
            ),
            video_with_subs(
                "https://cdn.example.org/720.m3u8",
                vec![("https://cdn.example.org/en.vtt", "English")],
            ),
        ];

        let source = videos_to_source(videos);

        match source {
            Source::Video { sub, .. } => {
                assert_eq!(sub.len(), 1, "duplicate subtitle should be deduped");
                assert_eq!(sub[0].url.url, "https://cdn.example.org/en.vtt");
            }
            _ => panic!("expected Source::Video"),
        }
    }

    #[test]
    fn videos_to_source_propagates_video_headers_to_subtitles() {
        let mut headers = HashMap::new();
        headers.insert(
            "Referer".to_string(),
            "https://example.org/watch".to_string(),
        );

        let video = VideoDto {
            url: "https://cdn.example.org/v.m3u8".to_string(),
            quality: Some("1080p".to_string()),
            video_url: Some("https://cdn.example.org/v.m3u8".to_string()),
            headers: Some(headers.clone()),
            subtitle_tracks: Some(vec![SubtitleTrackDto {
                url: "https://cdn.example.org/en.vtt".to_string(),
                lang: "English".to_string(),
            }]),
        };

        let source = videos_to_source(vec![video]);

        match source {
            Source::Video { sub, .. } => {
                assert_eq!(sub.len(), 1);
                assert_eq!(sub[0].url.header.as_ref(), Some(&headers));
            }
            _ => panic!("expected Source::Video"),
        }
    }

    #[test]
    fn videos_to_source_handles_empty_lang() {
        let video = video_with_subs(
            "https://cdn.example.org/v.m3u8",
            vec![("https://cdn.example.org/sub.vtt", "")],
        );

        let source = videos_to_source(vec![video]);

        match source {
            Source::Video { sub, .. } => {
                assert_eq!(sub.len(), 1);
                assert_eq!(sub[0].title, "Subtitle", "empty lang should fall back");
            }
            _ => panic!("expected Source::Video"),
        }
    }

    #[test]
    fn videos_to_source_without_subtitle_tracks_has_empty_sub() {
        let video = VideoDto {
            url: "https://cdn.example.org/v.m3u8".to_string(),
            quality: None,
            video_url: None,
            headers: None,
            subtitle_tracks: None,
        };

        let source = videos_to_source(vec![video]);

        match source {
            Source::Video { sub, .. } => assert!(sub.is_empty()),
            _ => panic!("expected Source::Video"),
        }
    }
}
