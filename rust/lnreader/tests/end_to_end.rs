//! Installs an LNReader plugin from a (mock) repository and drives it through
//! the Dion extension API, against a mock website.

use std::path::{Path, PathBuf};

use anyhow::{Result, bail};
use dion_runtime::{
    client_data::{AdapterClient, ExtensionClient},
    data::{
        action::Action,
        extension::ExtensionData,
        permission::Permission,
        settings::{SettingKind, SettingValue},
        source::{EntryId, EpisodeId, MediaType, Paragraph, ReleaseStatus, Source},
    },
    extension::{Adapter, Extension},
};
use httpmock::{Method::GET, Method::POST, MockServer};
use lnreader_adapter::LnReaderAdapter;

struct TestAdapterClient {
    path: PathBuf,
}

#[async_trait::async_trait]
impl AdapterClient for TestAdapterClient {
    async fn get_extension_client(
        &self,
        extension: ExtensionData,
    ) -> Result<Box<dyn ExtensionClient>> {
        Ok(Box::new(TestExtensionClient {
            path: self.path.join("data").join(extension.id),
        }))
    }

    async fn get_path(&self) -> Result<String> {
        Ok(self.path.to_string_lossy().into_owned())
    }
}

#[derive(Debug)]
struct TestExtensionClient {
    path: PathBuf,
}

#[async_trait::async_trait]
impl ExtensionClient for TestExtensionClient {
    async fn load_data(&self, _key: &str) -> Result<String> {
        bail!("nothing stored")
    }
    async fn store_data(&self, _key: &str, _data: String) -> Result<()> {
        Ok(())
    }
    async fn load_data_secure(&self, _key: &str) -> Result<String> {
        bail!("nothing stored")
    }
    async fn store_data_secure(&self, _key: &str, _data: String) -> Result<()> {
        Ok(())
    }
    async fn do_action(&self, _action: &Action) -> Result<()> {
        Ok(())
    }
    async fn store_set(&self, _key: &str, _value: serde_json::Value) -> Result<()> {
        Ok(())
    }
    async fn set_entry_setting(
        &self,
        _entry: EntryId,
        _key: String,
        _value: SettingValue,
    ) -> Result<()> {
        Ok(())
    }
    async fn request_permission(
        &self,
        _permission: &Permission,
        _msg: Option<String>,
    ) -> Result<bool> {
        Ok(true)
    }
    async fn get_path(&self) -> Result<String> {
        Ok(self.path.to_string_lossy().into_owned())
    }
}

