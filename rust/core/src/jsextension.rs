use std::{ path::Path, sync::Arc };

use rquickjs::{
    async_with, function::Args, AsyncContext, AsyncRuntime, Class, Ctx, Function, Module, Object, Promise, Value
};

use tokio::{ fs::{self, read_dir}, select, sync::RwLock, task::yield_now };
use tokio_util::sync::CancellationToken;

use crate::{
    datastructs::{ self, Entry, EntryDetailed, ExtensionData, Sort, Source }, error::{ Error, Result }, extension::{TExtension, TExtensionManager}, networking_js, permission::PermissionStore, permission_js, setting_js, settings::SettingStore, utils::{ val_to_string, wrapcatch, ReadOnlyUserContextContainer, SharedUserContextContainer }
};



pub struct ExtensionManager {
    path:String
}

impl ExtensionManager {
    pub fn new<T>(path:T)->Self where T:Into<String> {
        ExtensionManager { path:path.into() }
    }
}

#[async_trait::async_trait]
impl TExtensionManager<ExtensionContainer> for ExtensionManager {
    async fn get_extensions(&self)->Result<Vec<ExtensionContainer>> {
        let mut dir=read_dir(&self.path).await?;
        let mut ret=Vec::new();
        let rt = AsyncRuntime::new()?;
        while let Some(file) = dir.next_entry().await? {
            if !file.file_name().into_string().or(Err(Error::ExtensionError("Filename conversion failed".to_string())))?.ends_with(".dion.js") {
                continue;
            }
            println!("Got Extension {}",file.file_name().to_str().unwrap());
            ret.push(ExtensionContainer::create(file.path(),rt.clone()).await?);
        }
        Ok(ret)
    }
}


/// flutter_rust_bridge:opaque
pub struct ExtensionContainer {
    extension: Arc<RwLock<JSExtension>>,
    context: Option<AsyncContext>,
    code: String,
    rt: AsyncRuntime,
}

#[async_trait::async_trait]
impl TExtension for ExtensionContainer {
    fn is_enabled(&self) -> bool {
        self.context.is_some()
    }

    async fn set_enabled(&mut self,enabled:bool)->Result<()> {
        match (enabled,self.context.is_some()) {
            (true, true) => Ok(()),
            (true, false) => self.enable().await,
            (false, true) => Ok(self.disable()),
            (false, false) => Ok(()),
        }
    }

    async fn get_data(&self)-> datastructs::ExtensionData {
        self.extension.read().await.data.clone()
    }

    async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>
    ) -> Result<Vec<Entry>> {
        match &self.context {
            Some(context) =>
                async_with!(context => |ctx| {
                    let cancel = token.unwrap_or_default();
                    let mut args=Args::new(ctx.clone(), 2);
                    args.push_arg(page)?;
                    args.push_arg(sort)?;
                    let str=self.exec(ctx, "browse", args, cancel).await?;
                    Ok(serde_json::from_str(&str)?)
                }).await,
            None => Err(Error::ExtensionError("Extension not enabled".to_string())),
        }
    }

    async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancellationToken>
    ) -> Result<Vec<Entry>> {
        match &self.context {
            Some(context) =>
                async_with!(context => |ctx| {
                    let cancel = token.unwrap_or_default();
                    let mut args=Args::new(ctx.clone(), 2);
                    args.push_arg(page)?;
                    args.push_arg(filter)?;
                    let str=self.exec(ctx, "search", args, cancel).await?;
                    Ok(serde_json::from_str(&str)?)
                }).await,
            None => Err(Error::ExtensionError("Extension not enabled".to_string())),
        }
    }

    async fn detail(
        &self,
        entryid: &str,
        token: Option<CancellationToken>
    ) -> Result<EntryDetailed> {
        match &self.context {
            Some(context) =>
                async_with!(context => |ctx| {
                    let cancel = token.unwrap_or_default();
                    let mut args=Args::new(ctx.clone(), 2);
                    args.push_arg(entryid)?;
                    let str=self.exec(ctx, "detail", args, cancel).await?;
                    Ok(serde_json::from_str(&str)?)
                }).await,
            None => Err(Error::ExtensionError("Extension not enabled".to_string())),
        }
    }

    async fn source(&self, epid: &String, token: Option<CancellationToken>) -> Result<Source> {
        match &self.context {
            Some(context) =>
                async_with!(context => |ctx| {
                    let cancel = token.unwrap_or_default();
                    let mut args=Args::new(ctx.clone(), 2);
                    args.push_arg(epid)?;
                    let str=self.exec(ctx, "source", args, cancel).await?;
                    Ok(serde_json::from_str(&str)?)
                }).await,
            None => Err(Error::ExtensionError("Extension not enabled".to_string())),
        }
    }

    async fn fromurl(
        &self,
        url: String,
        token: Option<CancellationToken>
    ) -> Result<Option<Entry>> {
        match &self.context {
            Some(context) =>
                async_with!(context => |ctx| {
                    let cancel = token.unwrap_or_default();
                    let mut args=Args::new(ctx.clone(), 2);
                    args.push_arg(url)?;
                    let str=self.exec(ctx, "fromurl", args, cancel).await?;
                    Ok(serde_json::from_str(&str)?)
                }).await,
            None => Err(Error::ExtensionError("Extension not enabled".to_string())),
        }
    }
}

