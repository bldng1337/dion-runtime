use crate::extension::{container::InnerExtension, executor::Task};
use crate::network::{CONNECT_TIMEOUT, READ_TIMEOUT};
use crate::range_file::ProxyBody;
use crate::utils::AbortOnDrop;
use anyhow::{Context, Result};
use dion_runtime::data::extension::ExtensionData;
use http_body_util::BodyExt;
use http_body_util::Full;
use http_body_util::combinators::BoxBody;
use hyper::body::Bytes;
use hyper::body::Incoming;
use hyper::service::service_fn;
use hyper::{Request, Response, StatusCode};
use hyper_rustls::{HttpsConnector, HttpsConnectorBuilder};
use hyper_util::client::legacy::Client;
use hyper_util::client::legacy::connect::HttpConnector;
use hyper_util::rt::{TokioExecutor, TokioIo};
use hyper_util::server::conn::auto::Builder;
use log::warn;
use std::collections::HashMap;
use std::net::IpAddr;
use std::net::{Ipv4Addr, SocketAddr, SocketAddrV4};
use std::{
    convert::Infallible,
    sync::{Arc, LazyLock, Weak},
};
use tokio::net::TcpListener;
use tokio::sync::{RwLock, oneshot};
use tokio::task::JoinHandle;

pub(crate) fn request_to_value(req: &Request<String>) -> Result<serde_json::Value> {
    // Build a JSON object with method, uri, version, headers, body
    let mut map = serde_json::Map::new();

    // method and uri
    map.insert(
        "method".to_string(),
        serde_json::Value::String(req.method().to_string()),
    );
    map.insert(
        "uri".to_string(),
        serde_json::Value::String(req.uri().to_string()),
    );

    // version as a simple numeric representation:
    // 10 -> HTTP/1.0, 11 -> HTTP/1.1, 2 -> HTTP/2, 3 -> HTTP/3
    let version_num = match req.version() {
        hyper::Version::HTTP_10 => 10u64,
        hyper::Version::HTTP_11 => 11u64,
        hyper::Version::HTTP_2 => 2u64,
        hyper::Version::HTTP_3 => 3u64,
        _ => 11u64,
    };
    map.insert(
        "version".to_string(),
        serde_json::Value::Number(serde_json::Number::from(version_num)),
    );

    // headers: map of header-name -> array of header-values (each value is a string)
    let mut headers_map: HashMap<String, Vec<String>> = HashMap::new();
    for (name, value) in req.headers().iter() {
        let name_str = name.as_str().to_string();
        let value_str = value
            .to_str()
            .context("Header value is not valid UTF-8")?
            .to_string();
        headers_map.entry(name_str).or_default().push(value_str);
    }

    let mut headers_obj = serde_json::Map::new();
    for (name, values) in headers_map {
        let array: Vec<serde_json::Value> =
            values.into_iter().map(serde_json::Value::String).collect();
        headers_obj.insert(name, serde_json::Value::Array(array));
    }
    map.insert(
        "headers".to_string(),
        serde_json::Value::Object(headers_obj),
    );

    // body
    map.insert(
        "body".to_string(),
        serde_json::Value::String(req.body().clone()),
    );

    Ok(serde_json::Value::Object(map))
}

pub(crate) fn value_to_request(value: &serde_json::Value) -> Result<Request<String>> {
    use anyhow::Context as _;
    // Expect an object
    let obj = value
        .as_object()
        .context("Expected JSON object for Request")?;

    // method
    let method_str = obj
        .get("method")
        .and_then(|v| v.as_str())
        .context("Missing or invalid 'method' field")?;
    let method = method_str
        .parse::<hyper::Method>()
        .with_context(|| format!("Invalid HTTP method: {}", method_str))?;

    // uri
    let uri_str = obj
        .get("uri")
        .and_then(|v| v.as_str())
        .context("Missing or invalid 'uri' field")?;

    // body
    let body = obj
        .get("body")
        .and_then(|v| v.as_str())
        .unwrap_or("")
        .to_string();

    // Start building the request
    let mut builder = Request::builder().method(method).uri(uri_str);

    // headers (optional)
    if let Some(headers_val) = obj.get("headers") {
        let headers_map = headers_val.as_object().context(
            "'headers' must be an object mapping header names to string or array of strings",
        )?;
        for (name, values_val) in headers_map.iter() {
            let values: Vec<&str> = if let Some(s) = values_val.as_str() {
                vec![s]
            } else if let Some(arr) = values_val.as_array() {
                arr.iter()
                    .map(|v| {
                        v.as_str().with_context(|| {
                            format!("Header value in array for '{}' must be a string", name)
                        })
                    })
                    .collect::<Result<Vec<_>>>()?
            } else {
                anyhow::bail!(
                    "Header value for '{}' must be a string or array of strings",
                    name
                );
            };
            for value_str in values {
                let header_value = hyper::header::HeaderValue::from_str(value_str)
                    .with_context(|| format!("Invalid header value string for '{}'", name))?;
                // header name may be provided as string; header() accepts &str for names
                builder = builder.header(name.as_str(), header_value);
            }
        }
    }

    let request = builder
        .body(body)
        .context("Failed to build Request<String> from JSON")?;

    Ok(request)
}

