//! Streaming local-file responses for the extension proxy.
//!
//! A `handleProxy` result of `{ type: "file", path }` makes the runtime serve
//! a local file itself instead of routing bytes through JS. The file is
//! streamed in chunks (never buffered whole) and HTTP `Range` requests are
//! honored, which video players require for seeking local files. Access is
//! gated by the same `Permission::Storage` rules as the `filesystem` module.

use std::path::Path;

use anyhow::Result;
use http_body_util::BodyExt;
use http_body_util::combinators::BoxBody;
use hyper::body::Bytes;
use hyper::body::Frame;
use hyper::{HeaderMap, Method, Response, StatusCode};
use tokio_util::io::ReaderStream;

/// Error type used for proxy response bodies.
pub(crate) type BoxError = Box<dyn std::error::Error + Send + Sync>;
/// The body type the proxy server hands to hyper.
pub(crate) type ProxyBody = BoxBody<Bytes, BoxError>;

/// Chunk size for streaming file bodies.
const CHUNK_SIZE: usize = 64 * 1024;

/// An inclusive byte range within a resource of `len` bytes.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct HttpRange {
    pub start: u64,
    pub end: u64,
}

impl HttpRange {
    pub fn len(&self) -> u64 {
        self.end - self.start + 1
    }
}

/// Parses a `Range` header against a resource of `len` bytes.
///
/// Returns:
/// - `None` when the header is absent or malformed — serve the full body.
/// - `Some(None)` when well-formed but unsatisfiable — respond `416`.
/// - `Some(Some(range))` for the first satisfiable range. Multi-range
///   requests are answered with just the first range (players never send
///   them; serving one range is permitted by the spec via `206` with a
///   single part).
pub(crate) fn parse_range(headers: &HeaderMap, len: u64) -> Option<Option<HttpRange>> {
    let raw = headers.get(hyper::header::RANGE)?.to_str().ok()?.trim();
    let spec = raw.strip_prefix("bytes=")?.trim();
    // A trailing empty range (e.g. "0-1,") is tolerated; anything else with
    // multiple ranges uses only the first.
    let first = spec.split(',').next()?.trim();
    if first.is_empty() {
        return None;
    }
    let (start_spec, end_spec) = first.split_once('-')?;
    let range = match (start_spec.trim().is_empty(), end_spec.trim().is_empty()) {
        // "bytes=-N": the last N bytes.
        (true, false) => {
            let suffix: u64 = end_spec.trim().parse().ok()?;
            if suffix == 0 || len == 0 {
                return Some(None);
            }
            let suffix = suffix.min(len);
            HttpRange {
                start: len - suffix,
                end: len - 1,
            }
        }
        // "bytes=N-": from N to the end.
        (false, true) => {
            let start: u64 = start_spec.trim().parse().ok()?;
            if len == 0 || start >= len {
                return Some(None);
            }
            HttpRange {
                start,
                end: len - 1,
            }
        }
        // "bytes=N-M": inclusive.
        (false, false) => {
            let start: u64 = start_spec.trim().parse().ok()?;
            let end: u64 = end_spec.trim().parse().ok()?;
            if start > end {
                return None;
            }
            if len == 0 || start >= len {
                return Some(None);
            }
            HttpRange {
                start,
                end: end.min(len - 1),
            }
        }
        (true, true) => return None,
    };
    Some(Some(range))
}

/// Guesses a Content-Type from the file extension (ASCII, lowercase).
pub(crate) fn guess_mime(path: &Path) -> &'static str {
    let extension = path
        .extension()
        .and_then(|ext| ext.to_str())
        .map(|ext| ext.to_ascii_lowercase());
    match extension.as_deref() {
        Some("mp4" | "m4v") => "video/mp4",
        Some("mkv") => "video/x-matroska",
        Some("webm") => "video/webm",
        Some("avi") => "video/x-msvideo",
        Some("mov" | "qt") => "video/quicktime",
        Some("ts" | "m2ts") => "video/mp2t",
        Some("wmv") => "video/x-ms-wmv",
        Some("flv") => "video/x-flv",
        Some("3gp") => "video/3gpp",
        Some("mp3") => "audio/mpeg",
        Some("m4a" | "m4b") => "audio/mp4",
        Some("aac") => "audio/aac",
        Some("flac") => "audio/flac",
        Some("ogg" | "oga" | "opus") => "audio/ogg",
        Some("wav") => "audio/wav",
        Some("png") => "image/png",
        Some("jpg" | "jpeg") => "image/jpeg",
        Some("gif") => "image/gif",
        Some("webp") => "image/webp",
        Some("avif") => "image/avif",
        Some("bmp") => "image/bmp",
        Some("svg") => "image/svg+xml",
        Some("json") => "application/json",
        Some("txt" | "log") => "text/plain; charset=utf-8",
        Some("html" | "htm") => "text/html; charset=utf-8",
        Some("css") => "text/css; charset=utf-8",
        Some("js" | "mjs") => "text/javascript; charset=utf-8",
        Some("vtt") => "text/vtt",
        Some("srt") => "application/x-subrip",
        Some("pdf") => "application/pdf",
        Some("epub") => "application/epub+zip",
        Some("zip" | "cbz") => "application/zip",
        Some("rar" | "cbr") => "application/vnd.rar",
        _ => "application/octet-stream",
    }
}

