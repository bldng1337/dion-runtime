use flutter_rust_bridge::frb;

#[frb(sync)]
pub fn resolve_proxy_url(url: String) -> String {
    dion_extension::resolve_proxy_url(&url).unwrap_or(url)
}
