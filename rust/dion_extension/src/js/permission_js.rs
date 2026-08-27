use std::rc::Rc;

use boa_engine::Context;

use anyhow::Result;

use crate::utils::VirtualModuleLoader;
use boa_engine::boa_module;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    loader.insert(
        "permission".to_string(),
        permission::boa_module(None, context),
    );
    Ok(())
}

#[boa_module]
mod permission {
    use std::cell::RefCell;

    use boa_engine::{
        Context, JsError, JsNativeError, JsResult, JsValue, job::NativeAsyncJob,
        object::builtins::JsPromise,
    };

    use crate::extension::executor::ExtensionRuntimeDataContainer;
    use dion_runtime::data::permission::Permission;
    use serde_json::Value;

    #[boa(rename = "requestPermission")]
    fn request_permission(
        permission: JsValue,
        msg: String,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let permission: JsResult<Permission> = serde_json::from_value(
            permission
                .to_json(context)?
                .unwrap_or(serde_json::Value::Null),
        )
        .map_err(|e| {
            JsError::from_native(
                JsNativeError::error().with_message(format!("Failed to parse permission {}", e)),
            )
        });

        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(<boa_engine::job::Job>::from(NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let msg = msg;
                    let permission = permission?;
                    let runtime_data: Option<ExtensionRuntimeDataContainer> =
                        context.borrow().get_data().cloned();
                    let runtime_data =
                        runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let Some(runtime_data) = runtime_data.inner.upgrade() else {
                        return Err(JsError::from_native(
                            JsNativeError::error()
                                .with_message("Network container has been dropped"),
                        ));
                    };
                    // Fast path: already granted, no host round-trip needed.
                    let granted = {
                        let ext_store = runtime_data.store.read().await;
                        ext_store.permission.has_permission(&permission)
                    };
                    let res = if granted {
                        true
                    } else {
                        // Prompt WITHOUT holding the store lock: the host
                        // prompt may re-enter the runtime and would deadlock
                        // on the RwLock. Grant under a fresh lock on success.
                        let granted = runtime_data
                            .client
                            .request_permission(&permission, Some(msg))
                            .await
                            .map_err(|e| JsError::from_rust(&*e))?;
                        if granted {
                            {
                                let mut ext_store = runtime_data.store.write().await;
                                ext_store.permission.grant(permission);
                            }
                            let snapshot = runtime_data
                                .store
                                .read()
                                .await
                                .permission
                                .get_permissions()
                                .clone();
                            if let Err(err) =
                                dion_runtime::store::permission::PermissionStore::persist(
                                    &snapshot,
                                    runtime_data.client.as_ref(),
                                )
                                .await
                            {
                                log::warn!("Failed to persist granted permissions: {err:?}");
                            }
                        }
                        granted
                    };
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
        )));
        Ok(ret.into())
    }

    #[boa(rename = "hasPermission")]
    fn has_permission(permission: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let permission: JsResult<Permission> = serde_json::from_value(
            permission.to_json(context)?.unwrap_or(Value::Null),
        )
        .map_err(|e| {
            JsError::from_native(
                JsNativeError::error().with_message(format!("Failed to parse permission {}", e)),
            )
        });

        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(
            NativeAsyncJob::with_realm(
                async move |context: &RefCell<&mut Context>| {
                    match async {
                        let permission = permission?;

                        let runtime_data: Option<ExtensionRuntimeDataContainer> =
                            context.borrow().get_data().cloned();
                        let runtime_data =
                            runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                        let Some(runtime_data) = runtime_data.inner.upgrade() else {
                            return Err(JsError::from_native(
                                JsNativeError::error()
                                    .with_message("Network container has been dropped"),
                            ));
                        };
                        let ext_store = runtime_data.store.read().await;

                        let res = ext_store.permission.has_permission(&permission);
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
}
