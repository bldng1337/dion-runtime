use anyhow::{Context as _, Result};
use boa_engine::{
    class::Class,
    js_string,
    module::SyntheticModuleInitializer,
    object::{builtins::JsArray, FunctionObjectBuilder},
    property::Attribute,
    Context, JsArgs, JsData, JsError, JsNativeError, JsResult, JsString, JsValue, Module,
    NativeFunction,
};
use boa_gc::{Finalize, Trace};
use ego_tree::NodeId;
use scraper::{ElementRef, Html, Selector};
use std::rc::Rc;

use crate::extension::utils::MapJsResult;

pub fn declare(context: &mut Context) -> Result<()> {
    context
        .register_global_class::<Element>()
        .map_anyhow_ctx(context)
        .context("Failed to Register Element class")?;
    context
        .register_global_class::<ElementArray>()
        .map_anyhow_ctx(context)
        .context("Failed to Register ElementArray class")?;
    context
        .register_global_class::<CSSSelector>()
        .map_anyhow_ctx(context)
        .context("Failed to Register CSSSelector class")?;
    let parse_html_fn =
        FunctionObjectBuilder::new(context.realm(), NativeFunction::from_fn_ptr(parse_html))
            .length(1)
            .name("parse_html")
            .build();
    let parse_html_fragment_fn = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(parse_html_fragment),
    )
    .length(1)
    .name("parse_html_fragment")
    .build();
    context.module_loader().register_module(
        js_string!("parse"),
        Module::synthetic(
            &[js_string!("parse_html"), js_string!("parse_html_fragment")],
            SyntheticModuleInitializer::from_copy_closure_with_captures(
                move |m, (parse_html, parse_html_fragment), _ctx| {
                    m.set_export(&js_string!("parse_html"), parse_html.clone().into())?;
                    m.set_export(
                        &js_string!("parse_html_fragment"),
                        parse_html_fragment.clone().into(),
                    )?;
                    Ok(())
                },
                (parse_html_fn, parse_html_fragment_fn),
            ),
            None,
            None,
            context,
        ),
    );
    Ok(())
}

#[derive(Debug, Trace, Finalize, JsData)]
struct ElementArray {
    #[unsafe_ignore_trace]
    doc: Rc<Html>,
    #[unsafe_ignore_trace]
    nodes: Vec<NodeId>,
}

