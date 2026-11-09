use std::{
    fs::File,
    io::{BufReader, Write},
    path::{Path, PathBuf},
    sync::Arc,
    time::{Duration, Instant},
};

use anyhow::{Result, anyhow, bail};
use governor::{DefaultKeyedRateLimiter, Quota, RateLimiter};
use http::Extensions;
use http_cache::{CACacheManager, CacheMode, HttpCache, HttpCacheOptions};
use http_cache_reqwest::Cache;
use hyper::body::Bytes;
use nonzero_ext::nonzero;
use reqwest::header::{self, HeaderMap, HeaderValue};
use reqwest::{Method, Request, StatusCode, Url, redirect};
use reqwest_cookie_store::CookieStoreMutex;
use reqwest_middleware::{ClientBuilder, ClientWithMiddleware, Middleware, Next};

/// Cookies are persisted at most this often; more frequent changes coalesce
/// into the next save.
const COOKIE_SAVE_INTERVAL: Duration = Duration::from_secs(30);

pub(crate) const CONNECT_TIMEOUT: Duration = Duration::from_secs(30);
pub(crate) const READ_TIMEOUT: Duration = Duration::from_secs(60);

const MAX_REDIRECTS: usize = 10;

#[derive(Debug)]
pub(crate) struct OutboundRequest {
    pub method: Method,
    pub url: Url,
    pub headers: HeaderMap,
    pub body: Option<Bytes>,
}

impl OutboundRequest {
    fn redirect_target(&self, status: StatusCode, location: Option<&HeaderValue>) -> Option<Url> {
        if !matches!(
            status,
            StatusCode::MOVED_PERMANENTLY
                | StatusCode::FOUND
                | StatusCode::SEE_OTHER
                | StatusCode::TEMPORARY_REDIRECT
                | StatusCode::PERMANENT_REDIRECT
        ) {
            return None;
        }
        let location = std::str::from_utf8(location?.as_bytes()).ok()?;
        self.url.join(location).ok()
    }

    fn follow_redirect(&mut self, status: StatusCode, target: Url) {
        if matches!(
            status,
            StatusCode::MOVED_PERMANENTLY | StatusCode::FOUND | StatusCode::SEE_OTHER
        ) {
            self.body = None;
            for name in [
                header::TRANSFER_ENCODING,
                header::CONTENT_ENCODING,
                header::CONTENT_TYPE,
                header::CONTENT_LENGTH,
            ] {
                self.headers.remove(name);
            }
            if !matches!(self.method, Method::GET | Method::HEAD) {
                self.method = Method::GET;
            }
        }
        let same_host = target.host_str() == self.url.host_str()
            && target.port_or_known_default() == self.url.port_or_known_default();
        if !same_host {
            for name in [
                header::AUTHORIZATION,
                header::COOKIE,
                header::PROXY_AUTHORIZATION,
                header::WWW_AUTHENTICATE,
            ] {
                self.headers.remove(name);
            }
            self.headers.remove("cookie2");
        }
        if let Some(referer) = referer_for(&self.url, &target) {
            self.headers.insert(header::REFERER, referer);
        }
        self.url = target;
    }
}

fn referer_for(previous: &Url, next: &Url) -> Option<HeaderValue> {
    if previous.scheme() == "https" && next.scheme() == "http" {
        return None;
    }
    let mut referer = previous.clone();
    let _ = referer.set_username("");
    let _ = referer.set_password(None);
    referer.set_fragment(None);
    HeaderValue::from_str(referer.as_str()).ok()
}

struct RateLimitingMiddleware {
    ratelimiter: DefaultKeyedRateLimiter<String>,
}

impl Default for RateLimitingMiddleware {
    fn default() -> Self {
        Self {
            ratelimiter: RateLimiter::keyed(Quota::per_second(nonzero!(10u32))),
        }
    }
}

#[async_trait::async_trait]
impl Middleware for RateLimitingMiddleware {
    async fn handle(
        &self,
        req: Request,
        extensions: &mut Extensions,
        next: Next<'_>,
    ) -> reqwest_middleware::Result<reqwest::Response> {
        if let Some(domain) = req.url().domain() {
            self.ratelimiter.until_key_ready(&domain.to_string()).await;
        }
        next.run(req, extensions).await
    }
}

#[derive(Clone, Debug)]
pub struct DionNetworkManager {
    pub nclient: ClientWithMiddleware,
    pub cookies: Arc<CookieStoreMutex>,
    cookies_path: PathBuf,
    cookie_save: Arc<std::sync::Mutex<CookieSaveState>>,
}

#[derive(Debug, Default)]
struct CookieSaveState {
    last_save: Option<Instant>,
    save_scheduled: bool,
}

fn load_cookies(path: &Path) -> reqwest_cookie_store::CookieStore {
    let Ok(file) = File::open(path) else {
        return reqwest_cookie_store::CookieStore::new();
    };
    cookie_store::serde::json::load(BufReader::new(file)).unwrap_or_else(|err| {
        log::warn!("Ignoring unreadable cookie file {path:?}: {err:?}");
        reqwest_cookie_store::CookieStore::new()
    })
}

