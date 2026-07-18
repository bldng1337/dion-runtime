use std::rc::Rc;

use anyhow::Result;
use boa_engine::Context;
use boa_engine::boa_module;

use crate::utils::VirtualModuleLoader;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    loader.insert("store".to_string(), store::boa_module(None, context));
    Ok(())
}

#[boa_module]
mod store {
    use std::cell::RefCell;

    use boa_engine::{
        Context, JsError, JsNativeError, JsResult, JsValue, job::NativeAsyncJob,
        object::builtins::JsPromise,
    };
    use serde_json::Value;

    use crate::extension::executor::ExtensionRuntimeDataContainer;

    #[boa(rename = "set")]
    fn set(key: String, value: JsValue, context: &mut Context) -> JsResult<JsValue> {
        let value: Value = value.to_json(context)?.unwrap_or(Value::Null);

        let (promise, resolve) = JsPromise::new_pending(context);
        let ret = promise.clone();
        context.enqueue_job(
            NativeAsyncJob::with_realm(
                async move |context: &RefCell<&mut Context>| {
                    match async {
                        let runtime_data: Option<ExtensionRuntimeDataContainer> =
                            context.borrow().get_data().cloned();
                        let runtime_data =
                            runtime_data.ok_or(JsError::from_native(JsNativeError::error()))?;
                        let Some(runtime_data) = runtime_data.inner.upgrade() else {
                            return Err(JsError::from_native(
                                JsNativeError::error()
                                    .with_message("Runtime container has been dropped"),
                            ));
                        };
                        runtime_data
                            .client
                            .store_set(&key, value)
                            .await
                            .map_err(|e| JsError::from_rust(&*e))?;
                        Ok(JsValue::undefined())
                    }
                    .await as JsResult<JsValue>
                    {
                        Ok(val) => resolve.resolve.call(
                            &promise.into(),
                            &[val],
                            &mut context.borrow_mut(),
                        )?,
                        Err(err) => {
                            let mut context = context.borrow_mut();
                            resolve.reject.call(
                                &promise.into(),
                                &[err.to_opaque(&mut context)],
                                &mut context,
                            )?
                        }
                    };
                    Ok(JsValue::undefined())
                },
                context.realm().clone(),
            )
            .into(),
        );
        Ok(ret.into())
    }
}