pub(crate) fn value_to_response(value: serde_json::Value) -> Result<Response<Bytes>> {
    use anyhow::Context as _;
    let obj = value
        .as_object()
        .context("Expected JSON object for Response")?;

    // status: try several common field names, default to 200
    let status_num = obj
        .get("status")
        .or_else(|| obj.get("status_code"))
        .or_else(|| obj.get("statusCode"))
        .and_then(|v| v.as_u64())
        .unwrap_or(200);
    if status_num > u16::MAX as u64 {
        anyhow::bail!("Status code out of range");
    }
    let status = StatusCode::from_u16(status_num as u16)
        .with_context(|| format!("Invalid status code: {}", status_num))?;

    // start building response
    let mut builder = Response::builder().status(status);

    // headers (optional) - same representation as in request_to_value:
    if let Some(headers_val) = obj.get("headers") {
        let headers_map = headers_val.as_object().context(
            "'headers' must be an object mapping header names to string or array of strings",
        )?;
        for (name, values_val) in headers_map.iter() {
            let values: Vec<&str> = if let Some(s) = values_val.as_str() {
                vec![s]
            } else if let Some(arr) = values_val.as_array() {
                arr.iter()
                    .map(|v| {
                        v.as_str().with_context(|| {
                            format!("Header value in array for '{}' must be a string", name)
                        })
                    })
                    .collect::<Result<Vec<_>>>()?
            } else {
                anyhow::bail!(
                    "Header value for '{}' must be a string or array of strings",
                    name
                );
            };
            for value_str in values {
                let header_value = hyper::header::HeaderValue::from_str(value_str)
                    .with_context(|| format!("Invalid header value string for '{}'", name))?;
                builder = builder.header(name.as_str(), header_value);
            }
        }
    }

    // body (optional). `bodyEncoding: "base64"` lets a pure-JSON response
    // carry binary; `handleProxy` results with a `Uint8Array` body are
    // converted by the executor before they ever reach this JSON path.
    let body = match obj.get("bodyEncoding").and_then(|v| v.as_str()) {
        Some("base64") => {
            use base64::Engine as _;
            let encoded = obj.get("body").and_then(|v| v.as_str()).unwrap_or("");
            Bytes::from(
                base64::engine::general_purpose::STANDARD
                    .decode(encoded)
                    .context("Failed to decode base64 response body")?,
            )
        }
        _ => Bytes::from(
            obj.get("body")
                .and_then(|v| v.as_str())
                .unwrap_or("")
                .to_string(),
        ),
    };

    let response = builder
        .body(body)
        .context("Failed to build Response<Bytes> from JSON")?;

    Ok(response)
}

const MAX_REQUEST_BODY: usize = 16 * 1024 * 1024;

async fn convert_request_to_string(req: Request<Incoming>) -> Result<Request<String>> {
    let (parts, body) = req.into_parts();

    let whole_body = http_body_util::Limited::new(body, MAX_REQUEST_BODY)
        .collect()
        .await
        .map_err(|err| anyhow::anyhow!("Failed to read request body: {err}"))?
        .to_bytes();

    // The extension API carries the body as a string; binary bodies are
    // passed lossily rather than failing the whole request.
    let body_string = String::from_utf8_lossy(&whole_body).into_owned();

    Ok(Request::from_parts(parts, body_string))
}

