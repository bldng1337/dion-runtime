use std::fmt::Debug;

use anyhow::Result;

use crate::{
    datastructs::{Action, ExtensionData},
    permission::Permission,
};

#[async_trait::async_trait]
pub trait ClientManagerData: Send + Sync {
    async fn get_client(&self, extension: ExtensionData) -> Result<Box<dyn ClientExtensionData>>;

    async fn get_path(&self) -> Result<String>;
}

#[async_trait::async_trait]
pub trait ClientExtensionData: Send + Sync + Debug {
    async fn load_data(&self, key: &str) -> Result<String>;
    async fn store_data(&self, key: &str, data: String) -> Result<()>;

    async fn do_action(&self, action: &Action) -> Result<()>;

    async fn request_permission(
        &self,
        permission: &Permission,
        msg: Option<String>,
    ) -> Result<bool>;

    async fn get_path(&self) -> Result<String>;
}

// pub struct JsonStorageHandler {
//     root_path: PathBuf,
// }

// impl JsonStorageHandler {
//     fn to_path(&self, key: &str) -> PathBuf {
//         self.root_path.join(key).with_extension(".json")
//     }
// }

// impl StorageHandler for JsonStorageHandler {
//     async fn load<T: DeserializeOwned>(&self, key: &str) -> Result<T> {
//         let path = self.to_path(key);
//         let data = fs::read(path).await?;
//         let val: T = serde_json::from_slice(&data)?;
//         Ok(val)
//     }

//     async fn store<T: Serialize + Send + Sync>(&self, key: &str, data: &T) -> Result<()> {
//         let path = self.to_path(&key);
//         let data = serde_json::to_vec(data)?;
//         fs::write(path, data).await?;
//         Ok(())
//     }
// }
