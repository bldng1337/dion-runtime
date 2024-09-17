use std::{ path::Path, slice::{ Iter, IterMut }, sync::Arc };

use rquickjs::{
    async_with, function::Args, AsyncContext, AsyncRuntime, Ctx, Function, Module, Object, Promise, Value
};
use serde::{ Deserialize, Serialize };

use tokio::{ fs, select, sync::RwLock, task::yield_now };
use tokio_util::sync::CancellationToken;

use crate::{
    datastructs::{ Entry, EntryDetailed, MediaType, Sort, Source },
    error::{ Error, Result },
    networking_js,
    permission::PermissionStore,
    permission_js,
    setting_js,
    settings::SettingStore,
    utils::{ val_to_string, wrapcatch, ReadOnlyUserContextContainer, SharedUserContextContainer },
};

pub struct ExtensionManager {
    extensions: Vec<ExtensionContainer>,
}

impl Default for ExtensionManager {
    fn default() -> Self {
        Self { extensions: Default::default() }
    }
}
/// flutter_rust_bridge:opaque
impl ExtensionManager {

    pub async fn new() -> Self {
        Default::default()
    }

    pub async fn frb_override_add_from_file(&mut self, path: &str)->Result<()> {
        self.add_from_file(path).await
    }

    pub async fn add_from_file(&mut self, path: impl AsRef<Path>) -> Result<()> {
        self.extensions.push(ExtensionContainer::create(path).await?);
        Ok(())
    }

    pub fn iter(&self) -> Iter<'_, ExtensionContainer> {
        self.extensions.iter()
    }
    pub fn iter_mut(&mut self) -> IterMut<'_, ExtensionContainer> {
        self.extensions.iter_mut()
    }
}

/// flutter_rust_bridge:opaque
pub struct ExtensionContainer {
    extension: Arc<RwLock<JSExtension>>,
    context: Option<AsyncContext>,
    code: String,
}

impl ExtensionContainer {
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

    pub async fn browse(
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

    pub async fn search(
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
    pub async fn detail(
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
    pub async fn source(&self, epid: &String, token: Option<CancellationToken>) -> Result<Source> {
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
    pub async fn fromurl(
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

    pub async fn enable(&mut self, rt: &AsyncRuntime) -> Result<()> {
        let context = AsyncContext::full(&rt).await?;
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
    async fn create(path: impl AsRef<Path>) -> Result<Self> {
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
        };
        Ok(extcontainer)
    }
}

pub(crate) type ExtensionUserData = SharedUserContextContainer<JSExtension>;
/// flutter_rust_bridge:non_opaque
#[derive(Serialize, Deserialize, Debug, Default)]
pub struct ExtensionData {
    repo: String,
    name: String,
    #[serde(alias = "type")]
    media_type: Option<Vec<MediaType>>,

    giturl: Option<String>,
    version: Option<String>,
    desc: Option<String>,
    author: Option<String>,
    license: Option<String>,
    tags: Option<Vec<String>>,
    nsfw: Option<bool>,
    lang: Vec<String>,
    url: Option<String>,
    icon: Option<String>,
}
/// flutter_rust_bridge:opaque
pub struct JSExtension {
    #[allow(unused)]
    pub data: ExtensionData,
    pub permission: PermissionStore,
    pub setting: SettingStore,
}
