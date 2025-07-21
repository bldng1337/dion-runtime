use std::cell::RefCell;
use std::rc::Rc;

use boa_engine::module::SyntheticModuleInitializer;
use boa_engine::object::FunctionObjectBuilder;
use boa_engine::{
    job::NativeAsyncJob, js_string, object::builtins::JsPromise, JsArgs, JsError, JsNativeError,
    JsResult, JsString, JsValue,
};
use boa_engine::{Context, Module, NativeFunction};

use anyhow::Result;
use serde_json::Value;

use crate::data::permission::Permission;
use crate::extension::extension_container::JSSourceExtension;
use crate::extension::utils::{SharedUserContextContainer, VirtualModuleLoader};

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

    let permission: JsResult<Permission> = serde_json::from_value(
        args.get_or_undefined(0)
            .to_json(context)?
            .unwrap_or(serde_json::Value::Null),
    )
    .map_err(JsError::from_rust);

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let msg = msg?.to_std_string_lossy();
                    let permission = permission?;

                    let jsext: Option<SharedUserContextContainer<JSSourceExtension>> =
                        context.borrow().get_data().cloned();
                    let jsext = jsext.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let mut jsext = jsext.inner.write().await;

                    let res = jsext
                        .permission
                        .request_permission(permission, Some(msg))
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
                    Err(err) => resolve.reject.call(
                        &promise.into(),
                        &[JsString::from(err.to_string()).into()],
                        &mut context.borrow_mut(),
                    )?,
                };
                Ok(JsValue::undefined())
            },
            context.realm().clone(),
        )
        .into(),
    );
    Ok(ret.into())
}

fn has_permission(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let permission: JsResult<Permission> = serde_json::from_value(
        args.get_or_undefined(0)
            .to_json(context)?
            .unwrap_or(Value::Null),
    )
    .map_err(JsError::from_rust);

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
                    let permission = permission?;

                    let jsext: Option<SharedUserContextContainer<JSSourceExtension>> =
                        context.borrow().get_data().cloned();
                    let jsext = jsext.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let jsext = jsext.inner.read().await;

                    let res = jsext.permission.check_permission(&permission);
                    Ok(res.into())
                }
                .await as JsResult<JsValue>
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
            },
            context.realm().clone(),
        )
        .into(),
    );
    Ok(ret.into())
}

// #[rquickjs::module(rename_vars = "camelCase")]
// mod permission {
//     use rquickjs::{Ctx, IntoJs, Object};

//     use crate::{
//         error::Error,
//         jsextension::ExtensionUserData,
//         permission::Permission,
//     };

//     async fn internal_request_permission<'js>(
//         permission: Object<'js>,
//         msg: String
//     ) -> Result<bool, Error> {
//         println!("1");
//         let ctx = permission.ctx().clone();
//         println!("2");
//         let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
//             return Err(Error::ExtensionError("Data not initialised".to_string()))
//         };
//         println!("3");
//         let mut ext = binding.get_mut().await;
//         println!("4");
//         match ctx.json_stringify(permission)? {
//             Some(str) => {
//                 println!("{}",str.to_string()?.as_str());
//                 let data: Permission = serde_json::from_str::<Permission>(str.to_string()?.as_str())?;
//                 println!("{}",data);
//                 let res=ext.permission.request_permission(data, Some(msg)).await?;
//                 println!("res: {}",res);
//                 Ok(res)
//             }
//             None => Err(Error::ExtensionError("Couldnt convert Permission".to_owned())),
//         }
//     }
//     #[allow(non_snake_case)]
//     #[rquickjs::function]
//     pub async fn requestPermission<'js>(
//         ctx:Ctx<'js>,
//         permission: Object<'js>,
//         msg: String
//     ) -> Result<bool, rquickjs::Error> {
//         // Ok(true)
//         match internal_request_permission(permission, msg).await {
//             Ok(data) => Ok(data),
//             Err(err) => {
//                 Err(err.into_js(&ctx).err().unwrap())
//             },
//         }
//     }

//     async fn internal_has_permission<'js>(
//         permission: Object<'js>
//     ) -> Result<bool, Error> {
//         let ctx = permission.ctx().clone();
//         let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
//             return Err(Error::ExtensionError("Data not initialised".to_string()))
//         };
//         let ext = binding.get().await;
//         match ctx.json_stringify(permission)? {
//             Some(str) => {
//                 let data: Permission = serde_json::from_str(str.to_string()?.as_str())?;
//                 Ok(ext.permission.check_permission(&data))
//             }
//             None => Err(Error::ExtensionError("Malformed Permission".to_owned())),
//         }
//     }
//     #[allow(non_snake_case)]
//     #[rquickjs::function]
//     pub async fn hasPermission<'js>(
//         ctx:Ctx<'js>,
//         permission: Object<'js>
//     ) -> Result<bool, rquickjs::Error> {
//         match internal_has_permission(permission).await {
//             Ok(data) => Ok(data),
//             Err(err) => {
//                 Err(err.into_js(&ctx).err().unwrap())
//             },
//         }
//     }

// }
