use std::sync::Arc;

use dion_runtime::data::action::Action;
use dion_runtime::data::extension::ExtensionData;
use dion_runtime::data::permission::Permission;
use flutter_rust_bridge::frb;
use flutter_rust_bridge::DartFnFuture;

pub struct ManagerClient {
    pub(super) cget_path: Arc<dyn Fn() -> DartFnFuture<String> + Send + Sync>,
    pub(super) cget_client:
        Arc<dyn Fn(ExtensionData) -> DartFnFuture<ExtensionClient> + Send + Sync>,
}

impl ManagerClient {
    #[frb(serialize)]
    pub fn init(
        get_path: impl Fn() -> DartFnFuture<String> + Send + Sync + 'static,
        get_client: impl Fn(ExtensionData) -> DartFnFuture<ExtensionClient> + Send + Sync + 'static,
    ) -> Self {
        Self {
            cget_path: Arc::new(get_path),
            cget_client: Arc::new(get_client),
        }
    }
}

pub struct ExtensionClient {
    pub(super) cload_data: Arc<dyn Fn(String) -> DartFnFuture<String> + Send + Sync>,
    pub(super) cstore_data: Arc<dyn Fn(String, String) -> DartFnFuture<()> + Send + Sync>,
    pub(super) cload_data_secure: Arc<dyn Fn(String) -> DartFnFuture<String> + Send + Sync>,
    pub(super) cstore_data_secure: Arc<dyn Fn(String, String) -> DartFnFuture<()> + Send + Sync>,
    pub(super) cdo_action: Arc<dyn Fn(Action) -> DartFnFuture<()> + Send + Sync>,
    pub(super) crequest_permission:
        Arc<dyn Fn(Permission, Option<String>) -> DartFnFuture<bool> + Send + Sync>,
    pub(super) cget_path: Arc<dyn Fn() -> DartFnFuture<String> + Send + Sync>,
}

impl ExtensionClient {
    #[frb(serialize)]
    pub fn init(
        load_data: impl Fn(String) -> DartFnFuture<String> + Send + Sync + 'static,
        store_data: impl Fn(String, String) -> DartFnFuture<()> + Send + Sync + 'static,
        load_data_secure: impl Fn(String) -> DartFnFuture<String> + Send + Sync + 'static,
        store_data_secure: impl Fn(String, String) -> DartFnFuture<()> + Send + Sync + 'static,
        do_action: impl Fn(Action) -> DartFnFuture<()> + Send + Sync + 'static,
        request_permission: impl Fn(Permission, Option<String>) -> DartFnFuture<bool>
            + Send
            + Sync
            + 'static,
        get_path: impl Fn() -> DartFnFuture<String> + Send + Sync + 'static,
    ) -> Self {
        Self {
            cload_data: Arc::new(load_data),
            cstore_data: Arc::new(store_data),
            cload_data_secure: Arc::new(load_data_secure),
            cstore_data_secure: Arc::new(store_data_secure),
            cdo_action: Arc::new(do_action),
            crequest_permission: Arc::new(request_permission),
            cget_path: Arc::new(get_path),
        }
    }
}
