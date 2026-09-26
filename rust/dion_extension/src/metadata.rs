use std::io::{Cursor, Read};
use std::time::Duration;

use anyhow::{Context, Result, bail};
use serde::Serialize;

/// Which container family a byte blob was detected as.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum FormatKind {
    /// ZIP container whose `mimetype` entry is `application/epub+zip`.
    Epub,
    /// Plain ZIP archive (CBZ and friends).
    Zip,
    /// ISO base media container (MP4, M4A, M4B).
    Mp4,
    /// Audio format handled by lofty (MP3, FLAC, OGG, OPUS, WAV, APE, ...).
    Audio,
}

/// The result of a one-shot `inspect`: structured metadata plus, for audio
/// containers, the embedded cover art. The artwork bytes travel separately
/// because they cannot ride along a `serde_json` conversion.
#[derive(Debug)]
pub(crate) struct InspectOutput {
    pub metadata: Metadata,
    pub artwork: Option<Vec<u8>>,
}

#[derive(Debug, Serialize)]
#[serde(tag = "type", rename_all = "camelCase")]
pub(crate) enum Metadata {
    Epub(EpubMetadata),
    Archive(ArchiveMetadata),
    Mp4(Mp4Metadata),
    Audio(AudioMetadata),
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct EpubMetadata {
    pub title: Option<String>,
    pub creators: Vec<Creator>,
    pub publishers: Vec<String>,
    pub languages: Vec<String>,
    /// Publication date as written in the package document.
    pub published: Option<String>,
    pub description: Option<String>,
    pub identifiers: Vec<Identifier>,
    pub subjects: Vec<String>,
    /// Manifest path of the cover image, usable with `Archive.read`.
    pub cover_path: Option<String>,
    /// All manifest resources. `path` values are usable with `Archive.read`.
    pub resources: Vec<ResourceInfo>,
    /// Flattened table of contents.
    pub toc: Vec<TocItem>,
    /// Reading order as manifest paths.
    pub spine: Vec<String>,
}

#[derive(Debug, Serialize, PartialEq)]
#[serde(rename_all = "camelCase")]
pub(crate) struct Creator {
    pub name: String,
    pub roles: Vec<String>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct Identifier {
    pub scheme: Option<String>,
    pub value: String,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct ResourceInfo {
    pub path: String,
    pub media_type: Option<String>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct TocItem {
    pub title: Option<String>,
    pub path: String,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct ArchiveMetadata {
    pub entries: Vec<ArchiveEntry>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct ArchiveEntry {
    pub path: String,
    pub size: Option<u64>,
    pub is_dir: bool,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct Mp4Metadata {
    pub title: Option<String>,
    pub artist: Option<String>,
    pub album: Option<String>,
    pub album_artist: Option<String>,
    pub year: Option<String>,
    pub genre: Option<String>,
    pub track: Option<u32>,
    pub track_total: Option<u32>,
    pub disc: Option<u32>,
    pub disc_total: Option<u32>,
    pub duration_ms: Option<u64>,
    pub description: Option<String>,
    pub chapters: Vec<Chapter>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct AudioMetadata {
    pub title: Option<String>,
    pub artist: Option<String>,
    pub album: Option<String>,
    pub year: Option<u32>,
    pub genre: Option<String>,
    pub track: Option<u32>,
    pub duration_ms: Option<u64>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct Chapter {
    pub title: Option<String>,
    pub start_ms: u64,
    /// Derived from the next chapter's start (or the total duration for the
    /// last chapter), so consumers get an explicit extent without math.
    pub duration_ms: Option<u64>,
}

/// A handle over a zip-family container that keeps the parsed index in Rust
/// memory, so per-entry reads do not re-parse or re-copy the whole file.
#[derive(Debug)]
pub(crate) enum MetadataArchive {
    Epub(Box<rbook::Epub>),
    Zip(zip::ZipArchive<Cursor<Vec<u8>>>),
}

/// Detects the container family from magic bytes, falling back to the
/// filename/extension hint when the content is ambiguous (e.g. an EPUB with a
/// missing `mimetype` entry).
pub(crate) fn detect(data: &[u8], hint: Option<&str>) -> Option<FormatKind> {
    // ZIP: "PK\x03\x04" (also tolerate empty/spanning signatures).
    if data.len() >= 4 && &data[..2] == b"PK" {
        // A proper EPUB carries its mimetype entry; fall back to the hint for
        // broken epubs that are missing it.
        if zip_mimetype(data).as_deref() == Some("application/epub+zip") || hint_is(hint, &["epub"])
        {
            return Some(FormatKind::Epub);
        }
        return Some(FormatKind::Zip);
    }
    if data.len() >= 12 && &data[4..8] == b"ftyp" {
        return Some(FormatKind::Mp4);
    }
    // Lofty sniffs the concrete audio format itself; only tag the family.
    let audio_magic = [&b"ID3"[..], b"fLaC", b"OggS", b"RIFF", b"MAC\x96", b"MP+"];
    if audio_magic.iter().any(|magic| data.starts_with(magic)) {
        return Some(FormatKind::Audio);
    }
    // Tagless MP3: MPEG frame sync.
    if data.len() >= 2 && data[0] == 0xFF && data[1] & 0xE0 == 0xE0 {
        return Some(FormatKind::Audio);
    }
    match hint.and_then(hint_extension).as_deref() {
        Some("epub") => Some(FormatKind::Epub),
        Some("cbz" | "zip" | "ctbc") => Some(FormatKind::Zip),
        Some("mp4" | "m4a" | "m4b" | "m4p" | "m4r" | "mp4v") => Some(FormatKind::Mp4),
        Some("mp3" | "flac" | "ogg" | "oga" | "opus" | "wav" | "ape" | "aac" | "aif" | "aiff") => {
            Some(FormatKind::Audio)
        }
        _ => None,
    }
}

fn hint_extension(hint: &str) -> Option<String> {
    let trimmed = hint.trim();
    let name = trimmed.rsplit(['/', '\\']).next().unwrap_or(trimmed);
    let name = name.strip_prefix('.').unwrap_or(name);
    let (_, ext) = name.rsplit_once('.')?;
    Some(ext.to_ascii_lowercase())
}

fn hint_is(hint: Option<&str>, extensions: &[&str]) -> bool {
    hint.and_then(hint_extension)
        .is_some_and(|ext| extensions.contains(&ext.as_str()))
}

fn zip_mimetype(data: &[u8]) -> Option<String> {
    let mut archive = zip::ZipArchive::new(Cursor::new(data)).ok()?;
    let mut entry = archive.by_name("mimetype").ok()?;
    let mut buf = String::new();
    entry.read_to_string(&mut buf).ok()?;
    Some(buf.trim().to_string())
}

/// One-shot parse: extracts metadata and (for audio containers) cover art,
/// then drops the data. Takes ownership because EPUB parsing requires a
/// `'static` reader.
pub(crate) fn inspect(data: Vec<u8>, hint: Option<&str>) -> Result<InspectOutput> {
    let kind = detect(&data, hint).with_context(|| {
        format!(
            "unrecognized container{}",
            hint.map(|h| format!(" (hint: {h})")).unwrap_or_default()
        )
    })?;
    match kind {
        FormatKind::Epub => {
            let epub = rbook::Epub::read(Cursor::new(data))
                .map_err(|e| anyhow::anyhow!("failed to parse EPUB: {e}"))?;
            epub_metadata(&epub)
        }
        FormatKind::Zip => {
            let entries = zip_entries(&mut zip::ZipArchive::new(Cursor::new(data))?);
            Ok(InspectOutput {
                metadata: Metadata::Archive(ArchiveMetadata { entries }),
                artwork: None,
            })
        }
        FormatKind::Mp4 => {
            let mut cursor = Cursor::new(&data[..]);
            let tag = mp4ameta::Tag::read_from(&mut cursor)
                .map_err(|e| anyhow::anyhow!("failed to parse MP4 metadata: {e}"))?;
            Ok(mp4_metadata(&tag))
        }
        FormatKind::Audio => {
            let tagged = lofty::probe::Probe::new(Cursor::new(&data[..]))
                .guess_file_type()
                .map_err(|e| anyhow::anyhow!("failed to detect audio type: {e}"))?
                .read()
                .map_err(|e| anyhow::anyhow!("failed to parse audio metadata: {e}"))?;
            Ok(audio_metadata(&tagged))
        }
    }
}

fn epub_metadata(epub: &rbook::Epub) -> Result<InspectOutput> {
    let meta = epub.metadata();
    let manifest = epub.manifest();

    let href_path =
        |entry: rbook::epub::manifest::EpubManifestEntry<'_>| entry.href().path().to_string();

    let creators = meta
        .creators()
        .map(|creator| {
            let mut roles: Vec<String> = creator
                .main_role()
                .into_iter()
                .chain(creator.roles())
                .map(|role| role.code().to_string())
                .filter(|role| !role.is_empty())
                .collect();
            roles.dedup();
            Creator {
                name: creator.value().to_string(),
                roles,
            }
        })
        .collect();

    let identifiers = meta
        .identifiers()
        .map(|id| Identifier {
            scheme: id.scheme().map(|scheme| scheme.code().to_string()),
            value: id.value().to_string(),
        })
        .collect();

    let resources: Vec<ResourceInfo> = manifest
        .iter()
        .map(|entry| ResourceInfo {
            path: href_path(entry),
            media_type: Some(entry.media_type().to_string()),
        })
        .collect();

    let toc: Vec<TocItem> = epub
        .toc()
        .contents()
        .into_iter()
        .flat_map(|root| root.flatten().collect::<Vec<_>>())
        .filter_map(|entry| {
            let path = entry.href()?.path().to_string();
            let title = entry.label().trim();
            Some(TocItem {
                title: (!title.is_empty()).then(|| title.to_string()),
                path,
            })
        })
        .collect();

    let spine: Vec<String> = epub
        .spine()
        .iter()
        .filter_map(|entry| manifest.by_id(entry.idref()).map(href_path))
        .collect();

    Ok(InspectOutput {
        metadata: Metadata::Epub(EpubMetadata {
            title: meta.title().map(|t| t.value().to_string()),
            creators,
            publishers: meta.publishers().map(|p| p.value().to_string()).collect(),
            languages: meta.languages().map(|l| l.value().to_string()).collect(),
            published: meta.published().map(|d| d.to_string()),
            description: meta.description().map(|d| d.value().to_string()),
            identifiers,
            subjects: meta.tags().map(|t| t.value().to_string()).collect(),
            cover_path: manifest.cover_image().map(href_path),
            resources,
            toc,
            spine,
        }),
        artwork: None,
    })
}

fn zip_entries(archive: &mut zip::ZipArchive<Cursor<Vec<u8>>>) -> Vec<ArchiveEntry> {
    (0..archive.len())
        .filter_map(|i| {
            let entry = archive.by_index(i).ok()?;
            Some(ArchiveEntry {
                path: entry.name().to_string(),
                size: Some(entry.size()),
                is_dir: entry.is_dir(),
            })
        })
        .collect()
}

fn chapter_list(chapters: &[(Duration, String)], total: Duration) -> Vec<Chapter> {
    let mut sorted: Vec<(Duration, String)> = chapters
        .iter()
        .map(|(start, title)| (*start, title.clone()))
        .collect();
    sorted.sort_by_key(|(start, _)| *start);
    sorted
        .iter()
        .enumerate()
        .map(|(i, (start, title))| {
            let end = sorted
                .get(i + 1)
                .map(|(next, _)| *next)
                .unwrap_or(total)
                .max(*start);
            Chapter {
                title: (!title.trim().is_empty()).then(|| title.clone()),
                start_ms: start.as_millis() as u64,
                duration_ms: Some(end.saturating_sub(*start).as_millis() as u64),
            }
        })
        .collect()
}

fn duration_ms(duration: Duration) -> Option<u64> {
    (duration > Duration::ZERO).then_some(duration.as_millis() as u64)
}

fn mp4_metadata(tag: &mp4ameta::Tag) -> InspectOutput {
    let (track, track_total) = tag.track();
    let (disc, disc_total) = tag.disc();
    let chapters: Vec<(Duration, String)> = tag
        .chapters()
        .iter()
        .map(|chapter| (chapter.start, chapter.title.clone()))
        .collect();
    InspectOutput {
        metadata: Metadata::Mp4(Mp4Metadata {
            title: tag.title().map(str::to_string),
            artist: tag.artist().map(str::to_string),
            album: tag.album().map(str::to_string),
            album_artist: tag.album_artist().map(str::to_string),
            year: tag.year().map(str::to_string),
            genre: tag.genre().map(str::to_string),
            track: track.map(u32::from),
            track_total: track_total.map(u32::from),
            disc: disc.map(u32::from),
            disc_total: disc_total.map(u32::from),
            duration_ms: duration_ms(tag.duration()),
            description: tag.description().map(str::to_string),
            chapters: chapter_list(&chapters, tag.duration()),
        }),
        artwork: tag.artwork().map(|img| img.data.to_vec()),
    }
}

fn audio_metadata(tagged: &lofty::file::TaggedFile) -> InspectOutput {
    use lofty::prelude::*;

    let duration = tagged.properties().duration();
    let tag = tagged.primary_tag().or_else(|| tagged.first_tag());
    InspectOutput {
        metadata: Metadata::Audio(AudioMetadata {
            title: tag.and_then(|t| t.title()).map(|v| v.into_owned()),
            artist: tag.and_then(|t| t.artist()).map(|v| v.into_owned()),
            album: tag.and_then(|t| t.album()).map(|v| v.into_owned()),
            year: tag
                .and_then(|t| t.date())
                .and_then(|date| (date.year > 0).then(|| u32::from(date.year))),
            genre: tag.and_then(|t| t.genre()).map(|v| v.into_owned()),
            track: tag.and_then(|t| t.track()),
            duration_ms: duration_ms(duration),
        }),
        artwork: tag
            .and_then(|t| t.pictures().first())
            .map(|picture| picture.data().to_vec()),
    }
}

impl MetadataArchive {
    pub(crate) fn open(data: Vec<u8>, hint: Option<&str>) -> Result<Self> {
        let kind = detect(&data, hint).with_context(|| "not a recognized archive container")?;
        match kind {
            FormatKind::Epub => {
                let epub = rbook::Epub::read(Cursor::new(data))
                    .map_err(|e| anyhow::anyhow!("failed to parse EPUB: {e}"))?;
                Ok(MetadataArchive::Epub(Box::new(epub)))
            }
            FormatKind::Zip => Ok(MetadataArchive::Zip(zip::ZipArchive::new(Cursor::new(
                data,
            ))?)),
            FormatKind::Mp4 | FormatKind::Audio => {
                bail!("container has metadata but no archive entries; use inspect")
            }
        }
    }

    pub(crate) fn inspect(&mut self) -> Result<InspectOutput> {
        match self {
            MetadataArchive::Epub(epub) => epub_metadata(epub),
            MetadataArchive::Zip(archive) => Ok(InspectOutput {
                metadata: Metadata::Archive(ArchiveMetadata {
                    entries: zip_entries(archive),
                }),
                artwork: None,
            }),
        }
    }

    pub(crate) fn entries(&mut self) -> Result<Vec<ArchiveEntry>> {
        match self {
            MetadataArchive::Epub(epub) => Ok(epub
                .manifest()
                .iter()
                .map(|entry| ArchiveEntry {
                    path: entry.href().path().to_string(),
                    size: None,
                    is_dir: false,
                })
                .collect()),
            MetadataArchive::Zip(archive) => Ok(zip_entries(archive)),
        }
    }

    pub(crate) fn read(&mut self, path: &str) -> Result<Vec<u8>> {
        match self {
            MetadataArchive::Epub(epub) => epub
                .read_resource_bytes(path)
                .map_err(|e| anyhow::anyhow!("failed to read `{path}` from EPUB: {e}")),
            MetadataArchive::Zip(archive) => {
                let mut entry = archive
                    .by_name(path)
                    .with_context(|| format!("no archive entry named `{path}`"))?;
                let mut buf = Vec::with_capacity(entry.size() as usize);
                entry.read_to_end(&mut buf)?;
                Ok(buf)
            }
        }
    }

    pub(crate) fn read_text(&mut self, path: &str) -> Result<String> {
        let bytes = self.read(path)?;
        Ok(String::from_utf8_lossy(&bytes).into_owned())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Write;

    const FIXTURES: &str = "../../tests/fixtures/metadata";

    const CONTAINER_XML: &str = r#"<?xml version="1.0"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>"#;

    const CONTENT_OPF: &str = r#"<?xml version="1.0" encoding="UTF-8"?>
<package xmlns="http://www.idpf.org/2007/opf" version="3.0" unique-identifier="uid">
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:identifier id="uid">urn:uuid:12345678-1234-1234-1234-123456789abc</dc:identifier>
    <dc:title>Test Book</dc:title>
    <dc:creator id="creator">Test Author</dc:creator>
    <dc:language>en</dc:language>
    <dc:publisher>Test Publisher</dc:publisher>
    <dc:subject>Fiction</dc:subject>
    <dc:description>A test book</dc:description>
    <dc:date>2024-01-01</dc:date>
  </metadata>
  <manifest>
    <item id="nav" href="nav.xhtml" media-type="application/xhtml+xml" properties="nav"/>
    <item id="ch1" href="ch1.xhtml" media-type="application/xhtml+xml"/>
    <item id="cover-image" href="cover.png" media-type="image/png" properties="cover-image"/>
  </manifest>
  <spine>
    <itemref idref="ch1"/>
  </spine>
</package>"#;

    const NAV_XHTML: &str = r#"<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
<head><title>TOC</title></head>
<body>
<nav epub:type="toc"><ol><li><a href="ch1.xhtml">Chapter 1</a></li></ol></nav>
</body>
</html>"#;

    const CH1_XHTML: &str = r#"<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>Chapter 1</title></head>
<body><p>Hello world</p></body></html>"#;

    fn build_epub(cover: &[u8]) -> Vec<u8> {
        let mut writer = zip::ZipWriter::new(Cursor::new(Vec::new()));
        // The EPUB spec requires the mimetype entry first and uncompressed.
        writer
            .start_file(
                "mimetype",
                zip::write::SimpleFileOptions::default()
                    .compression_method(zip::CompressionMethod::Stored),
            )
            .unwrap();
        writer.write_all(b"application/epub+zip").unwrap();

        let deflated = zip::write::SimpleFileOptions::default();
        for (name, contents) in [
            ("META-INF/container.xml", CONTAINER_XML.as_bytes()),
            ("OEBPS/content.opf", CONTENT_OPF.as_bytes()),
            ("OEBPS/nav.xhtml", NAV_XHTML.as_bytes()),
            ("OEBPS/ch1.xhtml", CH1_XHTML.as_bytes()),
            ("OEBPS/cover.png", cover),
        ] {
            writer.start_file(name, deflated).unwrap();
            writer.write_all(contents).unwrap();
        }
        writer.finish().unwrap().into_inner()
    }

    fn cover_bytes() -> Vec<u8> {
        std::fs::read(format!("{FIXTURES}/cover.png")).unwrap()
    }

    /// Regenerates the committed `sample.epub` fixture. The audio fixtures
    /// (sample.m4b, sample.mp3) are produced with ffmpeg:
    ///
    /// ```text
    /// ffmpeg -f lavfi -i anullsrc=r=8000:cl=mono -t 3 -vn -c:a aac -b:a 8k -f ipod base.m4b
    /// ffmpeg -i base.m4b -i cover.png -i chapters.ffmeta -map 0:a -map 1:v -map_metadata 2 \
    ///   -c:a copy -c:v:0 mjpeg -disposition:v:0 attached_pic -f ipod sample.m4b
    /// ffmpeg -f lavfi -i anullsrc=r=8000:cl=mono -t 2 -vn -c:a libmp3lame -b:a 8k -f mp3 base.mp3
    /// ffmpeg -i base.mp3 -i cover.png -map 0:a -map 1:v -c:a copy -c:v mjpeg \
    ///   -disposition:v attached_pic -metadata title="Test Track" -metadata artist="Test Artist" \
    ///   -metadata album="Test Album" -metadata date=2024 -id3v2_version 3 -f mp3 sample.mp3
    /// ```
    #[test]
    #[ignore = "writes the committed fixture; run explicitly after changing the epub contents"]
    fn write_epub_fixture() {
        std::fs::write(
            format!("{FIXTURES}/sample.epub"),
            build_epub(&cover_bytes()),
        )
        .unwrap();
    }

    #[test]
    fn inspect_epub() {
        let output = inspect(build_epub(&cover_bytes()), Some("book.epub")).unwrap();
        let Metadata::Epub(meta) = output.metadata else {
            panic!("expected epub metadata, got {:?}", output.metadata);
        };
        assert_eq!(meta.title.as_deref(), Some("Test Book"));
        assert_eq!(
            meta.creators,
            vec![Creator {
                name: "Test Author".into(),
                roles: vec![]
            }]
        );
        assert_eq!(meta.publishers, vec!["Test Publisher"]);
        assert_eq!(meta.languages, vec!["en"]);
        assert_eq!(meta.subjects, vec!["Fiction"]);
        assert_eq!(meta.cover_path.as_deref(), Some("/OEBPS/cover.png"));
        assert!(meta.resources.iter().any(|r| r.path == "/OEBPS/ch1.xhtml"));
        assert_eq!(meta.spine, vec!["/OEBPS/ch1.xhtml"]);
        assert_eq!(meta.toc.len(), 1);
        assert_eq!(meta.toc[0].title.as_deref(), Some("Chapter 1"));
        assert_eq!(meta.toc[0].path, "/OEBPS/ch1.xhtml");
        // Serializes to camelCase JSON for the JS boundary.
        let json = serde_json::to_value(Metadata::Epub(meta)).unwrap();
        assert!(json.get("coverPath").is_some());
    }

    #[test]
    fn archive_read_epub() {
        let cover = cover_bytes();
        let data = build_epub(&cover);
        let mut archive = MetadataArchive::open(data, None).unwrap();
        let entries = archive.entries().unwrap();
        assert!(entries.iter().any(|e| e.path == "/OEBPS/nav.xhtml"));
        assert_eq!(archive.read("/OEBPS/cover.png").unwrap(), cover);
        assert!(
            archive
                .read_text("/OEBPS/ch1.xhtml")
                .unwrap()
                .contains("Hello world")
        );
        let output = archive.inspect().unwrap();
        assert!(matches!(output.metadata, Metadata::Epub(_)));
    }

    #[test]
    fn inspect_zip() {
        let mut writer = zip::ZipWriter::new(Cursor::new(Vec::new()));
        let options = zip::write::SimpleFileOptions::default();
        writer.start_file("page001.jpg", options).unwrap();
        writer.write_all(b"image-one").unwrap();
        writer.start_file("page002.jpg", options).unwrap();
        writer.write_all(b"image-two-longer").unwrap();
        let data = writer.finish().unwrap().into_inner();

        let output = inspect(data.clone(), Some("chapter.cbz")).unwrap();
        let Metadata::Archive(meta) = output.metadata else {
            panic!("expected archive metadata");
        };
        assert_eq!(meta.entries.len(), 2);
        assert_eq!(meta.entries[0].path, "page001.jpg");
        assert_eq!(meta.entries[0].size, Some(9));
        assert!(!meta.entries[0].is_dir);

        let mut archive = MetadataArchive::open(data, None).unwrap();
        assert_eq!(archive.read("page002.jpg").unwrap(), b"image-two-longer");
    }

    #[test]
    fn inspect_m4b_fixture() {
        let data = std::fs::read(format!("{FIXTURES}/sample.m4b")).unwrap();
        let output = inspect(data, Some("book.m4b")).unwrap();
        let Metadata::Mp4(meta) = output.metadata else {
            panic!("expected mp4 metadata, got {:?}", output.metadata);
        };
        assert_eq!(meta.title.as_deref(), Some("Test Audiobook"));
        assert_eq!(meta.artist.as_deref(), Some("Test Author"));
        assert_eq!(meta.album.as_deref(), Some("Test Album"));
        assert_eq!(meta.duration_ms, Some(3000));
        assert_eq!(meta.chapters.len(), 2);
        assert_eq!(meta.chapters[0].title.as_deref(), Some("Intro"));
        assert_eq!(meta.chapters[0].start_ms, 0);
        assert_eq!(meta.chapters[0].duration_ms, Some(1500));
        assert_eq!(meta.chapters[1].title.as_deref(), Some("Outro"));
        assert_eq!(meta.chapters[1].start_ms, 1500);
        assert_eq!(meta.chapters[1].duration_ms, Some(1500));
        let artwork = output.artwork.expect("embedded artwork");
        assert!(artwork.starts_with(&[0xFF, 0xD8]), "expected JPEG artwork");
    }

    #[test]
    fn inspect_mp3_fixture() {
        let data = std::fs::read(format!("{FIXTURES}/sample.mp3")).unwrap();
        let output = inspect(data, Some("track.mp3")).unwrap();
        let Metadata::Audio(meta) = output.metadata else {
            panic!("expected audio metadata, got {:?}", output.metadata);
        };
        assert_eq!(meta.title.as_deref(), Some("Test Track"));
        assert_eq!(meta.artist.as_deref(), Some("Test Artist"));
        assert_eq!(meta.album.as_deref(), Some("Test Album"));
        assert_eq!(meta.year, Some(2024));
        // The committed fixture is deterministic; encoder delay/padding makes
        // the decoded stream slightly longer than the requested 2s.
        let duration = meta.duration_ms.expect("duration");
        assert!((1900..=3000).contains(&duration), "duration {duration}");
        let artwork = output.artwork.expect("embedded artwork");
        assert!(artwork.starts_with(&[0xFF, 0xD8]), "expected JPEG artwork");
    }

    #[test]
    fn unsupported_container_is_rejected() {
        let err = inspect(b"not a container at all".to_vec(), None);
        assert!(err.is_err());
    }
}