#[derive(Debug)]
pub(crate) enum ProxyResult {
    Redirect(Request<String>),
    Response(Response<Bytes>),
    /// Serve a local file directly from the runtime, streamed and with HTTP
    /// `Range` support (see `range_file`). The path goes through the same
    /// storage-permission checks as the `filesystem` module.
    File {
        path: String,
        content_type: Option<String>,
    },
}

impl TryFrom<serde_json::Value> for ProxyResult {
    type Error = anyhow::Error;

    fn try_from(value: serde_json::Value) -> Result<Self, Self::Error> {
        let obj = value
            .as_object()
            .context("Expected JSON object for ProxyResult")?;

        // Determine type field to decide whether this is a Redirect or a Response
        let type_str = obj.get("type").and_then(|v| v.as_str()).context(
            "Missing or invalid 'type' field for ProxyResult; expected 'redirect', 'response' or 'file'",
        )?;

        match type_str.to_ascii_lowercase().as_str() {
            "redirect" => {
                let req_val = obj
                    .get("request")
                    .context("Missing 'request' field for ProxyResult of type 'redirect'")?;
                let req =
                    value_to_request(req_val).context("Failed to parse 'request' for Redirect")?;
                Ok(ProxyResult::Redirect(req))
            }
            "response" => {
                let resp =
                    value_to_response(value).context("Failed to parse Response for ProxyResult")?;
                Ok(ProxyResult::Response(resp))
            }
            "file" => {
                let (path, content_type) = crate::range_file::file_response_parts(&value)?;
                Ok(ProxyResult::File { path, content_type })
            }
            other => anyhow::bail!("Unknown ProxyResult type: {}", other),
        }
    }
}

fn path_belongs_to(path: &str, ext_path: &str) -> bool {
    path.strip_prefix(ext_path)
        .is_some_and(|rest| rest.is_empty() || rest.starts_with('/'))
}

#[derive(Debug)]
pub(crate) struct Proxy {
    registered_extensions: Vec<Weak<ProxyExtensionRef>>,
    abort_handle: Option<AbortOnDrop<JoinHandle<()>>>,
    addr: Option<SocketAddr>,
    token: String,
    client: Client<HttpsConnector<HttpConnector>, BoxBody<Bytes, hyper::Error>>,
}

fn new_proxy_token() -> String {
    let mut bytes = [0u8; 16];
    if let Err(err) = getrandom::fill(&mut bytes) {
        // Without OS randomness there is no secret
        warn!("Failed to generate proxy token: {err}");
        return String::new();
    }
    bytes.iter().map(|b| format!("{b:02x}")).collect()
}

fn plain_response(status: StatusCode, body: &'static str) -> Response<ProxyBody> {
    Response::builder()
        .status(status)
        .header("Content-Type", "text/plain")
        .body(
            Full::new(Bytes::from(body))
                .map_err(|never| match never {})
                .boxed(),
        )
        .unwrap()
}

fn strip_token<'a>(path: &'a str, token: &str) -> Option<&'a str> {
    if token.is_empty() {
        return Some(path);
    }
    let rest = path.strip_prefix('/')?.strip_prefix(token)?;
    rest.starts_with('/').then_some(rest)
}

fn is_loopback_host(host: Option<&str>, addr: Option<SocketAddr>) -> bool {
    let Some(host) = host else {
        return true;
    };
    let (name, port) = match host.rsplit_once(':') {
        Some((name, port)) if !port.is_empty() && port.chars().all(|c| c.is_ascii_digit()) => {
            (name, Some(port))
        }
        _ => (host, None),
    };
    if let (Some(port), Some(addr)) = (port, addr)
        && port.parse::<u16>().ok() != Some(addr.port())
    {
        return false;
    }
    name.eq_ignore_ascii_case("localhost") || name == "127.0.0.1" || name == "[::1]"
}

