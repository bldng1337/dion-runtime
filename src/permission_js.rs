use rquickjs::{Ctx, Module};

use crate::error::Error;

pub fn declare<'js>(ctx: Ctx<'js>) -> Result<(), Error> {
    Module::declare_def::<js_permission, _>(ctx.clone(), "permission")?;
    Ok(())
}

#[rquickjs::module(rename_vars = "camelCase")]
mod permission {
    use rquickjs::Object;

    use crate::{
        error::Error,
        jsextension::ExtensionUserData,
        permission::Permission,
    };

    async fn internal_request_permission<'js>(
        permission: Object<'js>,
        msg: String
    ) -> Result<bool, Error> {
        let ctx = permission.ctx().clone();
        let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
            return Err(Error::ExtensionError("Data not initialised".to_string()))
        };
        let mut ext = binding.get_mut().await;
        match ctx.json_stringify(permission)? {
            Some(str) => {
                let data: Permission = serde_json::from_str::<Permission>(str.to_string()?.as_str())?;
                Ok(ext.permission.request_permission(data, Some(msg))?)
            }
            None => Err(Error::ExtensionError("()".to_owned())),
        }
    }
    #[allow(non_snake_case)]
    #[rquickjs::function]
    pub async fn requestPermission<'js>(
        permission: Object<'js>,
        msg: String
    ) -> Result<bool, rquickjs::Error> {
        match internal_request_permission(permission, msg).await {
            Ok(data) => Ok(data),
            Err(err) => Err(err.into()),
        }
    }

    async fn internal_has_permission<'js>(
        permission: Object<'js>
    ) -> Result<bool, Error> {
        let ctx = permission.ctx().clone();
        let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
            return Err(Error::ExtensionError("Data not initialised".to_string()))
        };
        let ext = binding.get().await;
        match ctx.json_stringify(permission)? {
            Some(str) => {
                let data: Permission = serde_json::from_str(str.to_string()?.as_str())?;
                Ok(ext.permission.check_permission(&data))
            }
            None => Err(Error::ExtensionError("Malformed Permission".to_owned())),
        }
    }
    #[allow(non_snake_case)]
    #[rquickjs::function]
    pub async fn hasPermission<'js>(
        permission: Object<'js>
    ) -> Result<bool, rquickjs::Error> {
        match internal_has_permission(permission).await {
            Ok(data) => Ok(data),
            Err(err) => Err(err.into()),
        }
    }


}
