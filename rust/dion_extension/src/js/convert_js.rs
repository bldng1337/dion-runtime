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
        // Whitespace is allowed in the input per the HTML spec.
        let compact: String = arg.chars().filter(|c| !c.is_ascii_whitespace()).collect();
        let bytes = STANDARD
            .decode(compact)
            .or_else(|_| base64::engine::general_purpose::STANDARD_NO_PAD.decode(arg.trim()))
            .map_err(JsError::from_rust)?;
        Ok(bytes.into_iter().map(char::from).collect())
    }

    #[boa(rename = "btoa")]
    fn btoa(arg: String) -> JsResult<String> {
        let bytes = arg
            .chars()
            .map(|c| {
                u8::try_from(u32::from(c)).map_err(|_| {
                    JsError::from_native(boa_engine::JsNativeError::error().with_message(
                        "btoa: the string contains characters outside of the Latin1 range",
                    ))
                })
            })
            .collect::<JsResult<Vec<u8>>>()?;
        Ok(STANDARD.encode(bytes))
    }
}
