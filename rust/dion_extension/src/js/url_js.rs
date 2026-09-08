use std::cell::{Cell, RefCell};
use std::rc::Rc;

use anyhow::{Context as ErrorContext, Result};
use boa_engine::class::Class;
use boa_engine::native_function::NativeFunction;
use boa_engine::object::FunctionObjectBuilder;
use boa_engine::object::builtins::JsArray;
use boa_engine::property::{PropertyDescriptor, PropertyKey};
use boa_engine::value::TryIntoJs;
use boa_engine::{
    Context, JsData, JsError, JsNativeError, JsObject, JsResult, JsString, JsSymbol, JsValue,
    boa_class, js_string,
};
use boa_gc::{Finalize, GcRefCell, Trace};
use url::Url as SysUrl;

use crate::utils::MapJsResult;

/// Query pairs shared between a `URL` and its `URLSearchParams`.
type SharedPairs = Rc<RefCell<Vec<(String, String)>>>;

const ITER_KIND_ENTRIES: u8 = 0;
const ITER_KIND_KEYS: u8 = 1;
const ITER_KIND_VALUES: u8 = 2;

pub fn declare(context: &mut Context) -> Result<()> {
    context
        .register_global_class::<UrlSearchParams>()
        .map_anyhow_ctx(context)
        .context("Failed to Register URLSearchParams class")?;
    context
        .register_global_class::<Url>()
        .map_anyhow_ctx(context)
        .context("Failed to Register URL class")?;
    attach_search_params_iterator(context)
        .map_anyhow_ctx(context)
        .context("Failed to attach URLSearchParams iterator")?;
    attach_search_params_getter(context)
        .map_anyhow_ctx(context)
        .context("Failed to attach URL.searchParams")?;
    Ok(())
}

// ---------------------------------------------------------------------------
// Query pair parsing/serialization
// ---------------------------------------------------------------------------

fn parse_query(query: &str) -> Vec<(String, String)> {
    form_urlencoded::parse(query.as_bytes())
        .map(|(name, value)| (name.into_owned(), value.into_owned()))
        .collect()
}

/// WHATWG urlencoded serialization: the `+` produced by `form_urlencoded` for
/// spaces is written as `%20`, matching what browsers emit.
fn urlencoded_encode(value: &str) -> String {
    form_urlencoded::byte_serialize(value.as_bytes())
        .collect::<String>()
        .replace('+', "%20")
}

fn serialize_pairs(pairs: &[(String, String)]) -> String {
    pairs
        .iter()
        .map(|(name, value)| format!("{}={}", urlencoded_encode(name), urlencoded_encode(value)))
        .collect::<Vec<_>>()
        .join("&")
}

// ---------------------------------------------------------------------------
// URLSearchParams
// ---------------------------------------------------------------------------

#[derive(Debug, Trace, Finalize, JsData, Clone)]
struct UrlSearchParams {
    #[unsafe_ignore_trace]
    pairs: SharedPairs,
    /// The owning `URL` object, kept in sync on mutation.
    parent: Option<JsObject>,
}

#[boa_class(rename = "URLSearchParams")]
#[boa(rename_all = "camelCase")]
impl UrlSearchParams {
    /// Accepts the same init values as the web platform: a query string (a
    /// leading `?` is ignored), a record of string keys to values, or a
    /// sequence of name/value pairs (arrays, Maps, other URLSearchParams...).
    #[boa(constructor)]
    fn new(init: JsValue, context: &mut Context) -> JsResult<Self> {
        let pairs = if init.is_undefined() {
            Vec::new()
        } else if let Some(s) = init.as_string() {
            let s = s.to_std_string_escaped();
            parse_query(s.strip_prefix('?').unwrap_or(&s))
        } else if init.is_object() {
            match iterator_method(&init, context)? {
                Some(method) => sequence_pairs(&init, &method, context)?,
                None => record_pairs(&init, context)?,
            }
        } else {
            return Err(JsNativeError::typ()
                .with_message(
                    "URLSearchParams init must be a string, a record or a sequence of pairs",
                )
                .into());
        };
        Ok(Self {
            pairs: Rc::new(RefCell::new(pairs)),
            parent: None,
        })
    }

