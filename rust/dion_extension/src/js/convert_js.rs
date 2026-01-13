use std::rc::Rc;

use boa_engine::Context;

use crate::utils::MapJsResult;
use crate::utils::VirtualModuleLoader;
use anyhow::Result;
use boa_engine::boa_module;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    loader.insert("convert".to_string(), convert::boa_module(None, context));
    convert::boa_register(None, context).map_anyhow_ctx(context)?;
    Ok(())
}

#[boa_module]
mod convert {
    use base64::{Engine as _, engine::general_purpose::STANDARD};
    use boa_engine::{JsError, JsResult};

    #[boa(rename = "decodeBase64")]
    fn decode_base64(arg: String) -> JsResult<String> {
        String::from_utf8(STANDARD.decode(arg).map_err(JsError::from_rust)?)
            .map_err(JsError::from_rust)
    }

    #[boa(rename = "encodeBase64")]
    fn encode_base64(arg: String) -> String {
        STANDARD.encode(arg)
    }

    #[boa(rename = "atob")]
    fn atob(arg: String) -> JsResult<String> {
        String::from_utf8(STANDARD.decode(arg).map_err(JsError::from_rust)?)
            .map_err(JsError::from_rust)
    }

    #[boa(rename = "btoa")]
    fn btoa(arg: String) -> String {
        STANDARD.encode(arg)
    }
}
