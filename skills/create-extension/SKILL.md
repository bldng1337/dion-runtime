---
name: create-extension
description: Create and scaffold Dion runtime extensions — TypeScript/JavaScript modules that provide browseable/searchable media/sources, trackers, and other functionality for the Dion runtime. Use this when the user asks to create, scaffold, build, test, or structure a Dion extension, or to understand the Dion extension API.
---
# Creating Dion Extensions

A Dion **extension** is a bundled JavaScript module that plugs into the Dion runtime
(a Rust host embedding the `boa_engine` JS VM). Extensions provide media content
"entries" (books, comics, videos, audio) and the "sources" to play/read them from a website or API or give the ability to transform entries.

This skill tells you how to scaffold, implement, build, test, and package an extension.

## Mental model: how an extension runs
1. Source lives in `src/main.ts` as an ES module with a **`default export` class**.
2. `dion-bundle` (via `bun run build`) compiles `src/main.ts` into a single
   `.dist/<name>.dion.js` file. The first line is a `//<metadata-json>` comment; the rest is the bundled code. The built-in modules (`network`, `parse`, `setting`, `auth`, `permission`, `convert`) are kept **external** (provided by the host at runtime), so the bundle is small.
3. At runtime the host:
   - reads the metadata comment, checks `api_version` compatibility,
   - parses the module, instantiates the default-exported class,
   - calls `load()` once if present,
   - then calls interface methods (`browse`, `search`, `detail`, `source`, …) as needed, each of which **must return a Promise**.

Everything crosses the JS↔Rust boundary as JSON, so return plain JSON-serialisable objects.

## Scaffolding
The `@dion-js/extension-scripts` package ships a `dion-create` CLI. Run interactively or non-interactively:

```sh
bunx dion-create                      # interactive prompts
bunx dion-create ./extensions/my-ext  # create at a path
bunx dion-create -y --name my-ext --media Book --url https://example.com
```

Flags: `--name/-n`, `--description`, `--url`, `--author`, `--icon`, `--keywords`
(comma-separated), `--media` (comma-separated: `Video,Comic,Audio,Book,Unknown`), `-y/--yes` (non-interactive with defaults). It generates `package.json`, `tsconfig.json`, `biome.json`, `src/main.ts`, and `src/main.test.ts`. Follow the printed next steps: `bun install`.

## `package.json` — the extension manifest

`package.json` doubles as the **Dion metadata manifest**. At bundle time `dion-bundle` reads it, validates the Dion fields, and writes them into the `//<metadata>` header. The canonical Dion field names come from the `ExtensionMetadata` schema — **note these differ from the npm-standard names** (`desc` not `description`, `authors` not `author`, `tags` not `keywords`). The npm-standard fields are harmless but **ignored** for Dion metadata.

Required Dion fields (validation fails without these):
| Field | Type | Notes |
|---|---|---|
| `id` | string | Stable unique id. `dion-create` generates a UUID. |
| `name` | string | Display name. |
| `url` | string | The source website the extension talks to. |
| `icon` | string | Icon URL. |
| `version` | string | Semver-ish version, e.g. `1.0.0`. |
| `license` | string | SPDX string, e.g. `MIT`, `ISC`. |
| `api_version` | string | **Semver requirement** matched against the host runtime version. Use `"*"` unless you need to pin a host range (e.g. `">=1.0.0"`). A mismatch marks the extension `compatible: false`. |
| `nsfw` | boolean | Mark adult content. |
| `media_type` | `MediaType[]` | Any of: `Video`, `Comic`, `Audio`, `Book`, `Unknown`. |
| `extension_type` | `ExtensionType[]` | Declared capabilities. **Hand-authored** — `dion-bundle` does not derive it from your code, it copies whatever you write here into the metadata. The app uses it to filter/show extensions; an empty array (`[]`, the scaffold default) is treated as "provides everything". Variants and how they map to interfaces are listed below. Full schema in `@dion-js/runtime-types/runtime`. |

Optional Dion fields: `desc` (string), `authors` (string[]), `tags` (string[]),
`lang` (string[]), `repo` (string — usually auto-filled from git), `settings`, `accounts`.

Also required by the tooling: `"type": "module"`, `"private": true`, and the standard `scripts` block:

```json
"scripts": {
  "test": "bun test",
  "lint": "bunx biome check",
  "format": "bunx biome format --write",
  "build": "bunx dion-bundle",
  "check-types": "bunx tsc --noEmit"
}
```

Typical dependencies (use `catalog:` inside the Dion workspace, concrete versions outside):

