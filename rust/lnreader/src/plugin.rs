//! Reading LNReader plugin code and turning it into a Dion extension.

use std::collections::HashSet;

use anyhow::{Context, Result, anyhow, bail};
use boa_engine::{Context as JsContext, JsValue, Source, js_string};
use dion_extension::extension_manager::ExtensionMetadata;
use dion_runtime::data::{extension::ExtensionType, source::MediaType};
use serde::{Deserialize, Serialize};

use crate::repo::{
    PluginItem, display_name, extension_id, icon_url_for, language_code, language_from_plugin_url,
    site_permissions,
};

/// Name of the host module (the bundled shim) generated extensions import.
pub const HOST_MODULE: &str = "lnreader";

/// The bundled shim: cheerio, htmlparser2, dayjs, LNReader's `@libs/*` and
/// the Dion extension class driving a plugin. Built from `js/lnreader_shim`.
pub const SHIM_SOURCE: &str = include_str!("../assets/generated_lnreader_shim.js");

/// The metadata a plugin object declares about itself.
#[derive(Debug, Clone, Default, PartialEq, Eq, Deserialize)]
pub struct PluginInfo {
    pub id: String,
    #[serde(default)]
    pub name: String,
    #[serde(default)]
    pub site: String,
    #[serde(default)]
    pub version: String,
    #[serde(default)]
    pub icon: String,
}

/// Evaluates the plugin like lnreader-plugins' manifest builder does: every
/// `require` returns a recursive proxy, so no library code runs and only the
/// plugin's own constructor is executed.
const INFO_SCRIPT: &str = r#"
(function (code) {
    const make = function () {
        const target = function () {};
        return new Proxy(target, {
            get(target, prop) {
                if (prop === "get") return (value) => value;
                if (prop === Symbol.toPrimitive) return () => "";
                if (typeof prop === "symbol") return undefined;
                if (!(prop in target)) target[prop] = make();
                return target[prop];
            },
            apply() { return make(); },
            construct() { return make(); },
        });
    };
    const proxy = make();
    // Web globals plugins may touch while being constructed.
    for (const name of [
        "Headers", "FormData", "Blob", "Request", "Response", "URL", "URLSearchParams",
        "AbortController", "TextEncoder", "TextDecoder", "fetch", "setTimeout",
        "clearTimeout", "setInterval", "clearInterval", "atob", "btoa", "window",
        "self", "document", "navigator", "localStorage", "sessionStorage",
    ]) {
        if (!(name in globalThis)) globalThis[name] = make();
    }
    const plugin = Function(
        "require",
        "module",
        "const exports = module.exports = {};\n" + code + ";\nreturn exports.default",
    )(() => proxy, {});
    if (!plugin || typeof plugin !== "object") {
        throw new Error("plugin has no default export");
    }
    const text = (value) => (typeof value === "string" ? value : "");
    return JSON.stringify({
        id: text(plugin.id),
        name: text(plugin.name),
        site: text(plugin.site),
        version: text(plugin.version),
        icon: text(plugin.icon),
    });
})
"#;

/// Upper bound on loop iterations while reading metadata, so a plugin whose
/// constructor never terminates cannot hang the install.
const INFO_LOOP_LIMIT: u64 = 50_000_000;

/// Reads a plugin's id, name, site, version and icon from its code.
pub async fn read_plugin_info(code: String) -> Result<PluginInfo> {
    tokio::task::spawn_blocking(move || read_plugin_info_blocking(&code))
        .await
        .context("Plugin metadata task panicked")?
}

