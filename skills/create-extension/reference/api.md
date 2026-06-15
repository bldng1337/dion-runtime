# Dion Extension API Reference

Authoritative reference for the Dion extension API. Source of truth in the repo:
`js/extension_types/index.d.ts` (ambient module types), `js/runtime_types/gen/` (generated
data types + interfaces), `js/lib/src/` (`runtime-lib` helpers), and the Rust definitions
under `rust/core/src/data/` and `rust/dion_extension/`.

## How the host calls an extension

At load the host: parses the module → constructs the `default export` class → calls
`load()` if it exists → stores the instance as `__plugin`. Each capability is then a method
lookup by **exact name** on that instance, invoked with JSON-serialised args, and the return
value must be a Promise that resolves to JSON-serialisable data.

| Task (Rust) | JS method called | Args | Returns |
|---|---|---|---|
| load | `load` | — | `void`/Promise |
| Validate | `validate` | `(account: Account)` | `Account \| undefined` |
| Browse | `browse` | `(page: number)` | `EntryList` |
| Search | `search` | `(page: number, filter: string)` | `EntryList` |
| Detail | `detail` | `(entryid, settings)` | `EntryDetailedResult` |
| Source | `source` | `(epid, settings)` | `SourceResult` |
| MapEntry | `mapEntry` | `(entry, settings)` | `EntryDetailedResult` |
| OnEntryActivity | `onEntryActivity` | `(activity, entry, settings)` | `void` |
| ProcessSource | `mapSource` | `(source, epid, settings)` | `SourceResult` |
| HandleUrl | `handleUrl` | `(url: string)` | `boolean` |
| Event | `onEvent` | `(data: EventData)` | `EventResult \| undefined` |
| HandleProxy | `handleProxy` | `(request: ProxyRequest)` | `ProxyResponse` |

`settings` passed to `detail`/`source`/`mapEntry`/`mapSource`/`onEntryActivity` is a
`Record<string, Setting>` containing the resolved settings for that call.

## Interfaces (`@dion-js/runtime-types/extension`)

```ts
interface Extension {                       // base — always implemented
  onEvent(data: EventData): Promise<EventResult | undefined>;
  handleProxy?(request: ProxyRequest): Promise<ProxyResponse>;
  validate(acc: Account): Promise<Account | undefined>;
}

interface SourceProvider {                  // provide entries + sources
  browse(page: number): Promise<EntryList>;
  search(page: number, filter: string): Promise<EntryList>;
  detail(entryid: EntryId, settings: Record<string, Setting>): Promise<EntryDetailedResult>;
  source(epid: EpisodeId, settings: Record<string, Setting>): Promise<SourceResult>;
  handleUrl?(url: string): Promise<boolean>;
}

interface EntryExtension {                  // post-process entries
  mapEntry?(entry: EntryDetailed, settings: Record<string, Setting>): Promise<EntryDetailedResult>;
  onEntryActivity?(activity: EntryActivity, entry: EntryDetailed, settings: Record<string, Setting>): Promise<void>;
}

interface SourceProcessorExtension {        // transform sources
  mapSource(source: Source, epid: EpisodeId, settings: Record<string, Setting>): Promise<SourceResult>;
}
```

## Built-in modules (ambient; types from `@dion-js/extension-types`)

### `network`
```ts
function fetch(url: string, option?: Requestoptions): Promise<DionResponse>;
function getCookies(): Cookie[];
function getProxyAddress(): Promise<string | undefined>;

interface Requestoptions {
  method?: "GET"|"HEAD"|"POST"|"PUT"|"DELETE"|"CONNECT"|"TRACE"|"PATCH";
  headers?: Record<string, string>;
  body?: string;
}
interface DionResponse {
  status: number; headers: Record<string, string>; body: string;
  json: unknown; ok: boolean;
}
interface Cookie { name: string; value: string; }
```
Cookies are persisted in the host cookie jar across `fetch` calls. Use `header` on a `Link`
when the *player* (not your `fetch`) needs auth/referer headers.