/// Wraps a reader into a streaming proxy body.
fn stream_body<R>(reader: R) -> ProxyBody
where
    R: tokio::io::AsyncRead + Send + Sync + 'static,
{
    use futures_lite::StreamExt;
    let stream = ReaderStream::with_capacity(reader, CHUNK_SIZE)
        .map(|res| res.map(Frame::data).map_err(|e| Box::new(e) as BoxError));
    BoxBody::new(http_body_util::StreamBody::new(stream))
}

fn empty_body() -> ProxyBody {
    http_body_util::Empty::new()
        .map_err(|never| match never {})
        .boxed()
}

/// Streams a local file as an HTTP response with `Range` support.
///
/// `content_type` overrides the extension-based guess. Returns a `404`/`416`
/// response for missing files / unsatisfiable ranges instead of an error so
/// callers can hand the response straight to the proxy connection.
pub(crate) async fn serve_file(
    path: &Path,
    content_type: Option<&str>,
    method: &Method,
    headers: &HeaderMap,
) -> Response<ProxyBody> {
    let file = match tokio::fs::File::open(path).await {
        Ok(file) => file,
        Err(err) if err.kind() == std::io::ErrorKind::NotFound => {
            return error_response(StatusCode::NOT_FOUND, &format!("file not found: {err}"));
        }
        Err(err) => {
            return error_response(
                StatusCode::FORBIDDEN,
                &format!("failed to open file: {err}"),
            );
        }
    };
    let len = match file.metadata().await {
        Ok(meta) => meta.len(),
        Err(err) => {
            return error_response(
                StatusCode::INTERNAL_SERVER_ERROR,
                &format!("failed to stat file: {err}"),
            );
        }
    };
    let mime = content_type.unwrap_or_else(|| guess_mime(path));

    let builder = Response::builder()
        .header(hyper::header::CONTENT_TYPE, mime)
        .header(hyper::header::ACCEPT_RANGES, "bytes");

    // HEAD answers with the same headers but no body.
    if *method == Method::HEAD {
        return builder
            .header(hyper::header::CONTENT_LENGTH, len.to_string())
            .body(empty_body())
            .unwrap();
    }

    match parse_range(headers, len) {
        // Unsatisfiable but well-formed range.
        Some(None) => Response::builder()
            .status(StatusCode::RANGE_NOT_SATISFIABLE)
            .header(hyper::header::CONTENT_RANGE, format!("bytes */{len}"))
            .body(empty_body())
            .unwrap(),
        Some(Some(range)) => {
            use tokio::io::{AsyncReadExt, AsyncSeekExt};
            let mut file = file;
            if let Err(err) = file.seek(std::io::SeekFrom::Start(range.start)).await {
                return error_response(
                    StatusCode::INTERNAL_SERVER_ERROR,
                    &format!("failed to seek: {err}"),
                );
            }
            builder
                .status(StatusCode::PARTIAL_CONTENT)
                .header(
                    hyper::header::CONTENT_RANGE,
                    format!("bytes {}-{}/{}", range.start, range.end, len),
                )
                .header(hyper::header::CONTENT_LENGTH, range.len().to_string())
                .body(stream_body(file.take(range.len())))
                .unwrap()
        }
        // No (valid) range: stream the whole file.
        None => builder
            .header(hyper::header::CONTENT_LENGTH, len.to_string())
            .body(stream_body(file))
            .unwrap(),
    }
}

fn error_response(status: StatusCode, message: &str) -> Response<ProxyBody> {
    Response::builder()
        .status(status)
        .header(hyper::header::CONTENT_TYPE, "text/plain; charset=utf-8")
        .body(
            http_body_util::Full::new(Bytes::from(message.to_string()))
                .map_err(|never| match never {})
                .boxed(),
        )
        .unwrap()
}

/// Converts a serde JSON `handleProxy` result of kind `file` into its parts.
/// Kept here so the proxy stays free of file-serving detail.
pub(crate) fn file_response_parts(value: &serde_json::Value) -> Result<(String, Option<String>)> {
    use anyhow::Context as _;
    let obj = value
        .as_object()
        .context("Expected JSON object for file response")?;
    let path = obj
        .get("path")
        .and_then(|v| v.as_str())
        .context("Missing 'path' field for file response")?
        .to_string();
    let content_type = obj
        .get("contentType")
        .or_else(|| obj.get("content_type"))
        .and_then(|v| v.as_str())
        .map(str::to_string);
    Ok((path, content_type))
}