impl ExtensionContainer {

    pub async fn get_extension(&self) -> tokio::sync::RwLockReadGuard<'_, JSExtension, > {
        self.extension.read().await
    }

    pub async fn get_extension_mut(&self) -> tokio::sync::RwLockWriteGuard<'_, JSExtension> {
        self.extension.write().await
    }

    pub fn is_enabled(&self) -> bool {
        self.context.is_some()
    }

    fn getextension<'js>(ctx: &Ctx<'js>) -> Result<Object<'js>> {
        Ok(ctx.globals().get("__plugin")?)
    }

    async fn exec<'js>(
        &self,
        ctx: Ctx<'js>,
        funcname: &str,
        args: Args<'js>,
        cancel: CancellationToken
    ) -> Result<String> {
        let cancelcontainer = ReadOnlyUserContextContainer::new(cancel.clone());
        ctx.store_userdata(cancelcontainer)?;
        let obj =
            select! {
                        _ = cancel.cancelled() => {
                            Err(Error::Cancelled)
                        }
                        ret = async {
                            let extension=Self::getextension(&ctx)?;
                            
                            let func=extension.get::<&str,Function>(funcname)?;
                            
                            let obj=wrapcatch(&ctx,wrapcatch(&ctx, func.call_arg::<Promise>(args))?.into_future::<Object>().await)?;
                            Ok(obj)
                        } => ret
                    };
        cancel.cancel();
        yield_now().await; //Yield to runtime so that all tasks depending on the cancel token can be stopped
        ctx.remove_userdata::<ReadOnlyUserContextContainer<CancellationToken>>()?;
        let str: String = ctx
            .json_stringify(obj?)?
            .ok_or(Error::ExtensionError("Failed to get return value".into()))?
            .get()?;
        Ok(str)
    }

    pub fn disable(&mut self){
        self.context=None
    }

    pub async fn enable(&mut self) -> Result<()> {
        let context = AsyncContext::full(&self.rt).await?;
        let a = SharedUserContextContainer::from(self.extension.clone());
        let code = self.code.as_str();
        async_with!(context => |ctx| {
            ctx.store_userdata(a)?;
            ctx.globals().set("print", Function::new(ctx.clone(), |msg:Value| { println!("JS: {}", val_to_string(msg).unwrap_or_default());}))?;
            
            networking_js::declare(ctx.clone())?;
            permission_js::declare(ctx.clone())?;
            setting_js::declare(ctx.clone())?;
            let module = wrapcatch(&ctx, Module::declare(
                ctx.clone(),
                "extension",
                code))?;
            let (modu, promise) = wrapcatch(&ctx,Module::eval(module))?;
            wrapcatch(&ctx,promise.into_future::<()>().await)?;
            let pluginclass:Value=modu.get("default")?;
            ctx.globals().set("__pluginclass", pluginclass)?;
            wrapcatch(&ctx,wrapcatch(&ctx,
                ctx.eval_promise::<&str>("var __plugin=new __pluginclass();if(__plugin.load){await __plugin.load();}"))?
                .into_future::<()>().await)?;
            Ok::<_,Error>(())
        }).await?;
        self.context = Some(context);
        Ok(())
    }

    pub async fn create(path: impl AsRef<Path>, rt: AsyncRuntime) -> Result<Self> {
        let contents: String = String::from_utf8(fs::read(path).await?)?;
        let data: ExtensionData = serde_json::from_str(
            contents.lines().next().unwrap_or_default().strip_prefix("//").unwrap_or_default()
        )?;
        let ext = JSExtension { //TODO: Save permission and setting
            data: data,
            permission: Default::default(),
            setting: Default::default(),
        };
        let extcontainer = ExtensionContainer {
            extension: Arc::new(RwLock::new(ext)),
            context: None,
            code: contents,
            rt:rt
        };
        Ok(extcontainer)
    }
}

pub(crate) type ExtensionUserData = SharedUserContextContainer<JSExtension>;

/// flutter_rust_bridge:opaque
pub struct JSExtension {
    pub data: ExtensionData,
    pub permission: PermissionStore,
    pub setting: SettingStore,
}
