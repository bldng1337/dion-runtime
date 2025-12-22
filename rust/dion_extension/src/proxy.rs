use crate::extension::{container::InnerExtension, executor::Task};
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
    sync::{Arc, Weak},
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

pub(crate) fn value_to_response(value: serde_json::Value) -> Result<Response<String>> {
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

    // body (optional)
    let body = obj
        .get("body")
        .and_then(|v| v.as_str())
        .unwrap_or("")
        .to_string();

    let response = builder
        .body(body)
        .context("Failed to build Response<String> from JSON")?;

    Ok(response)
}

async fn convert_request_to_string(req: Request<Incoming>) -> Result<Request<String>> {
    let (parts, body) = req.into_parts();

    let whole_body = body.collect().await?.to_bytes();

    let body_string = String::from_utf8(whole_body.to_vec())?;

    Ok(Request::from_parts(parts, body_string))
}

#[derive(Debug)]
pub(crate) enum ProxyResult {
    Redirect(Request<String>),
    Response(Response<String>),
}

impl TryFrom<serde_json::Value> for ProxyResult {
    type Error = anyhow::Error;

    fn try_from(value: serde_json::Value) -> Result<Self, Self::Error> {
        let obj = value
            .as_object()
            .context("Expected JSON object for ProxyResult")?;

        // Determine type field to decide whether this is a Redirect or a Response
        let type_str = obj.get("type").and_then(|v| v.as_str()).context(
            "Missing or invalid 'type' field for ProxyResult; expected 'redirect' or 'response'",
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
            other => anyhow::bail!("Unknown ProxyResult type: {}", other),
        }
    }
}

#[derive(Debug)]
pub(crate) struct Proxy {
    registered_extensions: Vec<Weak<ProxyExtensionRef>>,
    abort_handle: Option<AbortOnDrop<JoinHandle<()>>>,
    addr: Option<SocketAddr>,
    client: Client<HttpsConnector<HttpConnector>, BoxBody<Bytes, hyper::Error>>,
}

impl Proxy {
    pub async fn new() -> Arc<RwLock<Self>> {
        let mut http = HttpConnector::new();
        http.enforce_http(false);

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
            client: Client::builder(TokioExecutor::new()).build(https),
        }));
        async fn handle(
            proxy_copy: Weak<RwLock<Proxy>>,
            client_ip: IpAddr,
            req: Request<Incoming>,
        ) -> Result<Response<BoxBody<Bytes, hyper::Error>>, Infallible> {
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
            match proxy.read().await.handle(client_ip, req).await {
                Ok(response) => Ok(response),
                Err(err) => Ok(Response::builder()
                    .status(StatusCode::INTERNAL_SERVER_ERROR)
                    .body(
                        Full::new(Bytes::from(format!("Internal server error: {:?}", err)))
                            .map_err(|never| match never {})
                            .boxed(),
                    )
                    .unwrap()),
            }
        }
        let weak_proxy = Arc::downgrade(&proxy);

        if let Ok(listener) =
            TcpListener::bind(SocketAddr::V4(SocketAddrV4::new(Ipv4Addr::LOCALHOST, 0))).await
        {
            let local_addr = listener.local_addr().unwrap();

            let mut proxy_lock = proxy.write().await;
            proxy_lock.addr = Some(local_addr);

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
        let addr = self.addr?;
        Some(format!(
            "http://{}:{}{}",
            addr.ip(),
            addr.port(),
            self.get_extension_path(data)
        ))
    }

    fn get_extension_path(&self, data: &ExtensionData) -> String {
        format!("/extproxy/{}", data.id)
    }

    async fn handle(
        &self,
        _client_ip: IpAddr,
        req: Request<Incoming>,
    ) -> Result<Response<BoxBody<Bytes, hyper::Error>>> {
        let req = convert_request_to_string(req).await?;
        for extension in self.get_active_extensions().await {
            let extension = match extension.runtime.upgrade() {
                Some(ext) => ext,
                None => continue,
            };
            let ext_path = {
                let store = extension.store.read().await;
                self.get_extension_path(&store.data)
            };
            if !req.uri().path().starts_with(ext_path.as_str()) {
                continue;
            }
            let context = extension.context.load();
            let Some(context) = context.as_ref() else {
                warn!("Extension at {} not enabled", ext_path);
                continue;
            };
            let (send, response) = oneshot::channel();
            let task = Task::HandleProxy { req, send };
            context
                .send(task)
                .context("Failed to send message to Extension Thread")?;

            match response.await?? {
                ProxyResult::Response(resp) => {
                    fn convert_response(
                        response: Response<String>,
                    ) -> Response<BoxBody<Bytes, hyper::Error>> {
                        let (parts, body) = response.into_parts();

                        // Convert String to Full<Bytes>, map error, and box it
                        let boxed_body = Full::new(Bytes::from(body))
                            .map_err(|never| match never {})
                            .boxed();

                        Response::from_parts(parts, boxed_body)
                    }
                    let a = convert_response(resp);
                    return Ok(a);
                }
                ProxyResult::Redirect(new_req) => {
                    let request_with_body = new_req.map(|body_string| {
                        Full::new(Bytes::from(body_string))
                            .map_err(|never| match never {})
                            .boxed()
                    });
                    let response = self.client.request(request_with_body).await?;
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
    pub async fn new(adapter: &RwLock<Proxy>, runtime: Weak<InnerExtension>) -> Arc<Self> {
        let ext = Arc::new(ProxyExtensionRef { runtime });
        let mut proxy = adapter.write().await;
        proxy.cleanup_dropped();
        proxy.register_extension(Arc::downgrade(&ext));
        ext
    }
}