impl DionNetworkManager {
    pub fn new(path: PathBuf) -> Result<Self> {
        Self::build(path, redirect::Policy::default())
    }

    pub(crate) fn for_extension(path: PathBuf) -> Result<Self> {
        Self::build(path, redirect::Policy::none())
    }

    fn build(path: PathBuf, redirects: redirect::Policy) -> Result<Self> {
        std::fs::create_dir_all(&path)
            .map_err(|e| anyhow!("Failed to create network data dir {:?}: {}", path, e))?;
        let cookie_store = load_cookies(&path.join(".cookies"));
        let cookie_store = reqwest_cookie_store::CookieStoreMutex::new(cookie_store);
        let cookie_store = std::sync::Arc::new(cookie_store);

        let client = reqwest::Client::builder()
            .cookie_provider(cookie_store.clone())
            .connect_timeout(CONNECT_TIMEOUT)
            .read_timeout(READ_TIMEOUT)
            .redirect(redirects)
            .build()?;
        let client = ClientBuilder::new(client)
            .with(RateLimitingMiddleware::default())
            .with(Cache(HttpCache {
                mode: CacheMode::Default,
                manager: CACacheManager::new(path.join(".httpcache"), true),
                options: HttpCacheOptions::default(),
            }))
            .build();
        Ok(Self {
            cookies: cookie_store,
            nclient: client,
            cookies_path: path.join(".cookies"),
            cookie_save: Default::default(),
        })
    }

    pub(crate) async fn send_following_redirects(
        &self,
        mut request: OutboundRequest,
        authorize: impl AsyncFn(&Url) -> Result<()>,
    ) -> Result<reqwest::Response> {
        for _ in 0..=MAX_REDIRECTS {
            authorize(&request.url).await?;
            let mut builder = self
                .nclient
                .request(request.method.clone(), request.url.clone())
                .headers(request.headers.clone());
            if let Some(body) = &request.body {
                builder = builder.body(body.clone());
            }
            let response = builder.send().await?;
            let status = response.status();
            let location = response.headers().get(header::LOCATION);
            let Some(target) = request.redirect_target(status, location) else {
                return Ok(response);
            };
            request.follow_redirect(status, target);
        }
        bail!("Too many redirects (limit is {MAX_REDIRECTS})")
    }

    /// Persist the cookie jar now.
    ///
    /// Uses `save_all` so session cookies are included — many sites keep the
    /// login state in session cookies, and dropping them would log the user
    /// out on every restart.
    ///
    /// The file is replaced atomically, so a crash mid-save leaves the
    /// previous jar intact.
    pub fn save_cookies(&self) -> Result<()> {
        // Held for the whole write so concurrent saves can't share the temp file.
        let mut state = self
            .cookie_save
            .lock()
            .map_err(|_| anyhow!("Cookie save lock poisoned"))?;
        let mut data = Vec::new();
        {
            let cookies = self
                .cookies
                .lock()
                .map_err(|_| anyhow!("Cookie store lock poisoned"))?;
            cookie_store::serde::json::save_incl_expired_and_nonpersistent(&cookies, &mut data)
                .map_err(|e| anyhow!("Failed to serialize cookies: {:?}", e))?;
        }
        let temp = self.cookies_path.with_extension("tmp");
        let mut file = File::create(&temp)?;
        file.write_all(&data)?;
        file.sync_all()?;
        drop(file);
        std::fs::rename(&temp, &self.cookies_path)?;
        state.last_save = Some(Instant::now());
        Ok(())
    }

    /// [`Self::save_cookies`], logging a failure instead of returning it.
    pub(crate) fn save_cookies_logged(&self) {
        if let Err(e) = self.save_cookies() {
            log::warn!("Failed to save cookies to {:?}: {}", self.cookies_path, e);
        }
    }

    pub fn save_cookies_debounced(&self) {
        self.save_cookies_within(COOKIE_SAVE_INTERVAL);
    }