- `@dion-js/runtime-lib` — the `DionExtension` base class + helpers (settings, auth, ui).
- `@dion-js/runtime-types` — runtime + extension type definitions (data shapes, interfaces).
- `@dion-js/extension-types` — ambient declarations for the built-in modules.
- `valibot`, `@biomejs/biome`, `typescript`, `@types/bun`.
- dev: `@dion-js/runtime` (native test runtime), `@dion-js/extension-test-utils` (test helpers).

## The extension class & interfaces

An extension is a class that `implements` one or more interfaces from
`@dion-js/runtime-types/extension`. Subclass `DionExtension` from `@dion-js/runtime-lib` to
get settings/auth registration and lifecycle wiring for free.

```ts
import { DionExtension } from "@dion-js/runtime-lib";
import { SourceProvider } from "@dion-js/runtime-types/extension";
import type {
  EntryDetailedResult, EntryId, EntryList, EpisodeId,
  EventData, EventResult, Setting, SourceResult,
} from "@dion-js/runtime-types/runtime";

export default class extends DionExtension implements SourceProvider {
  settings = {};          // declare ExtensionSetting<T> entries here
  accounts = {};          // declare AuthAccount entries here

  async onEvent(_data: EventData): Promise<EventResult | undefined> { return undefined; }

  async browse(page: number): Promise<EntryList> { /* … */ }
  async search(page: number, filter: string): Promise<EntryList> { /* … */ }
  async detail(entryid: EntryId, settings: Record<string, Setting>): Promise<EntryDetailedResult> { /* … */ }
  async source(epid: EpisodeId, settings: Record<string, Setting>): Promise<SourceResult> { /* … */ }
  async handleUrl?(url: string): Promise<boolean> { return false; }
}
```

### Interfaces (what you can implement)

| Interface | Methods | Purpose |
|---|---|---|
| `Extension` (base, always) | `onEvent`, `validate`, optional `handleProxy` | Lifecycle, auth validation, HTTP proxy interception. |
| `SourceProvider` | `browse`, `search`, `detail`, `source`, optional `handleUrl` | The common case: provide entries + sources from a site. |
| `EntryExtension` | optional `mapEntry`, `onEntryActivity` | Post-process/transform entries another provider returned. |
| `SourceProcessorExtension` | `mapSource` | Transform/rewrite a source another provider returned. |

Method-name spellings matter exactly — the host dispatches by name
(`browse`, `search`, `detail`, `source`, `mapEntry`, `onEntryActivity`, `mapSource`,
`handleUrl`, `handleProxy`, `onEvent`, `validate`, `load`). Use the TypeScript interfaces to get the correct signatures.

### Declaring `extension_type`
`extension_type` is a tagged union discriminated by `type`. Declare the variants matching the interfaces you implement (you can list more than one). The host does **not** infer these from your methods, so an unlisted capability won't be exposed.

| Variant | Fields | Declare when you implement |
|---|---|---|
| `EntryProvider` | `has_search: boolean` | `SourceProvider` (set `has_search` to whether search is meaningfully supported). |
| `SourceProcessor` | `sourcetypes: SourceType[]`, `opentype: SourceOpenType[]` (`"Download"`/`"Stream"`); opentype handles if the extension gets called for streamed in sources or only applies to downloading jobs, use download for longer running jobs and stream for quicker things that the user wants to have in general | `SourceProcessorExtension` (`mapSource`). |
| `EntryProcessor` | `trigger_map_entry: boolean`, `trigger_on_entry_activity: boolean`; these two denote if this extension 1. wants to rewrite EntryDetailed data of the Entries its attached to and for trigger_on_entry_activity if it wants to be notified if the user has read/watched/listened to an episode of this Entry (useful for tracking type extensions) | `EntryExtension` (`mapEntry` / `onEntryActivity`). |
| `URLHandler` | `url_patterns: string[]`; url_patterns denotes on what url patterns the extension gets invoked | `handleUrl`. |

Example: a `SourceProvider` with search and url-opening capabilities:
```json
"extension_type": [
  { "type": "EntryProvider", "has_search": true },
  { "type": "URLHandler", "url_patterns": ["https://example.com/entry/*"] }
]
```

### Lifecycle

- `load()` — called once after construction, before any other method. Use it to register
  settings/auth. `DionExtension.load()` already registers everything declared in
  `this.settings`/`this.accounts`, binds methods, then calls `onload()`.
- `onload()` — override this (not `load()`) when subclassing `DionExtension` for your own
  one-time setup.
- All data methods are async and may be cancelled; do not block on sync work.

## Built-in modules (provided by the host)

These are **external** — import them, do not bundle them. Ambient types come from
`@dion-js/extension-types`; look there for full signatures and data types.

