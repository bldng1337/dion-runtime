use std::sync::Arc;
use governor::{DefaultKeyedRateLimiter, Quota, RateLimiter};
use nonzero_ext::nonzero;
use reqwest::{ IntoUrl, Method, Request, Response, Url };
use reqwest_cookie_store::{ CookieStore, CookieStoreMutex };
use reqwest_middleware::{ClientBuilder, ClientWithMiddleware, Middleware, Next, RequestBuilder};
use http::Extensions;
use rquickjs::{ Ctx, Module };
use crate::{ error::Error, utils::{ wrapcatch, UserContextContainer } };


pub fn declare<'js>(ctx: Ctx<'js>) -> Result<(), Error> {
    Module::declare_def::<crate::networking_js::js_internal_network, _>(
        ctx.clone(),
        "internal_network"
    )?;
    wrapcatch(&ctx, Module::declare(ctx.clone(), "network", include_str!("js/network_js.js")))?;
    ctx.store_userdata(NetworkContainer::default())?;
    Ok(())
}

struct RateLimitingMiddleware{
    ratelimiter:DefaultKeyedRateLimiter<Url>
}

impl Default for RateLimitingMiddleware{
    fn default() -> Self {
        Self { ratelimiter: RateLimiter::keyed(Quota::per_second(nonzero!(10u32))) }
    }
}

#[async_trait::async_trait]
impl Middleware for RateLimitingMiddleware {
    async fn handle(
        &self,
        req: Request,
        extensions: &mut Extensions,
        next: Next<'_>,
    ) -> reqwest_middleware::Result<Response> {
        self.ratelimiter.until_key_ready(req.url()).await;
        next.run(req, extensions).await
    }
}




type NetworkContainer = UserContextContainer<NetworkManager>;
pub struct NetworkManager {
    nclient: ClientWithMiddleware,
    cookies: Arc<CookieStoreMutex>,
}
impl NetworkManager {
    pub fn request<U: IntoUrl>(&self, method: Method, url: U) -> RequestBuilder {
        self.nclient.request(method, url)
    }
}
impl Default for NetworkManager {
    fn default() -> Self {
        let cookie_store = CookieStore::default();
        let cookie_store = reqwest_cookie_store::CookieStoreMutex::new(cookie_store);
        let cookie_store = std::sync::Arc::new(cookie_store);
        let client=reqwest::Client::builder().cookie_provider(cookie_store.clone()).build().unwrap();
        let client = ClientBuilder::new(client)
        .with(RateLimitingMiddleware::default())
        .build();
        Self {
            cookies: cookie_store.clone(),
            nclient: client,
        }
    }
}

#[rquickjs::module(rename_vars = "camelCase")]
mod internal_network {
    use http::Method;
    use rquickjs::{ Ctx, IntoJs, Object };

    use crate::error::Error;

    use super::NetworkContainer;

    #[rquickjs::function]
    pub async fn fetch<'js>(
        ctx: Ctx<'js>,
        resource: String,
        options: Object<'js>
    ) -> Result<Object<'js>, rquickjs::Error> {
        let method = if options.contains_key("method")? {
            match options.get::<&str, String>("method")?.as_str() {
                "GET" => Method::GET,
                "HEAD" => Method::HEAD,
                "POST" => Method::POST,
                "PUT" => Method::PUT,
                "DELETE" => Method::DELETE,
                "CONNECT" => Method::CONNECT,
                "TRACE" => Method::TRACE,
                "PATCH" => Method::PATCH,
                _ => Method::GET,
            }
        } else {
            Method::GET
        };

        let mut rbuild = {
            let networkcontainer = ctx.userdata::<NetworkContainer>().unwrap();
            let networkmanager = networkcontainer.inner.read().await;
            networkmanager.request(method, resource)
        };
        if options.contains_key("body")? {
            rbuild = rbuild.body(options.get::<&str, String>("body")?);
        }
        //TODO! cache
        if options.contains_key("headers")? {
            let cheaders: Object = options.get("headers")?;
            for res in cheaders.keys::<String>() {
                let Ok(header) = res else {
                    continue;
                };
                let Ok(content) = cheaders.get::<_, String>(header.as_str()) else {
                    continue;
                };
                rbuild = rbuild.header(header, content);
            }
        }
        let Ok(response) = rbuild.send().await else {
            return Err(rquickjs::Error::new_resolving_message("", "", "msg"));
        };

        let retval: Object = Object::new(options.ctx().clone())?;
        retval.set("ok", response.status().is_success())?;
        retval.set("status", response.status().as_u16())?;
        let headermap = Object::new(options.ctx().clone())?;
        for (headername, header) in response.headers() {
            let Ok(stringheader) = header.to_str() else {
                continue;
            };
            headermap.set(headername.as_str(), stringheader)?;
        }
        retval.set("headers", headermap)?;
        let Ok(text) = response.text().await else {
            return Err(rquickjs::Error::new_resolving_message("", "", "Text decoding failed"));
        };
        retval.set("body", text)?;
        Ok(retval)
    }

    #[rquickjs::function]
    pub async fn get_cookies<'js>(ctx: Ctx<'js>) -> Result<Vec<Object<'js>>, rquickjs::Error> {
        match internal_get_cookies(ctx.clone()).await {
            Ok(data) => Ok(data),
            Err(err) => {
                Err(err.into_js(&ctx).err().unwrap())
            },
        }
    }

    async fn internal_get_cookies<'js>(ctx: Ctx<'js>) -> Result<Vec<Object<'js>>, Error> {
        let networkcontainer = ctx.userdata::<NetworkContainer>().unwrap();
        let networkmanager = networkcontainer.inner.read().await;
        let a = networkmanager.cookies
            .lock()?
            .iter_unexpired()
            .map(|c| {
                let obj: Object<'js> = Object::new(ctx.clone())?;
                obj.set("value", c.value_trimmed())?;
                obj.set("name", c.name())?;
                Ok(obj)
            })
            .filter(|a: &Result<Object<'js>, Error>| a.is_ok())
            .map(|a: Result<Object<'js>, _>| a.unwrap())
            .collect();
        Ok(a)
    }
}
