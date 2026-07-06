---
name: create-extension
description: Create and scaffold Dion runtime extensions — TypeScript/JavaScript modules that provide browseable/searchable media entries and playable sources for the Dion runtime. Use this when the user asks to create, scaffold, build, test, or structure a Dion extension, or to understand the Dion extension API (network, parse, settings, auth, permissions, proxy).
---

# Creating Dion Extensions

A Dion **extension** is a bundled JavaScript module that plugs into the Dion runtime
(a Rust host embedding the `boa_engine` JS VM). Extensions provide media content —
"entries" (books, comics, videos, audio) and the "sources" to play/read them — from a website or API or give the ability to transform entries.

This skill tells you how to scaffold, implement, build, test, and package an extension.

## Mental model: how an extension runs

1. Source lives in `src/main.ts` as an ES module with a **`default export` class**.
2. `dion-bundle` (via `bun run build`) compiles `src/main.ts` into a single
   `.dist/<name>.dion.js` file. The first line is a `//<metadata-json>` comment; the rest is the bundled code. The built-in modules (`network`, `parse`, `setting`, `auth`, `permission`, `convert`) are kept **external** (provided by the host at runtime), so the bundle is small and platform-independent.
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
| `extension_type` | `ExtensionType[]` | Declared capabilities. Depend on which interfaces you implement. See `@dion-js/runtime-types/gen/dion_runtime/generated_types.ts` |

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

### Lifecycle

- `load()` — called once after construction, before any other method. Use it to register
  settings/auth. `DionExtension.load()` already registers everything declared in
  `this.settings`/`this.accounts`, binds methods, then calls `onload()`.
- `onload()` — override this (not `load()`) when subclassing `DionExtension` for your own
  one-time setup.
- All data methods are async and may be cancelled; do not block on sync work.

## Built-in modules (provided by the host)

These are **external** — import them, do not bundle them. Ambient types come from
`@dion-js/extension-types`.

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

## Key data types (return these)

All defined in `@dion-js/runtime-types/runtime`. Tagged unions use a `"type"` discriminant.

- `Entry` — `{ id: { uid }, url, title, media_type, cover?, author?, rating?, views?, length? }`.
  `id.uid` must uniquely identify the entry within this extension.
- `EntryList` — `{ content: Entry[], hasnext?: boolean, length?: number }`.
- `EntryDetailed` — full entry: `id, url, titles[], media_type, status, description, language,
  episodes: Episode[], cover?, poster?, genres?, rating?, …`. `status` is `"Releasing" |
  "Complete" | "Unknown"`.
- `Episode` — `{ id: { uid }, name, url, description?, cover?, timestamp? }`.
- `EntryDetailedResult` — `{ entry: EntryDetailed, settings: Record<string, Setting> }`.
  Echo back the `settings` you received (or a transformed copy).
- `Source` — discriminated by `type`: `Epub { link }`, `Pdf { link }`, `Imagelist { links,
  audio? }`, `Video { sources: StreamSource[], sub: Subtitles[] }`, `Audio { sources }`,
  `Paragraphlist { paragraphs: Paragraph[] }`.
- `SourceResult` — `{ source: Source, settings: Record<string, Setting> }`.
- `Link` — `{ url, header?: Record<string,string> }` (use `header` for auth/referer headers
  the player must send).
- `MediaType` — `"Video" | "Comic" | "Audio" | "Book" | "Unknown"`.

See `@dion-js/runtime-types/runtime`

## Settings & auth (use the `runtime-lib` helpers)

Prefer declaring settings/auth on the `DionExtension` subclass rather than calling the raw
`setting`/`auth` modules. From `@dion-js/runtime-lib`:

- `ExtensionSetting<T>` — typed setting with a default, kind (`"Extension" | "Search"`),
  optional `UI` (`.setUI(new Slider(0,10,1))`, `new Checkbox()`, `new Dropdown([...])`,
  `new SettingCustomUI(ui)`), `.setVisible()`, `.setLabel()`. Register by listing it in
  `this.settings`.
- `AuthAccount` — `new AuthAccount(domain, authType, async validateFn)`; list in
  `this.accounts`. `validateFn` returns `{ userName?, profilePic? }`.
- `SettingStore` — read/write the per-call `settings` record handed to `detail`/`source`.

UI builders (`@dion-js/runtime-lib`): `Text`, `Image`, `HyperLink`, `Timestamp`, `Column`,
`Row`, `Card`, `EntryCard`, `Feed`, `Button`, `InlineSetting`, `Slot`, `If`.
`log/logwarn/logerr` (JSON-stringified), `makeurl`, `makeFormdata`, `parseNumberwithSuffix`,
`toStatus`, `encodeURL`, `deduplicate`.

Make sure that the settings are in the right scope: `"Extension"` is for general extension settings, `"Search"` is for per-search settings like categories. The Settings passed to `detail` and `source` are the same for each entry, they are for per entry settings. Always echo back the `settings` in your return values.

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
validates shapes with `assertValidEntries` / `assertValidEntry` / `assertValidSource`
(which also HEAD-check URLs).

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

When asked to create an extension end-to-end:

1. Scaffold (`dion-create` or copy `templates/`), set `name`, `url`, `media_type`, `id`.
2. In `src/main.ts`, subclass `DionExtension` and `implements SourceProvider`.
3. Implement `browse`/`search` (return `EntryList`), `detail` (return `EntryDetailedResult`),
   `source` (return `SourceResult`). Use `network.fetch` + `parse.parseHtml`.
4. Add any settings as `ExtensionSetting<T>` entries in `this.settings`; declare
   `api_version: "*"` unless pinning.
5. Keep `id.uid` values stable and unique; echo `settings` back in results.
6. `bun run build && bun test && bun run check-types && bun run lint`.
7. If packaging a repo, drop the extension under `extensions/` and run `dion-build-index`.

## Common pitfalls

- **Wrong metadata field names.** Use `desc`/`authors`/`tags` (Dion), not
  `description`/`author`/`keywords` (npm) — the latter are ignored for Dion metadata.
- **Forgetting to `build` before `test`.** Tests load the `.dist` bundle.
- **Importing built-in modules as packages.** They are external/ambient — just
  `import { fetch } from "network";`. Make sure `@dion-js/extension-types` is in
  `devDependencies` for the types.
- **Methods not returning Promises.** The host awaits a `.then`-able; a sync return throws
  "didn't return a Promise".
- **Non-JSON-serialisable values in return data** (functions, symbols, circular refs) — they
  cross the boundary as JSON.
- **Unstable `id.uid`.** Changing it breaks users' saved libraries/progress.
- **Dropping `settings` from a `*Result`.** Always include the `settings` map.
- **Hardcoding secrets.** Use `auth`/`getAuthSecret`, never bake credentials into the bundle.