/// A plugin written like the compiled ones in lnreader-plugins: CommonJS,
/// `exports.default` is the plugin instance, libraries come from `require`.
const PLUGIN: &str = r##"
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cheerio_1 = require("cheerio");
const fetch_1 = require("@libs/fetch");
const filterInputs_1 = require("@libs/filterInputs");
const novelStatus_1 = require("@libs/novelStatus");
const storage_1 = require("@libs/storage");
const htmlparser2_1 = require("htmlparser2");
const dayjs_1 = require("dayjs");
// TypeScript's down-levelled async helper shape: forwards `arguments`.
var __call = function (thisArg, args, fn) { return fn.apply(thisArg, args); };
function fetchBody(url) {
    return __call(this, arguments, function (url) {
        return (0, fetch_1.fetchApi)(url).then((r) => r.text());
    });
}
class TestPlugin {
    constructor() {
        this.id = "testplugin";
        this.name = "Test Plugin[test]";
        this.version = "1.2.3";
        this.icon = "src/en/test/icon.png";
        this.site = "SITE/";
        this.hideLocked = storage_1.storage.get("hideLocked");
        this.imageRequestInit = { headers: { Referer: "SITE/" } };
        this.pluginSettings = {
            hideLocked: { value: "", label: "Hide locked chapters", type: "Switch" },
        };
        this.filters = {
            genre: {
                type: filterInputs_1.FilterTypes.Picker,
                label: "Genre",
                value: "all",
                options: [
                    { label: "All", value: "all" },
                    { label: "Fantasy", value: "fantasy" },
                ],
            },
            tags: {
                type: filterInputs_1.FilterTypes.ExcludableCheckboxGroup,
                label: "Tags",
                value: { include: [], exclude: [] },
                options: [
                    { label: "Magic", value: "magic" },
                    { label: "Harem", value: "harem" },
                ],
            },
        };
    }
    async popularNovels(page, { showLatestNovels, filters }) {
        await new Promise((resolve) => setTimeout(resolve, 1));
        const params = new URLSearchParams({
            page: String(page),
            genre: filters.genre.value,
            exclude: filters.tags.value.exclude.join(","),
            latest: showLatestNovels ? "1" : "0",
            locked: this.hideLocked ? "hide" : "show",
        });
        const res = await (0, fetch_1.fetchApi)(this.site + "popular?" + params.toString());
        if (res.headers.get("x-test") !== "yes") throw new Error("missing header");
        const $ = (0, cheerio_1.load)(await res.text());
        return $("div.novel")
            .map((i, el) => ({
                name: $(el).find("a").text().trim(),
                path: $(el).find("a").attr("href"),
                cover: $(el).find("img").attr("src"),
            }))
            .get();
    }
    async searchNovels(term, page) {
        const form = new FormData();
        form.append("q", term);
        form.append("page", String(page));
        const res = await (0, fetch_1.fetchApi)(this.site + "search", { method: "POST", body: form });
        return (await res.json()).results;
    }
    async parseNovel(path) {
        const body = await (0, fetch_1.fetchText)(this.site + path);
        const $ = (0, cheerio_1.load)(body);
        storage_1.storage.set("lastNovel", path);
        return {
            path,
            name: $("h1").text(),
            author: $(".author").text(),
            genres: "Fantasy, Action",
            status: novelStatus_1.NovelStatus.Ongoing,
            summary: $(".summary").text().trim(),
            cover: $("img.cover").attr("src"),
            chapters: this.chapters($),
            totalPages: 2,
        };
    }
    async parsePage(path, page) {
        const body = await (0, fetch_1.fetchText)(this.site + path + "/page/" + page);
        return { chapters: this.chapters((0, cheerio_1.load)(body)) };
    }
    chapters($) {
        return $("li a")
            .map((i, el) => ({
                name: $(el).text(),
                path: $(el).attr("href"),
                releaseTime: dayjs_1($(el).attr("data-date")).toISOString(),
            }))
            .get();
    }
    async parseChapter(path) {
        const body = await fetchBody(this.site + path);
        // Exercise the streaming parser the way many plugins do.
        let title = "";
        let inTitle = false;
        const parser = new htmlparser2_1.Parser({
            onopentag(name) { inTitle = name === "title"; },
            ontext(text) { if (inTitle) title += text; },
            onclosetag() { inTitle = false; },
        });
        parser.write(body);
        parser.end();
        const $ = (0, cheerio_1.load)(body);
        $("#content .ad").remove();
        return "<h2>" + title + "</h2>" + $("#content").html();
    }
}
exports.default = new TestPlugin();
"##;

struct Fixture {
    server: MockServer,
    dir: PathBuf,
}

impl Fixture {
    async fn new(name: &str) -> Self {
        let dir = std::env::temp_dir().join(format!("lnreader-{name}-{}", std::process::id()));
        let _ = std::fs::remove_dir_all(&dir);
        std::fs::create_dir_all(&dir).unwrap();
        let server = MockServer::start_async().await;
        let site = format!("{}/", server.base_url());
        let plugin = PLUGIN.replace("SITE/", &site);
        let plugin_url = server.url("/.js/src/plugins/english/testplugin.js");
        let index = serde_json::json!([{
            "id": "testplugin",
            "name": "Test Plugin",
            "site": site,
            "lang": "English",
            "version": "1.2.3",
            "url": plugin_url,
            "iconUrl": server.url("/public/static/src/en/test/icon.png"),
        }]);
        server
            .mock_async(|when, then| {
                when.method(GET).path("/.dist/plugins.min.json");
                then.status(200).json_body(index.clone());
            })
            .await;
        server
            .mock_async(|when, then| {
                when.method(GET)
                    .path("/.js/src/plugins/english/testplugin.js");
                then.status(200).body(plugin.clone());
            })
            .await;
        Self { server, dir }
    }

