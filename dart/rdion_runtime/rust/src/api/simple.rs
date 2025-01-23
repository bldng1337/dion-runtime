use deadqueue::limited::Queue;
pub use dion_runtime::datastructs::{
    CustomUI, Entry, EntryDetailed, EpisodeList, ExtensionData, MediaType, MetaData, ReleaseStatus,
    Sort, Source,
};
use dion_runtime::error::{Error, Result};
use dion_runtime::extension_container::ExtensionContainer;
use dion_runtime::extension_manager::ExtensionManager;
use dion_runtime::permission::{Permission, PermissionRequester, PERMISSION};

use dion_runtime::extension::{TExtension, TExtensionManager};
use dion_runtime::settings::{Setting, Settingtype, Settingvalue};
use flutter_rust_bridge::frb;
use std::fmt::Debug;
use std::sync::{Arc, LazyLock};
use std::time::Duration;
use tokio::sync::RwLock;
use tokio::time::sleep;
use tokio_util::sync::CancellationToken;

use crate::frb_generated::StreamSink;


#[frb(rust2dart(dart_type = "String", dart_code = "{}"))]
pub fn encode_fancy_type(raw: serde_json::Value) -> String {
    serde_json::to_string(&raw).unwrap()
}

#[frb(dart2rust(dart_type = "String", dart_code = "{}"))]
pub fn decode_fancy_type(raw: String) -> serde_json::Value {
    serde_json::from_str(&raw).unwrap()
}

struct PermissionSink {
    sink: StreamSink<PermissionRequest>,
    queue: Arc<Queue<bool>>,
}

pub struct PermissionRequest {
    pub permission: Permission,
    pub msg: Option<String>,
}

#[async_trait::async_trait]
impl PermissionRequester for PermissionSink {
    async fn request(&self, permission: &Permission, msg: Option<String>) -> bool {
        while !self.queue.is_empty() {
            //Prob not good
            sleep(Duration::from_millis(500)).await;
        }
        let res = self.sink.add(PermissionRequest {
            permission: permission.clone(),
            msg: msg,
        });
        if res.is_err() {
            return false;
        }
        self.queue.pop().await
    }
}

impl Debug for PermissionSink {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        f.debug_struct("PermissionSink").finish()
    }
}

#[frb(opaque)]
pub struct QueueStore {
    queue: Option<Arc<Queue<bool>>>,
}
impl Default for QueueStore {
    fn default() -> Self {
        Self { queue: None }
    }
}
pub static QUEUE: LazyLock<RwLock<QueueStore>> = LazyLock::new(|| RwLock::new(Default::default()));
pub async fn internal_set_permission_request_listener(request: StreamSink<PermissionRequest>) {
    let queue: Arc<Queue<bool>> = Arc::new(Queue::new(1));
    let permreq = PermissionSink {
        sink: request,
        queue: queue.clone(),
    };
    PERMISSION.write().await.requester = Some(Box::new(permreq));
    QUEUE.write().await.queue = Some(queue);
}
pub async fn internal_send_permission_request_answer(answer: bool) -> Result<()> {
    match &QUEUE.read().await.queue {
        Some(perm) => {
            perm.push(answer).await;
            Ok(())
        }
        None => Err(Error::ExtensionError("()".to_owned())),
    }
}

pub struct ExtensionManagerProxy {
    inner: ExtensionManager,
}

impl ExtensionManagerProxy {
    #[frb(sync)]
    pub fn new(path: &str) -> Self {
        ExtensionManagerProxy {
            inner: ExtensionManager::new(path),
        }
    }

    pub async fn get_extensions(&self) -> Result<Vec<ExtensionProxy>> {
        Ok(self
            .inner
            .get_extensions()
            .await?
            .into_iter()
            .map(|a| ExtensionProxy { inner: a })
            .collect())
    }
}

pub struct ExtensionProxy {
    inner: ExtensionContainer,
}

impl ExtensionProxy {
    // PERMISSIONS
    pub async fn permissions_iter(&self) -> Vec<Permission> {
        self.inner
            .get_extension()
            .await
            .permission
            .get_permissions()
            .map(|a| a.clone())
            .collect()
    }

    pub async fn remove_permissions(&self, permission: &Permission) {
        self.inner
            .get_extension_mut()
            .await
            .permission
            .remove_permission(permission)
    }

    //SETTINGS
    pub async fn setting_ids(&self) -> Vec<String> {
        self.inner
            .get_extension()
            .await
            .setting
            .get_settings_ids()
            .map(|a| a.clone())
            .collect()
    }

    pub async fn setting_ids_filtered(&self, settingtype: &Settingtype) -> Vec<String> {
        self.inner
            .get_extension()
            .await
            .setting
            .iter()
            .filter(|a| a.1.settingtype == *settingtype)
            .map(|a| a.0.clone())
            .collect()
    }

