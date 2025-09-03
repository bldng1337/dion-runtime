use dion_extension::extension_manager::DionExtensionManager;
use dion_runtime::extension::{Extension, ExtensionManager};

use crate::api::extension::ProxyExtension;

pub(crate) struct WrapperExtensionManager {
    pub(super) inner: Box<dyn ExtensionManager>,
}

impl From<Box<DionExtensionManager>> for WrapperExtensionManager {
    fn from(value: Box<DionExtensionManager>) -> Self {
        Self { inner: value }
    }
}

impl From<Box<dyn ExtensionManager>> for WrapperExtensionManager {
    fn from(value: Box<dyn ExtensionManager>) -> Self {
        Self { inner: value }
    }
}

pub(crate) struct WrapperExtension {
    pub(super) inner: Box<dyn Extension>,
}

impl From<Box<dyn Extension>> for WrapperExtension {
    fn from(value: Box<dyn Extension>) -> Self {
        Self { inner: value }
    }
}

impl From<Box<dyn Extension>> for ProxyExtension {
    fn from(value: Box<dyn Extension>) -> Self {
        Self {
            inner: WrapperExtension { inner: value },
        }
    }
}
impl From<ProxyExtension> for Box<dyn Extension> {
    fn from(value: ProxyExtension) -> Self {
        value.inner.inner
    }
}