    async fn adapter(&self) -> LnReaderAdapter {
        LnReaderAdapter::new(Box::new(TestAdapterClient {
            path: self.dir.clone(),
        }))
        .await
        .unwrap()
    }

    fn index_url(&self) -> String {
        self.server.url("/.dist/plugins.min.json")
    }
}

impl Drop for Fixture {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.dir);
    }
}

async fn install(fixture: &Fixture, adapter: &LnReaderAdapter) -> Box<dyn Extension> {
    let repo = adapter.get_repo(&fixture.index_url()).await.unwrap();
    let remote = adapter.browse_repo(&repo, 0).await.unwrap();
    assert_eq!(remote.content.len(), 1);
    let mut extension = adapter.install(&remote.content[0].remote_id).await.unwrap();
    extension.set_enabled(true).await.unwrap();
    extension
}

fn mock_site(server: &MockServer) {
    server.mock(|when, then| {
        when.method(GET)
            .path("/popular")
            .query_param("page", "1")
            .query_param("genre", "fantasy")
            .query_param("exclude", "harem")
            .query_param("latest", "0")
            .query_param("locked", "hide")
            .header_exists("user-agent");
        then.status(200).header("x-test", "yes").body(
            r#"<html><body>
                <div class="novel"><a href="novel/1"> First Novel </a><img src="/covers/1.jpg"></div>
                <div class="novel"><a href="novel/2">Second Novel</a><img src="https://cdn.example/2.jpg"></div>
                <div class="novel"><span>Broken entry without a link</span></div>
            </body></html>"#,
        );
    });
    server.mock(|when, then| {
        when.method(POST)
            .path("/search")
            .header_exists("content-type")
            .body_contains("Content-Disposition: form-data; name=\"q\"")
            .body_contains("name=\"q\"\r\n\r\nhello world")
            .body_contains("name=\"page\"\r\n\r\n1");
        then.status(200)
            .json_body(serde_json::json!({ "results": [{ "name": "Found", "path": "novel/3" }] }));
    });
    server.mock(|when, then| {
        when.method(GET).path("/novel/1");
        then.status(200).body(
            r#"<html><body><h1>First Novel</h1><span class="author">Jane Doe, John Roe</span>
                <p class="summary"> A summary. </p><img class="cover" src="https://cdn.example/1.jpg">
                <ul><li><a href="chapter/1" data-date="2024-01-02T00:00:00Z">Chapter 1</a></li></ul>
            </body></html>"#,
        );
    });
    server.mock(|when, then| {
        when.method(GET).path("/novel/1/page/2");
        then.status(200).body(
            r#"<ul><li><a href="chapter/2" data-date="Feb 3, 2024 12:30 GMT">Chapter 2</a></li></ul>"#,
        );
    });
    server.mock(|when, then| {
        when.method(GET).path("/chapter/1");
        then.status(200).body(
            r#"<html><head><title>Chapter One</title></head><body><div id="content">
                <div class="text"><p>First paragraph&#8217;s text &amp; more.</p><div class="ad">Buy now!</div>
                <p>Second <b>bold</b> paragraph.</p></div><div>Line one<br>Line two</div><p><img data-src="/img/1.png" src="data:,"></p>
            </div></body></html>"#,
        );
    });
}

fn text_of(paragraph: &Paragraph) -> String {
    match paragraph {
        Paragraph::Text { content, .. } => content.clone(),
        Paragraph::Mixed { content } => content
            .iter()
            .map(|part| match part {
                dion_runtime::data::source::MixedContent::Text { content, .. } => content.clone(),
                _ => String::new(),
            })
            .collect(),
        Paragraph::CustomUI { ui } => match ui.as_ref() {
            dion_runtime::data::custom_ui::CustomUI::Image { image, .. } => {
                format!("[image {}]", image.url)
            }
            _ => String::new(),
        },
        _ => String::new(),
    }
}

