use std::cell::RefCell;
use std::rc::Rc;

use boa_engine::module::SyntheticModuleInitializer;
use boa_engine::object::FunctionObjectBuilder;
use boa_engine::{Context, Module, NativeFunction};
use boa_engine::{
    JsArgs, JsError, JsNativeError, JsResult, JsValue, job::NativeAsyncJob, js_string,
    object::builtins::JsPromise,
};

use anyhow::Result;
use dion_runtime::permission::Permission;
use serde_json::Value;

use crate::extension::executor::ExtensionRuntimeDataContainer;
use crate::utils::VirtualModuleLoader;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    let request_permission_fn = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(request_permission),
    )
    .length(2)
    .name("requestPermission")
    .build();
    let has_permission_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(has_permission))
            .length(1)
            .name("hasPermission")
            .build();
    let module = Module::synthetic(
        &[js_string!("requestPermission"), js_string!("hasPermission")],
        SyntheticModuleInitializer::from_copy_closure_with_captures(
            move |m, (request_permission_fn, has_permission_fn), _ctx| {
                m.set_export(
                    &js_string!("requestPermission"),
                    request_permission_fn.clone().into(),
                )?;
                m.set_export(
                    &js_string!("hasPermission"),
                    has_permission_fn.clone().into(),
                )?;
                Ok(())
            },
            (request_permission_fn, has_permission_fn),
        ),
        None,
        None,
        context,
    );
    loader.insert("permission".to_string(), module);
    Ok(())
}

fn request_permission(
    _this: &JsValue,
    args: &[JsValue],
    context: &mut Context,
) -> JsResult<JsValue> {
    let msg = args.get_or_undefined(1).to_string(context);

    let res = serde_json::from_value(
        args.get_or_undefined(0)
            .to_json(context)?
            .unwrap_or(serde_json::Value::Null),
    );

    let permission: JsResult<Permission> = res.map_err(|e| {
        JsError::from_native(
            JsNativeError::error().with_message(format!("Failed to parse permission {}", e)),
        )
    });

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(<boa_engine::job::Job>::from(NativeAsyncJob::with_realm(
        async move |context: &RefCell<&mut Context>| {
            match async {
                let msg = msg?.to_std_string_lossy();
                let permission = permission?;
                let runtime_data: Option<ExtensionRuntimeDataContainer> =
                    context.borrow().get_data().cloned();
                let runtime_data =
                    runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                let mut ext_store = runtime_data.store.write().await;

                let res = ext_store
                    .permission
                    .request_permission(runtime_data.client.as_ref(), permission, Some(msg))
                    .await
                    .map_err(|e| JsError::from_rust(&*e))?;
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

fn has_permission(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let permission: JsResult<Permission> = serde_json::from_value(
        args.get_or_undefined(0)
            .to_json(context)?
            .unwrap_or(Value::Null),
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
                    let ext_store = runtime_data.store.read().await;

                    let res = ext_store.permission.has_permission(&permission);
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
