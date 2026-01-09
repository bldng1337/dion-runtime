use boa_engine::{
    Context, JsData, JsError, JsNativeError, JsObject, JsResult, JsString, JsValue, class::Class,
    object::builtins::JsArray, value::TryIntoJs,
};
use boa_gc::{Finalize, Trace};
use dion_runtime::data::source::Paragraph;
use ego_tree::NodeId;
use scraper::{ElementRef, Html, Selector};
use std::rc::Rc;

use boa_engine::boa_class;
use boa_engine::boa_module;

use anyhow::Result;

use crate::utils::MapJsResult;
use crate::utils::VirtualModuleLoader;
use anyhow::Context as ErrorContext;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
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
    loader.insert("parse".to_string(), parse::boa_module(None, context));
    Ok(())
}

#[boa_module]
mod parse {
    use super::Element;
    use scraper::Html;
    use std::rc::Rc;

    #[boa(rename = "parseHtml")]
    fn parse_html(html: String) -> Element {
        let doc = Html::parse_document(&html);
        let node = doc.root_element().id();
        Element {
            doc: Rc::new(doc),
            node,
        }
    }

    #[boa(rename = "parseHtmlFragment")]
    fn parse_html_fragment(html: String) -> Element {
        let doc = Html::parse_fragment(&html);
        let node = doc.root_element().id();
        Element {
            doc: Rc::new(doc),
            node,
        }
    }
}

#[derive(Debug, Trace, Finalize, JsData, Clone)]
struct ElementArray {
    #[unsafe_ignore_trace]
    doc: Rc<Html>,
    #[unsafe_ignore_trace]
    nodes: Vec<NodeId>,
}

#[boa_class]
impl ElementArray {
    #[boa(constructor)]
    fn new() -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error().with_message(
            "ElementArray cannot be directly constructed",
        )))
    }

    fn select(
        #[boa(error = "`this` was not an ElementArray")] &self,
        selector: JsValue,
        context: &mut Context,
    ) -> JsResult<ElementArray> {
        let obj = selector.to_object(context)?;
        let selector = obj
            .downcast_ref::<CSSSelector>()
            .ok_or(JsNativeError::typ().with_message("'selector' is not a Selector object"))?;
        let nodes: Vec<_> = self
            .nodes
            .iter()
            .flat_map(|node| {
                let Some(node) = self.doc.tree.get(*node) else {
                    return vec![];
                };
                let Some(element) = ElementRef::wrap(node) else {
                    return vec![];
                };
                let mut ret = vec![];
                if selector.sel.matches(&element) {
                    ret.push(element.id());
                }
                let mut res: Vec<NodeId> = element.select(&selector.sel).map(|e| e.id()).collect();
                ret.append(&mut res);
                ret
            })
            .collect();
        let elarr = ElementArray {
            doc: self.doc.clone(),
            nodes,
        };
        Ok(elarr)
    }

    #[boa(getter)]
    fn length(#[boa(error = "`this` was not an ElementArray")] &self) -> usize {
        self.nodes.len()
    }

    #[boa(getter)]
    fn text(#[boa(error = "`this` was not an ElementArray")] &self) -> String {
        self.nodes
            .iter()
            .flat_map(|e| {
                self.doc
                    .tree
                    .get(*e)
                    .and_then(ElementRef::wrap)
                    .map(|e| e.text().collect::<Vec<_>>())
                    .unwrap_or_default()
            })
            .collect()
    }

    #[boa(getter)]
    fn paragraphs(
        #[boa(error = "`this` was not an ElementArray")] &self,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let str: Vec<_> = self
            .nodes
            .iter()
            .flat_map(|e| {
                self.doc
                    .tree
                    .get(*e)
                    .and_then(ElementRef::wrap)
                    .map(|e| e.text().collect::<Vec<_>>())
                    .unwrap_or_default()
            })
            .map(|str| Paragraph::Text {
                content: str.to_string(),
            })
            .collect();
        JsValue::from_json(
            &serde_json::to_value(str)
                .map_err(|e| JsNativeError::error().with_message(e.to_string()))?,
            context,
        )
    }

    fn attr(
        #[boa(error = "`this` was not an ElementArray")] &self,
        attr: String,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let res = self
            .nodes
            .iter()
            .flat_map(|e| {
                self.doc
                    .tree
                    .get(*e)
                    .into_iter()
                    .flat_map(ElementRef::wrap)
                    .flat_map(|e| e.attr(&attr))
            })
            .map(|e| JsString::from(e.to_string()).into());
        Ok(JsArray::from_iter(res, context).into())
    }

    fn get(
        #[boa(error = "`this` was not an ElementArray")] &self,
        index: usize,
    ) -> Option<Element> {
        self.nodes.get(index).map(|e| Element {
            doc: self.doc.clone(),
            node: *e,
        })
    }

    #[boa(getter)]
    fn first(
        #[boa(error = "`this` was not an ElementArray")] &self,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let ret = self.nodes.first().map(|e| Element {
            doc: self.doc.clone(),
            node: *e,
        });
        match ret {
            Some(ret) => Ok(Class::from_data(ret, context)?.into()),
            None => Ok(JsValue::undefined()),
        }
    }

    fn map(
        #[boa(error = "`this` was not an ElementArray")] &self,
        callback: JsValue,
        context: &mut Context,
    ) -> JsResult<Vec<JsValue>> {
        let callback = callback
            .as_callable()
            .ok_or(JsNativeError::typ().with_message("callback is not callable"))?;
        let this = self.try_into_js(context)?;
        let res: Vec<_> = self
            .nodes
            .iter()
            .flat_map(|e| {
                callback.call(
                    &this,
                    &[Class::from_data(
                        Element {
                            doc: self.doc.clone(),
                            node: *e,
                        },
                        context,
                    )?
                    .into()],
                    context,
                )
            })
            .collect();
        Ok(res)
    }

    fn filter(
        #[boa(error = "`this` was not an ElementArray")] &self,
        callback: JsValue,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let callback = callback
            .as_callable()
            .ok_or(JsNativeError::typ().with_message("callback is not callable"))?;
        let this = self.try_into_js(context)?;
        let res: Vec<_> = self
            .nodes
            .iter()
            .copied()
            .filter(|e| {
                let Ok(el) = Class::from_data(
                    Element {
                        doc: self.doc.clone(),
                        node: *e,
                    },
                    context,
                ) else {
                    return false;
                };
                let Ok(res) = callback.call(&this, &[el.into()], context) else {
                    return false;
                };

                res.as_boolean().unwrap_or(false)
            })
            .collect();
        Ok(Class::from_data(
            ElementArray {
                doc: self.doc.clone(),
                nodes: res,
            },
            context,
        )?
        .into())
    }
}

