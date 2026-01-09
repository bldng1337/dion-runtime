use crate::utils::MapJsResult;
use crate::utils::VirtualModuleLoader;
use anyhow::Context as ErrorContext;
use anyhow::Result;
use boa_engine::boa_class;
use boa_engine::{
    Context, JsData, JsError, JsNativeError, JsResult, JsString, JsValue, boa_module,
    object::builtins::JsMap,
};
use boa_gc::{Finalize, Trace};
use http::{HeaderMap, StatusCode};
use std::rc::Rc;
pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    context
        .register_global_class::<Response>()
        .map_anyhow_ctx(context)
        .context("Failed to Register Response class")?;
    loader.insert("network".to_string(), network::boa_module(None, context));
    Ok(())
}

#[boa_module]
mod network {
    use super::Response;
    use crate::extension::executor::ExtensionRuntimeDataContainer;
    use boa_engine::{
        Context, JsError, JsNativeError, JsResult, JsString, JsValue,
        class::Class,
        job::NativeAsyncJob,
        js_object, js_string,
        object::builtins::{JsArray, JsPromise},
        value::Type,
    };
    use cookie::Expiration;
    use reqwest::Method;
    use serde_json::Value;
    use std::cell::RefCell;

    fn fetch(resource: String, options: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let network: Option<&ExtensionRuntimeDataContainer> = context.get_data();
        let network = network.cloned();

        let options = match options.get_type() {
            Type::Object => options.to_json(context),
            _ => Ok(Some(Value::Null)),
        };

        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                    match async {
                        let resource = resource;
                        let networkcontainer = network.ok_or(JsError::from_native(JsNativeError::error()))?;
                        let Some(networkcontainer) = networkcontainer.inner.upgrade() else {
                            return Err(JsError::from_native(
                                JsNativeError::error().with_message("Network container has been dropped"),
                            ));
                        };
                        let options = options?.unwrap_or(Value::Null);
                        let options = options.as_object().cloned();
                        let method = match &options {
                            Some(options) => {
                                if options.contains_key("method") {
                                    match options["method"].as_str() {
                                        Some("GET") => Method::GET,
                                        Some("HEAD") => Method::HEAD,
                                        Some("POST") => Method::POST,
                                        Some("PUT") => Method::PUT,
                                        Some("DELETE") => Method::DELETE,
                                        Some("CONNECT") => Method::CONNECT,
                                        Some("TRACE") => Method::TRACE,
                                        Some("PATCH") => Method::PATCH,
                                        _ => Method::GET, //Maybe we should explicitly fail here
                                    }
                                } else {
                                    Method::GET
                                }
                            }
                            None => Method::GET,
                        };
                        let mut rbuild = networkcontainer.network.nclient.request(method, resource);
                        if let Some(options) = &options && options.contains_key("body") {
                            rbuild = rbuild.body(
                                options["body"]
                                    .as_str()
                                    .ok_or(JsError::from_native(
                                        JsNativeError::error().with_message("Expected body to be a String"),
                                    ))?
                                    .to_string(),
                            );
                        }
                        if let Some(options) = &options &&options.contains_key("headers") {
                            let cheaders = options["headers"].as_object().ok_or(JsError::from_native(
                                JsNativeError::error().with_message("Option Header should be a object"),
                            ))?;
                            for (header, content) in cheaders.iter() {
                                rbuild = rbuild.header(
                                    header,
                                    content.as_str().ok_or(JsError::from_native(
                                        JsNativeError::error().with_message(format!(
                                            "Invalid Header value {header} expected String got {content}"
                                        )),
                                    ))?,
                                );
                            }
                        }
                        let response = rbuild.send().await.map_err(JsError::from_rust)?;
                        let res = Response {
                            status: response.status(),
                            header: response.headers().clone(),
                            content: response.text().await.map_err(JsError::from_rust)?,
                        };
                        let res=Class::from_data(res, &mut context.borrow_mut())?;
                        Ok(res.into())
                    }.await as JsResult<JsValue>
                    {
                        Ok(val) => {
                            resolve
                                .resolve
                                .call(&promise.into(), &[val], &mut context.borrow_mut())?
                        }
                        Err(err) => {
                            let mut context = context.borrow_mut();
                            resolve.reject.call(
                                &promise.into(),
                                &[err.to_opaque(&mut context)],
                                &mut context,
                            )?
                        },
                    };
                    Ok(JsValue::undefined())
            },
            context.realm().clone(),
        ).into());
        Ok(ret.into())
    }

    fn get_cookies(context: &mut Context) -> JsResult<JsValue> {
        let network: ExtensionRuntimeDataContainer = context.get_data().cloned().ok_or(
            JsError::from_native(JsNativeError::error().with_message("Failed to get runtime data")),
        )?;
        let Some(network) = network.inner.upgrade() else {
            return Err(JsError::from_native(
                JsNativeError::error().with_message("Network container has been dropped"),
            ));
        };
        let cookies = network
            .network
            .cookies
            .lock()
            .expect("CookieLock is Poisoned");
        let array = JsArray::new(context);
        for cookie in cookies.iter_unexpired() {
            let obj = js_object!({
                "httpOnly": cookie.http_only().unwrap_or_default(),
                "secure": cookie.secure().unwrap_or_default(),
                "name": js_string!(cookie.name()),
                "value": js_string!(if cookie.http_only().unwrap_or_default() {
                    ""
                } else {
                    cookie.value()
                }),
            }, context);
            if let Some(domain) = cookie.domain() {
                obj.set(js_string!("domain"), js_string!(domain), true, context)?;
            }
            if let Some(expires) = cookie.expires() {
                // TODO: feature: temporal on boa
                // match expires {
                //     Expiration::DateTime(time) => {
                //         let (h, m, _) = time.offset().as_hms();
                //         let offset = format!("{:+03}:{:02}", h, m.abs());
                //         context
                //             .realm()
                //             .intrinsics()
                //             .constructors()
                //             .zoned_date_time()
                //             .constructor()
                //             .construct(
                //                 &[
                //                     JsBigInt::from(time.unix_timestamp_nanos()).into(),
                //                     JsString::from(offset).into(),
                //                 ],
                //                 None,
                //                 context,
                //             )?;
                //     }
                //     Expiration::Session => {
                //         obj.set(
                //             js_string!("expires"),
                //             JsString::from("session"),
                //             true,
                //             context,
                //         )?;
                //     }
                // }
                obj.set(
                    js_string!("expires"),
                    JsString::from(match expires {
                        Expiration::DateTime(time) => time.to_string(),
                        Expiration::Session => "session".to_string(),
                    }),
                    true,
                    context,
                )?;
            }
            if let Some(path) = cookie.path() {
                obj.set(js_string!("path"), JsString::from(path), true, context)?;
            }
            // if let Some(max_age) = cookie.max_age() {
            //     let val = context
            //         .realm()
            //         .intrinsics()
            //         .constructors()
            //         .duration()
            //         .constructor()
            //         .construct(
            //             &[
            //                 0.into(),
            //                 0.into(),
            //                 0.into(),
            //                 0.into(),
            //                 0.into(),
            //                 0.into(),
            //                 max_age.as_seconds_f64().into(),
            //             ],
            //             None,
            //             context,
            //         )?;
            //     obj.set(
            //         js_string!("maxAge"),
            //         val, //JsValue::rational(max_age.as_seconds_f64()),
            //         true,
            //         context,
            //     )?;
            // }
            array.push(obj, context)?;
        }
        Ok(array.into())
    }

    fn get_proxy_address(context: &mut Context) -> JsResult<JsValue> {
        let network: ExtensionRuntimeDataContainer = context.get_data().cloned().ok_or(
            JsError::from_native(JsNativeError::error().with_message("Failed to get runtime data")),
        )?;
        let Some(network) = network.inner.upgrade() else {
            return Err(JsError::from_native(
                JsNativeError::error().with_message("Network container has been dropped"),
            ));
        };
        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(<boa_engine::job::Job>::from(NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let proxy = network.proxy.read().await;
                    let uri = proxy.get_extension_uri(&network.store.read().await.data);
                    let Some(uri) = uri else {
                        return Ok(JsValue::undefined());
                    };
                    Ok(JsString::from(uri).into())
                }
                .await as JsResult<JsValue>
                {
                    Ok(val) => {
                        resolve
                            .resolve
                            .call(&promise.into(), &[val], &mut context.borrow_mut())?
                    }
                    Err(err) => {
                        let mut context = context.borrow_mut();
                        resolve.reject.call(
                            &promise.into(),
                            &[err.to_opaque(&mut context)],
                            &mut context,
                        )?
                    }
                };
                Ok(JsValue::undefined())
            },
            context.realm().clone(),
        )));
        Ok(ret.into())
    }
}

