//! LNReader plugin adapter for dion-runtime.
//!
//! Runs plugins written for [LNReader](https://github.com/lnreader/lnreader)
//! (see <https://github.com/lnreader/lnreader-plugins>) as Dion extensions,
//! and reads LNReader plugin repositories such as
//! `https://raw.githubusercontent.com/LNReader/lnreader-plugins/plugins/v3.0.0/.dist/plugins.min.json`.
//!
//! ```rust,no_run
//! use dion_runtime::client_data::AdapterClient;
//! use dion_runtime::extension::Adapter;
//! use lnreader_adapter::LnReaderAdapter;
//!
//! async fn example(client: Box<dyn AdapterClient>) -> anyhow::Result<()> {
//!     let adapter = LnReaderAdapter::new(client).await?;
//!     let repo = adapter
//!         .get_repo("https://raw.githubusercontent.com/LNReader/lnreader-plugins/plugins/v3.0.0/.dist/plugins.min.json")
//!         .await?;
//!     let plugins = adapter.browse_repo(&repo, 0).await?;
//!     let mut extension = adapter.install(&plugins.content[0].remote_id).await?;
//!     extension.set_enabled(true).await?;
//!     let popular = extension.browse(0, None).await?;
//!     # let _ = popular;
//!     Ok(())
//! }
//! ```
//!
//! # How plugins map onto Dion
//!
//! | LNReader | Dion |
//! | --- | --- |
//! | `popularNovels(page, { filters, showLatestNovels })` | `browse(page - 1)`, and `search` with an empty query |
//! | `searchNovels(term, page)` | `search(page - 1, term)` |
//! | `parseNovel` (+ `parsePage` for every page when `totalPages` is set) | `detail` |
//! | `parseChapter` (HTML) | `source`, as a `Paragraphlist` |
//! | `filters` | `Search` settings (`<key>`, plus `<key>:exclude` for excludable groups) |
//! | `pluginSettings` | `Extension` settings, visible to the plugin through `@libs/storage` |
//! | `@libs/storage` | a persistent per-plugin cache |
//!
//! Not supported: `fetchProto`, WebView-backed `localStorage`/`sessionStorage`
//! (always empty), and custom reader JS/CSS.

mod adapter;
pub mod plugin;
pub mod repo;

pub use adapter::LnReaderAdapter;
pub use plugin::{PluginInfo, PluginPackage};
pub use repo::{PluginItem, RepoIndex};