    pub async fn get_setting(&self, name: &String) -> Result<Setting> {
        self.inner
            .get_extension()
            .await
            .setting
            .get_setting(name)
            .cloned()
    }

    pub async fn set_setting(&self, name: &String, setting: Settingvalue) -> Result<()> {
        self.inner
            .get_extension_mut()
            .await
            .setting
            .get_setting_mut(name)?
            .val
            .overwrite(setting)
    }

    //EXTENSION STATE
    pub async fn data(&self) -> ExtensionData {
        self.inner.get_extension().await.data.clone()
    }

    pub async fn enable(&mut self) -> Result<()> {
        self.inner.set_enabled(true).await
    }

    pub async fn disable(&mut self) -> Result<()> {
        self.inner.set_enabled(false).await
    }

    pub async fn is_enabled(&self) -> bool {
        self.inner.is_enabled()
    }

    //EXTENSION METHODS
    pub async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancelToken>,
    ) -> Result<Vec<Entry>> {
        self.inner.browse(page, sort, token.map(|a| a.into())).await
    }

    pub async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancelToken>,
    ) -> Result<Vec<Entry>> {
        self.inner
            .search(page, filter, token.map(|a| a.into()))
            .await
    }

    pub async fn detail(
        &self,
        entryid: &String,
        token: Option<CancelToken>,
    ) -> Result<EntryDetailed> {
        self.inner
            .detail(entryid, token.map(|a| a.into()))
            .await
            .map(|a| a.into())
    }

    pub async fn source(&self, epid: &String, token: Option<CancelToken>) -> Result<Source> {
        self.inner.source(epid, token.map(|a| a.into())).await
    }

    pub async fn fromurl(&self, url: String, token: Option<CancelToken>) -> Result<Option<Entry>> {
        self.inner.fromurl(url, token.map(|a| a.into())).await
    }
}

// pub struct ExtensionManagerProxy {
//     inner: InnerExtensionManager<Arc<RwLock<ExtensionContainer>>>,
//     engine: Arc<AsyncRuntime>,
// }

// impl ExtensionManagerProxy {
//     #[frb(sync)]
//     pub fn new() -> ExtensionManagerProxy {
//         ExtensionManagerProxy {
//             inner: Default::default(),
//             engine: Arc::new(AsyncRuntime::new().unwrap()),
//         }
//     }
//     pub async fn add_from_file(&mut self, path: String) -> Result<ExtensionProxy> {
//         self.inner
//             .add_from_file(&path)
//             .await
//             .map(|a| ExtensionProxy::construct(a.clone(), self.engine.clone()))
//     }

//     pub async fn remove(&mut self, id: &String) {
//         let mut res: Option<usize> = None;
//         for (cpos, ext) in self.inner.iter().enumerate() {
//             if ext.read().await.get_extension().await.data.id == *id {
//                 res = Some(cpos)
//             }
//         }
//         if res.is_some() {
//             self.inner.remove(res.unwrap());
//         }
//     }

//     pub fn iter(&self) -> Vec<ExtensionProxy> {
//         self.inner
//             .iter()
//             .map(|a| ExtensionProxy::construct(a.clone(), self.engine.clone()))
//             .collect()
//     }
// }

// pub struct ExtensionProxy {
//     inner: Arc<RwLock<ExtensionContainer>>,
//     engine: Arc<AsyncRuntime>,
// }

// impl Clone for ExtensionProxy {
//     fn clone(&self) -> Self {
//         Self {
//             inner: self.inner.clone(),
//             engine: self.engine.clone(),
//         }
//     }
// }

// impl ExtensionProxy {
//     fn construct(inner: Arc<RwLock<ExtensionContainer>>, engine: Arc<AsyncRuntime>) -> Self {
//         ExtensionProxy {
//             inner: inner,
//             engine: engine,
//         }
//     }
//     pub async fn new(filepath: &String) -> Result<Self> {
//         Ok(ExtensionProxy {
//             inner: Arc::new(RwLock::new(ExtensionContainer::create(filepath).await?)),
//             engine: Arc::new(AsyncRuntime::new()?),
//         })
//     }

//     //PERMISSIONS
//     pub async fn permissions_iter(&self) -> Vec<Permission> {
//         self.inner
//             .read()
//             .await
//             .get_extension()
//             .await
//             .permission
//             .get_permissions()
//             .map(|a| a.clone())
//             .collect()
//     }

//     pub async fn remove_permissions(&self, permission: &Permission) {
//         self.inner
//             .write()
//             .await
//             .get_extension_mut()
//             .await
//             .permission
//             .remove_permission(permission)
//     }

//     //SETTINGS
//     pub async fn setting_ids(&self) -> Vec<String> {
//         self.inner
//             .read()
//             .await
//             .get_extension()
//             .await
//             .setting
//             .get_settings_ids()
//             .map(|a| a.clone())
//             .collect()
//     }