- `network` — `fetch(url, options?)`, `getCookies()`, `getProxyAddress()`. `fetch` returns a
  `DionResponse` with `status`, `headers`, `body` (string), `json`, `ok`. Cookies are managed
  automatically by the host's cookie jar.
- `parse` — `parseHtml(input)`, `parseHtmlFragment(input)`. Returns a `DionElement` tree
  with jQuery-like `select(new CSSSelector("div.foo"))`, `attr`, `children`, `text`,
  `paragraphs`. `DionElementArray` supports `map/filter/get/first/length`.
- `setting` — `getSetting(id, kind)`, `registerSetting(id, setting, kind)`,
  `setEntrySetting(entry, key, value)`. `kind` is `"Extension" | "Search"`. Prefer the typed
  helpers in `@dion-js/runtime-lib` (`ExtensionSetting`, `SettingStore`).
- `auth` — `mergeAuth(account)`, `isLoggedIn(domain)`, `invalidate(domain)`,
  `getAuthSecret(domain)`. Prefer `AuthAccount` from `runtime-lib`.
- `permission` — `requestPermission(permission, msg?)`, `hasPermission(permission)`.
  `Permission` is a tagged union: `{ type:"Network", domains }`, `{ type:"Storage", path, write }`,
  `{ type:"ArbitraryNetwork" }`, `{ type:"ActionPopup" }`.
- `convert` — `encodeBase64(str)`, `decodeBase64(str)`. (`btoa`/`atob` are also available.)
- `console` — `log/error/warn/info/debug`.
- global `appdata` — `{ app, version, platform }`.

For full signatures and the data types they use look at `@dion-js/extension-types`.

## Proxy handling
The host runs an HTTP proxy and routes requests that target an extension's proxy path to its `handleProxy(request)`. Implement it only if you need to intercept/rewrite traffic. It **must** return a `ProxyResponse`: `{ type: "response", status, headers, body? }` to answer directly, or `{ type: "redirect", request: ProxyRequest }` to re-issue the request (optionally modified) — a `redirect` forwarding the original request is how you "pass through" unmodified. Get the address to send your own requests through via `network.getProxyAddress()`. `ProxyRequest`/`ProxyResponse` are defined in `@dion-js/runtime-types/extension`.

## Key data types (return these)

All defined in `@dion-js/runtime-types/runtime` read the ts types to get the most up to date schema. Tagged unions use a `"type"` discriminant. Below are some notes to pay attention to when implementing your extension:
- `Entry`: `id.uid` must uniquely identify the entry within this extension.
- `EntryDetailed`: `id.uid` must match with the `Entry`.
- `EntryDetailedResult`: Echo back the `settings` you received (or a transformed copy).
- `Source`: discriminated by `type`: Epub, Pdf, Imagelist, Video, Audio, Paragraphlist
- `SourceResult`: Echo back the `settings` you received (or a transformed copy). The host threads the **same** per-entry `settings` object from `detail` into `source`, so any change you return from `detail` is what `source` receives for that entry. Always echo `settings` back in both return values.
- `Link`:use `header` for auth/referer headers the player must send.

See `@dion-js/runtime-types/runtime`

## Settings & auth (use the `runtime-lib` helpers)
Prefer declaring settings/auth on the `DionExtension` subclass rather than calling the raw
`setting`/`auth` modules. From `@dion-js/runtime-lib` read the types to get the most up to date schema.
- `ExtensionSetting<T>` — typed setting with a default, kind (`"Extension" | "Search"`),
  optional `UI` (`.setUI(new Slider(0,10,1))`, `new Checkbox()`, `new Dropdown([...])`,
  `new SettingCustomUI(ui)`), `.setVisible()`, `.setLabel()`. Register by listing it in
  `this.settings`. `kind` denotes if the Setting is shown in the extension settings or in the search filter UI. e.g. for categories, use `"Search"`.
- `AuthAccount` — `new AuthAccount(domain, authType, async validateFn)`; list in
  `this.accounts`. `validateFn` returns `{ userName?, profilePic? }` and validates if the account is valid.
- `SettingStore` — read/write the per-call `settings` record handed to `detail`/`source`.
The Settings passed to `detail` and `source` are the same for each entry, they are for per entry settings. Always echo back the `settings` in your return values.

## Custom UI
A `CustomUI` is a declarative, JSON-serializable UI tree that your extension returns for the app to render. You can attach a `CustomUI` anywhere the runtime accepts one. Common use cases include:
- The `UI` field of an `ExtensionSetting`, for specialized setting controls that don’t fit the built-in options.
- The `UI` field of an `EntryDetailed`, to display additional information from the source (such as recommended entries, characters, etc.).
- Custom UI within a `ParagraphList` source.
- Using `Popup` or `Nav` actions to display a custom UI in a modal or fullscreen view.