#[derive(Debug, Trace, Finalize, JsData, Clone)]
struct Element {
    #[unsafe_ignore_trace]
    doc: Rc<Html>,
    #[unsafe_ignore_trace]
    node: NodeId,
}

#[boa_class]
impl Element {
    #[boa(constructor)]
    fn new() -> JsResult<Self> {
        Err(JsError::from_native(JsNativeError::error().with_message(
            "ElementArray cannot be directly constructed",
        )))
    }
    #[boa(getter)]
    fn parent(
        #[boa(error = "`this` was not an Element")] &self,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let ret = element.parent().and_then(ElementRef::wrap).map(|e| e.id());
        match ret {
            Some(ret) => Ok(Class::from_data(
                Element {
                    doc: self.doc.clone(),
                    node: ret,
                },
                context,
            )?
            .into()),
            None => Ok(JsValue::undefined()),
        }
    }
    #[boa(getter)]
    fn children(#[boa(error = "`this` was not an Element")] &self) -> JsResult<ElementArray> {
        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let ret = ElementArray {
            doc: self.doc.clone(),
            nodes: element
                .children()
                .flat_map(ElementRef::wrap)
                .map(|e| e.id())
                .collect(),
        };
        Ok(ret)
    }
    #[boa(getter)]
    fn text(#[boa(error = "`this` was not an Element")] &self) -> JsResult<String> {
        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let ret: String = element.text().collect();
        Ok(ret)
    }
    #[boa(getter)]
    fn paragraphs(
        #[boa(error = "`this` was not an Element")] &self,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let ret = element.text().map(|str| JsString::from(str).into());
        Ok(JsArray::from_iter(ret, context).into())
    }
    #[boa(getter)]
    fn name(#[boa(error = "`this` was not an Element")] &self) -> JsResult<JsValue> {
        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let ret: String = element.value().name().to_string();
        Ok(JsString::from(ret).into())
    }

    fn attr(
        #[boa(error = "`this` was not an Element")] &self,
        attr: String,
    ) -> JsResult<Option<String>> {
        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let ret = element.attr(&attr).map(|e| e.to_string());
        Ok(ret)
    }

    fn select(
        #[boa(error = "`this` was not an Element")] &self,
        selector: JsObject,
    ) -> JsResult<ElementArray> {
        let selector = selector
            .downcast_ref::<CSSSelector>()
            .ok_or(JsNativeError::typ().with_message("'selector' is not a Selector object"))?;
        let doc = self.doc.clone();

        let node = self
            .doc
            .tree
            .get(self.node)
            .ok_or(JsNativeError::error().with_message("Invalid Node"))?;
        let element =
            ElementRef::wrap(node).ok_or(JsNativeError::error().with_message("Invalid element"))?;
        let nodes = element.select(&selector.sel).map(|e| e.id()).collect();
        let ret = ElementArray { doc, nodes };
        Ok(ret)
    }
}

#[derive(Debug, Trace, Finalize, JsData)]
struct CSSSelector {
    #[unsafe_ignore_trace]
    sel: Selector,
}

#[boa_class]
impl CSSSelector {
    #[boa(constructor)]
    fn new(selector: String) -> JsResult<Self> {
        Ok(Self {
            sel: Selector::parse(selector.as_str()).map_err(|_e| {
                JsNativeError::error().with_message("Failed to parse CSS Selector")
            })?,
        }) //TODO: Improve Error Feedback
    }
}