//     pub async fn setting_ids_filtered(&self, settingtype: &Settingtype) -> Vec<String> {
//         self.inner
//             .read()
//             .await
//             .get_extension()
//             .await
//             .setting
//             .iter()
//             .filter(|a| a.1.settingtype == *settingtype)
//             .map(|a| a.0.clone())
//             .collect()
//     }

//     pub async fn get_setting(&self, name: &String) -> Result<Setting> {
//         self.inner
//             .read()
//             .await
//             .get_extension()
//             .await
//             .setting
//             .get_setting(name)
//             .cloned()
//     }

//     pub async fn set_setting(&self, name: &String, setting: Settingvalue) -> Result<()> {
//         self.inner
//             .write()
//             .await
//             .get_extension_mut()
//             .await
//             .setting
//             .get_setting_mut(name)?
//             .val
//             .overwrite(setting)
//     }

//     //EXTENSION STATE
//     pub async fn data(&self) -> ExtensionData {
//         self.inner.read().await.get_extension().await.data.clone()
//     }

//     pub async fn enable(&self) -> Result<()> {
//         self.inner.write().await.enable(self.engine.deref()).await
//     }

//     pub async fn disable(&self) {
//         self.inner.write().await.disable().await
//     }

//     pub async fn is_enabled(&self) -> bool {
//         self.inner.read().await.is_enabled()
//     }

//     //EXTENSION METHODS
//     pub async fn browse(
//         &self,
//         page: i64,
//         sort: Sort,
//         token: Option<CancelToken>,
//     ) -> Result<Vec<Entry>> {
//         self.inner
//             .read()
//             .await
//             .browse(page, sort, token.map(|a| a.into()))
//             .await
//     }

//     pub async fn search(
//         &self,
//         page: i64,
//         filter: &str,
//         token: Option<CancelToken>,
//     ) -> Result<Vec<Entry>> {
//         self.inner
//             .read()
//             .await
//             .search(page, filter, token.map(|a| a.into()))
//             .await
//     }

//     pub async fn detail(
//         &self,
//         entryid: &String,
//         token: Option<CancelToken>,
//     ) -> Result<EntryDetailed> {
//         self.inner
//             .read()
//             .await
//             .detail(entryid, token.map(|a| a.into()))
//             .await.map(|a| a.into())
//     }

//     pub async fn source(&self, epid: &String, token: Option<CancelToken>) -> Result<Source> {
//         self.inner
//             .read()
//             .await
//             .source(epid, token.map(|a| a.into()))
//             .await
//     }

//     pub async fn fromurl(&self, url: String, token: Option<CancelToken>) -> Result<Option<Entry>> {
//         self.inner
//             .read()
//             .await
//             .fromurl(url, token.map(|a| a.into()))
//             .await
//     }
// }

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

// /// flutter_rust_bridge:non_opaque
// pub struct EntryDetailed {
//     pub id: String,
//     pub url: String,
//     pub title: String,

//     pub ui: Option<String>, //This contains cyclic data so not sure how to handle that to keep it serde and dart usw friendly

//     pub media_type: MediaType,
//     pub status: ReleaseStatus,
//     pub description: String,
//     pub language: String,

//     pub cover: Option<String>,
//     pub cover_header: Option<HashMap<String, String>>,

//     pub episodes: Vec<EpisodeList>,
//     pub genres: Option<Vec<String>>,
//     pub alttitles: Option<Vec<String>>,
//     pub author: Option<Vec<String>>,
//     pub rating: Option<f32>,
//     pub views: Option<f32>,
//     pub length: Option<i32>,
// }

// impl Into<dion_runtime::datastructs::EntryDetailed> for EntryDetailed {
//     fn into(self) -> dion_runtime::datastructs::EntryDetailed {
//         dion_runtime::datastructs::EntryDetailed {
//             id: self.id,
//             url: self.url,
//             title: self.title,
//             ui: serde_json::from_str(&self.ui).unwrap_or_default(),
//             media_type: self.media_type,
//             status: self.status,
//             description: self.description,
//             language: self.language,
//             cover: self.cover,
//             cover_header: self.cover_header,
//             episodes: self.episodes,
//             genres: self.genres,
//             alttitles: self.alttitles,
//             author: self.author,
//             rating: self.rating,
//             views: self.views,
//             length: self.length,
//         }
//     }
// }

// impl From<dion_runtime::datastructs::EntryDetailed> for EntryDetailed {
//     fn from(value: dion_runtime::datastructs::EntryDetailed) -> Self {
//         Self {
//             id: value.id,
//             url: value.url,
//             title: value.title,
//             ui: serde_json::to_string(&value.ui).unwrap_or_default(),
//             media_type: value.media_type,
//             status: value.status,
//             description: value.description,
//             language: value.language,
//             cover: value.cover,
//             cover_header: value.cover_header,
//             episodes: value.episodes,
//             genres: value.genres,
//             alttitles: value.alttitles,
//             author: value.author,
//             rating: value.rating,
//             views: value.views,
//             length: value.length,
//         }
//     }
// }

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
