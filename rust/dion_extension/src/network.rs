use std::{fs::File, io::BufReader, path::PathBuf, sync::Arc};

use anyhow::{Result, anyhow};
use governor::{DefaultKeyedRateLimiter, Quota, RateLimiter};
use http::Extensions;
use http_cache::{CACacheManager, CacheMode, HttpCache, HttpCacheOptions};
use http_cache_reqwest::Cache;
use nonzero_ext::nonzero;
use reqwest::Request;
use reqwest_cookie_store::CookieStoreMutex;
use reqwest_middleware::{ClientBuilder, ClientWithMiddleware, Middleware, Next};

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
}

impl DionNetworkManager {
    pub fn new(path: PathBuf) -> Result<Self> {
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
        })
    }
}