impl Proxy {
    pub async fn new() -> Arc<RwLock<Self>> {
        let mut http = HttpConnector::new();
        http.enforce_http(false);
        http.set_connect_timeout(Some(CONNECT_TIMEOUT));

        let https = HttpsConnectorBuilder::new()
            .with_webpki_roots()
            .https_or_http()
            .enable_http1()
            .enable_http2()
            .wrap_connector(http);
        let proxy = Arc::new(RwLock::new(Proxy {
            registered_extensions: Vec::new(),
            abort_handle: None,
            addr: None,
            token: new_proxy_token(),
            client: Client::builder(TokioExecutor::new()).build(https),
        }));
        async fn handle(
            proxy_copy: Weak<RwLock<Proxy>>,
            client_ip: IpAddr,
            req: Request<Incoming>,
        ) -> Result<Response<ProxyBody>, Infallible> {
            let Some(proxy) = proxy_copy.upgrade() else {
                return Ok(Response::builder()
                    .status(StatusCode::SERVICE_UNAVAILABLE)
                    .body(
                        Full::new(Bytes::from("Proxy not available"))
                            .map_err(|never| match never {})
                            .boxed(),
                    )
                    .unwrap());
            };
            // Snapshot what request handling needs (http client + registered
            // extensions) under a short-lived read guard. Holding the guard
            // for the whole request — including the outbound redirect fetch
            // and the extension JS round-trip — would block extension
            // (un)registration behind slow requests.
            let (client, extensions, token, addr) = {
                let proxy = proxy.read().await;
                (
                    proxy.client.clone(),
                    proxy.get_active_extensions().await,
                    proxy.token.clone(),
                    proxy.addr,
                )
            };
            let host = req
                .headers()
                .get(hyper::header::HOST)
                .and_then(|h| h.to_str().ok())
                .map(str::to_owned);
            if !is_loopback_host(host.as_deref(), addr) {
                return Ok(plain_response(StatusCode::FORBIDDEN, "Forbidden"));
            }
            let Some(path) = strip_token(req.uri().path(), &token).map(str::to_owned) else {
                return Ok(plain_response(StatusCode::NOT_FOUND, "Not found"));
            };
            let req = match Proxy::without_token(req, &path) {
                Ok(req) => req,
                Err(err) => {
                    warn!("Rejected proxy request: {err:?}");
                    return Ok(plain_response(StatusCode::BAD_REQUEST, "Bad request"));
                }
            };
            match Proxy::handle_request(&client, &extensions, client_ip, req).await {
                Ok(response) => Ok(response),
                Err(err) => {
                    warn!("Proxy request failed: {err:?}");
                    Ok(plain_response(
                        StatusCode::INTERNAL_SERVER_ERROR,
                        "Internal server error",
                    ))
                }
            }
        }
        let weak_proxy = Arc::downgrade(&proxy);

        if let Ok(listener) =
            TcpListener::bind(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOCALHOST, 0))).await
        {
            let local_addr = listener.local_addr().unwrap();

            let mut proxy_lock = proxy.write().await;
            proxy_lock.addr = Some(local_addr);
            register_endpoint(local_addr, proxy_lock.token.clone());

            let server_task = tokio::spawn(async move {
                let weak_proxy = weak_proxy;
                loop {
                    let (stream, remote_addr) = match listener.accept().await {
                        Ok(conn) => conn,
                        Err(e) => {
                            warn!("Failed to accept connection: {}", e);
                            continue;
                        }
                    };

                    let remote_ip = remote_addr.ip();
                    let io = TokioIo::new(stream);
                    let proxy = weak_proxy.clone();
                    tokio::spawn(async move {
                        let service = service_fn(move |req: hyper::Request<Incoming>| {
                            let proxy = proxy.clone();
                            handle(proxy, remote_ip, req)
                        });

                        if let Err(err) = Builder::new(TokioExecutor::new())
                            .serve_connection(io, service)
                            .await
                        {
                            warn!("Error serving connection: {:?}", err);
                        }
                    });
                }
            });

            proxy_lock.abort_handle = Some(AbortOnDrop::new(server_task));
        }

        proxy
    }

    pub fn get_extension_uri(&self, data: &ExtensionData) -> Option<String> {
        self.addr?;
        Some(format!(
            "{PROXY_URL_PREFIX}{EXTENSION_PATH_PREFIX}{}",
            data.id
        ))
    }

    fn extension_path(data: &ExtensionData) -> String {
        format!("/{EXTENSION_PATH_PREFIX}{}", data.id)
    }

    fn without_token(req: Request<Incoming>, path: &str) -> Result<Request<Incoming>> {
        let (mut parts, body) = req.into_parts();
        let path_and_query = match parts.uri.query() {
            Some(query) => format!("{path}?{query}"),
            None => path.to_string(),
        };
        let mut uri = parts.uri.clone().into_parts();
        uri.path_and_query = Some(path_and_query.parse()?);
        parts.uri = hyper::Uri::from_parts(uri)?;
        Ok(Request::from_parts(parts, body))
    }

    /// Handle a proxied request against a snapshot of the proxy state. Must
    /// not be called while holding the proxy RwLock (see `handle` above).
    async fn handle_request(
        client: &Client<HttpsConnector<HttpConnector>, BoxBody<Bytes, hyper::Error>>,
        extensions: &[Arc<ProxyExtensionRef>],
        _client_ip: IpAddr,
        req: Request<Incoming>,
    ) -> Result<Response<ProxyBody>> {
        let req = convert_request_to_string(req).await?;
        for extension in extensions {
            let extension = match extension.runtime.upgrade() {
                Some(ext) => ext,
                None => continue,
            };
            let ext_path = {
                let store = extension.store.read().await;
                Self::extension_path(&store.data)
            };
            if !path_belongs_to(req.uri().path(), &ext_path) {
                continue;
            }
            let context = extension.context.load();
            let Some(context) = context.as_ref() else {
                warn!("Extension at {} not enabled", ext_path);
                continue;
            };
            // Snapshot the request line/headers before the request value is
            // moved into the extension task; file responses need them for
            // method + Range handling.
            let method = req.method().clone();
            let request_headers = req.headers().clone();
            let (send, response) = oneshot::channel();
            let task = Task::HandleProxy { req, send };
            context
                .send(task)
                .context("Failed to send message to Extension Thread")?;

            match response.await?? {
                ProxyResult::Response(resp) => {
                    fn convert_response(response: Response<Bytes>) -> Response<ProxyBody> {
                        let (parts, body) = response.into_parts();
                        let boxed_body = Full::new(body).map_err(|never| match never {}).boxed();
                        Response::from_parts(parts, boxed_body)
                    }
                    let a = convert_response(resp);
                    return Ok(a);
                }
                ProxyResult::File { path, content_type } => {
                    // Same permission rules as the `filesystem` module: the
                    // data dir is free, anything else needs a granted (or
                    // prompted) Storage permission.
                    let resolved =
                        crate::filesystem::ensure_access(&extension, &path, false, false, "serve")
                            .await?;
                    let resp = crate::range_file::serve_file(
                        &resolved,
                        content_type.as_deref(),
                        &method,
                        &request_headers,
                    )
                    .await;
                    return Ok(resp);
                }
                ProxyResult::Redirect(new_req) => {
                    let target: reqwest::Url = new_req
                        .uri()
                        .to_string()
                        .parse()
                        .context("Invalid handleProxy redirect target")?;
                    extension.authorize_url(&target).await?;
                    let request_with_body = new_req.map(|body_string| {
                        Full::new(Bytes::from(body_string))
                            .map_err(|never| match never {})
                            .boxed()
                    });
                    let response =
                        tokio::time::timeout(READ_TIMEOUT, client.request(request_with_body))
                            .await
                            .context("Timed out waiting for handleProxy redirect target")??;
                    let (parts, body) = response.into_parts();
                    let boxed_body = body.map_err(Into::into).boxed();
                    return Ok(Response::from_parts(parts, boxed_body));
                }
            }
        }
        let response = Response::builder()
            .status(StatusCode::NOT_FOUND)
            .header("Content-Type", "text/plain")
            .body(
                Full::new(Bytes::from("No extension found to handle request"))
                    .map_err(|never| match never {})
                    .boxed(),
            )
            .unwrap();
        Ok(response)
    }

    fn register_extension(&mut self, extension: Weak<ProxyExtensionRef>) {
        self.registered_extensions.push(extension);
    }

    fn cleanup_dropped(&mut self) {
        self.registered_extensions
            .retain(|weak| weak.strong_count() > 0);
    }

    async fn get_active_extensions(&self) -> Vec<Arc<ProxyExtensionRef>> {
        self.registered_extensions
            .iter()
            .filter_map(|weak| weak.upgrade())
            .collect()
    }
}

