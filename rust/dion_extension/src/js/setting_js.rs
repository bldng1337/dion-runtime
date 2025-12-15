use std::{cell::RefCell, rc::Rc};

use boa_engine::{
    Context, JsArgs, JsError, JsNativeError, JsResult, JsValue, Module, NativeFunction,
    job::NativeAsyncJob,
    js_string,
    module::SyntheticModuleInitializer,
    object::{FunctionObjectBuilder, builtins::JsPromise},
};

use anyhow::Result;
use dion_runtime::data::settings::{Setting, SettingKind};
use serde_json::Value;

use crate::{extension::executor::ExtensionRuntimeDataContainer, utils::VirtualModuleLoader};

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    let get_setting_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(get_setting))
            .length(1)
            .name("getSetting")
            .build();

    let register_setting_fn = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(register_setting),
    )
    .length(3)
    .name("registerSetting")
    .build();
    let module = Module::synthetic(
        &[js_string!("getSetting"), js_string!("registerSetting")],
        SyntheticModuleInitializer::from_copy_closure_with_captures(
            move |m, (get_setting_fn, register_setting_fn), _ctx| {
                m.set_export(&js_string!("getSetting"), get_setting_fn.clone().into())?;
                m.set_export(
                    &js_string!("registerSetting"),
                    register_setting_fn.clone().into(),
                )?;
                Ok(())
            },
            (get_setting_fn, register_setting_fn),
        ),
        None,
        None,
        context,
    );
    loader.insert("setting".to_string(), module);
    Ok(())
}

fn get_setting(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let settingid = args.get_or_undefined(0).to_string(context);
    let settingid = settingid?.to_std_string_lossy();

    let settingkind = args.get_or_undefined(1).to_string(context);
    let settingkind = settingkind?.to_std_string_lossy();
    let settingkind = match settingkind.to_lowercase().as_str() {
        "extension" => SettingKind::Extension,
        "search" => SettingKind::Search,
        _ => {
            return Err(JsError::from_native(
                JsNativeError::error().with_message("Invalid Setting kind"),
            ));
        }
    };

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context: &RefCell<&mut Context>| {
                match async {
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

                    let Some(setting) = ext_store
                        .settings
                        .get_settings(&settingkind)
                        .get(&settingid)
                    else {
                        return Err(JsError::from_native(
                            JsNativeError::error().with_message("e.to_string()"),
                        ));
                    };
                    JsValue::from_json(
                        &serde_json::to_value(setting).map_err(JsError::from_rust)?,
                        &mut context.borrow_mut(),
                    )
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

fn register_setting(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let settingid = args.get_or_undefined(0).to_string(context);
    let setting = args.get_or_undefined(1).to_json(context);
    let settingkind = args.get_or_undefined(2).to_string(context);
    let settingkind = settingkind?.to_std_string_lossy();
    let settingkind = match settingkind.to_lowercase().as_str() {
        "extension" => SettingKind::Extension,
        "search" => SettingKind::Search,
        _ => {
            return Err(JsError::from_native(
                JsNativeError::error().with_message("Invalid Setting kind"),
            ));
        }
    };

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(
        NativeAsyncJob::with_realm(
            async move |context| {
                match async {
                    let settingid = settingid?.to_std_string_lossy();
                    let setting: Setting = serde_json::from_value(setting?.unwrap_or(Value::Null))
                        .map_err(JsError::from_rust)?;
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
                    let mut ext_store = runtime_data.store.write().await;

                    ext_store
                        .settings
                        .merge_setting_definition(settingid, &settingkind, setting)
                        .map_err(|e| {
                            JsError::from_native(JsNativeError::error().with_message(e.to_string()))
                        })?;
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
