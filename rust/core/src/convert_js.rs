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
        String::from_utf8(
            STANDARD
                .decode(str)
                .map_err(|_e| rquickjs::Error::Exception)?,
        )
        .map_err(|_e| rquickjs::Error::Exception)
    }
}
