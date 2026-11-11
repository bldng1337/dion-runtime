//! LNReader plugin repositories.
//!
//! A repository is a JSON array of [`PluginItem`]s, e.g.
//! `https://raw.githubusercontent.com/LNReader/lnreader-plugins/plugins/v3.0.0/.dist/plugins.min.json`
//! (built by `scripts/build-plugin-manifest.js` in lnreader-plugins).

use std::collections::HashSet;

use anyhow::{Context, Result, bail};
use dion_runtime::data::{
    extension_repo::{ExtensionKind, ExtensionRepo, RemoteExtension, RemoteExtensionResult},
    permission::Permission,
    source::{Link, MediaType},
};
use serde::{Deserialize, Serialize};
use url::Url;

/// One plugin as listed in a repository index (LNReader's `PluginItem`).
#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PluginItem {
    pub id: String,
    pub name: String,
    #[serde(default)]
    pub site: String,
    /// The language's native name, e.g. `English` or `Español`.
    #[serde(default)]
    pub lang: String,
    #[serde(default)]
    pub version: String,
    /// Where the plugin's code is downloaded from.
    pub url: String,
    #[serde(default)]
    pub icon_url: String,
    #[serde(default, rename = "customJS", skip_serializing_if = "Option::is_none")]
    pub custom_js: Option<String>,
    #[serde(default, rename = "customCSS", skip_serializing_if = "Option::is_none")]
    pub custom_css: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub has_settings: Option<bool>,
}

impl PluginItem {
    pub fn extension_id(&self) -> String {
        extension_id(&self.id)
    }

    pub fn to_remote(&self) -> RemoteExtension {
        RemoteExtension {
            remote_id: self.url.clone(),
            id: self.extension_id(),
            name: display_name(&self.name),
            url: self.site.clone(),
            cover: (!self.icon_url.is_empty()).then(|| Link {
                url: self.icon_url.clone(),
                header: None,
            }),
            version: self.version.clone(),
            compatible: true,
            permissions: site_permissions(&self.site),
            authors: Vec::new(),
            lang: language_code(&self.lang).into_iter().collect(),
            tags: Vec::new(),
            nsfw: false,
            media_type: HashSet::from([MediaType::Book]),
            extension_kinds: vec![ExtensionKind::EntryProvider],
        }
    }
}

/// A fetched repository index.
#[derive(Debug, Clone)]
pub struct RepoIndex {
    pub url: String,
    pub plugins: Vec<PluginItem>,
}

impl RepoIndex {
    /// Parses an index. Like the app, later entries win over earlier ones with
    /// the same id.
    pub fn parse(url: &str, body: &str) -> Result<Self> {
        let value: serde_json::Value =
            serde_json::from_str(body).context("Repository index is not valid JSON")?;
        let serde_json::Value::Array(entries) = value else {
            bail!("Repository index must be a JSON array of plugins");
        };
        let mut plugins: Vec<PluginItem> = Vec::with_capacity(entries.len());
        for entry in entries {
            match serde_json::from_value::<PluginItem>(entry) {
                Ok(item) => {
                    plugins.retain(|existing| existing.id != item.id);
                    plugins.push(item);
                }
                Err(err) => log::warn!("Skipping malformed LNReader plugin entry in {url}: {err}"),
            }
        }
        Ok(Self {
            url: url.to_string(),
            plugins,
        })
    }

    pub fn to_repo(&self) -> ExtensionRepo {
        let (name, homepage) = describe_repo_url(&self.url);
        ExtensionRepo {
            remote_id: self.url.clone(),
            name,
            description: format!(
                "LNReader plugin repository ({} plugins)",
                self.plugins.len()
            ),
            url: homepage,
        }
    }

    pub fn to_result(&self) -> RemoteExtensionResult {
        RemoteExtensionResult {
            content: self.plugins.iter().map(PluginItem::to_remote).collect(),
            hasnext: Some(false),
            length: Some(self.plugins.len() as i32),
        }
    }

    /// Finds a plugin by its Dion extension id or its LNReader plugin id.
    pub fn find(&self, id: &str) -> Option<&PluginItem> {
        self.plugins
            .iter()
            .find(|plugin| plugin.extension_id() == id || plugin.id == id)
    }
}

/// The Dion extension id for an LNReader plugin id. Dion ids may not contain
/// path separators, `:` or `..`.
pub fn extension_id(plugin_id: &str) -> String {
    let mut id: String = plugin_id
        .chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() || matches!(c, '-' | '_' | '.') {
                c
            } else {
                '_'
            }
        })
        .collect();
    while id.contains("..") {
        id = id.replace("..", "_");
    }
    format!("lnreader.{id}")
}

/// Plugin names may carry a multisrc tag like `ArNovel[madara]`; the app's
/// manifest builder strips it, so do the same for names read from code.
pub fn display_name(name: &str) -> String {
    match (name.find('['), name.rfind(']')) {
        (Some(start), Some(end)) if start < end => {
            let mut stripped = String::with_capacity(name.len());
            stripped.push_str(&name[..start]);
            stripped.push_str(&name[end + 1..]);
            stripped.trim().to_string()
        }
        _ => name.trim().to_string(),
    }
}

