#![deny(clippy::all)]

pub mod cancel;
pub mod client;
pub mod error;
pub mod extension;
pub mod logger;
pub mod manager;

use napi_derive::napi;

/// Resolves a `proxy://` URL handed out by an extension (see
/// `getProxyAddress`) to the `http://` URL its proxy serves on in this
/// process; any other URL is returned unchanged.
#[napi(js_name = "resolveProxyUrl")]
pub fn resolve_proxy_url(url: String) -> String {
  dion_extension::resolve_proxy_url(&url).unwrap_or(url)
}
