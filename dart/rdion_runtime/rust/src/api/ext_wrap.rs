use dion_extension::extension_manager::DionExtensionAdapter;
use dion_runtime::extension::{Adapter, Extension};

use crate::api::extension::ProxyExtension;

pub(crate) struct WrapperAdapter {
    pub(super) inner: Box<dyn Adapter>,
}

impl From<Box<DionExtensionAdapter>> for WrapperAdapter {
    fn from(value: Box<DionExtensionAdapter>) -> Self {
        Self { inner: value }
    }
}

impl From<Box<dyn Adapter>> for WrapperAdapter {
    fn from(value: Box<dyn Adapter>) -> Self {
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