#[cfg(test)]
mod tests {
    use super::*;
    use hyper::header::{HeaderName, HeaderValue};

    fn range_header(value: &str) -> HeaderMap {
        let mut headers = HeaderMap::new();
        headers.insert(
            HeaderName::from_static("range"),
            HeaderValue::from_str(value).unwrap(),
        );
        headers
    }

    const LEN: u64 = 1000;

    #[test]
    fn parses_full_and_partial_ranges() {
        let cases = [
            ("bytes=0-", HttpRange { start: 0, end: 999 }),
            (
                "bytes=100-",
                HttpRange {
                    start: 100,
                    end: 999,
                },
            ),
            ("bytes=0-0", HttpRange { start: 0, end: 0 }),
            (
                "bytes=100-200",
                HttpRange {
                    start: 100,
                    end: 200,
                },
            ),
            (
                "bytes=999-99999",
                HttpRange {
                    start: 999,
                    end: 999,
                },
            ),
            (
                "bytes=-100",
                HttpRange {
                    start: 900,
                    end: 999,
                },
            ),
            ("bytes=-99999", HttpRange { start: 0, end: 999 }),
        ];
        for (header, expected) in cases {
            assert_eq!(
                parse_range(&range_header(header), LEN),
                Some(Some(expected)),
                "header: {header}"
            );
        }
    }

    #[test]
    fn absent_or_malformed_range_is_ignored() {
        let empty = HeaderMap::new();
        assert_eq!(parse_range(&empty, LEN), None);
        for header in ["bytes=", "chars=0-", "abc", "bytes=a-b", "bytes=5-1", "-"] {
            assert_eq!(
                parse_range(&range_header(header), LEN),
                None,
                "header: {header}"
            );
        }
        // Multiple ranges: the first one wins.
        assert_eq!(
            parse_range(&range_header("bytes=0-99,200-300"), LEN),
            Some(Some(HttpRange { start: 0, end: 99 }))
        );
        // Tolerated trailing comma.
        assert_eq!(
            parse_range(&range_header("bytes=0-99,"), LEN),
            Some(Some(HttpRange { start: 0, end: 99 }))
        );
    }

    #[test]
    fn unsatisfiable_ranges() {
        for header in ["bytes=1000-", "bytes=1000-2000", "bytes=-0"] {
            assert_eq!(
                parse_range(&range_header(header), LEN),
                Some(None),
                "header: {header}"
            );
        }
        assert_eq!(parse_range(&range_header("bytes=0-"), 0), Some(None));
    }

    #[tokio::test]
    async fn serves_whole_file_and_range() {
        use http_body_util::BodyExt;
        let dir = std::env::temp_dir().join(format!("dion-range-test-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let path = dir.join("video.mp4");
        std::fs::write(&path, vec![7u8; 5000]).unwrap();

        let full = serve_file(&path, None, &Method::GET, &HeaderMap::new()).await;
        assert_eq!(full.status(), StatusCode::OK);
        assert_eq!(
            full.headers().get(hyper::header::CONTENT_LENGTH).unwrap(),
            "5000"
        );
        assert_eq!(
            full.headers().get(hyper::header::CONTENT_TYPE).unwrap(),
            "video/mp4"
        );
        let bytes = full.into_body().collect().await.unwrap().to_bytes();
        assert_eq!(bytes.len(), 5000);

        let partial = serve_file(&path, None, &Method::GET, &range_header("bytes=100-199")).await;
        assert_eq!(partial.status(), StatusCode::PARTIAL_CONTENT);
        assert_eq!(
            partial.headers().get(hyper::header::CONTENT_RANGE).unwrap(),
            "bytes 100-199/5000"
        );
        let bytes = partial.into_body().collect().await.unwrap().to_bytes();
        assert_eq!(bytes.len(), 100);

        let unsat = serve_file(&path, None, &Method::GET, &range_header("bytes=9999-")).await;
        assert_eq!(unsat.status(), StatusCode::RANGE_NOT_SATISFIABLE);
        assert_eq!(
            unsat.headers().get(hyper::header::CONTENT_RANGE).unwrap(),
            "bytes */5000"
        );

        let head = serve_file(
            &path,
            Some("video/x-test"),
            &Method::HEAD,
            &HeaderMap::new(),
        )
        .await;
        assert_eq!(head.status(), StatusCode::OK);
        assert_eq!(
            head.headers().get(hyper::header::CONTENT_TYPE).unwrap(),
            "video/x-test"
        );
        assert!(head.into_body().frame().await.is_none());

        let missing =
            serve_file(&dir.join("nope.mp4"), None, &Method::GET, &HeaderMap::new()).await;
        assert_eq!(missing.status(), StatusCode::NOT_FOUND);

        std::fs::remove_dir_all(&dir).ok();
    }
}