### `parse`
```ts
function parseHtml(input: string): DionElement;
function parseHtmlFragment(input: string): DionElement;

interface DionElement {
  attr(name: string): string;
  select(selector: CSSSelector): DionElementArray;
  parent: DionElement | undefined;
  children: DionElementArray;
  text: string;
  paragraphs: Paragraph[];
  name: string;
}
interface DionElementArray {
  select(selector: CSSSelector): DionElementArray;
  attr(name: string): string[];
  get(index: number): DionElement | undefined;
  map<T>(cb: (el: DionElement) => T): T[];
  filter(cb: (el: DionElement) => boolean): DionElementArray;
  first: DionElement | undefined;
  length: number;
  text: string;
  paragraphs: Paragraph[];
}
class CSSSelector { constructor(selector: string); } // e.g. "div.card a.title"
```

### `setting`
```ts
type SettingKind = "Extension" | "Search";
function getSetting(id: string, kind: SettingKind): Promise<Setting>;
function registerSetting(id: string, setting: Setting, kind: SettingKind): Promise<void>;
function setEntrySetting(entry: EntryId, key: string, value: SettingValue): Promise<void>;
```

### `auth`
```ts
function mergeAuth(account: Account): Promise<void>;            // register/update auth type
function isLoggedIn(domain: string): Promise<boolean>;
function invalidate(domain: string): Promise<void>;
function getAuthSecret(domain: string): Promise<AuthCreds>;     // throws if not logged in
```

### `permission`
```ts
function requestPermission(permission: Permission, msg?: string): Promise<boolean>;
function hasPermission(permission: Permission): Promise<boolean>;

type Permission =
  | { type: "Network"; domains: string[] }
  | { type: "Storage"; path: string; write?: boolean }
  | { type: "ArbitraryNetwork" }
  | { type: "ActionPopup" };
```

### `convert`
```ts
function encodeBase64(input: string): string;
function decodeBase64(input: string): string;
// btoa()/atob() are also available globally.
```

### globals
```ts
declare const appdata: { app: string; version: string; platform: string };
declare var console: { log/error/warn/info/debug(...args: any[]): void };
```

## Data types (`@dion-js/runtime-types/runtime`)

All optional fields are sent as `null` over JSON (the host uses serde `Option`).

### IDs & lists
```ts
interface EntryId   { uid: string; iddata?: string }
interface EpisodeId { uid: string; iddata?: string }
interface EntryList { content: Entry[]; hasnext?: boolean | null; length?: number | null }
```

### Entry
```ts
type MediaType = "Video" | "Comic" | "Audio" | "Book" | "Unknown";

interface Link { url: string; header?: Record<string,string> | null }

interface Entry {
  id: EntryId; url: string; title: string; media_type: MediaType;
  cover?: Link | null; author?: string[] | null;
  rating?: number | null; views?: number | null; length?: number | null;
}
```

### EntryDetailed
```ts
type ReleaseStatus = "Releasing" | "Complete" | "Unknown";

interface Episode {
  id: EpisodeId; name: string; url: string;
  description?: string | null; cover?: Link | null; timestamp?: string | null;
}

interface EntryDetailed {
  id: EntryId; url: string; titles: string[]; media_type: MediaType;
  status: ReleaseStatus; description: string; language: string;
  episodes: Episode[];
  author?: string[] | null; ui?: CustomUI | null; meta?: Record<string,string> | null;
  cover?: Link | null; poster?: Link | null;
  genres?: string[] | null; rating?: number | null; views?: number | null; length?: number | null;
}

interface EntryDetailedResult { entry: EntryDetailed; settings: Record<string, Setting> }
```

