use std::rc::Rc;

use anyhow::Result;
use base64::{Engine as _, engine::general_purpose::STANDARD};
use boa_engine::{
    Context, JsArgs, JsError, JsNativeError, JsResult, JsString, JsValue, Module, NativeFunction,
    js_string, module::SyntheticModuleInitializer, object::FunctionObjectBuilder,
};

use crate::utils::VirtualModuleLoader;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    let decode_base64_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(decode_base64))
            .length(1)
            .name("decodeBase64")
            .build();
    let encode_base64_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(encode_base64))
            .length(1)
            .name("encodeBase64")
            .build();
    let module = Module::synthetic(
        &[js_string!("decodeBase64"), js_string!("encodeBase64")],
        SyntheticModuleInitializer::from_copy_closure_with_captures(
            move |m, (decode_base64, encode_base64), _ctx| {
                m.set_export(&js_string!("decodeBase64"), decode_base64.clone().into())?;
                m.set_export(&js_string!("encodeBase64"), encode_base64.clone().into())?;
                Ok(())
            },
            (decode_base64_fn, encode_base64_fn),
        ),
        None,
        None,
        context,
    );
    loader.insert("convert".to_string(), module);
    Ok(())
}

fn decode_base64(_this: &JsValue, args: &[JsValue], _context: &mut Context) -> JsResult<JsValue> {
    let arg1 = args
        .get_or_undefined(0)
        .as_string()
        .ok_or(JsError::from_native(JsNativeError::error()))?
        .to_std_string_lossy();
    let ret = String::from_utf8(STANDARD.decode(arg1).map_err(JsError::from_rust)?)
        .map_err(JsError::from_rust)?;
    Ok(JsString::from(ret).into())
}

fn encode_base64(_this: &JsValue, args: &[JsValue], _context: &mut Context) -> JsResult<JsValue> {
    let arg1 = args
        .get_or_undefined(0)
        .as_string()
        .ok_or(JsError::from_native(JsNativeError::error()))?
        .to_std_string_lossy();
    let ret = STANDARD.encode(arg1);
    Ok(JsString::from(ret).into())
}
