use std::cell::RefCell;
use std::rc::Rc;

use boa_engine::module::SyntheticModuleInitializer;
use boa_engine::object::FunctionObjectBuilder;
use boa_engine::{Context, JsString, Module, NativeFunction};
use boa_engine::{
    JsArgs, JsError, JsNativeError, JsResult, JsValue,
    job::NativeAsyncJob,
    js_string,
    object::builtins::{JsArray, JsPromise},
};

use anyhow::Result;
use dion_runtime::data::auth::Account;

use crate::extension::executor::ExtensionRuntimeDataContainer;
use crate::utils::VirtualModuleLoader;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    let merge_auth_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(merge_auth))
            .length(1)
            .name("mergeAuth")
            .build();
    let is_logged_in_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(is_logged_in))
            .length(2)
            .name("isLoggedIn")
            .build();
    let invalidate_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(invalidate))
            .length(1)
            .name("invalidate")
            .build();
    let get_auth_secret_fn = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(get_auth_secret),
    )
    .length(1)
    .name("getAuthSecret")
    .build();
    let module = Module::synthetic(
        &[
            js_string!("mergeAuth"),
            js_string!("isLoggedIn"),
            js_string!("invalidate"),
            js_string!("getAuthSecret"),
        ],
        SyntheticModuleInitializer::from_copy_closure_with_captures(
            move |m, (merge_auth_fn, is_logged_in_fn, invalidate_fn, get_auth_secret_fn), _ctx| {
                m.set_export(&js_string!("mergeAuth"), merge_auth_fn.clone().into())?;
                m.set_export(&js_string!("isLoggedIn"), is_logged_in_fn.clone().into())?;
                m.set_export(&js_string!("invalidate"), invalidate_fn.clone().into())?;
                m.set_export(
                    &js_string!("getAuthSecret"),
                    get_auth_secret_fn.clone().into(),
                )?;
                Ok(())
            },
            (
                merge_auth_fn,
                is_logged_in_fn,
                invalidate_fn,
                get_auth_secret_fn,
            ),
        ),
        None,
        None,
        context,
    );
    loader.insert("auth".to_string(), module);
    Ok(())
}