#[derive(Debug)]
pub(crate) struct ProxyExtensionRef {
    runtime: Weak<InnerExtension>,
}

impl ProxyExtensionRef {
    pub async fn new(adapter: &RwLock<Proxy>, runtime: &Arc<InnerExtension>) -> Arc<Self> {
        let id = runtime.store.read().await.data.id.clone();
        let ext = Arc::new(ProxyExtensionRef {
            runtime: Arc::downgrade(runtime),
        });
        let mut proxy = adapter.write().await;
        proxy.cleanup_dropped();
        proxy.register_extension(Arc::downgrade(&ext));
        if let Some(addr) = proxy.addr {
            register_route(id, addr, proxy.token.clone(), Arc::downgrade(&ext));
        }
        ext
    }
}

impl Drop for ProxyExtensionRef {
    fn drop(&mut self) {
        if let Ok(mut routes) = ROUTES.write() {
            routes.retain(|route| route.owner.strong_count() > 0);
        }
    }
}

const PROXY_URL_PREFIX: &str = "proxy://";
const EXTENSION_PATH_PREFIX: &str = "extproxy/";
const LEGACY_URL_PREFIX: &str = "http://127.0.0.1:";

static ROUTES: LazyLock<std::sync::RwLock<Vec<ProxyRoute>>> = LazyLock::new(Default::default);

