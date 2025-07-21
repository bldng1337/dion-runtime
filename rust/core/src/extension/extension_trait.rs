use std::collections::HashMap;

use anyhow::Result;
use tokio_util::sync::CancellationToken;

use crate::data::datastructs::{Entry, EntryDetailed, ExtensionData, Sort, Source};
use crate::data::settings::Setting;
#[async_trait::async_trait()]
pub trait TSourceExtensionManager<T: TSourceExtension> {
    async fn get_extensions(&self) -> Result<Vec<T>>;
}

#[async_trait::async_trait()]
pub trait TSourceExtension {
    fn is_enabled(&self) -> bool;
    async fn set_enabled(&mut self, enabled: bool) -> Result<()>;
    async fn get_data(&self) -> ExtensionData;

    async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>>;

    async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancellationToken>,
    ) -> Result<Vec<Entry>>;

    async fn fromurl(&self, url: &str, token: Option<CancellationToken>) -> Result<Option<Entry>>;

    async fn detail(
        &self,
        entryid: &str,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<EntryDetailed>;

    async fn source(
        &self,
        epid: &str,
        settings: HashMap<String, Setting>,
        token: Option<CancellationToken>,
    ) -> Result<Source>;

    // Extensions
    // async fn call(method: &str, args: Vec<Value>) -> Value;

    // async fn register(
    //     method: &str,
    //     callback: dyn Fn(Vec<Value>) -> dyn Future<Value> + Send + Sync + 'static,
    // );
}