### Source
```ts
type SourceType = "Epub" | "Pdf" | "Imagelist" | "Video" | "Audio" | "Paragraphlist";

interface StreamSource { name: string; lang: string; url: Link }
interface Subtitles     { title: string; lang: string; url: Link }
interface ImageListAudio{ link: Link; from: number; to: number }

type Source =
  | { type: "Epub";   link: Link }
  | { type: "Pdf";    link: Link }
  | { type: "Imagelist"; links: Link[]; audio?: ImageListAudio[] | null }
  | { type: "Video";  sources: StreamSource[]; sub: Subtitles[] }
  | { type: "Audio";  sources: StreamSource[] }
  | { type: "Paragraphlist"; paragraphs: Paragraph[] };

interface SourceResult { source: Source; settings: Record<string, Setting> }
```

### Paragraph / MixedContent (for `Paragraphlist` sources and rich text)
```ts
interface TextStyle { bold?; italic?; underline?; strikethrough?; code?; link?: string; font_size?: number }

type Paragraph =
  | { type: "Text"; content: string; style?: TextStyle | null }
  | { type: "Mixed"; content: MixedContent[] }
  | { type: "CustomUI"; ui: CustomUI }
  | { type: "Table"; columns: Row[] };     // Row = { cells: Paragraph[] }

type MixedContent =
  | { type: "Text"; content: string; style?: TextStyle | null }
  | { type: "CustomUI"; ui: CustomUI }
  | { type: "Table"; columns: Row[] };
```
Note: `parseHtml` elements expose `.paragraphs: Paragraph[]` so you can convert HTML straight
into a `Paragraphlist` source.

### Settings
```ts
type SettingValue =
  | { type: "String";     data: string }
  | { type: "Number";     data: number }
  | { type: "Boolean";    data: boolean }
  | { type: "StringList"; data: string[] };

type SettingsUI =
  | { type: "CheckBox" }
  | { type: "Slider"; min: number; max: number; step: number }
  | { type: "Dropdown"; options: { label: string; value: string }[] }
  | { type: "MultiDropdown"; options: { label: string; value: string }[] }
  | { type: "CustomUI"; ui: CustomUI };

interface Setting {
  label: string; value: SettingValue; default: SettingValue; visible: boolean;
  ui?: SettingsUI | null;
}
```

### Auth
```ts
type AuthData =
  | { type: "Cookie"; loginpage: string; logonpage: string }
  | { type: "ApiKey" }
  | { type: "UserPass" }
  | { type: "OAuth"; authorization_url: string; token_url?: string | null;
      client_id: string; client_secret: string; scope?: string | null };

type AuthCreds =
  | { type: "Cookies"; cookies: Record<string, string[]> }
  | { type: "ApiKey"; key: string }
  | { type: "UserPass"; username: string; password: string }
  | { type: "OAuth"; access_token: string; refresh_token?: string | null; expires_at?: number | null };

interface Account { domain: string; auth: AuthData; user_name?: string | null;
  cover?: string | null; creds?: AuthCreds | null }
```

### CustomUI, Actions, Events
```ts
type CustomUI =
  | { type: "Text"; text: string }
  | { type: "Image"; image: Link; width?: number | null; height?: number | null }
  | { type: "Link"; link: string; label?: string | null }
  | { type: "TimeStamp"; timestamp: string; display?: "Relative" | "Absolute" }
  | { type: "EntryCard"; entry: Entry }
  | { type: "Card"; image: Link; top: CustomUI; bottom: CustomUI }
  | { type: "Feed"; event: string; data: string }
  | { type: "Button"; label: string; on_click?: UIAction | null }
  | { type: "InlineSetting"; setting_id: string; setting_kind: SettingKind; on_commit?: UIAction | null }
  | { type: "Slot"; id: string; child: CustomUI }
  | { type: "Column"; children: CustomUI[] }
  | { type: "Row"; children: CustomUI[] };

type Action =
  | { type: "OpenBrowser"; url: string }
  | { type: "Popup"; title: string; content: CustomUI; actions: { label: string; onclick: Action }[] }
  | { type: "Nav"; title: string; content: CustomUI }
  | { type: "TriggerEvent"; event: string; data: string }
  | { type: "NavEntry"; entry: EntryDetailed };

type UIAction =
  | { type: "Action"; action: Action }
  | { type: "SwapContent"; targetid: string; event: string; data: string; placeholder?: CustomUI | null };

type EventData =
  | { type: "SwapContent"; event: string; targetid: string; data: string }
  | { type: "FeedUpdate"; event: string; data: string; page: number }
  | { type: "Action"; event: string; data: string };

type EventResult =
  | { type: "SwapContent"; customui: CustomUI }
  | { type: "FeedUpdate"; customui: CustomUI[]; hasnext?: boolean | null; length?: number | null };

type EntryActivity = { type: "EpisodeActivity"; progress: number };
```

