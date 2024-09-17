use rquickjs::{Ctx, Module};

use crate::error::Error;

pub fn declare<'js>(ctx: Ctx<'js>) -> Result<(), Error> {
    Module::declare_def::<js_permission, _>(ctx.clone(), "permission")?;
    Ok(())
}

#[rquickjs::module(rename_vars = "camelCase")]
mod permission {
    use rquickjs::{Ctx, IntoJs, Object};

    use crate::{
        error::Error,
        jsextension::ExtensionUserData,
        permission::Permission,
    };

    async fn internal_request_permission<'js>(
        permission: Object<'js>,
        msg: String
    ) -> Result<bool, Error> {
        println!("1");
        let ctx = permission.ctx().clone();
        println!("2");
        let Some(binding) = ctx.userdata::<ExtensionUserData>() else {
            return Err(Error::ExtensionError("Data not initialised".to_string()))
        };
        println!("3");
        let mut ext = binding.get_mut().await;
        println!("4");
        match ctx.json_stringify(permission)? {
            Some(str) => {
                println!("{}",str.to_string()?.as_str());
                let data: Permission = serde_json::from_str::<Permission>(str.to_string()?.as_str())?;
                println!("{}",data);
                let res=ext.permission.request_permission(data, Some(msg)).await?;
                println!("res: {}",res);
                Ok(res)
            }
            None => Err(Error::ExtensionError("Couldnt convert Permission".to_owned())),
        }
    }
    #[allow(non_snake_case)]
    #[rquickjs::function]
    pub async fn requestPermission<'js>(
        ctx:Ctx<'js>,
        permission: Object<'js>,
        msg: String
    ) -> Result<bool, rquickjs::Error> {
        // Ok(true)
        match internal_request_permission(permission, msg).await {
            Ok(data) => Ok(data),
            Err(err) => {
                Err(err.into_js(&ctx).err().unwrap())
            },
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
        ctx:Ctx<'js>,
        permission: Object<'js>
    ) -> Result<bool, rquickjs::Error> {
        match internal_has_permission(permission).await {
            Ok(data) => Ok(data),
            Err(err) => {
                Err(err.into_js(&ctx).err().unwrap())
            },
        }
    }


}
