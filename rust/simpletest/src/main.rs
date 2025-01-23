use std::{
    collections::HashMap,
    path::Path,
    rc::Rc,
    time::{self, Duration},
};

use boa_engine::{
    builtins::promise::PromiseState,
    gc::GcRefCell,
    job::NativeAsyncJob,
    js_string,
    module::{ModuleLoader, Referrer, SimpleModuleLoader, SyntheticModuleInitializer},
    object::{builtins::JsPromise, FunctionObjectBuilder},
    property::Attribute,
    Context, JsError, JsNativeError, JsResult, JsString, JsValue, JsVariant, Module,
    NativeFunction, Source,
};
use boa_runtime::Console;
use tokio::{task, time::sleep};

#[derive(Debug)]
pub struct VirtualModuleLoader {
    module_map: GcRefCell<HashMap<String, Module>>,
}

impl VirtualModuleLoader {
    /// Creates a new `SimpleModuleLoader` from a root module path.
    pub fn new() -> JsResult<Self> {
        Ok(Self {
            module_map: GcRefCell::default(),
        })
    }

    /// Inserts a new module onto the module map.
    #[inline]
    pub fn insert(&self, path: String, module: Module) {
        self.module_map.borrow_mut().insert(path, module);
    }

    /// Gets a module from its original path.
    #[inline]
    pub fn get(&self, path: &String) -> Option<Module> {
        self.module_map.borrow().get(path).cloned()
    }
}

impl ModuleLoader for VirtualModuleLoader {
    fn load_imported_module(
        &self,
        referrer: Referrer,
        specifier: JsString,
        finish_load: Box<dyn FnOnce(JsResult<Module>, &mut Context)>,
        context: &mut Context,
    ) {
        let result: Result<Module, JsError> = (|| {
            let short_path = specifier.to_std_string_escaped();
            if let Some(module) = self.get(&short_path) {
                return Ok(module);
            }
            Err(JsError::from_native(JsNativeError::syntax().with_message(
                format!("could not parse module `{short_path}`"),
            )))
        })();
        finish_load(result, context);
    }

    fn register_module(&self, specifier: JsString, module: Module) {
        self.insert(specifier.to_std_string_escaped(), module);
    }

    fn get_module(&self, specifier: JsString) -> Option<Module> {
        self.get(&specifier.to_std_string_escaped())
    }
}

fn async_test(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let (promise, resolve) = JsPromise::new_pending(context);
    let ret = promise.clone();
    context.enqueue_job(boa_engine::job::Job::AsyncJob(NativeAsyncJob::with_realm(
        move |context| {
            Box::pin(async move {
                println!("Start sleeping");
                sleep(Duration::from_millis(3000)).await;
                println!("Finished sleeping");
                let context = &mut context.borrow_mut();
                resolve.resolve.call(
                    &promise.into(),
                    &[JsValue::from(js_string!("some"))],
                    context,
                )?;
                Ok(JsValue::undefined())
            })
        },
        context.realm().clone(),
    )));
    Ok(ret.into())
}

#[tokio::main]
async fn main() {
    // let local_set = &mut task::LocalSet::default();
    // let engine = local_set.run_until(async {
        let loader = Rc::new(VirtualModuleLoader::new().unwrap());
        let mut context = Context::builder()
            .module_loader(loader.clone())
            .build()
            .unwrap();

        loader.register_module(
            js_string!("test"),
            Module::synthetic(
                &[js_string!("sometest"), js_string!("other")],
                SyntheticModuleInitializer::from_copy_closure_with_captures(
                    move |m, value, _ctx| {
                        let body = NativeFunction::from_fn_ptr(|_this, args, _ctx| {
                            Ok(false.into()) // Otherwise we return `false`.
                        });
                        let function = FunctionObjectBuilder::new(_ctx.realm(), body)
                            .name("sometest")
                            .length(0)
                            .constructor(true)
                            .build();
                        let other = FunctionObjectBuilder::new(
                            _ctx.realm(),
                            NativeFunction::from_fn_ptr(async_test),
                        )
                        .name("other")
                        .length(0)
                        .constructor(true)
                        .build();
                        m.set_export(&js_string!("sometest"), function.into())?;
                        m.set_export(&js_string!("other"), other.into())?;
                        Ok(())
                    },
                    boa_engine::JsValue::undefined(),
                ),
                None,
                None,
                &mut context,
            ),
        );
        println!("Test");
        let console = Console::init(&mut context);
        context
            .register_global_property(Console::NAME, console, Attribute::all())
            .expect("the console builtin shouldn't exist");
        context
            .eval(Source::from_bytes("const print=(a)=>console.log(a);"))
            .unwrap();
        let module = Module::parse(
            Source::from_bytes(
                r#"
    import { sometest,other } from 'test';
    print("asd");
    console.log(sometest());
    async function asd(){
        console.log(await other());
        console.log("Fullfilled");
    }
    asd();
    // other().then((a)=>{
    //     console.log("Fullfilled");
    //     console.log(a);
    // });
    
    "#,
            ),
            None,
            &mut context,
        )
        .unwrap();
        loader.register_module(js_string!("extension"), module.clone());
        let promise = module.load_link_evaluate(&mut context);
        println!("Finished link");
        context.run_jobs_async().await.unwrap();
        match promise.state() {
            PromiseState::Rejected(js_value) => println!(
                "{}",
                js_value
                    .to_string(&mut context)
                    .unwrap()
                    .to_std_string_lossy()
            ),
            _ => (),
        };
        assert_eq!(
            promise.state(),
            PromiseState::Fulfilled(JsValue::undefined())
        );
    // });
    // tokio::join!(engine);
}