### Proxy
```ts
interface ProxyRequest {
  method: "GET"|"HEAD"|"POST"|"PUT"|"DELETE"|"CONNECT"|"TRACE"|"PATCH";
  uri: string; version: 10 | 11 | 2 | 3;
  headers: Record<string, string[]>; body?: string;
}
type ProxyResponse =
  | { type: "redirect"; request: ProxyRequest }
  | { type: "response"; status: number; headers: Record<string, string[]>; body?: string };
```
`handleProxy` lets an extension intercept/rewrite HTTP traffic the *player* makes (e.g.
inject headers, redirect to a tokenised URL, or synthesise a response). Header values are
arrays of strings.

## `runtime-lib` helpers (`@dion-js/runtime-lib`)

### Base class
```ts
abstract class DionExtension implements Extension {
  abstract settings: Record<string, ExtensionSetting<any>>;
  abstract accounts: Record<string, AuthAccount>;
  abstract onEvent(data: EventData): Promise<EventResult | undefined>;
  handleProxy?(request: ProxyRequest): Promise<ProxyResponse>;
  async validate(acc: Account): Promise<Account | undefined>;   // default: route via accounts
  async load(): Promise<void>;        // registers settings/accounts, binds methods, calls onload()
  async onload(): Promise<void>;      // override for one-time setup
}
```

### Settings helpers
```ts
class ExtensionSetting<T> {            // T: string | number | boolean
  constructor(id: string, defaultvalue: T, type: SettingKind);
  setUI(ui: UI<T>): this;              // Slider | Checkbox | Dropdown | SettingCustomUI
  setVisible(visible: boolean): this;
  setLabel(label: string): this;
  getDefinition(): Setting;
  register(): Promise<void>;
  get(): Promise<T>;                   // falls back to default on error
}

class SettingStore {                   // wraps the per-call `settings` record
  constructor(settings: Record<string, Setting>);
  getOrDefine<T>(opts: { id; defaultval: T; label?; visible?; ui? }): T;  // define-if-missing
  inherit<T>(ext: ExtensionSetting<T>): Promise<T>;                       // merge with ext definition
  get<T>(id: string): T; tryGet<T>(id: string): T | undefined;
  toMap(): Record<string, Setting>;
}

abstract class UI<T> { /* getDefinition(); fitsDefinition() */ }
class Slider extends UI<number>          { constructor(min, max, step) }
class Checkbox extends UI<boolean>
class Dropdown extends UI<string>        { constructor(options: {value,label}[]) }
class SettingCustomUI<T> extends UI<T>   { constructor(ui: CustomUI) }
```

### Auth helper
```ts
class AuthAccount {
  constructor(domain: string, authType: AuthData,
              validate: (acc: AuthAccount) => Promise<{ userName?: string; profilePic?: string }>);
  getDefinition(): Account;
  register(): Promise<void>; isLoggedIn(): Promise<boolean>;
  invalidate(): Promise<void>; getAuthSecret(): Promise<AuthCreds | undefined>;
}
```
`DionExtension.validate` iterates `this.accounts`, matches `domain` + `auth.type`, calls the
account's `validate`, and returns `{ ...definition, user_name, cover }`.