fn read_plugin_info_blocking(code: &str) -> Result<PluginInfo> {
    let mut context = JsContext::default();
    context
        .runtime_limits_mut()
        .set_loop_iteration_limit(INFO_LOOP_LIMIT);
    let js_error = |context: &mut JsContext, err: boa_engine::JsError| match err.try_native(context)
    {
        Ok(native) => anyhow!("{native}"),
        Err(_) => anyhow!("{err}"),
    };
    let reader = context
        .eval(Source::from_bytes(INFO_SCRIPT))
        .map_err(|err| js_error(&mut context, err))?;
    let reader = reader
        .as_callable()
        .ok_or_else(|| anyhow!("metadata reader is not callable"))?
        .clone();
    let json = reader
        .call(
            &JsValue::undefined(),
            &[js_string!(code).into()],
            &mut context,
        )
        .map_err(|err| js_error(&mut context, err))
        .context("Failed to evaluate LNReader plugin")?;
    let json = json
        .as_string()
        .ok_or_else(|| anyhow!("metadata reader returned no string"))?
        .to_std_string_escaped();
    let info: PluginInfo = serde_json::from_str(&json).context("Invalid plugin metadata")?;
    if info.id.trim().is_empty() {
        bail!("LNReader plugin declares no id");
    }
    Ok(info)
}

/// What the generated module passes to the shim's `createExtension`.
#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
struct ShimMeta<'a> {
    plugin_id: &'a str,
    lang: &'a str,
}

/// Everything known about a plugin being installed.
#[derive(Debug, Clone)]
pub struct PluginPackage {
    pub info: PluginInfo,
    /// The repository listing for the plugin, when it was installed from one.
    pub item: Option<PluginItem>,
    /// The repository index the plugin was listed in.
    pub repo_url: Option<String>,
    /// Where the plugin code came from.
    pub source_url: String,
    pub code: String,
}

impl PluginPackage {
    pub fn extension_id(&self) -> String {
        extension_id(&self.info.id)
    }

    pub fn language(&self) -> Option<String> {
        self.item
            .as_ref()
            .and_then(|item| language_code(&item.lang))
            .or_else(|| language_from_plugin_url(&self.source_url))
    }

    pub fn metadata(&self) -> ExtensionMetadata {
        let item = self.item.as_ref();
        let name = item
            .map(|item| item.name.clone())
            .filter(|name| !name.is_empty())
            .unwrap_or_else(|| self.info.name.clone());
        let site = if self.info.site.is_empty() {
            item.map(|item| item.site.clone()).unwrap_or_default()
        } else {
            self.info.site.clone()
        };
        let version = if self.info.version.is_empty() {
            item.map(|item| item.version.clone()).unwrap_or_default()
        } else {
            self.info.version.clone()
        };
        let icon = item
            .map(|item| item.icon_url.clone())
            .filter(|icon| !icon.is_empty())
            .or_else(|| icon_url_for(&self.source_url, &self.info.icon))
            .unwrap_or_default();
        ExtensionMetadata {
            id: self.extension_id(),
            name: display_name(&name),
            url: site.clone(),
            icon,
            desc: Some(format!("LNReader plugin {}", self.info.id)),
            authors: Vec::new(),
            tags: vec!["lnreader".to_string()],
            lang: self.language().into_iter().collect(),
            nsfw: false,
            media_type: HashSet::from([MediaType::Book]),
            extension_type: HashSet::from([ExtensionType::EntryProvider { has_search: true }]),
            repo: self.repo_url.clone(),
            version,
            license: String::new(),
            api_version: "*".to_string(),
            settings: Default::default(),
            accounts: Vec::new(),
            permissions: site_permissions(&site).unwrap_or_default(),
        }
    }

