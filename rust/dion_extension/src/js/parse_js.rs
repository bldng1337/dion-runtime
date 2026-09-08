use boa_engine::{
    Context, JsData, JsError, JsNativeError, JsObject, JsResult, JsString, JsValue, class::Class,
    object::builtins::JsArray, value::TryIntoJs,
};
use boa_gc::{Finalize, Trace};
use dion_runtime::data::source::{MixedContent, Paragraph, Row, TextStyle};
use ego_tree::{NodeId, Tree};
use html5ever::{Attribute, LocalName, Namespace, QualName};
use quick_xml::events::{BytesStart, Event};
use quick_xml::reader::Reader;
use scraper::{
    ElementRef, Html, Node, Selector,
    node::{Element as ScraperElement, Text as ScrapedText},
};
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
        "p" | "div"
            | "h1"
            | "h2"
            | "h3"
            | "h4"
            | "h5"
            | "h6"
            | "blockquote"
            | "pre"
            | "ul"
            | "ol"
            | "li"
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
            | "dl"
            | "dt"
            | "dd"
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
        let content: Vec<MixedContent> = std::mem::take(inline);
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
                        let has_style = mixed
                            .iter()
                            .any(|mc| matches!(mc, MixedContent::Text { style: Some(_), .. }));
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
                                MixedContent::Text { content, style } => {
                                    Paragraph::Text { content, style }
                                }
                                mc @ MixedContent::CustomUI { .. } => {
                                    Paragraph::Mixed { content: vec![mc] }
                                }
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
                            MixedContent::Text { ref content, .. } if content.trim().is_empty() => {
                            }
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
    use super::{Element, looks_like_xml, parse_xml_document};
    use scraper::Html;
    use std::rc::Rc;

    #[boa(rename = "parseHtml")]
    fn parse_html(html: String) -> Element {
        let doc = if looks_like_xml(&html) {
            parse_xml_document(&html).unwrap_or_else(|| Html::parse_document(&html))
        } else {
            Html::parse_document(&html)
        };
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

    #[boa(rename = "parseXml")]
    fn parse_xml(xml: String) -> Element {
        let doc = parse_xml_document(&xml).unwrap_or_else(|| Html::parse_document(&xml));
        let node = doc.root_element().id();
        Element {
            doc: Rc::new(doc),
            node,
        }
    }
}

fn looks_like_xml(body: &str) -> bool {
    body.trim_start().starts_with("<?xml")
}

fn parse_xml_document(body: &str) -> Option<Html> {
    let mut reader = Reader::from_str(body);
    let config = reader.config_mut();
    config.expand_empty_elements = true;
    config.check_end_names = false;
    config.allow_unmatched_ends = true;
    config.allow_dangling_amp = true;

    let mut tree: Tree<Node> = Tree::new(Node::Document);
    let root = tree.root().id();
    // (tag name, node id) of every open element; mirrors the XML nesting.
    let mut open: Vec<(String, NodeId)> = Vec::new();
    let mut has_root_element = false;

    loop {
        match reader.read_event() {
            Ok(Event::Start(start)) => {
                let name = element_name(&start);
                let parent = open.last().map_or(root, |(_, id)| *id);
                let id = append_node(
                    &mut tree,
                    parent,
                    Node::Element(element_from_start(&start, &name)),
                );
                has_root_element |= open.is_empty();
                open.push((name, id));
            }
            Ok(Event::Empty(start)) => {
                let name = element_name(&start);
                let parent = open.last().map_or(root, |(_, id)| *id);
                append_node(
                    &mut tree,
                    parent,
                    Node::Element(element_from_start(&start, &name)),
                );
                has_root_element |= open.is_empty();
            }
            Ok(Event::End(end)) => {
                let name = String::from_utf8_lossy(end.name().as_ref()).into_owned();
                // Close the nearest matching open element; anything still
                // nested inside it is closed implicitly (lenient misnesting).
                if let Some(pos) = open.iter().rposition(|(n, _)| *n == name) {
                    open.truncate(pos);
                }
            }
            Ok(Event::Text(text)) => {
                if let Ok(text) = text.decode() {
                    append_text(&mut tree, &open, root, text.as_ref());
                }
            }
            Ok(Event::GeneralRef(reference)) => {
                // General entity references arrive as standalone events; wrap
                // them back into `&name;` form and reuse the escape resolver.
                if let Ok(name) = reference.decode()
                    && let Ok(resolved) = quick_xml::escape::unescape(&format!("&{name};"))
                {
                    append_text(&mut tree, &open, root, resolved.as_ref());
                }
            }
            Ok(Event::CData(cdata)) => {
                if let Ok(text) = cdata.decode() {
                    append_text(&mut tree, &open, root, text.as_ref());
                }
            }
            Ok(Event::Eof) => break,
            // Comments, declarations, processing instructions and malformed
            // chunks are skipped; the tree built so far is kept.
            Ok(_) => {}
            Err(_) => break,
        }
    }

    if !has_root_element {
        return None;
    }
    let mut doc = Html::new_document();
    doc.tree = tree;
    Some(doc)
}

