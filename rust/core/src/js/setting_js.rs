use boa_engine::{
    job::NativeAsyncJob,
    js_string,
    module::SyntheticModuleInitializer,
    object::{builtins::JsPromise, FunctionObjectBuilder},
    Context, JsArgs, JsError, JsNativeError, JsResult, JsString, JsValue, Module, NativeFunction,
};

use anyhow::Result;

use crate::{
    data::settings::ExtensionSetting,
    extension::{extension_container::JSSourceExtension, utils::SharedUserContextContainer},
};

pub fn declare(context: &mut Context) -> Result<()> {
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

    context.module_loader().register_module(
        js_string!("setting"),
        Module::synthetic(
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
        ),
    );
    Ok(())
}

fn get_setting(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let setting = args.get_or_undefined(0).to_string(context);
    let setting = setting?.to_std_string_lossy();

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(boa_engine::job::Job::AsyncJob(NativeAsyncJob::with_realm(
        move |context| {
            Box::pin(async move {
                match async {
                    let jsext: Option<SharedUserContextContainer<JSSourceExtension>> =
                        { (&mut context.borrow_mut()).get_data().cloned() };
                    let jsext = jsext.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let jsext = jsext.inner.read().await;
                    let res = jsext.setting.get_setting(&setting).map_err(|e| {
                        JsError::from_native(JsNativeError::error().with_message(e.to_string()))
                    })?;
                    let a = JsValue::from_json(
                        &serde_json::to_value(res).map_err(|e| JsError::from_rust(e))?,
                        &mut context.borrow_mut(),
                    );
                    a
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
            })
        },
        context.realm().clone(),
    )));
    Ok(ret.into())
}

fn register_setting(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let settingid = args.get_or_undefined(0).to_string(context);
    let setting = args.get_or_undefined(1).to_json(context);

    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(boa_engine::job::Job::AsyncJob(NativeAsyncJob::with_realm(
        move |context| {
            Box::pin(async move {
                match async {
                    let settingid = settingid?.to_std_string_lossy();
                    let setting: ExtensionSetting =
                        serde_json::from_value(setting?).map_err(|e| JsError::from_rust(e))?;
                    let jsext: Option<SharedUserContextContainer<JSSourceExtension>> =
                        (&mut context.borrow_mut()).get_data().cloned();
                    let jsext = jsext.ok_or(JsError::from_native(JsNativeError::error()))?;
                    let mut jsext = jsext.inner.write().await;
                    jsext.setting.add_setting(settingid, setting);
                    Ok(JsValue::undefined())
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
            })
        },
        context.realm().clone(),
    )));
    Ok(ret.into())
}

// #[rquickjs::module(rename_vars = "camelCase")]
// mod setting {
//     use rquickjs::{ Ctx, FromJs, IntoJs, Object, Value };
//     use crate::{
//         error::Error,
//         JSSourceExtension::ExtensionUserData,
//         settings::{ Setting, SettingUI, Settingtype, Settingvalue }, utils::convertfromjs,
//     };

//     async fn internal_get_setting<'js>(
//         ctx: Ctx<'js>,
//         setting: &String
//     ) -> Result<Settingvalue, Error> {
//         let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
//             return Err(Error::ExtensionError("Data not initialised".to_string()))
//         };
//         let ext = binding.get().await;
//         ext.setting.get_setting(setting).and_then(|t| Ok(t.val.clone()))
//     }

//     #[allow(non_snake_case)]
//     #[rquickjs::function]
//     pub async fn getSetting<'js>(
//         ctx: Ctx<'js>,
//         settingid: String
//     ) -> Result<Value<'js>, rquickjs::Error> {
//         match internal_get_setting(ctx.clone(), &settingid).await {
//             Ok(data) => Ok(data.into_js(&ctx)?),
//             Err(err) => {
//                 Err(err.into_js(&ctx).err().unwrap())
//             },
//         }
//     }

//     async fn internal_set_ui<'js>(
//         ctx: Ctx<'js>,
//         setting: &String,
//         uidefinition: Object<'js>
//     ) -> Result<(), Error> {
//         let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
//             return Err(Error::ExtensionError("Data not initialised".to_string()))
//         };
//         let mut ext = binding.get_mut().await;
//         let key: String = uidefinition.get("type")?;
//         let newsetting:SettingUI =convertfromjs(uidefinition,&ctx)?;
//         // let newsetting = (match key.as_str() {
//         //     "slider" =>
//         //         Ok(SettingUI::Slider {
//         //             label: uidefinition.get("label")?,
//         //             min: uidefinition.get("mmin")?,
//         //             max: uidefinition.get("max")?,
//         //             step: uidefinition.get("step")?,
//         //         }),
//         //     "checkbox" => Ok(SettingUI::Checkbox { label: uidefinition.get("label")? }),
//         //     "textbox" => Ok(SettingUI::Textbox { label: uidefinition.get("label")? }),
//         //     "dropdown" =>
//         //         Ok(SettingUI::Dropdown {
//         //             label: uidefinition.get("label")?,
//         //             options: uidefinition
//         //                 .get::<_, Vec<Object>>("options")?
//         //                 .into_iter()
//         //                 .map(|a: Object| {
//         //                     Ok((a.get::<_, String>("label")?, a.get::<_, String>("value")?))
//         //                 })
//         //                 .filter(|a| a.is_ok())
//         //                 .map(|a: Result<(String, String), Error>| a.unwrap())
//         //                 .collect(),
//         //         }),
//         //     "path" =>
//         //         Ok(SettingUI::PathSelection {
//         //             label: uidefinition.get("label")?,
//         //             pickfolder: uidefinition.get::<_, String>("picktype")? == "folder",
//         //         }),
//         //     str => Err(Error::ExtensionError(format!("Unknown SettingUI type: {}", str))),
//         // })?;
//         ext.setting.get_setting_mut(setting)?.ui = Some(newsetting);
//         Ok(())
//     }

//     #[allow(non_snake_case)]
//     #[rquickjs::function]
//     pub async fn setUI<'js>(
//         ctx: Ctx<'js>,
//         settingid: String,
//         uidefinition: Object<'js>
//     ) -> Result<(), rquickjs::Error> {
//         match internal_set_ui(ctx.clone(), &settingid, uidefinition).await {
//             Ok(data) => Ok(data),
//             Err(err) => {
//                 Err(err.into_js(&ctx).err().unwrap())
//             },
//         }
//     }

//     async fn internal_register_setting<'js>(
//         ctx: Ctx<'js>,
//         settingid: String,
//         settingtype: String,
//         default_val: Value<'js>
//     ) -> Result<(), Error> {
//         let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
//             return Err(Error::ExtensionError("Data not initialised".to_string()))
//         };
//         let mut ext = binding.get_mut().await;
//         let settingval = (match default_val.type_of() {
//             rquickjs::Type::Bool =>
//                 Ok(Settingvalue::Boolean {
//                     val: default_val.as_bool().unwrap_or_default(),
//                     default_val: default_val.as_bool().unwrap_or_default(),
//                 }),
//             rquickjs::Type::Int | rquickjs::Type::Float =>
//                 Ok(Settingvalue::Number {
//                     val: default_val.as_number().unwrap_or_default(),
//                     default_val: default_val.as_number().unwrap_or_default(),
//                 }),
//             rquickjs::Type::String => {
//                 let default_val = String::from_js(&ctx, default_val)?;
//                 Ok(Settingvalue::String { val: default_val.clone(), default_val: default_val })
//             }
//             sometype =>
//                 Err(Error::ExtensionError(format!("Unknown SettingType {}", sometype.to_string()))),
//         })?;
//         let stype = (match settingtype.to_lowercase().as_str() {
//             "extension" => Ok(Settingtype::Extension),
//             "entry" => Ok(Settingtype::Entry),
//             "search" => Ok(Settingtype::Search),
//             str => Err(Error::ExtensionError(format!("Unknown SettingType: {}", str))),
//         })?;
//         ext.setting.add_setting(settingid, Setting {

//             val: settingval,
//             settingtype: stype,
//             ui: None,
//         });
//         Ok(())
//     }

//     #[allow(non_snake_case)]
//     #[rquickjs::function]
//     pub async fn registerSetting<'js>(
//         ctx: Ctx<'js>,
//         settingid: String,
//         settingtype: String,
//         default_val: Value<'js>
//     ) -> Result<(), rquickjs::Error> {
//         match internal_register_setting(ctx.clone(), settingid, settingtype, default_val).await {
//             Ok(data) => Ok(data),
//             Err(err) => {
//                 Err(err.into_js(&ctx).err().unwrap())
//             },
//         }
//     }
// }