fn merge_auth(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let account_json = args.get_or_undefined(0).to_json(context)?;
    let account: JsResult<Account> =
        serde_json::from_value(account_json.unwrap_or(serde_json::json!(null))).map_err(|e| {
            JsError::from_native(
                JsNativeError::error().with_message(format!("Failed to parse account: {}", e)),
            )
        });

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(<boa_engine::job::Job>::from(NativeAsyncJob::with_realm(
        async move |context: &RefCell<&mut Context>| {
            match async {
                let account = account?;
                let runtime_data: Option<ExtensionRuntimeDataContainer> =
                    context.borrow().get_data().cloned();
                let runtime_data =
                    runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                let Some(runtime_data) = runtime_data.inner.upgrade() else {
                    return Err(JsError::from_native(
                        JsNativeError::error().with_message("Runtime container has been dropped"),
                    ));
                };
                let mut ext_store = runtime_data.store.write().await;

                ext_store.auth.merge_auth(&account);
                ext_store
                    .auth
                    .save_state(runtime_data.client.as_ref())
                    .await
                    .map_err(|e| JsError::from_rust(&*e))?;

                Ok(JsValue::undefined())
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

fn is_logged_in(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let domain = args.get_or_undefined(0).to_string(context);

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let domain = domain?.to_std_string_lossy();

                    let runtime_data: Option<ExtensionRuntimeDataContainer> =
                        context.borrow().get_data().cloned();
                    let runtime_data =
                        runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let Some(runtime_data) = runtime_data.inner.upgrade() else {
                        return Err(JsError::from_native(
                            JsNativeError::error()
                                .with_message("Runtime container has been dropped"),
                        ));
                    };
                    let ext_store = runtime_data.store.read().await;

                    let res = ext_store.auth.is_logged_in(&domain);
                    Ok(res.into())
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
        )
        .into(),
    );
    Ok(ret.into())
}

fn invalidate(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let domain = args.get_or_undefined(0).to_string(context);

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let domain = domain?.to_std_string_lossy();

                    let runtime_data: Option<ExtensionRuntimeDataContainer> =
                        context.borrow().get_data().cloned();
                    let runtime_data =
                        runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let Some(runtime_data) = runtime_data.inner.upgrade() else {
                        return Err(JsError::from_native(
                            JsNativeError::error()
                                .with_message("Runtime container has been dropped"),
                        ));
                    };
                    let mut ext_store = runtime_data.store.write().await;

                    ext_store.auth.invalidate(&domain);
                    ext_store
                        .auth
                        .save_state(runtime_data.client.as_ref())
                        .await
                        .map_err(|e| JsError::from_rust(&*e))?;

                    Ok(JsValue::undefined())
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
        )
        .into(),
    );
    Ok(ret.into())
}

fn get_auth_secret(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let domain = args.get_or_undefined(0).to_string(context);

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let domain = domain?.to_std_string_lossy();

                    let runtime_data: Option<ExtensionRuntimeDataContainer> =
                        context.borrow().get_data().cloned();
                    let runtime_data =
                        runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let Some(runtime_data) = runtime_data.inner.upgrade() else {
                        return Err(JsError::from_native(
                            JsNativeError::error()
                                .with_message("Runtime container has been dropped"),
                        ));
                    };
                    let ext_store = runtime_data.store.read().await;

                    let account = ext_store
                        .auth
                        .get_accounts()
                        .iter()
                        .find(|acc| acc.domain == domain);

                    if account.is_none() {
                        return Err(JsError::from_native(
                            JsNativeError::error()
                                .with_message(format!("Account for domain {} not found", domain)),
                        ));
                    }

                    let account = account.unwrap();
                    if account.creds.is_none() {
                        return Err(JsError::from_native(JsNativeError::error().with_message(
                            format!("Account for domain {} is not logged in", domain),
                        )));
                    }

                    let creds = account.creds.as_ref().unwrap();
                    let secret_value = match creds {
                        dion_runtime::data::auth::AuthCreds::UserPass { username, password } => {
                            use boa_engine::object::JsObject;
                            let mut ctx = context.borrow_mut();
                            let obj = JsObject::default();
                            obj.set(
                                js_string!("user"),
                                JsString::from(username.clone()),
                                true,
                                &mut ctx,
                            )?;
                            obj.set(
                                js_string!("pass"),
                                JsString::from(password.clone()),
                                true,
                                &mut ctx,
                            )?;
                            obj.set(
                                js_string!("type"),
                                JsString::from("userpass"),
                                true,
                                &mut ctx,
                            )?;
                            obj.into()
                        }
                        dion_runtime::data::auth::AuthCreds::ApiKey { key } => {
                            use boa_engine::object::JsObject;
                            let mut ctx = context.borrow_mut();
                            let obj = JsObject::default();
                            obj.set(js_string!("type"), JsString::from("apikey"), true, &mut ctx)?;
                            obj.set(
                                js_string!("key"),
                                JsString::from(key.clone()),
                                true,
                                &mut ctx,
                            )?;
                            obj.into()
                        }
                        dion_runtime::data::auth::AuthCreds::Cookies { cookies } => {
                            use boa_engine::object::JsObject;
                            let mut ctx = context.borrow_mut();

                            let obj = JsObject::default();
                            let cookies_obj = JsObject::default();
                            for (name, values) in cookies.iter() {
                                if values.len() == 1 {
                                    cookies_obj.set(
                                        js_string!(name.as_str()),
                                        JsString::from(values[0].clone()),
                                        true,
                                        &mut ctx,
                                    )?;
                                } else {
                                    let array = JsArray::new(&mut ctx);
                                    for val in values {
                                        array.push(JsString::from(val.clone()), &mut ctx)?;
                                    }
                                    cookies_obj.set(
                                        js_string!(name.as_str()),
                                        JsValue::from(array),
                                        true,
                                        &mut ctx,
                                    )?;
                                }
                            }
                            obj.set(js_string!("type"), JsString::from("cookie"), true, &mut ctx)?;
                            obj.set(
                                js_string!("cookies"),
                                JsValue::from(cookies_obj),
                                true,
                                &mut ctx,
                            )?;
                            obj.into()
                        }
                    };

                    Ok(secret_value)
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
        )
        .into(),
    );
    Ok(ret.into())
}
