use anyhow::{anyhow, Context as ErrorContext, Result};
use base64::{engine::general_purpose::STANDARD, Engine as _};
use boa_engine::{
    js_string, module::SyntheticModuleInitializer, object::FunctionObjectBuilder, Context, JsArgs,
    JsError, JsNativeError, JsResult, JsString, JsValue, Module, NativeFunction,
};

pub fn declare(context: &mut Context) -> Result<()> {
    let decode_base64_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(decode_base64))
            .length(1)
            .name("decode_base64")
            .build();
    let encode_base64_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(encode_base64))
            .length(1)
            .name("encode_base64")
            .build();
    context.module_loader().register_module(
        js_string!("convert"),
        Module::synthetic(
            &[js_string!("decode_base64"), js_string!("encode_base64")],
            SyntheticModuleInitializer::from_copy_closure_with_captures(
                move |m, (decode_base64, encode_base64), _ctx| {
                    m.set_export(&js_string!("decode_base64"), decode_base64.clone().into())?;
                    m.set_export(&js_string!("encode_base64"), encode_base64.clone().into())?;
                    Ok(())
                },
                (decode_base64_fn, encode_base64_fn),
            ),
            None,
            None,
            context,
        ),
    );
    Ok(())
}

fn decode_base64(_this: &JsValue, args: &[JsValue], _context: &mut Context) -> JsResult<JsValue> {
    let arg1 = args
        .get_or_undefined(0)
        .as_string()
        .ok_or(JsError::from_native(JsNativeError::error()))?
        .to_std_string_lossy();
    let ret = String::from_utf8(STANDARD.decode(arg1).map_err(|e| JsError::from_rust(e))?)
        .map_err(|e| JsError::from_rust(e))?;
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