    fn save_cookies_within(&self, interval: Duration) {
        let delay = {
            let Ok(mut state) = self.cookie_save.lock() else {
                return;
            };
            let remaining = state.last_save.map_or(Duration::ZERO, |last| {
                interval.saturating_sub(last.elapsed())
            });
            if !remaining.is_zero() {
                if state.save_scheduled {
                    return;
                }
                state.save_scheduled = true;
            }
            remaining
        };
        if delay.is_zero() {
            self.save_cookies_logged();
            return;
        }
        let this = self.clone();
        tokio::spawn(async move {
            tokio::time::sleep(delay).await;
            if let Ok(mut state) = this.cookie_save.lock() {
                state.save_scheduled = false;
            }
            this.save_cookies_logged();
        });
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use httpmock::prelude::*;
    use std::cell::RefCell;

    fn request(method: Method, url: &str) -> OutboundRequest {
        OutboundRequest {
            method,
            url: url.parse().unwrap(),
            headers: HeaderMap::new(),
            body: Some(Bytes::from_static(b"payload")),
        }
    }

    fn test_manager(name: &str) -> (DionNetworkManager, PathBuf) {
        let dir = std::env::temp_dir().join(format!("dion-net-{name}-{}", std::process::id()));
        (DionNetworkManager::for_extension(dir.clone()).unwrap(), dir)
    }

    #[test]
    fn corrupt_cookie_file_does_not_block_startup() {
        for contents in ["", "not json"] {
            let (_, dir) = test_manager("corrupt-setup");
            std::fs::write(dir.join(".cookies"), contents).unwrap();

            assert!(DionNetworkManager::for_extension(dir.clone()).is_ok());

            let _ = std::fs::remove_dir_all(dir);
        }
    }

    #[tokio::test]
    async fn changes_inside_the_interval_are_saved_when_it_ends() {
        let (manager, dir) = test_manager("debounce");
        let cookies = dir.join(".cookies");
        let interval = Duration::from_millis(100);

        manager.save_cookies_within(interval);
        assert!(cookies.exists(), "the first save must not wait");

        std::fs::remove_file(&cookies).unwrap();
        manager.save_cookies_within(interval);
        assert!(!cookies.exists(), "a save inside the interval must wait");

        tokio::time::sleep(Duration::from_millis(300)).await;
        assert!(cookies.exists(), "the delayed save must run");
        let _ = std::fs::remove_dir_all(dir);
    }

    #[test]
    fn found_redirect_becomes_a_bodyless_get() {
        let mut req = request(Method::POST, "https://a.example/start");
        req.headers
            .insert(header::CONTENT_TYPE, HeaderValue::from_static("text/plain"));

        req.follow_redirect(StatusCode::FOUND, "https://a.example/end".parse().unwrap());

        assert_eq!(req.method, Method::GET);
        assert!(req.body.is_none());
        assert!(!req.headers.contains_key(header::CONTENT_TYPE));
    }

    #[test]
    fn temporary_redirect_replays_method_and_body() {
        let mut req = request(Method::POST, "https://a.example/start");

        req.follow_redirect(
            StatusCode::TEMPORARY_REDIRECT,
            "https://a.example/end".parse().unwrap(),
        );

        assert_eq!(req.method, Method::POST);
        assert!(req.body.is_some());
    }

    #[test]
    fn credentials_only_survive_same_host_redirects() {
        let credentials = HeaderValue::from_static("secret");
        let mut same = request(Method::GET, "https://a.example/start");
        same.headers
            .insert(header::AUTHORIZATION, credentials.clone());
        same.follow_redirect(StatusCode::FOUND, "https://a.example/end".parse().unwrap());
        assert!(same.headers.contains_key(header::AUTHORIZATION));

        let mut other = request(Method::GET, "https://a.example/start");
        other.headers.insert(header::AUTHORIZATION, credentials);
        other.follow_redirect(StatusCode::FOUND, "https://b.example/end".parse().unwrap());
        assert!(!other.headers.contains_key(header::AUTHORIZATION));
    }

    #[tokio::test]
    async fn redirect_to_an_unauthorized_host_is_never_contacted() {
        let server = MockServer::start_async().await;
        let target = format!("http://localhost:{}/end", server.port());
        server
            .mock_async(|when, then| {
                when.method(GET).path("/start");
                then.status(302).header("Location", target.as_str());
            })
            .await;
        let end = server
            .mock_async(|when, then| {
                when.method(GET).path("/end");
                then.status(200).body("secret");
            })
            .await;
        let (manager, dir) = test_manager("denied");
        let mut req = request(Method::GET, &server.url("/start"));
        req.body = None;

        let result = manager
            .send_following_redirects(req, async |url: &Url| {
                if url.host_str() == Some("localhost") {
                    bail!("denied");
                }
                Ok(())
            })
            .await;

        assert_eq!(result.unwrap_err().to_string(), "denied");
        assert_eq!(end.hits_async().await, 0);
        let _ = std::fs::remove_dir_all(dir);
    }

    #[tokio::test]
    async fn every_redirect_hop_is_authorized() {
        let server = MockServer::start_async().await;
        let target = format!("http://localhost:{}/end", server.port());
        server
            .mock_async(|when, then| {
                when.method(GET).path("/start");
                then.status(302).header("Location", target.as_str());
            })
            .await;
        server
            .mock_async(|when, then| {
                when.method(GET).path("/end");
                then.status(200).body("done");
            })
            .await;
        let (manager, dir) = test_manager("allowed");
        let mut req = request(Method::GET, &server.url("/start"));
        req.body = None;
        let hosts = RefCell::new(Vec::new());

        let response = manager
            .send_following_redirects(req, async |url: &Url| {
                hosts.borrow_mut().push(url.host_str().unwrap().to_string());
                Ok(())
            })
            .await
            .unwrap();

        assert_eq!(response.text().await.unwrap(), "done");
        assert_eq!(hosts.into_inner(), ["127.0.0.1", "localhost"]);
        let _ = std::fs::remove_dir_all(dir);
    }
}
