// Use #[neon::export] to export Rust functions as JavaScript functions.
// See more at: https://docs.rs/neon/latest/neon/attr.export.html

use std::{collections::HashMap, sync::Arc};

use dion_runtime::{
    data::datastructs::Sort,
    extension::{
        extension_container::ExtensionContainer,
        extension_manager::ExtensionManager,
        extension_trait::{TSourceExtension, TSourceExtensionManager},
    },
};
use neon::{
    handle::Handle,
    object::Object,
    prelude::{Context, FunctionContext, ModuleContext},
    result::{JsResult, NeonResult},
    types::{Finalize, JsArray, JsBoolean, JsBox, JsNumber, JsPromise, JsString, JsValue, Value},
};
use once_cell::sync::OnceCell;
use tokio::{runtime::Runtime, sync::RwLock};

struct ProxyExtensionManager(ExtensionManager);

impl Finalize for ProxyExtensionManager {}

struct ProxyExtensionContainer(Arc<RwLock<ExtensionContainer>>);

impl Finalize for ProxyExtensionContainer {}

fn runtime<'a, C: Context<'a>>(cx: &mut C) -> NeonResult<&'static Runtime> {
    static RUNTIME: OnceCell<Runtime> = OnceCell::new();

    RUNTIME.get_or_try_init(|| Runtime::new().or_else(|err| cx.throw_error(err.to_string())))
}

fn vec_to_array<'a, C: Context<'a>, W: Value>(
    vec: Vec<Handle<W>>,
    cx: &mut C,
) -> JsResult<'a, JsArray> {
    let a = JsArray::new(cx, vec.len());

    for (i, s) in vec.into_iter().enumerate() {
        a.set(cx, i as u32, s)?;
    }

    Ok(a)
}

// Extension Manager

fn _get_extensions(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let manager = cx.argument::<JsBox<ProxyExtensionManager>>(0)?;
    let manager = manager.0.clone();

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extensions = manager.get_extensions().await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(release) => vec_to_array(
                release
                    .into_iter()
                    .map(|a| cx.boxed(ProxyExtensionContainer(Arc::new(RwLock::new(a)))))
                    .collect(),
                &mut cx,
            ),
            Err(err) => cx.throw_error(format!("Error: {err}")),
        });
    });

    // Return the promise back to JavaScript
    Ok(promise)
}

fn _new_extension_manager(mut cx: FunctionContext) -> JsResult<JsBox<ProxyExtensionManager>> {
    let path = cx.argument::<JsString>(0)?;
    let path = path.value(&mut cx);
    Ok(cx.boxed(ProxyExtensionManager(ExtensionManager::new(path))))
}

// Extensions

fn _is_enabled(mut cx: FunctionContext) -> JsResult<JsBoolean> {
    let path = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    Ok(cx.boolean(path.0.blocking_read().is_enabled()))
}

