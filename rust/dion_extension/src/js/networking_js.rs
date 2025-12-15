use crate::{
    extension::executor::ExtensionRuntimeDataContainer,
    utils::{MapJsResult, VirtualModuleLoader},
};
use anyhow::{Context as ErrorContext, Result};
use boa_engine::{
    Context, JsArgs, JsData, JsError, JsNativeError, JsObject, JsResult, JsString, JsValue, Module,
    NativeFunction,
    class::{self, Class},
    job::NativeAsyncJob,
    js_string,
    module::SyntheticModuleInitializer,
    object::{
        FunctionObjectBuilder,
        builtins::{JsArray, JsMap, JsPromise},
    },
    property::Attribute,
    value::Type,
};
use boa_gc::{Finalize, Trace};
use cookie::Expiration;
use http::{HeaderMap, StatusCode};
use reqwest::Method;
use serde_json::Value;
use std::{cell::RefCell, rc::Rc};
pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    context
        .register_global_class::<Response>()
        .map_anyhow_ctx(context)
        .context("Failed to Register Response class")?;
    let fetch_fn = FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(fetch))
        .length(1)
        .name("fetch")
        .build();
    let get_cookies_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(get_cookies))
            .length(0)
            .name("getCookies")
            .build();
    let get_proxy_address_fn = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(get_proxy_address),
    )
    .length(0)
    .name("getProxyAddress")
    .build();
    let module = Module::synthetic(
        &[
            js_string!("fetch"),
            js_string!("getCookies"),
            js_string!("getProxyAddress"),
        ],
        SyntheticModuleInitializer::from_copy_closure_with_captures(
            move |m, (fetch_fn, get_cookies_fn, get_proxy_address_fn), _ctx| {
                m.set_export(&js_string!("fetch"), fetch_fn.clone().into())?;
                m.set_export(&js_string!("getCookies"), get_cookies_fn.clone().into())?;
                m.set_export(
                    &js_string!("getProxyAddress"),
                    get_proxy_address_fn.clone().into(),
                )?;
                Ok(())
            },
            (fetch_fn, get_cookies_fn, get_proxy_address_fn),
        ),
        None,
        None,
        context,
    );
    loader.insert("network".to_string(), module);
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
                return Ok(JsString::from(person.content.as_str()).into());
            }
        }
        // If `this` was not an object or the type of `this` was not a native object `Person`,
        // we throw a `TypeError`.
        Err(JsNativeError::typ()
            .with_message("'this' is not a Response object")
            .into())
    }
    fn get_header(this: &JsValue, _: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        // We check if this is an object.
        if let Some(object) = this.as_object() {
            // If it is we downcast the type to type `Person`.
            if let Some(response) = object.downcast_ref::<Self>() {
                let header = &response.header;
                let map = JsMap::new(context);
                for (name, value) in header.iter() {
                    let name = JsString::from(name.as_str());
                    let Ok(value) = value.to_str() else {
                        continue;
                    };
                    let value = JsString::from(value);
                    map.set(name, value, context)?;
                }
                return Ok(map.into());
            }
        }
        // If `this` was not an object or the type of `this` was not a native object `Person`,
        // we throw a `TypeError`.
        Err(JsNativeError::typ()
            .with_message("'this' is not a Response object")
            .into())
    }
    fn get_json(this: &JsValue, _: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object()
            && let Some(this) = object.downcast_ref::<Self>()
        {
            let ret = &this.content;
            let ret = serde_json::from_str(ret).map_err(|err| {
                JsError::from_native(JsNativeError::error().with_message(err.to_string()))
            })?; //TODO: do a cleaner convert
            let ret = JsValue::from_json(&ret, context)?;
            return Ok(ret);
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Response object")
            .into())
    }
    fn is_ok(this: &JsValue, _: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object()
            && let Some(this) = object.downcast_ref::<Self>()
        {
            let ret = this.status;
            let ret = ret.is_success();
            return Ok(ret.into());
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Response object")
            .into())
    }
    fn status(this: &JsValue, _: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object()
            && let Some(this) = object.downcast_ref::<Self>()
        {
            let ret = this.status;
            let ret = ret.as_u16();
            return Ok(ret.into());
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Response object")
            .into())
    }
}

impl Class for Response {
    const NAME: &'static str = "Response";

    fn init(class: &mut class::ClassBuilder<'_>) -> JsResult<()> {
        let getter_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::get_body),
        )
        .length(0)
        .name("body")
        .build();
        class.accessor(
            js_string!("body"),
            Some(getter_fn),
            None,
            Attribute::READONLY,
        );
        let header_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::get_header),
        )
        .length(0)
        .name("headers")
        .build();
        class.accessor(
            js_string!("headers"),
            Some(header_fn),
            None,
            Attribute::READONLY,
        );
        let getter_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::get_json),
        )
        .length(0)
        .name("json")
        .build();
        class.accessor(
            js_string!("json"),
            Some(getter_fn),
            None,
            Attribute::READONLY,
        );
        let getter_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::is_ok),
        )
        .length(0)
        .name("ok")
        .build();
        class.accessor(js_string!("ok"), Some(getter_fn), None, Attribute::READONLY);
        let getter_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::status),
        )
        .length(0)
        .name("status")
        .build();
        class.accessor(
            js_string!("status"),
            Some(getter_fn),
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

fn fetch(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let resource = args
        .get_or_undefined(0)
        .to_string(context)
        .map(|str| str.to_std_string_lossy())
        .clone();
    let options = args.get_or_undefined(1);
    let options = match options.get_type() {
        Type::Object => options.to_json(context),
        _ => Ok(Some(Value::Null)),
    };
    let network: Option<&ExtensionRuntimeDataContainer> = context.get_data();
    let network = network.cloned();

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(NativeAsyncJob::with_realm(
        async move |context: &RefCell<&mut Context>| {
                match async {
                    let resource = resource?;
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

fn get_cookies(_this: &JsValue, _args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
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
        let obj = JsObject::default();
        obj.set(
            js_string!("httpOnly"),
            cookie.http_only().unwrap_or_default(),
            true,
            context,
        )?;
        obj.set(
            js_string!("secure"),
            cookie.secure().unwrap_or_default(),
            true,
            context,
        )?;
        obj.set(
            js_string!("name"),
            JsString::from(cookie.name()),
            true,
            context,
        )?;
        obj.set(
            js_string!("value"),
            JsString::from(if cookie.http_only().unwrap_or_default() {
                ""
            } else {
                cookie.value()
            }),
            true,
            context,
        )?;
        if let Some(domain) = cookie.domain() {
            obj.set(js_string!("domain"), JsString::from(domain), true, context)?;
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

fn get_proxy_address(
    _this: &JsValue,
    _args: &[JsValue],
    context: &mut Context,
) -> JsResult<JsValue> {
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
