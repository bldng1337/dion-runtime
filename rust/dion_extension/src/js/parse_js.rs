use boa_engine::{
    Context, JsData, JsError, JsNativeError, JsObject, JsResult, JsString, JsValue, class::Class,
    object::builtins::JsArray, value::TryIntoJs,
};
use boa_gc::{Finalize, Trace};
use dion_runtime::data::source::{MixedContent, Paragraph, Row, TextStyle};
use ego_tree::NodeId;
use scraper::{ElementRef, Html, Node, Selector};
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

fn apply_inline_style(element: &ElementRef, mut style: TextStyle) -> TextStyle {
    let tag = element.value().name().to_ascii_lowercase();
    match tag.as_str() {
        "b" | "strong" => style.bold = Some(true),
        "i" | "em" => style.italic = Some(true),
        "u" | "ins" => style.underline = Some(true),
        "s" | "strike" | "del" => style.strikethrough = Some(true),
        "code" => style.code = Some(true),
        "a" => {
            if let Some(href) = element.attr("href") {
                style.link = Some(href.to_string());
            }
        }
        _ => {}
    }
    style
}

fn collect_text_with_style<'a>(
    element: ElementRef<'a>,
    base_style: &TextStyle,
    doc: &'a Html,
) -> Vec<MixedContent> {
    let mut result = Vec::new();
    let new_style = apply_inline_style(&element, base_style.clone());

    for child in element.children() {
        match child.value() {
            Node::Text(text) => {
                let trimmed = text.text.trim();
                if !trimmed.is_empty() {
                    result.push(MixedContent::Text {
                        content: text.text.to_string(),
                        style: if new_style == TextStyle::default() {
                            None
                        } else {
                            Some(new_style.clone())
                        },
                    });
                }
            }
            Node::Element(_) => {
                if let Some(child_el) = ElementRef::wrap(child) {
                    let tag = child_el.value().name().to_ascii_lowercase();
                    if tag == "table" {
                        result.push(MixedContent::Table {
                            columns: convert_table(&child_el, doc),
                        });
                    } else if tag == "style" || tag == "script" {
                        continue;
                    } else {
                        result.extend(collect_text_with_style(child_el, &new_style, doc));
                    }
                }
            }
            _ => {}
        }
    }
    result
}

fn mixed_to_paragraph(mixed: Vec<MixedContent>) -> Paragraph {
    if mixed.is_empty() {
        return Paragraph::Text {
            content: String::new(),
            style: None,
        };
    }
    if mixed.len() == 1 {
        return match mixed.into_iter().next().unwrap() {
            MixedContent::Text { content, style } => Paragraph::Text { content, style },
            mc @ MixedContent::CustomUI { .. } => Paragraph::Mixed { content: vec![mc] },
            MixedContent::Table { columns } => Paragraph::Table { columns },
        };
    }
    Paragraph::Mixed { content: mixed }
}

fn convert_table(table: &ElementRef, doc: &Html) -> Vec<Row> {
    let mut rows = Vec::new();
    for tr in table.select(&Selector::parse("tr").unwrap()) {
        let mut cells = Vec::new();
        for cell in tr.select(&Selector::parse("th, td").unwrap()) {
            let mixed = element_inner_to_mixed(cell, doc);
            cells.push(mixed_to_paragraph(mixed));
        }
        if !cells.is_empty() {
            rows.push(Row { cells });
        }
    }
    rows
}

fn is_block_element(tag: &str) -> bool {
    matches!(
        tag,
        "p"
            | "div"
            | "h1" | "h2" | "h3" | "h4" | "h5" | "h6"
            | "blockquote"
            | "pre"
            | "ul" | "ol" | "li"
            | "table"
            | "hr"
            | "br"
            | "section"
            | "article"
            | "aside"
            | "header"
            | "footer"
            | "nav"
            | "figure"
            | "figcaption"
            | "details"
            | "summary"
            | "main"
            | "dl" | "dt" | "dd"
    )
}

fn element_to_mixed_content(element: ElementRef, doc: &Html) -> Vec<MixedContent> {
    let tag = element.value().name().to_ascii_lowercase();
    if tag == "table" {
        return vec![MixedContent::Table {
            columns: convert_table(&element, doc),
        }];
    }
    if tag == "style" || tag == "script" {
        return vec![];
    }
    collect_text_with_style(element, &TextStyle::default(), doc)
}