### UI builders + utils
```ts
// ui.ts
Text(text); Image(link, w?, h?); HyperLink(url, label?); Timestamp(ts, display?="Relative");
Column(...children); Row(...children); Card(image, top, bottom); EntryCard(entry);
Feed(event, data); Button(label, on_click?=null); InlineSetting(id, kind, on_commit?=null);
Slot(id, child); If(condition, ui);

// util.ts
log(...a); logwarn(...a); logerr(...a);          // JSON-stringified
encodeURL(s); deduplicate(arr); makeurl(base, query, sep="&"); makeFormdata(data, sep="&");
parseNumberwithSuffix(s, def?): number | undefined;   // "1.2K" -> 1200
toStatus(s): ReleaseStatus; trywrap<T>(fn): T | undefined;

// asserts.ts
assert(cond, msg?); assertDefined(v, msg?); getAssertDefined(v, msg?);
assertisArray(v, msg?); getAssertisArray(v, msg?);
```

## Test helpers (`@dion-js/extension-test-utils`)

```ts
class MockManagerClient {
  constructor(managerpath: string = ".");   // path to the dir containing .dist/<name>.dion.js
  client: ManagerClient;                    // pass to Adapter.init()
}
async function getTestExtension(client: ManagerClient): Promise<Extension>;
async function assertValidEntries(entries: (Entry|EntryDetailed)[]);   // HEAD-checks URLs
async function assertValidEntry(entry: Entry|EntryDetailed);
async function assertValidSource(source: Source);                      // incl. m3u8 for Video
async function assertValidURL(link: Link); async function assertValidImageURL(link: Link);
async function assertValidM3U8(link: Link);
function wait(ms): Promise<void>; function ratelimit(ms): Promise<void>;
```

A minimal test pattern (full version in `templates/main.test.ts`):

```ts
import { beforeAll, describe, expect, it } from "bun:test";
import { MockManagerClient, getTestExtension, assertValidEntries } from "@dion-js/extension-test-utils";
import type { Extension } from "@dion-js/runtime";
import { join } from "node:path";

let extension: Extension;
beforeAll(async () => {
  const client = new MockManagerClient(join(import.meta.path, "../../.dist"));
  extension = await getTestExtension(client.client);
  await extension.setEnabled(true);
});
describe("Extension", () => {
  it("browses", async () => {
    const res = await extension.browse(0);
    expect(res.content.length).toBeGreaterThan(0);
    await assertValidEntries(res.content);
  });
});
```

For extensions that need a backend, start a `Bun.serve` mock and push its URL into a setting
before enabling:

```ts
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
const server = Bun.serve({ port: 0, fetch: /* routes */ });
const mock = new MockManagerClient(join(import.meta.path, "../../.dist"));
const manager = await Adapter.init(mock.client);
const ext = (await manager.getExtensions())[0]!;
await ext.mergeSettingDefinition("backend", "Extension", {
  visible: false, label: "Backend",
  default: { type: "String", data: server.url.toString() },
  value:   { type: "String", data: server.url.toString() },
});
await ext.setEnabled(true);
```

## Metadata schema (valibot `ExtensionMetadata`)

Required: `id, name, url, icon, version, license, api_version` (strings),
`nsfw` (bool), `media_type` (`MediaType[]`), `extension_type` (`ExtensionType[]`).
Optional: `desc`, `authors`, `tags`, `lang`, `repo`, `settings`, `accounts`.

`ExtensionType` variants (tagged by `type`; rarely hand-written — usually `[]`):
```ts
| { type: "EntryProvider";     has_search: boolean }
| { type: "SourceProcessor";   sourcetypes: SourceType[]; opentype: ("Download"|"Stream")[] }
| { type: "EntryProcessor";    trigger_map_entry: boolean; trigger_on_entry_activity: boolean }
| { type: "URLHandler";        url_patterns: string[] }
```

## Repository index (`DionRepoIndex`)

```ts
{
  repo_index_version: 1,
  name: string; url: string; description: string; icon: string,
  content: { path: string; extdata: ExtensionMetadata }[]
}
```
Generated by `dion-build-index` into `.index/index.repo.json`; built extension files copied to
`.index/<name>.dion.js`.
