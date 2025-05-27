use dion_runtime::data::datastructs::*;

pub use dion_runtime::data::datastructs::*;

pub use dion_runtime::data::settings::{ExtensionSetting, Setting, Settingvalue};

use anyhow::{Context, Result};
use dion_runtime::extension::extension::{TSourceExtension, TSourceExtensionManager};
use dion_runtime::extension::extension_container::ExtensionContainer;
use dion_runtime::extension::extension_manager::ExtensionManager;
use flutter_rust_bridge::{frb, DartFnFuture};
use tokio_util::sync::CancellationToken;

#[frb(rust2dart(dart_type = "String", dart_code = "{}"))]
pub fn encode_fancy_type(raw: serde_json::Value) -> String {
    serde_json::to_string(&raw).unwrap()
}

#[frb(dart2rust(dart_type = "String", dart_code = "{}"))]
pub fn decode_fancy_type(raw: String) -> serde_json::Value {
    serde_json::from_str(&raw).unwrap()
}

// struct PermissionSink {
//     sink: StreamSink<PermissionRequest>,
//     queue: Arc<Queue<bool>>,
// }

// pub struct PermissionRequest {
//     pub permission: Permission,
//     pub msg: Option<String>,
// }

// #[async_trait::async_trait]
// impl PermissionRequester for PermissionSink {
//     async fn request(&self, permission: &Permission, msg: Option<String>) -> bool {
//         while !self.queue.is_empty() {
//             //Prob not good
//             sleep(Duration::from_millis(500)).await;
//         }
//         let res = self.sink.add(PermissionRequest {
//             permission: permission.clone(),
//             msg: msg,
//         });
//         if res.is_err() {
//             return false;
//         }
//         self.queue.pop().await
//     }
// }

// #[frb(opaque)]
// struct Permission {
//     // queue: Option<Arc<Queue<bool>>>,
//     test: Box<dyn Fn(String) -> DartFnFuture<bool> + Send + Sync + 'static>,
// }
// impl Debug for Permission {
//     fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
//         f.debug_struct("Permission").finish()
//     }
// }

// #[async_trait]
// impl PermissionRequester for Permission {
//     async fn request(&self, permission: Permission, msg: Option<String>) -> bool {
//         true
//     }
// }

// pub async fn set_rust_function(
//     dart_callback: impl Fn(String) -> DartFnFuture<String> + Send + Sync + 'static,
// ) {
//     set_permission_request(requester)
//     // QUEUE.write().await.test = Some(Box::new(dart_callback));
// }

// pub async fn call_rust_function(argument: String) -> String {
//     let Some(ref func) = QUEUE.read().await.test else {
//         return argument;
//     };
//     return func(argument).await;
// }

pub struct SourceExtensionManagerProxy {
    inner: ExtensionManager,
}

impl SourceExtensionManagerProxy {
    #[frb(sync)]
    pub fn new(path: &str) -> Self {
        Self {
            inner: ExtensionManager::new(path),
        }
    }

    pub async fn get_extensions(&self) -> Result<Vec<SourceExtensionProxy>> {
        Ok(self
            .inner
            .get_extensions()
            .await?
            .into_iter()
            .map(|e| SourceExtensionProxy { inner: e })
            .collect())
    }
}

pub struct SourceExtensionProxy {
    inner: ExtensionContainer,
}

impl SourceExtensionProxy {
    pub async fn is_enabled(&self) -> bool {
        self.inner.is_enabled()
    }
    pub async fn set_enabled(&mut self, enabled: bool) -> Result<()> {
        self.inner.set_enabled(enabled).await
    }
    pub async fn get_data(&self) -> ExtensionData {
        self.inner.get_data().await
    }
    pub async fn get_settings_ids(&self) -> Vec<String> {
        self.inner
            .get_extension()
            .await
            .setting
            .get_settings_ids()
            .map(|e| e.clone())
            .collect()
    }
    pub async fn get_setting(&self, name: &String) -> Result<ExtensionSetting> {
        self.inner
            .get_extension()
            .await
            .setting
            .get_setting(name)
            .map(|e| e.clone())
    }
    pub async fn set_setting(&self, name: &String, value: &Settingvalue) -> Result<()> {
        let mut ext = self.inner.get_extension_mut().await;
        ext.setting
            .get_setting_mut(name)?
            .setting
            .val
            .overwrite(value)?;
        ext.setting.save().await;
        Ok(())
    }

    pub async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancelToken>,
    ) -> Result<Vec<Entry>> {
        self.inner.browse(page, sort, token.map(|e| e.into())).await
    }

    pub async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancelToken>,
    ) -> Result<Vec<Entry>> {
        self.inner
            .search(page, filter, token.map(|e| e.into()))
            .await
    }

    pub async fn fromurl(&self, url: &str, token: Option<CancelToken>) -> Result<Option<Entry>> {
        self.inner.fromurl(url, token.map(|e| e.into())).await
    }

    pub async fn detail(
        &self,
        entryid: &str,
        settings: Vec<Setting>,
        token: Option<CancelToken>,
    ) -> Result<EntryDetailed> {
        self.inner
            .detail(entryid, settings, token.map(|e| e.into()))
            .await
    }

    pub async fn source(
        &self,
        epid: &str,
        settings: Vec<Setting>,
        token: Option<CancelToken>,
    ) -> Result<Source> {
        self.inner
            .source(epid, settings, token.map(|e| e.into()))
            .await
    }
}

pub struct CancelToken {
    tok: CancellationToken,
}
impl CancelToken {
    #[frb(sync)]
    pub fn new() -> Self {
        CancelToken {
            tok: CancellationToken::new(),
        }
    }

    pub fn cancel(&self) {
        self.tok.cancel();
    }

    pub fn child(&self) -> CancelToken {
        CancelToken {
            tok: self.tok.child_token(),
        }
    }
}
impl Clone for CancelToken {
    fn clone(&self) -> Self {
        CancelToken {
            tok: self.tok.clone(),
        }
    }
}
impl Into<CancellationToken> for CancelToken {
    fn into(self) -> CancellationToken {
        self.tok
    }
}