fn _set_enabled(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsBoolean>(1)?;
    let enabled = arg.value(&mut cx);

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let mut extension = extension.write().await;
        let extensions = extension.set_enabled(enabled).await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(_) => Ok(cx.undefined()),
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _get_setting(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsString>(1)?;
    let settingid = arg.value(&mut cx);

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let extension = extension.get_extension().await;
        let setting = extension.setting.get_setting(&settingid).cloned();

        deferred.settle_with(&channel, move |mut cx| match setting {
            Ok(release) => match neon_serde4::to_value(&mut cx, &release) {
                Ok(_) => Ok(cx.undefined()),
                Err(err) => cx.throw_error(format!("Error: {err:#}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _set_setting(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsString>(1)?;
    let settingid = arg.value(&mut cx);

    let arg = cx.argument::<JsValue>(2)?;
    let settings =
        neon_serde4::from_value::<_, dion_runtime::data::settings::Settingvalue>(&mut cx, arg);
    let settings = match settings {
        Ok(val) => val,
        Err(err) => return cx.throw_error(format!("Error getting argument: {err}")),
    };

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let mut extension = extension.get_extension_mut().await;
        let setting = extension
            .setting
            .get_setting_mut(&settingid)
            .map(|err| err.setting.val.overwrite(&settings));

        deferred.settle_with(&channel, move |mut cx| match setting {
            Ok(release) => match release {
                Ok(_) => Ok(cx.undefined()),
                Err(err) => cx.throw_error(format!("Error: {err:#}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _browse(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsNumber>(1)?;
    let page = arg.value(&mut cx).floor() as i64;

    let arg = cx.argument::<JsString>(2)?;
    let sort = match arg.value(&mut cx).to_lowercase().as_str() {
        "latest" => Sort::Latest,
        "popular" => Sort::Popular,
        "updated" => Sort::Updated,
        _ => return cx.throw_error("Wrong Sort"),
    };

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let extensions = extension.browse(page, sort, None).await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(release) => match neon_serde4::to_value(&mut cx, &release) {
                Ok(ok) => Ok(ok),
                Err(err) => cx.throw_error(format!("Error: {err}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _search(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsNumber>(1)?;
    let page = arg.value(&mut cx).floor() as i64;

    let arg = cx.argument::<JsString>(2)?;
    let filter = arg.value(&mut cx);

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let extensions = extension.search(page, &filter, None).await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(release) => match neon_serde4::to_value(&mut cx, &release) {
                Ok(ok) => Ok(ok),
                Err(err) => cx.throw_error(format!("Error: {err}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _fromurl(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsString>(1)?;
    let url = arg.value(&mut cx);

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let extensions = extension.fromurl(&url, None).await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(release) => match neon_serde4::to_value(&mut cx, &release) {
                Ok(ok) => Ok(ok),
                Err(err) => cx.throw_error(format!("Error: {err}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _detail(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsString>(1)?;
    let entryid = arg.value(&mut cx);

    let arg = cx.argument::<JsValue>(2)?;
    let settings = neon_serde4::from_value::<
        _,
        HashMap<String, dion_runtime::data::settings::Setting>,
    >(&mut cx, arg);
    let settings = match settings {
        Ok(val) => val,
        Err(err) => return cx.throw_error(format!("Error: {err}")),
    };

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let extensions = extension.detail(&entryid, settings, None).await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(release) => match neon_serde4::to_value(&mut cx, &release) {
                Ok(ok) => Ok(ok),
                Err(err) => cx.throw_error(format!("Error: {err}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

fn _source(mut cx: FunctionContext) -> JsResult<JsPromise> {
    let rt = runtime(&mut cx)?;

    let channel = cx.channel();
    let arg = cx.argument::<JsBox<ProxyExtensionContainer>>(0)?;
    let extension = arg.0.clone();

    let arg = cx.argument::<JsString>(1)?;
    let entryid = arg.value(&mut cx);

    let arg = cx.argument::<JsValue>(2)?;
    let settings = neon_serde4::from_value::<
        _,
        HashMap<String, dion_runtime::data::settings::Setting>,
    >(&mut cx, arg);
    let settings = match settings {
        Ok(val) => val,
        Err(err) => return cx.throw_error(format!("Error: {err}")),
    };

    let (deferred, promise) = cx.promise();

    rt.spawn(async move {
        let extension = extension.read().await;
        let extensions = extension.source(&entryid, settings, None).await;

        deferred.settle_with(&channel, move |mut cx| match extensions {
            Ok(release) => match neon_serde4::to_value(&mut cx, &release) {
                Ok(ok) => Ok(ok),
                Err(err) => cx.throw_error(format!("Error: {err}")),
            },
            Err(err) => cx.throw_error(format!("Error: {err:#}")),
        });
    });
    Ok(promise)
}

// Use #[neon::main] to add additional behavior at module loading time.
// See more at: https://docs.rs/neon/latest/neon/attr.main.html

#[neon::main]
fn main(mut cx: ModuleContext) -> NeonResult<()> {
    cx.export_function("_get_extensions", _get_extensions)?;
    cx.export_function("_new_extension_manager", _new_extension_manager)?;

    cx.export_function("_is_enabled", _is_enabled)?;
    cx.export_function("_set_enabled", _set_enabled)?;

    cx.export_function("_browse", _browse)?;
    cx.export_function("_search", _search)?;
    cx.export_function("_fromurl", _fromurl)?;
    cx.export_function("_detail", _detail)?;
    cx.export_function("_source", _source)?;

    cx.export_function("_get_setting", _get_setting)?;
    cx.export_function("_set_setting", _set_setting)?;

    Ok(())
}
