use std::{
    fs::File,
    io::BufReader,
    path::PathBuf,
    sync::Arc,
    time::{Duration, Instant},
};

use anyhow::{Result, anyhow};
use governor::{DefaultKeyedRateLimiter, Quota, RateLimiter};
use http::Extensions;
use http_cache::{CACacheManager, CacheMode, HttpCache, HttpCacheOptions};
use http_cache_reqwest::Cache;
use nonzero_ext::nonzero;
use reqwest::Request;
use reqwest_cookie_store::CookieStoreMutex;
use reqwest_middleware::{ClientBuilder, ClientWithMiddleware, Middleware, Next};

/// Cookies are persisted at most this often; more frequent changes coalesce
/// into the next save.
const COOKIE_SAVE_INTERVAL: Duration = Duration::from_secs(30);

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
    last_cookie_save: Arc<std::sync::Mutex<Instant>>,
}

impl DionNetworkManager {
    pub fn new(path: PathBuf) -> Result<Self> {
        std::fs::create_dir_all(&path)
            .map_err(|e| anyhow!("Failed to create network data dir {:?}: {}", path, e))?;
        let cookie_store = {
            if let Ok(file) = File::open(path.join(".cookies")).map(BufReader::new) {
                cookie_store::serde::json::load(file)
            } else {
                Ok(reqwest_cookie_store::CookieStore::new())
            }
        }
        .map_err(|e| anyhow!("{:?}", e))?; //That Error conversion is not the cleanest

        let cookie_store = reqwest_cookie_store::CookieStoreMutex::new(cookie_store);
        let cookie_store = std::sync::Arc::new(cookie_store);

        let client = reqwest::Client::builder()
            .cookie_provider(cookie_store.clone())
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
            last_cookie_save: Arc::new(std::sync::Mutex::new(Instant::now())),
        })
    }

    /// Persist the cookie jar now.
    ///
    /// Uses `save_all` so session cookies are included — many sites keep the
    /// login state in session cookies, and dropping them would log the user
    /// out on every restart.
    pub fn save_cookies(&self) -> Result<()> {
        let mut file = File::create(&self.cookies_path)?;
        let cookies = self
            .cookies
            .lock()
            .map_err(|_| anyhow!("Cookie store lock poisoned"))?;
        cookie_store::serde::json::save_incl_expired_and_nonpersistent(&cookies, &mut file)
            .map_err(|e| anyhow!("Failed to serialize cookies: {:?}", e))
    }

    /// Persist the cookie jar if the debounce interval has elapsed since the
    /// last save. Cheap to call after every request; failures are logged, not
    /// propagated, since losing a debounced save is not worth failing the
    /// request that triggered it.
    pub fn save_cookies_debounced(&self) {
        let mut last = match self.last_cookie_save.lock() {
            Ok(last) => last,
            Err(_) => return,
        };
        if last.elapsed() < COOKIE_SAVE_INTERVAL {
            return;
        }
        *last = Instant::now();
        drop(last);
        if let Err(e) = self.save_cookies() {
            log::warn!("Failed to save cookies to {:?}: {}", self.cookies_path, e);
        }
    }
}
