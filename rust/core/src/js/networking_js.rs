use anyhow::{anyhow, Context as ErrorContext, Result};
use boa_engine::{
    class::{self, Class},
    job::NativeAsyncJob,
    js_string,
    module::SyntheticModuleInitializer,
    object::{
        builtins::{JsArray, JsMap, JsPromise},
        FunctionObjectBuilder,
    },
    property::Attribute,
    value::Type,
    Context, JsArgs, JsData, JsError, JsNativeError, JsResult, JsString, JsValue, Module,
    NativeFunction,
};
use boa_gc::{Finalize, Trace};
use governor::{DefaultKeyedRateLimiter, Quota, RateLimiter};
use http::{Extensions, HeaderMap, StatusCode};
use nonzero_ext::nonzero;
use reqwest::{IntoUrl, Method, Request, Url};
use reqwest_cookie_store::{CookieStore, CookieStoreMutex};
use reqwest_middleware::{ClientBuilder, ClientWithMiddleware, Middleware, Next, RequestBuilder};
use serde_json::Value;
use std::sync::Arc;

use crate::extension::utils::{MapJsResult, ReadOnlyUserContextContainer};

pub fn declare(context: &mut Context) -> Result<()> {
    context
        .register_global_class::<Response>()
        .map_anyhow_ctx(context)
        .context("Failed to Register Response class")?;
    context.insert_data(NetworkContainer::default());
    let fetch_fn = FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(fetch))
        .length(1)
        .name("fetch")
        .build();
    let get_cookies_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(get_cookies))
            .length(0)
            .name("getCookies")
            .build();
    context.module_loader().register_module(
        js_string!("network"),
        Module::synthetic(
            &[js_string!("fetch"), js_string!("getCookies")],
            SyntheticModuleInitializer::from_copy_closure_with_captures(
                move |m, (fetch_fn, get_cookies_fn), _ctx| {
                    m.set_export(&js_string!("fetch"), fetch_fn.clone().into())?;
                    m.set_export(&js_string!("getCookies"), get_cookies_fn.clone().into())?;
                    Ok(())
                },
                (fetch_fn, get_cookies_fn),
            ),
            None,
            None,
            context,
        ),
    );
    Ok(())
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

impl Response {
    fn get_body(this: &JsValue, _: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        // We check if this is an object.
        if let Some(object) = this.as_object() {
            // If it is we downcast the type to type `Person`.
            if let Some(person) = object.downcast_ref::<Self>() {
                let _ = &person.header; //TODO: Fix
                let _ = &person.status;
                return Ok(JsString::from(person.content.as_str()).into());
            }
        }
        // If `this` was not an object or the type of `this` was not a native object `Person`,
        // we throw a `TypeError`.
        Err(JsNativeError::typ()
            .with_message("'this' is not a Response object")
            .into())
    }
}

impl Class for Response {
    const NAME: &'static str = "Response";

    fn init(class: &mut class::ClassBuilder<'_>) -> JsResult<()> {
        class.method(
            js_string!("sayHello"),
            0,
            NativeFunction::from_fn_ptr(Self::get_body),
        );
        let get_body_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::get_body),
        )
        .length(0)
        .name("body")
        .build();
        class.accessor(
            js_string!("body"),
            Some(get_body_fn),
            None,
            Attribute::READONLY,
        );
        Ok(())
    }

    fn data_constructor(
        _new_target: &JsValue,
        _args: &[JsValue],
        _context: &mut Context,
    ) -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error()))
    }
}

// fn fetch(
//     _this: &JsValue,
//     args: &[JsValue],
//     context: &mut Context,
// ) -> impl Future<Output = JsResult<JsValue>> {
//     let resource = args
//         .get_or_undefined(0)
//         .to_string(context)
//         .map(|str| str.to_std_string_lossy())
//         .clone();
//     let options = args.get_or_undefined(1);
//     let options = match options.get_type() {
//         Type::Object => options.to_json(context),
//         _ => Ok(Value::Null),
//     };
//     let network: Option<&NetworkContainer> = context.get_data();
//     let network = network.cloned();
//     let prototype = context
//         .get_global_class::<Response>()
//         .ok_or_else(|| {
//             JsNativeError::typ().with_message(format!(
//                 "could not find native class `{}` in the map of registered classes",
//                 Response::NAME
//             ))
//         })
//         .map(|prot| prot.prototype());

//     async move {
//         let prototype = prototype?;
//         let resource = resource?;
//         let networkcontainer = network.ok_or(JsError::from_native(JsNativeError::error()))?;
//         let options = options?;
//         let options = options.as_object().cloned();
//         let method = match &options {
//             Some(options) => {
//                 if options.contains_key("method") {
//                     match options["method"].as_str() {
//                         Some("GET") => Method::GET,
//                         Some("HEAD") => Method::HEAD,
//                         Some("POST") => Method::POST,
//                         Some("PUT") => Method::PUT,
//                         Some("DELETE") => Method::DELETE,
//                         Some("CONNECT") => Method::CONNECT,
//                         Some("TRACE") => Method::TRACE,
//                         Some("PATCH") => Method::PATCH,
//                         _ => Method::GET, //Maybe we should explicitly fail here
//                     }
//                 } else {
//                     Method::GET
//                 }
//             }
//             None => Method::GET,
//         };