fn element_inner_to_mixed(element: ElementRef, doc: &Html) -> Vec<MixedContent> {
    let mut paragraphs: Vec<MixedContent> = Vec::new();
    let mut current_inline: Vec<MixedContent> = Vec::new();

    let flush_inline = |inline: &mut Vec<MixedContent>, paras: &mut Vec<MixedContent>| {
        if inline.is_empty() {
            return;
        }
        let content: Vec<MixedContent> = inline.drain(..).collect();
        if content.len() == 1 {
            paras.push(content.into_iter().next().unwrap());
        } else {
            paras.push(MixedContent::Text {
                content: String::new(),
                style: None,
            });
            paras.extend(content);
        }
    };

    for child in element.children() {
        match child.value() {
            Node::Text(text) => {
                let trimmed = text.text.trim();
                if !trimmed.is_empty() {
                    current_inline.push(MixedContent::Text {
                        content: text.text.to_string(),
                        style: None,
                    });
                }
            }
            Node::Element(_) => {
                if let Some(child_el) = ElementRef::wrap(child) {
                    let tag = child_el.value().name().to_ascii_lowercase();

                    if tag == "style" || tag == "script" {
                        continue;
                    }

                    if tag == "br" {
                        if !current_inline.is_empty() {
                            flush_inline(&mut current_inline, &mut paragraphs);
                        }
                        continue;
                    }

                    if tag == "hr" {
                        flush_inline(&mut current_inline, &mut paragraphs);
                        continue;
                    }

                    if tag == "table" {
                        flush_inline(&mut current_inline, &mut paragraphs);
                        paragraphs.push(MixedContent::Table {
                            columns: convert_table(&child_el, doc),
                        });
                        continue;
                    }

                    if is_block_element(&tag) {
                        flush_inline(&mut current_inline, &mut paragraphs);
                        let inner = element_to_mixed_content(child_el, doc);
                        paragraphs.extend(inner);
                        continue;
                    }

                    current_inline.extend(collect_text_with_style(
                        child_el,
                        &TextStyle::default(),
                        doc,
                    ));
                }
            }
            _ => {}
        }
    }

    flush_inline(&mut current_inline, &mut paragraphs);
    paragraphs
}

fn element_to_paragraph_list(element: ElementRef, doc: &Html) -> Vec<Paragraph> {
    let mut result = Vec::new();

    for child in element.children() {
        match child.value() {
            Node::Text(text) => {
                let trimmed = text.text.trim();
                if !trimmed.is_empty() {
                    result.push(Paragraph::Text {
                        content: trimmed.to_string(),
                        style: None,
                    });
                }
            }
            Node::Element(_) => {
                if let Some(child_el) = ElementRef::wrap(child) {
                    let tag = child_el.value().name().to_ascii_lowercase();

                    if tag == "style" || tag == "script" {
                        continue;
                    }

                    if tag == "table" {
                        result.push(Paragraph::Table {
                            columns: convert_table(&child_el, doc),
                        });
                        continue;
                    }

                    if tag == "br" || tag == "hr" {
                        continue;
                    }

                    if is_block_element(&tag) {
                        let mixed = element_to_mixed_content(child_el, doc);
                        if mixed.is_empty() {
                            continue;
                        }
                        let has_style = mixed.iter().any(|mc| {
                            matches!(mc, MixedContent::Text { style: Some(_), .. })
                        });
                        let has_non_text = mixed
                            .iter()
                            .any(|mc| !matches!(mc, MixedContent::Text { style: None, .. }));

                        if !has_non_text && !has_style {
                            let text: String = mixed
                                .iter()
                                .filter_map(|mc| match mc {
                                    MixedContent::Text { content, .. } => Some(content.as_str()),
                                    _ => None,
                                })
                                .collect::<Vec<_>>()
                                .join("");
                            let trimmed = text.trim();
                            if !trimmed.is_empty() {
                                result.push(Paragraph::Text {
                                    content: trimmed.to_string(),
                                    style: None,
                                });
                            }
                        } else if mixed.len() == 1 {
                            result.push(match mixed.into_iter().next().unwrap() {
                                MixedContent::Text { content, style } => Paragraph::Text {
                                    content,
                                    style,
                                },
                                mc @ MixedContent::CustomUI { .. } => Paragraph::Mixed {
                                    content: vec![mc],
                                },
                                MixedContent::Table { columns } => Paragraph::Table { columns },
                            });
                        } else {
                            result.push(Paragraph::Mixed { content: mixed });
                        }
                        continue;
                    }

                    let inline = collect_text_with_style(child_el, &TextStyle::default(), doc);
                    for mc in inline {
                        match mc {
                            MixedContent::Text { ref content, .. } if content.trim().is_empty() => {}
                            MixedContent::Table { columns } => {
                                result.push(Paragraph::Table { columns });
                            }
                            mc => {
                                result.push(Paragraph::Mixed { content: vec![mc] });
                            }
                        }
                    }
                }
            }
            _ => {}
        }
    }

    result
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
        let mut all_paragraphs: Vec<Paragraph> = Vec::new();
        for node_id in &self.nodes {
            if let Some(node) = self.doc.tree.get(*node_id) {
                if let Some(element) = ElementRef::wrap(node) {
                    all_paragraphs.extend(element_to_paragraph_list(element, &self.doc));
                }
            }
        }
        JsValue::from_json(
            &serde_json::to_value(all_paragraphs)
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
        let paragraphs = element_to_paragraph_list(element, &self.doc);
        JsValue::from_json(
            &serde_json::to_value(paragraphs)
                .map_err(|e| JsNativeError::error().with_message(e.to_string()))?,
            context,
        )
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
