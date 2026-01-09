use std::rc::Rc;

use boa_engine::Context;

use anyhow::Result;

use crate::utils::VirtualModuleLoader;
use boa_engine::boa_module;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    loader.insert("auth".to_string(), auth::boa_module(None, context));
    Ok(())
}

#[boa_module]
mod auth {

    use std::cell::RefCell;

    use boa_engine::{
        Context, JsError, JsNativeError, JsResult, JsValue, job::NativeAsyncJob,
        object::builtins::JsPromise,
    };
    use dion_runtime::data::auth::Account;

    use crate::extension::executor::ExtensionRuntimeDataContainer;

    fn merge_auth(account: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let account_json = account.to_json(context)?;
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
                            JsNativeError::error()
                                .with_message("Runtime container has been dropped"),
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

    fn is_logged_in(domain: String, context: &mut Context) -> JsResult<JsValue> {
        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(
            NativeAsyncJob::with_realm(
                async move |context: &RefCell<&mut Context>| {
                    let domain = domain;
                    match async {
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
                        Ok(val) => resolve.resolve.call(
                            &promise.into(),
                            &[val],
                            &mut context.borrow_mut(),
                        )?,
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

    fn invalidate(domain: String, context: &mut Context) -> JsResult<JsValue> {
        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(
            NativeAsyncJob::with_realm(
                async move |context: &RefCell<&mut Context>| {
                    let domain = domain;
                    match async {
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
                        Ok(val) => resolve.resolve.call(
                            &promise.into(),
                            &[val],
                            &mut context.borrow_mut(),
                        )?,
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

    fn get_auth_secret(domain: String, context: &mut Context) -> JsResult<JsValue> {
        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(
            NativeAsyncJob::with_realm(
                async move |context: &RefCell<&mut Context>| {
                    let domain = domain;
                    match async {
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
                            return Err(JsError::from_native(JsNativeError::error().with_message(
                                format!("Account for domain {} not found", domain),
                            )));
                        }

                        let account = account.unwrap();
                        if account.creds.is_none() {
                            return Err(JsError::from_native(JsNativeError::error().with_message(
                                format!("Account for domain {} is not logged in", domain),
                            )));
                        }

                        let creds = account.creds.as_ref().unwrap();
                        JsValue::from_json(
                            &serde_json::to_value(creds).map_err(|e| {
                                JsError::from_native(
                                    JsNativeError::error()
                                        .with_message(format!("Failed to serialize creds: {}", e)),
                                )
                            })?,
                            &mut context.borrow_mut(),
                        )
                    }
                    .await as JsResult<JsValue>
                    {
                        Ok(val) => resolve.resolve.call(
                            &promise.into(),
                            &[val],
                            &mut context.borrow_mut(),
                        )?,
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
}