    fn append(&self, name: String, value: String) {
        self.pairs.borrow_mut().push((name, value));
        self.sync_parent();
    }

    /// Without `value` every entry named `name` is removed; with it only
    /// entries matching both (as in newer specs).
    fn delete(&self, name: String, value: Option<String>) {
        self.pairs
            .borrow_mut()
            .retain(|(n, v)| *n != name || value.as_ref().is_some_and(|want| want != v));
        self.sync_parent();
    }

    fn get(&self, name: String) -> JsValue {
        self.pairs
            .borrow()
            .iter()
            .find(|(n, _)| *n == name)
            .map_or_else(JsValue::undefined, |(_, v)| {
                JsString::from(v.as_str()).into()
            })
    }

    fn get_all(&self, name: String, context: &mut Context) -> JsResult<JsValue> {
        let pairs = self.pairs.borrow();
        let values = pairs
            .iter()
            .filter(|(n, _)| *n == name)
            .map(|(_, v)| JsValue::from(JsString::from(v.as_str())));
        let array = JsArray::from_iter(values, context);
        drop(pairs);
        Ok(array.into())
    }

    fn has(&self, name: String, value: Option<String>) -> bool {
        let only = value;
        self.pairs
            .borrow()
            .iter()
            .any(|(n, v)| *n == name && only.as_ref().is_none_or(|want| want == v))
    }

    /// Replaces the first entry named `name` with the new value and removes
    /// all later ones; appends when `name` is not present yet.
    fn set(&self, name: String, value: String) {
        let mut pairs = self.pairs.borrow_mut();
        match pairs.iter().position(|(n, _)| *n == name) {
            Some(first) => {
                pairs[first].1 = value;
                let mut i = first + 1;
                while i < pairs.len() {
                    if pairs[i].0 == name {
                        pairs.remove(i);
                    } else {
                        i += 1;
                    }
                }
            }
            None => pairs.push((name, value)),
        }
        drop(pairs);
        self.sync_parent();
    }

    /// Stable sort by name, per spec.
    fn sort(&self) {
        self.pairs.borrow_mut().sort_by(|a, b| a.0.cmp(&b.0));
        self.sync_parent();
    }

    fn for_each(
        &self,
        callback: JsValue,
        this_arg: JsValue,
        context: &mut Context,
    ) -> JsResult<JsValue> {
        let callback = callback
            .as_callable()
            .ok_or(JsNativeError::typ().with_message("callback is not callable"))?;
        let this_obj = self.try_into_js(context)?;
        let snapshot = self.pairs.borrow().clone();
        for (name, value) in &snapshot {
            callback.call(
                &this_arg,
                &[
                    JsValue::from(JsString::from(value.as_str())),
                    JsValue::from(JsString::from(name.as_str())),
                    this_obj.clone(),
                ],
                context,
            )?;
        }
        Ok(JsValue::undefined())
    }

    fn entries(&self, context: &mut Context) -> JsResult<JsObject> {
        make_pair_iterator(&self.pairs, ITER_KIND_ENTRIES, context)
    }

    fn keys(&self, context: &mut Context) -> JsResult<JsObject> {
        make_pair_iterator(&self.pairs, ITER_KIND_KEYS, context)
    }

    fn values(&self, context: &mut Context) -> JsResult<JsObject> {
        make_pair_iterator(&self.pairs, ITER_KIND_VALUES, context)
    }

    #[boa(getter)]
    fn size(&self) -> u32 {
        self.pairs.borrow().len() as u32
    }

    fn to_string(&self) -> JsString {
        JsString::from(serialize_pairs(&self.pairs.borrow()))
    }
}