#[derive(Debug, Trace, Finalize, JsData)]
struct Response {
    #[unsafe_ignore_trace]
    content: String,
    #[unsafe_ignore_trace]
    status: StatusCode,
    #[unsafe_ignore_trace]
    header: HeaderMap,
}

#[boa_class]
impl Response {
    #[boa(constructor)]
    fn new() -> JsResult<Self> {
        Err(JsError::from_native(
            JsNativeError::error().with_message("Response cannot be directly constructed"),
        ))
    }

    #[boa(getter)]
    fn body(#[boa(error = "`this` was not an Response")] &self) -> String {
        self.content.clone()
    }

    #[boa(getter)]
    fn headers(
        #[boa(error = "`this` was not an Response")] &self,
        context: &mut Context,
    ) -> JsResult<JsMap> {
        let header = &self.header;
        let map = JsMap::new(context);
        for (name, value) in header.iter() {
            let name = JsString::from(name.as_str());
            let Ok(value) = value.to_str() else {
                continue;
            };
            let value = JsString::from(value);
            map.set(name, value, context)?;
        }
        Ok(map)
    }

    #[boa(getter)]
    fn json(
        #[boa(error = "`this` was not an Response")] &self,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let ret = &self.content;
        let ret = serde_json::from_str(ret).map_err(|err| {
            JsError::from_native(JsNativeError::error().with_message(err.to_string()))
        })?; //TODO: do a cleaner convert
        let ret = JsValue::from_json(&ret, context)?;
        Ok(ret)
    }

    #[boa(getter)]
    fn ok(#[boa(error = "`this` was not an Response")] &self) -> bool {
        self.status.is_success()
    }

    #[boa(getter)]
    fn status(#[boa(error = "`this` was not an Response")] &self) -> u16 {
        self.status.as_u16()
    }
}
