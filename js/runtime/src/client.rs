#![deny(clippy::all)]

use anyhow::bail;
use anyhow::Result;
use dion_runtime::data::settings::SettingValue;
use dion_runtime::data::source::EntryId;
use dion_runtime::{
  client_data::{AdapterClient, ExtensionClient},
  data::{action::Action, extension::ExtensionData, permission::Permission},
};
use napi::{
  bindgen_prelude::{FnArgs, Reference},
  threadsafe_function::{ThreadsafeFunction, ThreadsafeFunctionCallMode},
  tokio::sync::oneshot,
};
use napi_derive::napi;
use std::{fmt::Debug, sync::Arc};

struct ClientExtensionHandlerInner {
  load_data: ThreadsafeFunction<String, String>,
  store_data: ThreadsafeFunction<FnArgs<(String, String)>, ()>,
  do_action: ThreadsafeFunction<serde_json::Value, ()>,
  request_permission: ThreadsafeFunction<FnArgs<(serde_json::Value, Option<String>)>, bool>,
  get_path: ThreadsafeFunction<(), String>,
  set_entry_setting:
    ThreadsafeFunction<FnArgs<(serde_json::Value, serde_json::Value, serde_json::Value)>, ()>,
}

impl Debug for ClientExtensionHandlerInner {
  fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
    f.debug_struct("ClientExtensionHandlerInner").finish()
  }
}

#[napi(js_name = "ExtensionClient")]
#[derive(Debug)]
pub struct ClientExtensionHandler {
  inner: Arc<ClientExtensionHandlerInner>,
}

impl Clone for ClientExtensionHandler {
  fn clone(&self) -> Self {
    Self {
      inner: self.inner.clone(),
    }
  }
}

#[napi]
impl ClientExtensionHandler {
  #[napi(
    constructor,
    ts_args_type = "loadData: ((err: Error | null, key: string) => string), storeData: ((err: Error | null, key: string, value: string) => void), doAction: ((err: Error | null, action: Action) => void), requestPermission: ((err: Error | null, permission: Permission, msg?: string | undefined | null) => boolean), getPath: ((err: Error | null, ) => string)"
  )]
  pub fn new(
    load_data: ThreadsafeFunction<String, String>,
    store_data: ThreadsafeFunction<FnArgs<(String, String)>, ()>,
    do_action: ThreadsafeFunction<serde_json::Value, ()>,
    request_permission: ThreadsafeFunction<FnArgs<(serde_json::Value, Option<String>)>, bool>,
    get_path: ThreadsafeFunction<(), String>,
    set_entry_setting: ThreadsafeFunction<
      FnArgs<(serde_json::Value, serde_json::Value, serde_json::Value)>,
      (),
    >,
  ) -> Self {
    Self {
      inner: Arc::new(ClientExtensionHandlerInner {
        load_data,
        store_data,
        do_action,
        request_permission,
        get_path,
        set_entry_setting,
      }),
    }
  }
}

#[async_trait::async_trait]
impl ExtensionClient for ClientExtensionHandler {
  async fn set_entry_setting(
    &self,
    entry: EntryId,
    key: String,
    value: SettingValue,
  ) -> Result<()> {
    self
      .inner
      .set_entry_setting
      .call_async(Ok(
        (
          serde_json::to_value(entry)?,
          serde_json::to_value(key)?,
          serde_json::to_value(value)?,
        )
          .into(),
      ))
      .await?;
    Ok(())
  }

  async fn load_data(&self, key: &str) -> Result<String> {
    let res = self.inner.load_data.call_async(Ok(key.to_string())).await?;
    Ok(res)
  }

  async fn load_data_secure(&self, _key: &str) -> Result<String> {
    bail!("No loading implemented")
  }

  async fn store_data_secure(&self, _key: &str, _data: String) -> Result<()> {
    Ok(())
  }

  async fn store_data(&self, key: &str, data: String) -> Result<()> {
    self
      .inner
      .store_data
      .call_async(Ok((key.to_string(), data).into()))
      .await?;
    Ok(())
  }

  async fn do_action(&self, action: &Action) -> Result<()> {
    self
      .inner
      .do_action
      .call_async(Ok(serde_json::to_value(action)?))
      .await?;
    Ok(())
  }

  async fn request_permission(&self, permission: &Permission, msg: Option<String>) -> Result<bool> {
    let res = self
      .inner
      .request_permission
      .call_async(Ok((serde_json::to_value(permission)?, msg).into()))
      .await?;
    Ok(res)
  }

  async fn get_path(&self) -> Result<String> {
    let res = self.inner.get_path.call_async(Ok(())).await?;
    Ok(res)
  }
}

struct ClientManagerInner {
  get_client: ThreadsafeFunction<serde_json::Value, Reference<ClientExtensionHandler>>,
  get_path: ThreadsafeFunction<(), String>,
}

#[napi(js_name = "ManagerClient")]
pub struct ClientManagerHandler {
  inner: Arc<ClientManagerInner>,
}

#[napi]
impl ClientManagerHandler {
  #[napi(
    constructor,
    ts_args_type = "getClient: ((err: Error | null, arg: ExtensionData) => ExtensionClient), getPath: ((err: Error | null, ) => string)"
  )]
  pub fn new(
    get_client: ThreadsafeFunction<serde_json::Value, Reference<ClientExtensionHandler>>,
    get_path: ThreadsafeFunction<(), String>,
  ) -> Self {
    Self {
      inner: Arc::new(ClientManagerInner {
        get_client,
        get_path,
      }),
    }
  }
}

impl Clone for ClientManagerHandler {
  fn clone(&self) -> Self {
    Self {
      inner: self.inner.clone(),
    }
  }
}

#[async_trait::async_trait]
impl AdapterClient for ClientManagerHandler {
  async fn get_extension_client(
    &self,
    extension: ExtensionData,
  ) -> Result<Box<dyn ExtensionClient>> {
    let (send, resp) = oneshot::channel();
    self.inner.get_client.call_with_return_value(
      Ok(serde_json::to_value(extension)?),
      ThreadsafeFunctionCallMode::Blocking,
      |res, _env| {
        let res = res.map(|a| Box::new((*a).clone()));
        //TODO: Error Handling
        let _ = send.send(res);
        Ok(())
      },
    );
    let res = resp.await?;
    Ok(res?)
  }

  async fn get_path(&self) -> Result<String> {
    Ok(self.inner.get_path.call_async(Ok(())).await?)
  }
}