impl UrlSearchParams {
    /// Writes the current pairs back into the owning URL's query.
    fn sync_parent(&self) {
        let Some(parent) = &self.parent else {
            return;
        };
        let Some(url) = parent.downcast_ref::<Url>() else {
            return;
        };
        let serialized = serialize_pairs(&self.pairs.borrow());
        let mut inner = url.inner.borrow_mut();
        let query = if serialized.is_empty() {
            None
        } else {
            Some(serialized.as_str())
        };
        if inner.query() != query {
            inner.set_query(query);
        }
    }
}

// ---------------------------------------------------------------------------
// URL
// ---------------------------------------------------------------------------

#[derive(Debug, Trace, Finalize, JsData, Clone)]
struct Url {
    #[unsafe_ignore_trace]
    inner: RefCell<SysUrl>,
    #[unsafe_ignore_trace]
    pairs: SharedPairs,
    /// Lazily created `URLSearchParams` bound to `pairs`.
    search_params: GcRefCell<Option<JsObject>>,
}

#[boa_class(rename = "URL")]
#[boa(rename_all = "camelCase")]
impl Url {
    #[boa(constructor)]
    fn new(input: String, base: Option<String>) -> JsResult<Self> {
        let base = match base {
            Some(base) => Some(SysUrl::parse(&base).map_err(|e| {
                JsNativeError::typ().with_message(format!("Invalid base URL: {e}"))
            })?),
            None => None,
        };
        let url = match &base {
            Some(base) => SysUrl::options()
                .base_url(Some(base))
                .parse(&input)
                .map_err(|e| JsNativeError::typ().with_message(format!("Invalid URL: {e}")))?,
            None => SysUrl::parse(&input)
                .map_err(|e| JsNativeError::typ().with_message(format!("Invalid URL: {e}")))?,
        };
        Ok(Self::from_sys_url(url))
    }