#[derive(Debug)]
struct ProxyRoute {
    id: String,
    addr: SocketAddr,
    token: String,
    owner: Weak<ProxyExtensionRef>,
}

static ENDPOINTS: LazyLock<std::sync::RwLock<Vec<(SocketAddr, String)>>> =
    LazyLock::new(Default::default);

fn register_endpoint(addr: SocketAddr, token: String) {
    if let Ok(mut endpoints) = ENDPOINTS.write() {
        endpoints.push((addr, token));
    }
}

fn register_route(id: String, addr: SocketAddr, token: String, owner: Weak<ProxyExtensionRef>) {
    let Ok(mut routes) = ROUTES.write() else {
        return;
    };
    routes.retain(|route| route.owner.strong_count() > 0);
    routes.push(ProxyRoute {
        id,
        addr,
        token,
        owner,
    });
}

fn route_for(id: &str) -> Option<(SocketAddr, String)> {
    let routes = ROUTES.read().ok()?;
    routes
        .iter()
        .rev()
        .find(|route| route.id == id && route.owner.strong_count() > 0)
        .map(|route| (route.addr, route.token.clone()))
}

pub fn is_proxy_url(url: &str) -> bool {
    if strip_prefix_ignore_case(url, PROXY_URL_PREFIX).is_some() {
        return true;
    }
    if let Some(rest) = url.strip_prefix(LEGACY_URL_PREFIX)
        && let Some(port_end) = rest.find(|c: char| !c.is_ascii_digit())
        && rest[port_end..]
            .strip_prefix('/')
            .is_some_and(|path| path.starts_with(EXTENSION_PATH_PREFIX))
    {
        return true;
    }
    let Ok(parsed) = url.parse::<reqwest::Url>() else {
        return false;
    };
    let Some(port) = parsed.port_or_known_default() else {
        return false;
    };
    let Ok(endpoints) = ENDPOINTS.read() else {
        return false;
    };
    let is_loopback = parsed.host_str().is_some_and(|host| {
        let host = host.trim_start_matches('[').trim_end_matches(']');
        host.eq_ignore_ascii_case("localhost")
            || host.parse::<IpAddr>().is_ok_and(|ip| ip.is_loopback())
    });
    is_loopback && endpoints.iter().any(|(addr, _)| addr.port() == port)
}

pub fn resolve_proxy_url(url: &str) -> Option<String> {
    let path = if let Some(path) = strip_prefix_ignore_case(url, PROXY_URL_PREFIX) {
        path
    } else {
        let rest = url.strip_prefix(LEGACY_URL_PREFIX)?;
        let port_end = rest.find(|c: char| !c.is_ascii_digit())?;
        rest[port_end..].strip_prefix('/')?
    };
    let after_prefix = path.strip_prefix(EXTENSION_PATH_PREFIX)?;
    let id_end = after_prefix
        .find(['/', '?', '#'])
        .unwrap_or(after_prefix.len());
    let id = &after_prefix[..id_end];
    if id.is_empty() {
        return None;
    }
    let (addr, token) = route_for(id)?;
    if token.is_empty() {
        return Some(format!("http://{addr}/{path}"));
    }
    Some(format!("http://{addr}/{token}/{path}"))
}