    /// The Dion single-file extension: the metadata line, then a module that
    /// hands the plugin code to the shim.
    pub fn extension_source(&self) -> Result<String> {
        let manifest = serde_json::to_string(&self.metadata())?;
        let lang = self.language().unwrap_or_default();
        let meta = serde_json::to_string(&ShimMeta {
            plugin_id: &self.info.id,
            lang: &lang,
        })?;
        // A JSON string is a valid JS string literal.
        let code = serde_json::to_string(&self.code)?;
        Ok(format!(
            "//{manifest}\nimport {{ createExtension }} from \"{HOST_MODULE}\";\nexport default createExtension({meta}, {code});\n"
        ))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const TS_PLUGIN: &str = r#"var e=this&&this.__awaiter||function(){};Object.defineProperty(exports,"__esModule",{value:!0});var t=require("cheerio"),o=require("@libs/storage"),n=require("@libs/filterInputs"),u=function(){function e(){this.id="royalroad",this.name="Royal Road[test]",this.version="2.3.4",this.icon="src/en/royalroad/icon.png",this.site="https://www.royalroad.com/",this.enableVol=o.storage.get("enableVol"),this.filters={genre:{type:n.FilterTypes.Picker,label:"Genre",value:"",options:[]}}}return e.prototype.popularNovels=function(){},e}();exports.default=new u;"#;

    #[tokio::test]
    async fn reads_metadata_without_running_libraries() {
        let info = read_plugin_info(TS_PLUGIN.to_string()).await.unwrap();
        assert_eq!(
            info,
            PluginInfo {
                id: "royalroad".into(),
                name: "Royal Road[test]".into(),
                site: "https://www.royalroad.com/".into(),
                version: "2.3.4".into(),
                icon: "src/en/royalroad/icon.png".into(),
            }
        );
    }

    #[tokio::test]
    async fn web_globals_are_available_to_constructors() {
        let code = r#"exports.default = new (class { constructor() { this.id = "x"; this.headers = new Headers({ a: "b" }); this.url = new URL("https://a.example/").href; } })();"#;
        assert_eq!(read_plugin_info(code.into()).await.unwrap().id, "x");
    }

    #[tokio::test]
    async fn rejects_code_without_a_plugin() {
        assert!(
            read_plugin_info("exports.default = 1".into())
                .await
                .is_err()
        );
        assert!(
            read_plugin_info("throw new Error('x')".into())
                .await
                .is_err()
        );
        assert!(
            read_plugin_info("exports.default = { name: 'no id' }".into())
                .await
                .is_err()
        );
        // Runaway constructors hit the loop limit instead of hanging.
        assert!(read_plugin_info("while (true) {}".into()).await.is_err());
    }

    fn package(item: Option<PluginItem>) -> PluginPackage {
        PluginPackage {
            info: PluginInfo {
                id: "royalroad".into(),
                name: "Royal Road[test]".into(),
                site: "https://www.royalroad.com/".into(),
                version: "2.3.4".into(),
                icon: "src/en/royalroad/icon.png".into(),
            },
            item,
            repo_url: None,
            source_url:
                "https://raw.githubusercontent.com/o/r/b/.js/src/plugins/english/royalroad.js"
                    .into(),
            code: TS_PLUGIN.into(),
        }
    }

    #[test]
    fn metadata_falls_back_to_the_plugin_url() {
        let meta = package(None).metadata();
        assert_eq!(meta.id, "lnreader.royalroad");
        assert_eq!(meta.name, "Royal Road");
        assert_eq!(meta.lang, vec!["en".to_string()]);
        assert_eq!(
            meta.icon,
            "https://raw.githubusercontent.com/o/r/b/public/static/src/en/royalroad/icon.png"
        );
        assert!(meta.is_compatible());
    }

    #[test]
    fn metadata_prefers_the_repository_listing() {
        let meta = package(Some(PluginItem {
            id: "royalroad".into(),
            name: "Royal Road".into(),
            lang: "Español".into(),
            icon_url: "https://example.com/icon.png".into(),
            url: "https://example.com/royalroad.js".into(),
            ..Default::default()
        }))
        .metadata();
        assert_eq!(meta.lang, vec!["es".to_string()]);
        assert_eq!(meta.icon, "https://example.com/icon.png");
    }

    #[test]
    fn extension_source_has_a_manifest_line_and_imports_the_shim() {
        let source = package(None).extension_source().unwrap();
        let (first, rest) = source.split_once('\n').unwrap();
        let manifest: ExtensionMetadata =
            serde_json::from_str(first.strip_prefix("//").unwrap()).unwrap();
        assert_eq!(manifest.id, "lnreader.royalroad");
        assert!(rest.starts_with("import { createExtension } from \"lnreader\";"));
        assert!(rest.contains(r#"{"pluginId":"royalroad","lang":"en"}"#));
    }

    #[test]
    fn shim_asset_is_bundled() {
        assert!(SHIM_SOURCE.starts_with("// GENERATED by js/lnreader_shim"));
        assert!(SHIM_SOURCE.contains("createExtension"));
    }
}