impl ElementArray {
    fn select(this: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let obj = val.get_or_undefined(0).to_object(context)?;
                let selector = obj.downcast_ref::<CSSSelector>().ok_or(
                    JsNativeError::typ().with_message("'selector' is not a Selector object"),
                )?;
                let nodes: Vec<_> = this
                    .nodes
                    .iter()
                    .flat_map(|node| {
                        let Some(node) = this.doc.tree.get(*node) else {
                            return vec![];
                        };
                        let Some(element) = ElementRef::wrap(node) else {
                            return vec![];
                        };
                        element.select(&selector.sel).map(|e| e.id()).collect()
                    })
                    .collect();
                let elarr = ElementArray {
                    doc: this.doc.clone(),
                    nodes,
                };
                return Ok(Class::from_data(elarr, context)?.into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }

    fn len(this: &JsValue, _: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                return Ok(this.nodes.len().into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn text(this: &JsValue, _: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let str: String = this
                    .nodes
                    .iter()
                    .flat_map(|e| {
                        this.doc
                            .tree
                            .get(*e)
                            .map(|e| ElementRef::wrap(e))
                            .filter(|e| e.is_some())
                            .map(|e| e.unwrap().text().collect::<Vec<_>>())
                            .unwrap_or_default()
                    })
                    .collect();
                return Ok(JsString::from(str).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn paragraphs(this: &JsValue, _: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let str = this
                    .nodes
                    .iter()
                    .flat_map(|e| {
                        this.doc
                            .tree
                            .get(*e)
                            .map(|e| ElementRef::wrap(e))
                            .filter(|e| e.is_some())
                            .map(|e| e.unwrap().text().collect::<Vec<_>>())
                            .unwrap_or_default()
                    })
                    .map(|str| JsString::from(str).into());
                return Ok(JsArray::from_iter(str, context).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn attr(this: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let attr = val
                    .get_or_undefined(0)
                    .to_string(context)?
                    .to_std_string_lossy();
                let res = this
                    .nodes
                    .iter()
                    .map(|e| {
                        this.doc
                            .tree
                            .get(*e)
                            .map(|e| ElementRef::wrap(e))
                            .filter(|e| e.is_some())
                            .map(|e| e.unwrap().attr(&attr))
                            .filter(|e| e.is_some())
                            .map(|e| e.unwrap())
                    })
                    .filter(|e| e.is_some())
                    .map(|e| JsString::from(e.unwrap().to_string()).into());
                return Ok(JsArray::from_iter(res, context).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn get(this: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let index = val.get_or_undefined(0).to_u32(context)?;
                let ret = this.nodes.get(index as usize).map(|e| Element {
                    doc: this.doc.clone(),
                    node: *e,
                });
                return match ret {
                    Some(ret) => Ok(Class::from_data(ret, context)?.into()),
                    None => Ok(JsValue::undefined()),
                };
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn first(this: &JsValue, _val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let ret = this.nodes.get(0).map(|e| Element {
                    doc: this.doc.clone(),
                    node: *e,
                });
                return match ret {
                    Some(ret) => Ok(Class::from_data(ret, context)?.into()),
                    None => Ok(JsValue::undefined()),
                };
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn map(thisv: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = thisv.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let callback = val
                    .get_or_undefined(0)
                    .as_callable()
                    .ok_or(JsNativeError::typ().with_message("Argument is not callable"))?;
                let res: Vec<_> = this
                    .nodes
                    .iter()
                    .map(|e| {
                        return callback.call(
                            thisv,
                            &[Class::from_data(
                                Element {
                                    doc: this.doc.clone(),
                                    node: *e,
                                },
                                context,
                            )?
                            .into()],
                            context,
                        );
                    })
                    .filter(|e| e.is_ok())
                    .map(|e| e.unwrap())
                    .collect();
                return Ok(JsArray::from_iter(res, context).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }
    fn filter(thisv: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = thisv.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let callback = val
                    .get_or_undefined(0)
                    .as_callable()
                    .ok_or(JsNativeError::typ().with_message("Argument is not callable"))?;
                let res: Vec<_> = this
                    .nodes
                    .iter()
                    .map(|e| e.clone())
                    .filter(|e| {
                        let Ok(el) = Class::from_data(
                            Element {
                                doc: this.doc.clone(),
                                node: *e,
                            },
                            context,
                        ) else {
                            return false;
                        };
                        let Ok(res) = callback.call(thisv, &[el.into()], context) else {
                            return false;
                        };

                        return res.as_boolean().unwrap_or(false);
                    })
                    .collect();
                return Ok(Class::from_data(
                    ElementArray {
                        doc: this.doc.clone(),
                        nodes: res,
                    },
                    context,
                )?
                .into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a ElementArray object")
            .into())
    }

    //TODO: Map, Filter, foreach, paragraphtext
}

impl Class for ElementArray {
    const NAME: &'static str = "ElementArray";

    fn init(class: &mut boa_engine::class::ClassBuilder<'_>) -> JsResult<()> {
        class.method(
            js_string!("attr"),
            1,
            NativeFunction::from_fn_ptr(Self::attr),
        );
        class.method(
            js_string!("select"),
            1,
            NativeFunction::from_fn_ptr(Self::select),
        );
        class.method(js_string!("get"), 1, NativeFunction::from_fn_ptr(Self::get));
        class.method(js_string!("map"), 1, NativeFunction::from_fn_ptr(Self::map));
        class.method(
            js_string!("filter"),
            1,
            NativeFunction::from_fn_ptr(Self::filter),
        );

        let paragraphs_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::paragraphs),
        )
        .length(0)
        .name("paragraphs")
        .build();
        class.accessor(
            js_string!("paragraphs"),
            Some(paragraphs_fn),
            None,
            Attribute::READONLY,
        );

        let len_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::len),
        )
        .length(0)
        .name("length")
        .build();
        class.accessor(
            js_string!("length"),
            Some(len_fn),
            None,
            Attribute::READONLY,
        );

        let text_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::text),
        )
        .length(0)
        .name("text")
        .build();
        class.accessor(js_string!("text"), Some(text_fn), None, Attribute::READONLY);

        let first_fn = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::first),
        )
        .length(0)
        .name("first")
        .build();
        class.accessor(
            js_string!("first"),
            Some(first_fn),
            None,
            Attribute::READONLY,
        );

        Ok(())
    }

    fn data_constructor(
        _new_target: &JsValue,
        _args: &[JsValue],
        _context: &mut Context,
    ) -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error()))
    }
}

#[derive(Debug, Trace, Finalize, JsData)]
struct Element {
    #[unsafe_ignore_trace]
    doc: Rc<Html>,
    #[unsafe_ignore_trace]
    node: NodeId,
}

impl Element {
    fn parent(this: &JsValue, _val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let ret = element
                    .parent()
                    .map(|e| ElementRef::wrap(e))
                    .filter(|e| e.is_some())
                    .map(|e| e.unwrap().id());
                return match ret {
                    Some(ret) => Ok(Class::from_data(
                        Element {
                            doc: this.doc.clone(),
                            node: ret,
                        },
                        context,
                    )?
                    .into()),
                    None => Ok(JsValue::undefined()),
                };
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
    fn children(this: &JsValue, _val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let ret = ElementArray {
                    doc: this.doc.clone(),
                    nodes: element
                        .children()
                        .map(|e| ElementRef::wrap(e))
                        .filter(|e| e.is_some())
                        .map(|e| e.unwrap().id())
                        .collect(),
                };
                return Ok(Class::from_data(ret, context)?.into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
    fn text(this: &JsValue, _val: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let ret: String = element.text().collect();
                return Ok(JsString::from(ret).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
    fn paragraphs(this: &JsValue, _val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let ret = element.text().map(|str| JsString::from(str).into());
                return Ok(JsArray::from_iter(ret, context).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
    fn name(this: &JsValue, _val: &[JsValue], _: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let ret: String = element.value().name().to_string();
                return Ok(JsString::from(ret).into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
    fn attr(this: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let attr = val
                    .get_or_undefined(0)
                    .to_string(context)?
                    .to_std_string_lossy();
                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let ret = element.attr(&attr).map(|e| e.to_string());
                return match ret {
                    Some(ret) => Ok(JsString::from(ret).into()),
                    None => Ok(JsValue::undefined()),
                };
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
    fn select(this: &JsValue, val: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
        if let Some(object) = this.as_object() {
            if let Some(this) = object.downcast_ref::<Self>() {
                let obj = val.get_or_undefined(0).to_object(context)?;
                let selector = obj.downcast_ref::<CSSSelector>().ok_or(
                    JsNativeError::typ().with_message("'selector' is not a Selector object"),
                )?;
                let doc = this.doc.clone();

                let node = this
                    .doc
                    .tree
                    .get(this.node)
                    .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
                let element = ElementRef::wrap(node)
                    .ok_or(JsNativeError::error().with_message("Invalid element"))?;
                let nodes = element.select(&selector.sel).map(|e| e.id()).collect();
                let ret = ElementArray { doc, nodes };
                return Ok(Class::from_data(ret, context)?.into());
            }
        }
        Err(JsNativeError::typ()
            .with_message("'this' is not a Element object")
            .into())
    }
}

impl Class for Element {
    const NAME: &'static str = "Element";

    fn init(class: &mut boa_engine::class::ClassBuilder<'_>) -> JsResult<()> {
        class.method(
            js_string!("attr"),
            1,
            NativeFunction::from_fn_ptr(Self::attr),
        );
        class.method(
            js_string!("select"),
            1,
            NativeFunction::from_fn_ptr(Self::select),
        );

        let fn_obj = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::parent),
        )
        .length(0)
        .name("parent")
        .build();
        class.accessor(
            js_string!("parent"),
            Some(fn_obj),
            None,
            Attribute::READONLY,
        );

        let fn_obj = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::children),
        )
        .length(0)
        .name("children")
        .build();
        class.accessor(
            js_string!("children"),
            Some(fn_obj),
            None,
            Attribute::READONLY,
        );

        let fn_obj = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::paragraphs),
        )
        .length(0)
        .name("paragraphs")
        .build();
        class.accessor(
            js_string!("paragraphs"),
            Some(fn_obj),
            None,
            Attribute::READONLY,
        );

        let fn_obj = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::text),
        )
        .length(0)
        .name("text")
        .build();
        class.accessor(js_string!("text"), Some(fn_obj), None, Attribute::READONLY);

        let fn_obj = FunctionObjectBuilder::new(
            class.context().realm(),
            NativeFunction::from_fn_ptr(Self::name),
        )
        .length(0)
        .name("name")
        .build();
        class.accessor(js_string!("name"), Some(fn_obj), None, Attribute::READONLY);

        Ok(())
    }

    fn data_constructor(
        _new_target: &JsValue,
        _args: &[JsValue],
        _context: &mut Context,
    ) -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error()))
    }
}