#[tokio::test]
async fn installs_and_runs_a_plugin_from_a_repository() {
    let fixture = Fixture::new("e2e").await;
    let adapter = fixture.adapter().await;

    let repo = adapter.get_repo(&fixture.index_url()).await.unwrap();
    assert_eq!(repo.remote_id, fixture.index_url());
    let found = adapter
        .get_remote_extension(&repo, "lnreader.testplugin".into())
        .await
        .unwrap()
        .unwrap();
    assert_eq!(found.lang, vec!["en".to_string()]);

    let extension = install(&fixture, &adapter).await;
    {
        let store = extension.get_data().read().await;
        let data = &store.data;
        assert_eq!(data.id, "lnreader.testplugin");
        assert_eq!(data.name, "Test Plugin");
        assert_eq!(data.version, "1.2.3");
        assert_eq!(data.lang, vec!["en".to_string()]);
        assert_eq!(data.repo.as_deref(), Some(fixture.index_url().as_str()));
        assert!(data.media_type.contains(&MediaType::Book));

        let search = store.settings.get_settings(&SettingKind::Search);
        for id in ["genre", "tags", "tags:exclude", "lnreader:latest"] {
            assert!(search.contains_key(id), "missing search setting {id}");
        }
        let ext = store.settings.get_settings(&SettingKind::Extension);
        assert!(ext.contains_key("hideLocked"));
        assert!(ext.contains_key("lnreader:userAgent"));
    }

    // Settings reach the plugin without a reload: filters through
    // popularNovels, plugin settings through @libs/storage (which this plugin
    // reads in its constructor).
    {
        let mut store = extension.get_data().write().await;
        let settings = &mut store.settings;
        settings
            .set_setting(
                "genre",
                &SettingKind::Search,
                SettingValue::String {
                    data: "fantasy".into(),
                },
            )
            .unwrap();
        settings
            .set_setting(
                "tags:exclude",
                &SettingKind::Search,
                SettingValue::StringList {
                    data: vec!["harem".into()],
                },
            )
            .unwrap();
        settings
            .set_setting(
                "hideLocked",
                &SettingKind::Extension,
                SettingValue::Boolean { data: true },
            )
            .unwrap();
    }
    mock_site(&fixture.server);

    let popular = extension.browse(0, None).await.unwrap();
    assert_eq!(popular.content.len(), 2);
    assert_eq!(popular.hasnext, Some(true));
    let first = &popular.content[0];
    assert_eq!(first.title, "First Novel");
    assert_eq!(first.id.uid, "novel/1");
    assert_eq!(first.url, fixture.server.url("/novel/1"));
    let cover = first.cover.as_ref().unwrap();
    assert_eq!(cover.url, fixture.server.url("/covers/1.jpg"));
    let headers = cover.header.as_ref().unwrap();
    assert_eq!(
        headers.get("Referer"),
        Some(&format!("{}/", fixture.server.base_url()))
    );
    assert!(headers.contains_key("User-Agent"));

    let found = extension
        .search(0, "hello world".into(), None)
        .await
        .unwrap();
    assert_eq!(found.content.len(), 1);
    assert_eq!(found.content[0].id.uid, "novel/3");

    let detail = extension
        .detail(
            EntryId {
                uid: "novel/1".into(),
                iddata: None,
            },
            Default::default(),
            None,
        )
        .await
        .unwrap()
        .entry;
    assert_eq!(detail.titles, vec!["First Novel".to_string()]);
    assert_eq!(
        detail.author,
        Some(vec!["Jane Doe".to_string(), "John Roe".to_string()])
    );
    assert_eq!(detail.description, "A summary.");
    assert_eq!(detail.language, "en");
    assert!(matches!(detail.status, ReleaseStatus::Releasing));
    assert_eq!(
        detail.genres,
        Some(vec!["Fantasy".to_string(), "Action".to_string()])
    );
    // Chapters from parseNovel plus parsePage for page 2.
    let episodes: Vec<&str> = detail.episodes.iter().map(|e| e.name.as_str()).collect();
    assert_eq!(episodes, vec!["Chapter 1", "Chapter 2"]);
    assert_eq!(
        detail.episodes[1].timestamp.map(|t| t.to_rfc3339()),
        Some("2024-02-03T12:30:00+00:00".to_string())
    );
    assert_eq!(detail.episodes[0].url, fixture.server.url("/chapter/1"));

    let source = extension
        .source(
            EpisodeId {
                uid: "chapter/1".into(),
                iddata: None,
            },
            Default::default(),
            None,
        )
        .await
        .unwrap()
        .source;
    let Source::Paragraphlist { paragraphs, .. } = source else {
        panic!("expected a paragraph list, got {source:?}");
    };
    let texts: Vec<String> = paragraphs.iter().map(text_of).collect();
    assert_eq!(
        texts,
        vec![
            "Chapter One".to_string(),
            "First paragraph\u{2019}s text & more.".to_string(),
            "Second bold paragraph.".to_string(),
            "Line one".to_string(),
            "Line two".to_string(),
            format!("[image {}]", fixture.server.url("/img/1.png")),
        ],
        "{paragraphs:?}"
    );
}

