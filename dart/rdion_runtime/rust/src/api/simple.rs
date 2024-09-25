use deadqueue::limited::Queue;
use dion_runtime::datastructs::{Entry, EntryDetailed, Episode, Sort, Source};
use dion_runtime::error::{Error, Result};
use dion_runtime::jsextension::{
    ExtensionContainer, ExtensionData, InnerExtensionManager
};
use dion_runtime::permission::{Permission, PermissionRequester, PERMISSION};

use flutter_rust_bridge::frb;
use rquickjs::AsyncRuntime;
use tokio::time::sleep;
use std::fmt::Debug;
use std::ops::Deref;
use std::sync::{Arc, LazyLock};
use std::time::Duration;
use tokio::sync::RwLock;
use tokio_util::sync::CancellationToken;

use crate::frb_generated::StreamSink;


struct PermissionSink {
    sink: StreamSink<PermissionRequest>,
    queue: Arc<Queue<bool>>
}

pub struct PermissionRequest {
    pub permission:Permission,
    pub msg:Option<String>
}

#[async_trait::async_trait]
impl PermissionRequester for PermissionSink {
    async fn request(&self, permission: &Permission, msg: Option<String>) -> bool {
        while !self.queue.is_empty() {//Prob not good
            sleep(Duration::from_millis(500)).await;
        }
        let res=self.sink.add(PermissionRequest { permission: permission.clone(), msg: msg });
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
    queue:Option<Arc<Queue<bool>>>
}
impl Default for QueueStore {
    fn default() -> Self {
        Self { queue: None }
    }
}
pub static QUEUE: LazyLock<RwLock<QueueStore>> = LazyLock::new(||
    RwLock::new(Default::default())
);
pub async fn internal_set_permission_request_listener(request: StreamSink<PermissionRequest>) {
    let queue: Arc<Queue<bool>>=Arc::new(Queue::new(1));
    let permreq=PermissionSink { sink: request, queue: queue.clone() };
    PERMISSION.write().await.requester=Some(Box::new(permreq));
    QUEUE.write().await.queue=Some(queue);
}
pub async fn internal_send_permission_request_answer(answer:bool)->Result<()>{
    match &QUEUE.read().await.queue {
        Some(perm) => {
            perm.push(answer).await;
            Ok(())
        },
        None => Err(Error::ExtensionError("()".to_owned())),
    }
}

pub struct ExtensionManagerProxy {
    inner: InnerExtensionManager<Arc<RwLock<ExtensionContainer>>>,
    engine: Arc<AsyncRuntime>,
}

impl ExtensionManagerProxy {
    #[frb(sync)]
    pub fn new() -> ExtensionManagerProxy {
        ExtensionManagerProxy {
            inner: Default::default(),
            engine: Arc::new(AsyncRuntime::new().unwrap()),
        }
    }
    pub async fn add_from_file(&mut self, path: String) -> Result<()> {
        self.inner.frb_override_add_from_file(&path).await
    }

    pub fn iter(&self) -> Vec<ExtensionProxy> {
        self.inner.iter().map(|a| ExtensionProxy::new(a.clone(),self.engine.clone())).collect()
    }
}

pub struct ExtensionProxy {
    inner: Arc<RwLock<ExtensionContainer>>,
    engine: Arc<AsyncRuntime>,
}

impl ExtensionProxy {
    fn new(inner: Arc<RwLock<ExtensionContainer>>, engine: Arc<AsyncRuntime>) -> Self {
        ExtensionProxy {
            inner:inner,
            engine:engine,
        }
    }

    pub async fn data(&self) -> ExtensionData {
        self.inner.read().await.get_extension().await.data.clone()
    }

    pub async fn enable(&self) ->Result<()> {
        self.inner.write().await.enable(self.engine.deref()).await
    }

    pub async fn is_enabled(&self) -> bool {
        self.inner.read().await.is_enabled()
    }

    pub async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancelToken>
    ) -> Result<Vec<Entry>> {
        self.inner.read().await.browse(page, sort, token.map(|a|a.into())).await
    }

    pub async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancelToken>
    ) -> Result<Vec<Entry>>{
        self.inner.read().await.search(page, filter, token.map(|a|a.into())).await
    }

    pub async fn detail(&self,entry:Entry,token: Option<CancelToken>) -> Result<EntryDetailed> {
        self.inner.read().await.detail(&entry.id, token.map(|a|a.into())).await
    }

    pub async fn source(&self, ep: &Episode, token: Option<CancelToken>) -> Result<Source>{
        self.inner.read().await.source(&ep.id, token.map(|a|a.into())).await
    }


    pub async fn fromurl(
        &self,
        url: String,
        token: Option<CancelToken>
    ) -> Result<Option<Entry>> {
        self.inner.read().await.fromurl(url, token.map(|a|a.into())).await
    }
}

pub struct CancelToken{
    tok:CancellationToken
}
impl CancelToken {
    #[frb(sync)]
    pub fn new()->Self{
        CancelToken {tok:CancellationToken::new()}
    }
}
impl Clone for CancelToken {
    fn clone(&self) -> Self {
        CancelToken { tok:self.tok.clone() }
    }
}
impl Into<CancellationToken> for CancelToken {
    fn into(self) -> CancellationToken {
        self.tok
    }
}


#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
