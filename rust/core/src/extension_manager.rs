use boa_engine::{
    builtins::promise::PromiseState,
    js_string,
    object::builtins::JsPromise,
    property::{Attribute, PropertyKey},
    value::{Convert, TryIntoJs},
    Context, JsError, JsObject, JsString, JsValue, Module, Source,
};
use std::io::{self, Write};
use std::{path::Path, rc::Rc, sync::Arc};

use boa_runtime::Console;
use serde_json::Value;
use tokio::{
    fs::{self, read_dir},
    sync::RwLock,
};
use tokio_util::sync::CancellationToken;

use crate::extension_container::ExtensionContainer;
use crate::{
    datastructs::{self, Entry, EntryDetailed, ExtensionData, Sort},
    error::{Error, Result},
    extension::{TExtension, TExtensionManager},
    networking_js,
    permission::PermissionStore,
    permission_js, setting_js,
    settings::SettingStore,
    utils::{
        await_promise, Queue, ReadOnlyUserContextContainer, SharedUserContextContainer,
        VirtualModuleLoader,
    },
};

pub struct ExtensionManager {
    path: String,
}

impl ExtensionManager {
    pub fn new<T>(path: T) -> Self
    where
        T: Into<String>,
    {
        ExtensionManager { path: path.into() }
    }
}

#[async_trait::async_trait()]
impl TExtensionManager<ExtensionContainer> for ExtensionManager {
    async fn get_extensions(&self) -> Result<Vec<ExtensionContainer>> {
        let mut dir = read_dir(&self.path).await?;
        let mut ret = Vec::new();
        while let Some(file) = dir.next_entry().await? {
            if !file
                .file_name()
                .into_string()
                .or(Err(Error::ExtensionError(
                    "Filename conversion failed".to_string(),
                )))?
                .ends_with(".dion.js")
            {
                continue;
            }
            println!("Got Extension {}", file.file_name().to_str().unwrap());
            ret.push(ExtensionContainer::create(file.path()).await?);
        }
        Ok(ret)
    }
}

/// flutter_rust_bridge:opaque
pub struct JSExtension {
    pub data: ExtensionData,
    pub permission: PermissionStore,
    pub setting: SettingStore,
}