/// The host of the plugin's site, which every plugin talks to.
pub fn site_permissions(site: &str) -> Option<Vec<Permission>> {
    let host = Url::parse(site).ok()?.host_str()?.to_string();
    Some(vec![Permission::Network {
        domains: vec![host],
    }])
}

/// The languages LNReader repositories use (lnreader-plugins
/// `scripts/languages.js`): folder name, native name, ISO 639-1 code.
const LANGUAGES: &[(&str, &str, &str)] = &[
    ("arabic", "العربية", "ar"),
    ("bangla", "বাংলা", "bn"),
    ("chinese", "中文, 汉语, 漢語", "zh"),
    ("english", "English", "en"),
    ("french", "Français", "fr"),
    ("indonesian", "Bahasa Indonesia", "id"),
    ("japanese", "日本語", "ja"),
    ("korean", "조선말, 한국어", "ko"),
    ("polish", "Polski", "pl"),
    ("portuguese", "Português", "pt"),
    ("russian", "Русский", "ru"),
    ("spanish", "Español", "es"),
    ("thai", "ไทย", "th"),
    ("turkish", "Türkçe", "tr"),
    ("ukrainian", "Українська", "uk"),
    ("vietnamese", "Tiếng Việt", "vi"),
    ("multi", "Multi", "all"),
];

/// ISO 639-1 code for an LNReader language name (native or English).
/// Unknown names are passed through lowercased; empty names yield `None`.
pub fn language_code(name: &str) -> Option<String> {
    // The Arabic name carries a left-to-right mark.
    let name = name.trim_matches(|c: char| c.is_whitespace() || c == '\u{200e}' || c == '\u{200f}');
    if name.is_empty() {
        return None;
    }
    let code = LANGUAGES
        .iter()
        .find(|(folder, native, _)| {
            native.eq_ignore_ascii_case(name) || folder.eq_ignore_ascii_case(name)
        })
        .map(|(_, _, code)| (*code).to_string());
    Some(code.unwrap_or_else(|| name.to_lowercase()))
}

/// The language of a plugin from its published location, which follows
/// `.../plugins/<language>/<plugin>.js`.
pub fn language_from_plugin_url(plugin_url: &str) -> Option<String> {
    let url = Url::parse(plugin_url).ok()?;
    let segments: Vec<&str> = url.path_segments()?.collect();
    // The last one: GitHub branches are named `plugins/<version>` too.
    let index = segments.iter().rposition(|s| *s == "plugins")?;
    let folder = segments.get(index + 1)?;
    LANGUAGES
        .iter()
        .find(|(name, _, _)| name.eq_ignore_ascii_case(folder))
        .map(|(_, _, code)| (*code).to_string())
}

/// The icon URL the manifest builder would publish for a plugin's `icon`
/// path: `<branch root>/public/static/<icon>`, where the plugin code lives at
/// `<branch root>/.js/...`.
pub fn icon_url_for(plugin_url: &str, icon: &str) -> Option<String> {
    if icon.is_empty() {
        return None;
    }
    if icon.starts_with("http://") || icon.starts_with("https://") {
        return Some(icon.to_string());
    }
    let (root, _) = plugin_url.split_once("/.js/")?;
    Some(format!(
        "{root}/public/static/{}",
        icon.trim_start_matches('/')
    ))
}

