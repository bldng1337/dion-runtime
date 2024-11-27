use rquickjs::{ Ctx, Module };

use crate::error::Error;

pub fn declare<'js>(ctx: Ctx<'js>) -> Result<(), Error> {
    Module::declare_def::<js_setting, _>(ctx.clone(), "setting")?;
    Ok(())
}

#[rquickjs::module(rename_vars = "camelCase")]
mod setting {
    use rquickjs::{ Ctx, FromJs, IntoJs, Object, Value };
    use crate::{
        error::Error,
        jsextension::ExtensionUserData,
        settings::{ Setting, SettingUI, Settingtype, Settingvalue }, utils::convertfromjs,
    };

    async fn internal_get_setting<'js>(
        ctx: Ctx<'js>,
        setting: &String
    ) -> Result<Settingvalue, Error> {
        let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
            return Err(Error::ExtensionError("Data not initialised".to_string()))
        };
        let ext = binding.get().await;
        ext.setting.get_setting(setting).and_then(|t| Ok(t.val.clone()))
    }

    #[allow(non_snake_case)]
    #[rquickjs::function]
    pub async fn getSetting<'js>(
        ctx: Ctx<'js>,
        settingid: String
    ) -> Result<Value<'js>, rquickjs::Error> {
        match internal_get_setting(ctx.clone(), &settingid).await {
            Ok(data) => Ok(data.into_js(&ctx)?),
            Err(err) => {
                Err(err.into_js(&ctx).err().unwrap())
            },
        }
    }

    async fn internal_set_ui<'js>(
        ctx: Ctx<'js>,
        setting: &String,
        uidefinition: Object<'js>
    ) -> Result<(), Error> {
        let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
            return Err(Error::ExtensionError("Data not initialised".to_string()))
        };
        let mut ext = binding.get_mut().await;
        let key: String = uidefinition.get("type")?;
        let newsetting:SettingUI =convertfromjs(uidefinition,&ctx)?;
        // let newsetting = (match key.as_str() {
        //     "slider" =>
        //         Ok(SettingUI::Slider {
        //             label: uidefinition.get("label")?,
        //             min: uidefinition.get("mmin")?,
        //             max: uidefinition.get("max")?,
        //             step: uidefinition.get("step")?,
        //         }),
        //     "checkbox" => Ok(SettingUI::Checkbox { label: uidefinition.get("label")? }),
        //     "textbox" => Ok(SettingUI::Textbox { label: uidefinition.get("label")? }),
        //     "dropdown" =>
        //         Ok(SettingUI::Dropdown {
        //             label: uidefinition.get("label")?,
        //             options: uidefinition
        //                 .get::<_, Vec<Object>>("options")?
        //                 .into_iter()
        //                 .map(|a: Object| {
        //                     Ok((a.get::<_, String>("label")?, a.get::<_, String>("value")?))
        //                 })
        //                 .filter(|a| a.is_ok())
        //                 .map(|a: Result<(String, String), Error>| a.unwrap())
        //                 .collect(),
        //         }),
        //     "path" =>
        //         Ok(SettingUI::PathSelection {
        //             label: uidefinition.get("label")?,
        //             pickfolder: uidefinition.get::<_, String>("picktype")? == "folder",
        //         }),
        //     str => Err(Error::ExtensionError(format!("Unknown SettingUI type: {}", str))),
        // })?;
        ext.setting.get_setting_mut(setting)?.ui = Some(newsetting);
        Ok(())
    }

    #[allow(non_snake_case)]
    #[rquickjs::function]
    pub async fn setUI<'js>(
        ctx: Ctx<'js>,
        settingid: String,
        uidefinition: Object<'js>
    ) -> Result<(), rquickjs::Error> {
        match internal_set_ui(ctx.clone(), &settingid, uidefinition).await {
            Ok(data) => Ok(data),
            Err(err) => {
                Err(err.into_js(&ctx).err().unwrap())
            },
        }
    }

    async fn internal_register_setting<'js>(
        ctx: Ctx<'js>,
        settingid: String,
        settingtype: String,
        default_val: Value<'js>
    ) -> Result<(), Error> {
        let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
            return Err(Error::ExtensionError("Data not initialised".to_string()))
        };
        let mut ext = binding.get_mut().await;
        let settingval = (match default_val.type_of() {
            rquickjs::Type::Bool =>
                Ok(Settingvalue::Boolean {
                    val: default_val.as_bool().unwrap_or_default(),
                    default_val: default_val.as_bool().unwrap_or_default(),
                }),
            rquickjs::Type::Int | rquickjs::Type::Float =>
                Ok(Settingvalue::Number {
                    val: default_val.as_number().unwrap_or_default(),
                    default_val: default_val.as_number().unwrap_or_default(),
                }),
            rquickjs::Type::String => {
                let default_val = String::from_js(&ctx, default_val)?;
                Ok(Settingvalue::String { val: default_val.clone(), default_val: default_val })
            }
            sometype =>
                Err(Error::ExtensionError(format!("Unknown SettingType {}", sometype.to_string()))),
        })?;
        let stype = (match settingtype.to_lowercase().as_str() {
            "extension" => Ok(Settingtype::Extension),
            "entry" => Ok(Settingtype::Entry),
            "search" => Ok(Settingtype::Search),
            str => Err(Error::ExtensionError(format!("Unknown SettingType: {}", str))),
        })?;
        ext.setting.add_setting(settingid, Setting {
            
            val: settingval,
            settingtype: stype,
            ui: None,
        });
        Ok(())
    }

    #[allow(non_snake_case)]
    #[rquickjs::function]
    pub async fn registerSetting<'js>(
        ctx: Ctx<'js>,
        settingid: String,
        settingtype: String,
        default_val: Value<'js>
    ) -> Result<(), rquickjs::Error> {
        match internal_register_setting(ctx.clone(), settingid, settingtype, default_val).await {
            Ok(data) => Ok(data),
            Err(err) => {
                Err(err.into_js(&ctx).err().unwrap())
            },
        }
    }
}