#[derive(Debug, Trace, Finalize, JsData)]
struct CSSSelector {
    #[unsafe_ignore_trace]
    sel: Selector,
}

impl Class for CSSSelector {
    const NAME: &'static str = "CSSSelector";

    fn init(_class: &mut boa_engine::class::ClassBuilder<'_>) -> JsResult<()> {
        Ok(())
    }

    fn data_constructor(
        _new_target: &JsValue,
        args: &[JsValue],
        context: &mut Context,
    ) -> JsResult<Self> {
        Ok(Self {
            sel: Selector::parse(
                &args
                    .get_or_undefined(0)
                    .to_string(context)?
                    .to_std_string_lossy(),
            )
            .map_err(|_e| JsNativeError::error().with_message("Failed to parse CSS Selector"))?,
        }) //TODO: Improve Error Feedback
    }
}

fn parse_html_fragment(
    _this: &JsValue,
    args: &[JsValue],
    context: &mut Context,
) -> JsResult<JsValue> {
    let resource = args
        .get_or_undefined(0)
        .to_string(context)?
        .to_std_string_lossy();
    let html = Html::parse_fragment(&resource);
    let node = html.root_element().id();
    let doc = Element {
        doc: Rc::new(html),
        node,
    };

    Ok(Class::from_data(doc, context)?.into())
}

fn parse_html(_this: &JsValue, args: &[JsValue], context: &mut Context) -> JsResult<JsValue> {
    let resource = args
        .get_or_undefined(0)
        .to_string(context)?
        .to_std_string_lossy();
    let html = Html::parse_document(&resource);
    let node = html.root_element().id();
    let doc = Element {
        doc: Rc::new(html),
        node,
    };
    Ok(Class::from_data(doc, context)?.into())
}