The runtime renders the UI tree and routes any UI events back to the extension’s `onEvent` method.
Build nodes with the helper functions from `@dion-js/runtime-lib/ui` rather than writing the raw objects — every helper returns the correct tagged-union shape. 
Nodes split into:
- **Leaf**: `Text`, `Timestamp`, `Image`, `Link`, `Spinner`, `EntryCard`,
  `Card(image, top, bottom)`.
- **Container**: `Column(...)`, `Row(...)` — both filter out `undefined`
  children, so `cond ? node : undefined` is the idiomatic conditional.
- **Interactive**: `Button(label, onClick)`, `InlineSetting(id, kind, onCommit)`,
  `Feed(event, data)` (lazy-paginated list), and `Slot(id, child, onMount)`
  (a swappable placeholder).

Buttons carry a `UIAction` built either with `Do(action)` for a one-shot
`Action` (`OpenBrowser`, `TriggerEvent`, `Nav`, `NavEntry`, `Popup`) or with
`SwapContent(targetId, event, data)` to ask the runtime to replace a `Slot`'s
contents. The runtime routes the resulting `EventData` back to the extension's
`onEvent`, which `DionExtension` already implements: `SwapContent`/`FeedUpdate`
events go to entries in `this.regions`, and everything else goes to
`this.triggers`. Prefer the `runtime-lib` abstractions over hand-writing events:
- `SwapRegion<E>` — binds a `Slot` id to a typed map of handlers; `.build()`
  emits the slot (optionally auto-firing an event on mount), `.swap(event, data)`
  returns a typed `UIAction` for buttons, and the handler's return value becomes
  the slot's new content. Annotate handler parameters so TypeScript infers the
  `EventMap`.
- `FeedRegion<D>` — wraps a `Feed` with an `onPage(data, page)` handler that
  returns `{ items, hasNext }`; the runtime requests pages as the user scrolls.
- `Trigger<E>` — a standalone event handler listed in `this.triggers`; use its
  `.trigger(data)` to produce the `EventData`/`UIAction` you attach to a button.

## Build, test, lint
Run inside the extension directory:

```sh
bun install
bun run build          # dion-bundle -> .dist/<name>.dion.js
bun test               # runs src/*.test.ts via bun:test
bun run check-types    # tsc --noEmit
bun run lint           # biome check
bun run format         # biome format --write
```

The test loads the **built** extension through the real native runtime
(`@dion-js/runtime`'s `Adapter` + a `MockManagerClient` from
`@dion-js/extension-test-utils`), so always `bun run build` before `bun test`. The template
`main.test.ts` exercises the full flow: enable → browse → search → detail → source, and
validates shapes with `assertValidEntries` / `assertValidEntry` / `assertValidSource`.

## Extension repositories
An extension **repository** is a directory of built extensions plus a generated index. Repo
layout (built from the repo root, not an individual extension):

```
my-repo/
├── package.json          # repo metadata: name, url, description, icon
└── extensions/
    ├── ext-a/            # each is a full extension project (has its own .dist)
    └── ext-b/
```

Build each extension first (`extensions/<name>/.dist/<name>.dion.js`), then from the repo
root run `dion-build-index`. It copies each built file into `.index/<name>.dion.js` and
writes `.index/index.repo.json` (schema `DionRepoIndex`: `repo_index_version: 1`, repo
fields, and `content: [{ path, extdata }]`). The repo `url` is read from the repo
`package.json` (falling back to `git remote get-url origin`).

## Worked example checklist

When asked to create an extension for a site end-to-end:
1. **Research**: Look at the site, use curl or browser devtools to see: the type of content, the URL patterns, the HTML structure or API endpoints, any auth requirements. Think about how to best expose the content as Extension as good as possible. Think about what settings (extension, entry, search), auth, and custom UI you might want to expose.
2. **Scaffold**: Run `dion-create` to generate the extension skeleton.
3. **Implement**: Fill in the `browse`, `search`, `detail`, and `source` methods, plus any settings/auth/custom UI. Use `network.fetch` and `parse.parseHtml` to get and parse the content. Use `this.settings` and `this.accounts` to register settings and auth. Use `DionExtension` helpers for settings/auth/custom UI.
4. **Build & test**: Run `bun run build && bun test && bun run check-types && bun run lint`. Fix any errors. If you made any custom UI or special edgecases/functions, write tests for them in `src/main.test.ts`.
