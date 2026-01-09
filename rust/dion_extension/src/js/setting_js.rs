use std::rc::Rc;

use boa_engine::Context;

use anyhow::Result;

use crate::utils::VirtualModuleLoader;
use boa_engine::boa_module;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    loader.insert("setting".to_string(), setting::boa_module(None, context));
    Ok(())
}

#[boa_module]
mod setting {
    use std::cell::RefCell;

    use boa_engine::{
        Context, JsError, JsNativeError, JsResult, JsValue, job::NativeAsyncJob,
        object::builtins::JsPromise,
    };
    use dion_runtime::data::settings::{Setting, SettingKind};
    use serde_json::Value;

    use crate::extension::executor::ExtensionRuntimeDataContainer;

    #[boa(rename = "getSetting")]
    fn get_setting(settingid: String, kind: String, context: &mut Context) -> JsResult<JsValue> {
        let settingkind = match kind.to_lowercase().as_str() {
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
                                JsNativeError::error().with_message("Setting not found"),
                            ));
                        };
                        JsValue::from_json(
                            &serde_json::to_value(setting).map_err(JsError::from_rust)?,
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

    #[boa(rename = "registerSetting")]
    fn register_setting(
        settingid: String,
        setting: JsValue,
        kind: String,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let settingkind = match kind.to_lowercase().as_str() {
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
                        let setting: Setting = serde_json::from_value(
                            setting
                                .to_json(&mut context.borrow_mut())?
                                .unwrap_or(Value::Null),
                        )
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
                                JsError::from_native(
                                    JsNativeError::error().with_message(e.to_string()),
                                )
                            })?;
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
}