    #[boa(getter)]
    fn href(&self) -> JsString {
        JsString::from(url::quirks::href(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "href")]
    fn set_href(&self, value: String) -> JsResult<()> {
        url::quirks::set_href(&mut self.inner.borrow_mut(), &value)
            .map_err(|e| JsNativeError::typ().with_message(format!("Failed to set href: {e}")))?;
        self.refresh_pairs();
        Ok(())
    }

    #[boa(getter)]
    fn protocol(&self) -> JsString {
        JsString::from(url::quirks::protocol(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "protocol")]
    fn set_protocol(&self, value: String) {
        let _ = url::quirks::set_protocol(&mut self.inner.borrow_mut(), &value);
    }

    #[boa(getter)]
    fn host(&self) -> JsString {
        JsString::from(url::quirks::host(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "host")]
    fn set_host(&self, value: String) {
        let _ = url::quirks::set_host(&mut self.inner.borrow_mut(), &value);
    }

    #[boa(getter)]
    fn hostname(&self) -> JsString {
        JsString::from(url::quirks::hostname(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "hostname")]
    fn set_hostname(&self, value: String) {
        let _ = url::quirks::set_hostname(&mut self.inner.borrow_mut(), &value);
    }

    #[boa(getter)]
    fn port(&self) -> JsString {
        JsString::from(url::quirks::port(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "port")]
    fn set_port(&self, value: String) {
        let _ = url::quirks::set_port(&mut self.inner.borrow_mut(), &value);
    }

    #[boa(getter)]
    fn pathname(&self) -> JsString {
        JsString::from(url::quirks::pathname(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "pathname")]
    fn set_pathname(&self, value: String) {
        url::quirks::set_pathname(&mut self.inner.borrow_mut(), &value);
    }

    #[boa(getter)]
    fn search(&self) -> JsString {
        JsString::from(url::quirks::search(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "search")]
    fn set_search(&self, value: String) {
        url::quirks::set_search(&mut self.inner.borrow_mut(), &value);
        self.refresh_pairs();
    }

    #[boa(getter)]
    fn hash(&self) -> JsString {
        JsString::from(url::quirks::hash(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "hash")]
    fn set_hash(&self, value: String) {
        url::quirks::set_hash(&mut self.inner.borrow_mut(), &value);
    }

    #[boa(getter)]
    fn origin(&self) -> JsString {
        JsString::from(url::quirks::origin(&self.inner.borrow()))
    }

    #[boa(getter)]
    fn username(&self) -> JsString {
        JsString::from(self.inner.borrow().username())
    }

    #[boa(setter)]
    #[boa(rename = "username")]
    fn set_username(&self, value: String) {
        let _ = self.inner.borrow_mut().set_username(&value);
    }

    #[boa(getter)]
    fn password(&self) -> JsString {
        JsString::from(url::quirks::password(&self.inner.borrow()))
    }

    #[boa(setter)]
    #[boa(rename = "password")]
    fn set_password(&self, value: String) {
        let _ = self.inner.borrow_mut().set_password(Some(&value));
    }

    fn to_string(&self) -> JsString {
        JsString::from(self.inner.borrow().as_str())
    }

    #[boa(rename = "toJSON")]
    fn to_json(&self) -> JsString {
        JsString::from(self.inner.borrow().as_str())
    }

    #[boa(static)]
    fn can_parse(input: String, base: Option<String>) -> bool {
        Url::new(input, base).is_ok()
    }

    /// Like the web platform, returns `null` instead of throwing when the
    /// input cannot be parsed.
    #[boa(static)]
    fn parse(input: String, base: Option<String>, context: &mut Context) -> JsResult<JsValue> {
        match Url::new(input, base) {
            Ok(url) => Ok(<Url as Class>::from_data(url, context)?.into()),
            Err(_) => Ok(JsValue::null()),
        }
    }

    #[boa(static)]
    #[boa(rename = "createObjectURL")]
    fn create_object_url() -> JsResult<()> {
        Err(JsNativeError::error()
            .with_message("URL.createObjectURL is not supported")
            .into())
    }

    #[boa(static)]
    #[boa(rename = "revokeObjectURL")]
    fn revoke_object_url() -> JsResult<()> {
        Err(JsNativeError::error()
            .with_message("URL.revokeObjectURL is not supported")
            .into())
    }
}

impl Url {
    fn from_sys_url(url: SysUrl) -> Self {
        let pairs = parse_query(url.query().unwrap_or_default());
        Self {
            inner: RefCell::new(url),
            pairs: Rc::new(RefCell::new(pairs)),
            search_params: GcRefCell::new(None),
        }
    }

    /// Re-reads the query into the shared pairs after a URL-side change, so a
    /// previously handed-out `searchParams` object observes it.
    fn refresh_pairs(&self) {
        let query = self.inner.borrow().query().map(str::to_string);
        *self.pairs.borrow_mut() = parse_query(query.as_deref().unwrap_or_default());
    }
}

// ---------------------------------------------------------------------------
// Wiring: Symbol.iterator on URLSearchParams, searchParams on URL
// ---------------------------------------------------------------------------

/// Resolves `value[Symbol.iterator]`, or `None` when the value is not
/// iterable.
fn iterator_method(value: &JsValue, context: &mut Context) -> JsResult<Option<JsObject>> {
    let object = value.to_object(context)?;
    let method = object.get(JsSymbol::iterator(), context)?;
    Ok(method.as_object().filter(|object| object.is_callable()))
}

fn sequence_pairs(
    init: &JsValue,
    method: &JsObject,
    context: &mut Context,
) -> JsResult<Vec<(String, String)>> {
    let iterator = method.call(init, &[], context)?;
    let iterator = iterator
        .as_object()
        .ok_or(JsNativeError::typ().with_message("iterator is not an object"))?;
    let next = iterator.get(js_string!("next"), context)?;
    let next = next
        .as_callable()
        .ok_or(JsNativeError::typ().with_message("iterator.next is not callable"))?
        .clone();
    let mut pairs = Vec::new();
    loop {
        let result = next.call(&iterator.clone().into(), &[], context)?;
        let result = result
            .as_object()
            .ok_or(JsNativeError::typ().with_message("iterator result is not an object"))?;
        if result.get(js_string!("done"), context)?.to_boolean() {
            break;
        }
        let entry = result.get(js_string!("value"), context)?;
        let entry =
            entry
                .as_object()
                .ok_or(JsNativeError::typ().with_message(
                    "URLSearchParams sequence entries must be [name, value] pairs",
                ))?;
        let name = entry.get(js_string!("0"), context)?;
        let value = entry.get(js_string!("1"), context)?;
        pairs.push((
            name.to_string(context)?.to_std_string_escaped(),
            value.to_string(context)?.to_std_string_escaped(),
        ));
    }
    Ok(pairs)
}

fn record_pairs(init: &JsValue, context: &mut Context) -> JsResult<Vec<(String, String)>> {
    let object = init
        .as_object()
        .ok_or(JsNativeError::typ().with_message("record init must be an object"))?;
    let mut pairs = Vec::new();
    for key in object.own_property_keys(context)? {
        let PropertyKey::String(name) = key.clone() else {
            continue;
        };
        let value = object.get(name.clone(), context)?;
        pairs.push((
            name.to_std_string_escaped(),
            value.to_string(context)?.to_std_string_escaped(),
        ));
    }
    Ok(pairs)
}

#[derive(Trace, Finalize)]
struct IterState {
    #[unsafe_ignore_trace]
    pairs: SharedPairs,
    #[unsafe_ignore_trace]
    index: Cell<usize>,
    kind: u8,
}

/// Builds a plain iterator object over the (live) pair list, supporting
/// `for...of`, spreads and `Object.fromEntries`.
fn make_pair_iterator(pairs: &SharedPairs, kind: u8, context: &mut Context) -> JsResult<JsObject> {
    let iterator = JsObject::with_object_proto(context.intrinsics());
    let next = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_copy_closure_with_captures(
            |_this, _args, state: &IterState, context| {
                let list = state.pairs.borrow();
                let index = state.index.get();
                let Some((name, value)) = list.get(index) else {
                    return iterator_result(context, None).map(JsValue::from);
                };
                state.index.set(index + 1);
                let item = match state.kind {
                    ITER_KIND_KEYS => JsValue::from(JsString::from(name.as_str())),
                    ITER_KIND_VALUES => JsValue::from(JsString::from(value.as_str())),
                    _ => JsArray::from_iter(
                        [
                            JsValue::from(JsString::from(name.as_str())),
                            JsValue::from(JsString::from(value.as_str())),
                        ],
                        context,
                    )
                    .into(),
                };
                iterator_result(context, Some(item)).map(JsValue::from)
            },
            IterState {
                pairs: pairs.clone(),
                index: Cell::new(0),
                kind,
            },
        ),
    )
    .name("next")
    .length(0)
    .build();
    iterator.create_data_property_or_throw(js_string!("next"), next, context)?;

    let self_iterator = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_copy_closure_with_captures(
            |_this, _args, iterator: &JsObject, _context| Ok(iterator.clone().into()),
            iterator.clone(),
        ),
    )
    .name("[Symbol.iterator]")
    .length(0)
    .build();
    iterator.create_data_property_or_throw(JsSymbol::iterator(), self_iterator, context)?;
    Ok(iterator)
}

fn iterator_result(context: &mut Context, value: Option<JsValue>) -> JsResult<JsObject> {
    let result = JsObject::with_object_proto(context.intrinsics());
    match value {
        Some(value) => {
            result.create_data_property_or_throw(js_string!("value"), value, context)?;
            result.create_data_property_or_throw(js_string!("done"), false, context)?;
        }
        None => {
            result.create_data_property_or_throw(
                js_string!("value"),
                JsValue::undefined(),
                context,
            )?;
            result.create_data_property_or_throw(js_string!("done"), true, context)?;
        }
    }
    Ok(result)
}

fn global_prototype(context: &mut Context, class_name: &str) -> JsResult<JsObject> {
    let constructor = context
        .global_object()
        .get(JsString::from(class_name), context)?;
    let constructor = constructor.as_object().ok_or_else(|| {
        JsError::from(JsNativeError::typ().with_message(format!("{class_name} is not registered")))
    })?;
    let prototype = constructor.get(js_string!("prototype"), context)?;
    prototype.as_object().ok_or_else(|| {
        JsError::from(JsNativeError::typ().with_message(format!("{class_name}.prototype missing")))
    })
}

fn attach_search_params_iterator(context: &mut Context) -> JsResult<()> {
    let prototype = global_prototype(context, "URLSearchParams")?;
    // URLSearchParams is iterable over its entries.
    let symbol_iterator = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(|this, _args, context| {
            let this = this
                .as_object()
                .ok_or(JsNativeError::typ().with_message("`this` is not an object"))?;
            let entries = this.get(js_string!("entries"), context)?;
            let entries = entries
                .as_callable()
                .ok_or(JsNativeError::typ().with_message("entries is not callable"))?
                .clone();
            entries.call(&this.into(), &[], context)
        }),
    )
    .name("[Symbol.iterator]")
    .length(0)
    .build();
    prototype.create_data_property_or_throw(JsSymbol::iterator(), symbol_iterator, context)?;
    Ok(())
}

fn attach_search_params_getter(context: &mut Context) -> JsResult<()> {
    let prototype = global_prototype(context, "URL")?;
    let getter = FunctionObjectBuilder::new(
        context.realm(),
        NativeFunction::from_fn_ptr(|this, _args, context| {
            let object = this
                .as_object()
                .ok_or(JsNativeError::typ().with_message("`this` is not a URL"))?;
            let Some(url) = object.downcast_ref::<Url>() else {
                return Err(JsNativeError::typ()
                    .with_message("`this` is not a URL")
                    .into());
            };
            let existing = url.search_params.borrow().clone();
            if let Some(existing) = existing {
                return Ok(existing.into());
            }
            let params = <UrlSearchParams as Class>::from_data(
                UrlSearchParams {
                    pairs: url.pairs.clone(),
                    parent: Some(object.clone()),
                },
                context,
            )?;
            *url.search_params.borrow_mut() = Some(params.clone());
            Ok(params.into())
        }),
    )
    .name("get searchParams")
    .length(0)
    .build();
    prototype.define_property_or_throw(
        js_string!("searchParams"),
        PropertyDescriptor::builder()
            .get(getter)
            .enumerable(true)
            .configurable(true)
            .build(),
        context,
    )?;
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use boa_engine::Source;

    fn eval(src: &str) -> String {
        let mut context = Context::default();
        declare(&mut context).unwrap();
        let value = context.eval(Source::from_bytes(src)).unwrap();
        value
            .to_string(&mut context)
            .unwrap()
            .to_std_string_escaped()
    }

    #[test]
    fn url_parses_and_exposes_components() {
        assert_eq!(
            eval(
                r#"
                const url = new URL("https://user:pw@example.org:8443/a/b?x=1&x=2&y=hello+world#frag");
                [
                    url.protocol, url.hostname, url.port, url.host, url.pathname,
                    url.search, url.hash, url.origin, url.username, url.searchParams.get("y")
                ].join("|")
            "#
            ),
            "https:|example.org|8443|example.org:8443|/a/b|?x=1&x=2&y=hello+world|#frag|https://example.org:8443|user|hello world"
        );
    }

    #[test]
    fn url_resolves_relative_against_base() {
        assert_eq!(
            eval(r#"new URL("/next?page=2", "https://example.org/list/1").toString()"#),
            "https://example.org/next?page=2"
        );
        assert_eq!(eval("URL.canParse('/x', 'https://example.org/')"), "true");
        assert_eq!(eval("URL.canParse('https://exa mple.org/')"), "false");
        assert_eq!(
            eval("String(URL.parse('/x', 'https://example.org/')?.pathname)"),
            "/x"
        );
        assert_eq!(eval("String(URL.parse('ht tp://bad'))"), "null");
    }

    #[test]
    fn search_params_string_roundtrip() {
        assert_eq!(
            eval(r#"new URLSearchParams("?a=1&b=two words").toString()"#),
            "a=1&b=two%20words"
        );
        assert_eq!(
            eval(
                r#"
                const p = new URLSearchParams("a=1&a=2&b=3");
                [p.get("a"), p.getAll("a").join(","), p.has("b"), p.has("c"), p.size].join("|")
            "#
            ),
            "1|1,2|true|false|3"
        );
    }

    #[test]
    fn search_params_record_and_sequence_init() {
        assert_eq!(
            eval(r#"new URLSearchParams({ q: "big cats", page: "2" }).toString()"#),
            "q=big%20cats&page=2"
        );
        assert_eq!(
            eval(
                r#"
                const p = new URLSearchParams([["a", "1"], ["b", "2"]]);
                [...p].map(([k, v]) => `${k}=${v}`).join("&")
            "#
            ),
            "a=1&b=2"
        );
        assert_eq!(
            eval(
                r#"
                const p = new URLSearchParams("z=1&a=2");
                p.sort(); p.toString()
            "#
            ),
            "a=2&z=1"
        );
    }

    #[test]
    fn search_params_mutations_and_iteration() {
        assert_eq!(
            eval(
                r#"
                const p = new URLSearchParams("a=1&b=2");
                p.set("a", "9"); p.append("c", "3"); p.delete("b");
                [p.toString(), [...p.keys()].join(","), [...p.values()].join(",")].join(" | ")
            "#
            ),
            "a=9&c=3 | a,c | 9,3"
        );
        assert_eq!(
            eval(
                r#"
                const seen = [];
                new URLSearchParams("a=1&b=2").forEach((value, key, search) => {
                    seen.push(`${key}=${value}:${search === search}`);
                });
                seen.join(",")
            "#
            ),
            "a=1:true,b=2:true"
        );
    }

    #[test]
    fn url_search_params_stay_in_sync_both_ways() {
        assert_eq!(
            eval(
                r#"
                const url = new URL("https://example.org/?a=1");
                url.searchParams.set("a", "2");
                url.searchParams.append("b", "three 3");
                url.toString()
            "#
            ),
            "https://example.org/?a=2&b=three%203"
        );
        assert_eq!(
            eval(
                r#"
                const url = new URL("https://example.org/?a=1");
                url.search = "?x=%20y";
                [url.searchParams.get("x"), url.searchParams.size].join("|")
            "#
            ),
            " y|1"
        );
        assert_eq!(
            eval(
                r#"
                const url = new URL("https://example.org/?a=1");
                url.href = "https://other.org/path?z=9";
                url.searchParams.get("z")
            "#
            ),
            "9"
        );
    }

    #[test]
    fn search_params_identity_is_stable() {
        assert_eq!(
            eval(
                r#"
                const url = new URL("https://example.org/?a=1");
                url.searchParams === url.searchParams
            "#
            ),
            "true"
        );
    }

    #[test]
    fn json_and_object_url_errors() {
        assert_eq!(
            eval(r#"new URL("https://example.org/x").toJSON()"#),
            "https://example.org/x"
        );
        assert_eq!(
            eval(
                r#"
                try { URL.createObjectURL(); } catch (e) { e.message }
            "#
            ),
            "URL.createObjectURL is not supported"
        );
    }
}
