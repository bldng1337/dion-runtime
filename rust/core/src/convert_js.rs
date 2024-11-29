use crate::error::Error;
use rquickjs::{Ctx, Module};

pub fn declare<'js>(ctx: Ctx<'js>) -> Result<(), Error> {
    Module::declare_def::<js_convert, _>(ctx.clone(), "convert")?;
    Ok(())
}

#[rquickjs::module(rename_vars = "camelCase")]
mod convert {
    use base64::{engine::general_purpose::STANDARD, Engine as _};

    #[rquickjs::function]
    pub fn encode_base64(str: String) -> String {
        STANDARD.encode(str).to_string()
    }

    #[rquickjs::function]
    pub fn decode_base64(str: String) -> Result<String, rquickjs::Error> {
        String::from_utf8(STANDARD.decode(str.clone()).map_err(|e| {
            rquickjs::Error::new_resolving_message(
                "",
                "",
                format!("Failed to parse: {} Error: {}", str, e),
            )
        })?)
        .map_err(|e| {
            rquickjs::Error::new_resolving_message(
                "",
                "",
                format!("Failed to convert base64 to utf-8 {} Error: {}", str, e),
            )
        })
    }
}