/// A display name and homepage for a repository index URL. GitHub-hosted
/// indexes (`raw.githubusercontent.com/<owner>/<repo>/<branch...>/.dist/...`)
/// are named `<owner>/<repo> (<branch>)`.
pub fn describe_repo_url(index_url: &str) -> (String, String) {
    let Ok(url) = Url::parse(index_url) else {
        return (index_url.to_string(), index_url.to_string());
    };
    let segments: Vec<&str> = url
        .path_segments()
        .map(|s| s.filter(|s| !s.is_empty()).collect())
        .unwrap_or_default();
    if url.host_str() == Some("raw.githubusercontent.com") && segments.len() >= 3 {
        let (owner, repo) = (segments[0], segments[1]);
        let rest = &segments[2..];
        let branch_end = rest
            .iter()
            .position(|s| *s == ".dist")
            .unwrap_or(rest.len().saturating_sub(1));
        let branch = rest[..branch_end].join("/");
        let name = if branch.is_empty() {
            format!("{owner}/{repo}")
        } else {
            format!("{owner}/{repo} ({branch})")
        };
        return (name, format!("https://github.com/{owner}/{repo}"));
    }
    let host = url.host_str().unwrap_or_default();
    (
        format!("{host}{}", url.path()),
        format!("{}://{host}", url.scheme()),
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    const INDEX: &str = r#"[
        {"id":"arnovel","name":"ArNovel","site":"https://ar-no.com/","lang":"‎العربية","version":"2.4.0","url":"https://raw.githubusercontent.com/lnreader/lnreader-plugins/plugins/v3.0.0/.js/src/plugins/arabic/ArNovel[madara].js","iconUrl":"https://raw.githubusercontent.com/lnreader/lnreader-plugins/plugins/v3.0.0/public/static/multisrc/madara/arnovel/icon.png"},
        {"id":"royalroad","name":"Royal Road","site":"https://www.royalroad.com/","lang":"English","version":"2.3.4","url":"https://example.com/old.js","iconUrl":""},
        {"broken": true},
        {"id":"royalroad","name":"Royal Road","site":"https://www.royalroad.com/","lang":"English","version":"2.3.5","url":"https://example.com/new.js","iconUrl":"","customCSS":"https://example.com/c.css"}
    ]"#;

    #[test]
    fn parses_index_and_keeps_the_last_duplicate() {
        let index = RepoIndex::parse("https://example.com/plugins.min.json", INDEX).unwrap();
        assert_eq!(index.plugins.len(), 2);
        let royal = index.find("royalroad").unwrap();
        assert_eq!(royal.version, "2.3.5");
        assert_eq!(
            royal.custom_css.as_deref(),
            Some("https://example.com/c.css")
        );
        assert_eq!(index.find("lnreader.royalroad"), Some(royal));
    }

    #[test]
    fn rejects_non_array_indexes() {
        assert!(RepoIndex::parse("u", r#"{"plugins":[]}"#).is_err());
        assert!(RepoIndex::parse("u", "not json").is_err());
    }

    #[test]
    fn remote_extension_carries_plugin_details() {
        let index = RepoIndex::parse("https://example.com/plugins.min.json", INDEX).unwrap();
        let remote = index.find("arnovel").unwrap().to_remote();
        assert_eq!(remote.id, "lnreader.arnovel");
        assert_eq!(remote.remote_id, index.plugins[0].url);
        assert_eq!(remote.lang, vec!["ar".to_string()]);
        assert_eq!(remote.url, "https://ar-no.com/");
        assert!(remote.media_type.contains(&MediaType::Book));
        assert_eq!(
            remote.permissions,
            Some(vec![Permission::Network {
                domains: vec!["ar-no.com".to_string()]
            }])
        );
        // An empty icon URL yields no cover.
        assert!(index.find("royalroad").unwrap().to_remote().cover.is_none());
    }

    #[test]
    fn extension_ids_are_safe() {
        assert_eq!(extension_id("royalroad"), "lnreader.royalroad");
        assert_eq!(extension_id("FWN.com"), "lnreader.FWN.com");
        assert_eq!(extension_id("a/b:c"), "lnreader.a_b_c");
        assert_eq!(extension_id("a..b"), "lnreader.a_b");
    }

    #[test]
    fn display_names_drop_multisrc_tags() {
        assert_eq!(display_name("ArNovel[madara]"), "ArNovel");
        assert_eq!(display_name("Royal Road"), "Royal Road");
    }

    #[test]
    fn languages_map_to_iso_codes() {
        assert_eq!(language_code("English").as_deref(), Some("en"));
        assert_eq!(language_code("\u{200e}العربية").as_deref(), Some("ar"));
        assert_eq!(language_code("Multi").as_deref(), Some("all"));
        assert_eq!(language_code("Klingon").as_deref(), Some("klingon"));
        assert_eq!(language_code(""), None);
        assert_eq!(
            language_from_plugin_url(
                "https://raw.githubusercontent.com/lnreader/lnreader-plugins/plugins/v3.0.0/.js/src/plugins/spanish/x.js"
            )
            .as_deref(),
            Some("es")
        );
        assert_eq!(language_from_plugin_url("https://example.com/x.js"), None);
    }

    #[test]
    fn icon_urls_follow_the_manifest_builder() {
        let plugin = "https://raw.githubusercontent.com/lnreader/lnreader-plugins/plugins/v3.0.0/.js/src/plugins/english/royalroad.js";
        assert_eq!(
            icon_url_for(plugin, "src/en/royalroad/icon.png").as_deref(),
            Some(
                "https://raw.githubusercontent.com/lnreader/lnreader-plugins/plugins/v3.0.0/public/static/src/en/royalroad/icon.png"
            )
        );
        assert_eq!(icon_url_for("https://example.com/x.js", "a.png"), None);
        assert_eq!(icon_url_for(plugin, ""), None);
    }

    #[test]
    fn github_repos_are_named_after_owner_repo_and_branch() {
        let (name, homepage) = describe_repo_url(
            "https://raw.githubusercontent.com/LNReader/lnreader-plugins/plugins/v3.0.0/.dist/plugins.min.json",
        );
        assert_eq!(name, "LNReader/lnreader-plugins (plugins/v3.0.0)");
        assert_eq!(homepage, "https://github.com/LNReader/lnreader-plugins");

        let (name, homepage) = describe_repo_url("https://example.com/repo/plugins.json");
        assert_eq!(name, "example.com/repo/plugins.json");
        assert_eq!(homepage, "https://example.com");
    }
}