//         let mut rbuild = networkcontainer.request(method, resource);
//         if let Some(options) = &options {
//             if options.contains_key("body") {
//                 rbuild = rbuild.body(
//                     options["body"]
//                         .as_str()
//                         .ok_or(JsError::from_native(
//                             JsNativeError::error().with_message("Expected body to be a String"),
//                         ))?
//                         .to_string(),
//                 );
//             }
//         }
//         // //TODO! cache
//         if let Some(options) = &options {
//             if options.contains_key("headers") {
//                 let cheaders = options["header"].as_object().ok_or(JsError::from_native(
//                     JsNativeError::error().with_message("Option Header should be a object"),
//                 ))?;
//                 for (header, content) in cheaders.iter() {
//                     rbuild = rbuild.header(
//                         header,
//                         content.as_str().ok_or(JsError::from_native(
//                             JsNativeError::error().with_message(format!(
//                                 "Invalid Header value {header} expected String got {content}"
//                             )),
//                         ))?,
//                     );
//                 }
//             }
//         }
//         println!("Network");
//         // let response = rbuild.send().await.map_err(|e| JsError::from_rust(e))?;
//         // let text = response.text().await.map_err(|e| JsError::from_rust(e))?;
//         // println!("{}", text);
//         // let res = Response { 0: response };
//         // Ok(JsObject::from_proto_and_data(prototype, res).into())
//         Ok(JsValue::undefined())
//     }
// }

fn fetch(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let resource = args
        .get_or_undefined(0)
        .to_string(context)
        .map(|str| str.to_std_string_lossy())
        .clone();
    let options = args.get_or_undefined(1);
    let options = match options.get_type() {
        Type::Object => options.to_json(context),
        _ => Ok(Value::Null),
    };
    let network: Option<&NetworkContainer> = context.get_data();
    let network = network.cloned();

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(boa_engine::job::Job::AsyncJob(NativeAsyncJob::with_realm(
        move |context| {
            Box::pin(async move {
                match async {
                    let resource = resource?;
                    let networkcontainer = network.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let options = options?;
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

                    let mut rbuild = networkcontainer.request(method, resource);
                    if let Some(options) = &options {
                        if options.contains_key("body") {
                            rbuild = rbuild.body(
                                options["body"]
                                    .as_str()
                                    .ok_or(JsError::from_native(
                                        JsNativeError::error().with_message("Expected body to be a String"),
                                    ))?
                                    .to_string(),
                            );
                        }
                    }
                    // //TODO! cache
                    if let Some(options) = &options {
                        if options.contains_key("headers") {
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
                    }
                    let response = rbuild.send().await.map_err(|e| JsError::from_rust(e))?;
                    let res = Response {
                        status: response.status(),
                        header: response.headers().clone(),
                        content: response.text().await.map_err(|e| JsError::from_rust(e))?,
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
                    Err(err) => resolve.reject.call(
                        &promise.into(),
                        &[JsString::from(err.to_string()).into()],
                        &mut context.borrow_mut(),
                    )?,
                };
                Ok(JsValue::undefined())
            })
        },
        context.realm().clone(),
    )));
    Ok(ret.into())
}

fn get_cookies(_this: &JsValue, _args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let network: NetworkContainer = context.get_data().cloned().ok_or(JsError::from_native(
        JsNativeError::error().with_message("Expected body to be a String"),
    ))?;
    let network = network.cookies.lock().unwrap();
    let array = JsArray::new(context);
    for cookie in network.iter_unexpired() {
        let map = JsMap::new(context);
        map.set(js_string!("name"), JsString::from(cookie.name()), context)?;
        map.set(js_string!("value"), JsString::from(cookie.value()), context)?;
        array.push(map, context)?;
    }
    Ok(JsPromise::resolve(array, context).into())
}

struct RateLimitingMiddleware {
    ratelimiter: DefaultKeyedRateLimiter<Url>,
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
        self.ratelimiter.until_key_ready(req.url()).await;
        next.run(req, extensions).await
    }
}

type NetworkContainer = ReadOnlyUserContextContainer<NetworkManager>;

#[derive(Clone)]
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
        let client = reqwest::Client::builder()
            .cookie_provider(cookie_store.clone())
            .build()
            .unwrap();
        let client = ClientBuilder::new(client)
            .with(RateLimitingMiddleware::default())
            .build();
        Self {
            cookies: cookie_store.clone(),
            nclient: client,
        }
    }
}