#[tokio::test]
async fn installed_plugins_survive_a_restart_and_can_be_uninstalled() {
    let fixture = Fixture::new("restart").await;
    {
        let adapter = fixture.adapter().await;
        install(&fixture, &adapter).await;
    }
    let adapter = fixture.adapter().await;
    let extensions = adapter.get_extensions().await.unwrap();
    assert_eq!(extensions.len(), 1);
    let mut extension = extensions.into_iter().next().unwrap();
    extension.set_enabled(true).await.unwrap();
    assert_eq!(
        extension.get_data().read().await.data.id,
        "lnreader.testplugin"
    );

    adapter.uninstall(&extension).await.unwrap();
    assert!(adapter.get_extensions().await.unwrap().is_empty());
}

#[tokio::test]
async fn installs_a_plugin_from_a_file_without_a_repository() {
    let fixture = Fixture::new("file").await;
    let file: PathBuf = fixture.dir.join("my-plugin.js");
    std::fs::write(&file, PLUGIN.replace("SITE/", "https://novels.example/")).unwrap();
    let adapter = fixture.adapter().await;
    let mut extension = adapter
        .install(&format!("file://{}", file.display()))
        .await
        .unwrap();
    extension.set_enabled(true).await.unwrap();
    let store = extension.get_data().read().await;
    assert_eq!(store.data.id, "lnreader.testplugin");
    // Read from the plugin itself, with its multisrc tag stripped.
    assert_eq!(store.data.name, "Test Plugin");
    assert_eq!(store.data.url, "https://novels.example/");
    assert_eq!(
        store.data.permissions,
        Some(vec![Permission::Network {
            domains: vec!["novels.example".into()]
        }])
    );
    assert!(store.data.repo.is_none());
}

#[tokio::test]
async fn broken_plugins_are_not_installed() {
    let fixture = Fixture::new("broken").await;
    let file = fixture.dir.join("broken.js");
    std::fs::write(&file, "exports.default = 42;").unwrap();
    let adapter = fixture.adapter().await;
    assert!(
        adapter
            .install(&format!("file://{}", file.display()))
            .await
            .is_err()
    );
    assert!(adapter.get_extensions().await.unwrap().is_empty());
    assert!(!plugin_dir_has_files(&fixture.dir.join("plugins")));
}

fn plugin_dir_has_files(dir: &Path) -> bool {
    std::fs::read_dir(dir)
        .map(|mut entries| entries.next().is_some())
        .unwrap_or(false)
}