fn strip_prefix_ignore_case<'a>(value: &'a str, prefix: &str) -> Option<&'a str> {
    let head = value.get(..prefix.len())?;
    head.eq_ignore_ascii_case(prefix)
        .then(|| &value[prefix.len()..])
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn proxy_routing_stops_at_the_extension_id() {
        assert!(path_belongs_to("/extproxy/foo", "/extproxy/foo"));
        assert!(path_belongs_to("/extproxy/foo/page", "/extproxy/foo"));
        assert!(!path_belongs_to("/extproxy/foo2/page", "/extproxy/foo"));
    }

    #[test]
    fn resolves_proxy_urls_to_the_live_port() {
        let owner = Arc::new(ProxyExtensionRef {
            runtime: Weak::new(),
        });
        let addr: SocketAddr = "127.0.0.1:4321".parse().unwrap();
        register_route(
            "resolve.Test".into(),
            addr,
            "tok".into(),
            Arc::downgrade(&owner),
        );

        assert_eq!(
            resolve_proxy_url("proxy://extproxy/resolve.Test/video.m3u8?q=1").as_deref(),
            Some("http://127.0.0.1:4321/tok/extproxy/resolve.Test/video.m3u8?q=1")
        );
        assert_eq!(
            resolve_proxy_url("proxy://extproxy/resolve.Test").as_deref(),
            Some("http://127.0.0.1:4321/tok/extproxy/resolve.Test")
        );
        assert_eq!(
            resolve_proxy_url("http://127.0.0.1:9999/extproxy/resolve.Test/a").as_deref(),
            Some("http://127.0.0.1:4321/tok/extproxy/resolve.Test/a")
        );
        assert_eq!(resolve_proxy_url("proxy://extproxy/resolve.Testx/a"), None);
        assert_eq!(
            resolve_proxy_url("https://example.com/extproxy/resolve.Test"),
            None
        );

        drop(owner);
        assert_eq!(resolve_proxy_url("proxy://extproxy/resolve.Test"), None);
    }

    #[test]
    fn token_and_host_checks() {
        assert_eq!(
            strip_token("/tok/extproxy/a/b", "tok"),
            Some("/extproxy/a/b")
        );
        assert_eq!(strip_token("/extproxy/a/b", "tok"), None);
        assert_eq!(strip_token("/tokx/extproxy/a", "tok"), None);
        assert_eq!(strip_token("/extproxy/a", ""), Some("/extproxy/a"));

        let addr: SocketAddr = "127.0.0.1:4321".parse().unwrap();
        assert!(is_loopback_host(Some("127.0.0.1:4321"), Some(addr)));
        assert!(is_loopback_host(Some("localhost:4321"), Some(addr)));
        assert!(is_loopback_host(None, Some(addr)));
        assert!(!is_loopback_host(Some("evil.example:4321"), Some(addr)));
        assert!(!is_loopback_host(Some("127.0.0.1:80"), Some(addr)));
    }

    #[test]
    fn proxy_urls_are_recognised() {
        assert!(is_proxy_url("proxy://extproxy/a/b"));
        assert!(is_proxy_url("PROXY://extproxy/a"));
        assert!(is_proxy_url("http://127.0.0.1:1234/extproxy/a"));
        assert!(!is_proxy_url("https://example.com/extproxy/a"));
    }

    #[test]
    fn response_body_defaults_to_utf8() {
        let json = serde_json::json!({
            "type": "response",
            "status": 200,
            "body": "hello",
        });
        let result: ProxyResult = json.try_into().unwrap();
        let ProxyResult::Response(resp) = result else {
            panic!("expected response");
        };
        assert_eq!(resp.body(), &Bytes::from_static(b"hello"));
    }

    #[test]
    fn response_body_base64_encoding() {
        let json = serde_json::json!({
            "type": "response",
            "status": 200,
            "bodyEncoding": "base64",
            "body": "AAECA/8=",
        });
        let result: ProxyResult = json.try_into().unwrap();
        let ProxyResult::Response(resp) = result else {
            panic!("expected response");
        };
        assert_eq!(resp.body(), &Bytes::from_static(&[0, 1, 2, 3, 255]));
    }
}