fn append_text(tree: &mut Tree<Node>, open: &[(String, NodeId)], root: NodeId, text: &str) {
    let parent = open.last().map_or(root, |(_, id)| *id);
    append_node(
        tree,
        parent,
        Node::Text(ScrapedText {
            text: scraper::StrTendril::from(text),
        }),
    );
}

fn append_node(tree: &mut Tree<Node>, parent: NodeId, node: Node) -> NodeId {
    tree.get_mut(parent).unwrap().append(node).id()
}

fn element_name(start: &BytesStart) -> String {
    String::from_utf8_lossy(start.name().as_ref()).into_owned()
}

fn element_from_start(start: &BytesStart, name: &str) -> ScraperElement {
    let qualified = |raw: &str| QualName {
        prefix: None,
        ns: Namespace::from(""),
        local: LocalName::from(raw.to_string()),
    };
    let attrs: Vec<Attribute> = start
        .attributes()
        .filter_map(|attr| {
            let attr = attr.ok()?;
            Some(Attribute {
                name: qualified(&String::from_utf8_lossy(attr.key.as_ref())),
                value: scraper::StrTendril::from(attr.unescape_value().ok()?.as_ref()),
            })
        })
        .collect();
    ScraperElement::new(qualified(name), attrs)
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
            if let Some(node) = self.doc.tree.get(*node_id)
                && let Some(element) = ElementRef::wrap(node)
            {
                all_paragraphs.extend(element_to_paragraph_list(element, &self.doc));
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

#[cfg(test)]
mod tests {
    use super::*;

    fn select_all(doc: &Html, selector: &str) -> Vec<String> {
        let sel = Selector::parse(selector).unwrap();
        doc.root_element()
            .select(&sel)
            .map(|el| el.value().name().to_string())
            .collect()
    }

    #[test]
    fn xml_keeps_repeated_sibling_elements() {
        // Regression: the HTML5 tree builder leaves self-closed non-void
        // elements open, which nested every following <link> inside the first
        // <category>. The XML parser must keep them as siblings.
        let doc = parse_xml_document(
            r#"<?xml version="1.0"?><feed><entry><category term="a"/>
                <link href="1"/><link href="2"/><link href="3"/></entry></feed>"#,
        )
        .unwrap();
        let entry = doc
            .root_element()
            .select(&Selector::parse("entry").unwrap())
            .next()
            .unwrap();
        assert_eq!(entry.select(&Selector::parse("link").unwrap()).count(), 3);
        // Self-closed elements are real closed elements: the entry's element
        // children are category + 3 links, all direct children.
        assert_eq!(
            entry
                .children()
                .filter_map(ElementRef::wrap)
                .map(|el| el.value().name().to_string())
                .collect::<Vec<_>>(),
            vec!["category", "link", "link", "link"]
        );
    }

    #[test]
    fn xml_child_combinator_finds_links() {
        let doc = parse_xml_document(
            r#"<?xml version="1.0"?><feed><entry>
                <category term="a"/>
                <link href="1"/><link href="2"/></entry></feed>"#,
        )
        .unwrap();
        assert_eq!(select_all(&doc, "entry > link").len(), 2);
    }

    #[test]
    fn xml_keeps_namespace_prefixes_and_attributes() {
        let doc = parse_xml_document(
            r#"<?xml version="1.0"?><feed xmlns:dcterms="http://purl.org/dc/terms/">
                <dcterms:language>en</dcterms:language>
                <link title="EPUB (no images)" href="/a.epub"/></feed>"#,
        )
        .unwrap();
        // Escaped selectors can address prefixed names directly.
        assert_eq!(select_all(&doc, r"dcterms\:language").len(), 1);
        let root = doc.root_element();
        let names: Vec<String> = root
            .children()
            .filter_map(ElementRef::wrap)
            .map(|el| el.value().name().to_string())
            .collect();
        assert!(names.contains(&"dcterms:language".to_string()));
        let link = ElementRef::wrap(
            root.children()
                .find(|c| ElementRef::wrap(*c).is_some_and(|el| el.value().name() == "link"))
                .unwrap(),
        )
        .unwrap();
        assert_eq!(link.attr("title").unwrap(), "EPUB (no images)");
    }

    #[test]
    fn xml_decodes_entities_and_cdata() {
        let doc = parse_xml_document(
            r#"<?xml version="1.0"?><entry><title>A &amp; B</title>
                <desc><![CDATA[<p>raw</p> x & y]]></desc></entry>"#,
        )
        .unwrap();
        let root = doc.root_element();
        let title = root
            .select(&Selector::parse("title").unwrap())
            .next()
            .unwrap();
        assert_eq!(title.text().collect::<String>(), "A & B");
        let desc = root
            .select(&Selector::parse("desc").unwrap())
            .next()
            .unwrap();
        assert_eq!(desc.text().collect::<String>(), "<p>raw</p> x & y");
    }

    #[test]
    fn xml_without_elements_falls_back() {
        assert!(parse_xml_document("just text").is_none());
    }

    #[test]
    fn looks_like_xml_detection() {
        assert!(looks_like_xml("<?xml version=\"1.0\"?><feed/>"));
        assert!(looks_like_xml("  <?xml version=\"1.0\"?>\n<feed/>"));
        assert!(!looks_like_xml("<!DOCTYPE html><html></html>"));
        assert!(!looks_like_xml("<feed></feed>"));
    }
}
