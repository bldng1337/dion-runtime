use tokio_util::sync::CancellationToken;

use crate::{datastructs::{Entry, EntryDetailed, ExtensionData, Sort, Source}, error::Result};

#[async_trait::async_trait()]
pub trait TExtensionManager<T:TExtension> {
    async fn get_extensions(&self)->Result<Vec<T>>;
}

#[async_trait::async_trait()]
pub trait TExtension {
    fn is_enabled(&self)->bool;
    async fn set_enabled(&mut self,enabled:bool)->Result<()>;
    async fn get_data(&self)->ExtensionData;

    async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>
    ) -> Result<Vec<Entry>>;

    async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancellationToken>
    ) -> Result<Vec<Entry>>;

    async fn fromurl(
        &self,
        url: String,
        token: Option<CancellationToken>
    ) -> Result<Option<Entry>>;

    async fn detail(
        &self,
        entryid: &str,
        token: Option<CancellationToken>
    ) -> Result<EntryDetailed>;

    async fn source(&self, epid: &String, token: Option<CancellationToken>) -> Result<Source>;
}