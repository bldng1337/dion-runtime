// This file has been generated. DO NOT EDIT.
// dion runtime types
// Version: 0.1.0
import * as v from "valibot";

export const AuthCreds = v.variant("type", [v.object({ type: v.literal("Cookies"), cookies: v.record(v.string(), v.array(v.string())) }), v.object({ type: v.literal("ApiKey"), key: v.string() }), v.object({ type: v.literal("UserPass"), username: v.string(), password: v.string() })]);

export const AuthData = v.variant("type", [v.object({ type: v.literal("Cookie"), loginpage: v.string(), logonpage: v.string() }), v.object({ type: v.literal("ApiKey") }), v.object({ type: v.literal("UserPass") })]);

export const Account = v.object({ domain: v.string(), user_name: v.optional(v.nullable(v.string())), cover: v.optional(v.nullable(v.string())), auth: AuthData, creds: v.optional(v.nullable(AuthCreds)) });

export const PopupAction = v.object({ label: v.string(), onclick: v.lazy(() => Action) });

export const MediaType = v.picklist(["Video", "Comic", "Audio", "Book", "Unknown"]);

export const EntryId = v.object({ uid: v.string(), iddata: v.optional(v.nullable(v.string())) });

export const EpisodeId = v.object({ uid: v.string(), iddata: v.optional(v.nullable(v.string())) });

export const Link = v.object({ url: v.string(), header: v.optional(v.nullable(v.record(v.string(), v.string()))) });

export const Episode = v.object({ id: EpisodeId, name: v.string(), description: v.optional(v.nullable(v.string())), url: v.string(), cover: v.optional(v.nullable(Link)), timestamp: v.optional(v.nullable(v.string())) });

export const SettingKind = v.picklist(["Extension", "Search"]);

export const UIAction = v.variant("type", [v.object({ type: v.literal("Action"), action: v.lazy(() => Action) }), v.object({ type: v.literal("SwapContent"), targetid: v.string(), event: v.string(), data: v.string(), placeholder: v.nullable(v.lazy(() => CustomUI)) })]);

export const TimestampType = v.picklist(["Relative", "Absolute"]);

export const Entry = v.object({ id: EntryId, url: v.string(), title: v.string(), media_type: MediaType, cover: v.optional(v.nullable(Link)), author: v.optional(v.nullable(v.array(v.string()))), rating: v.optional(v.nullable(v.number())), views: v.optional(v.nullable(v.number())), length: v.optional(v.nullable(v.number())) });

export const CustomUI: v.GenericSchema = v.variant("type", [v.object({ type: v.literal("Text"), text: v.string() }), v.object({ type: v.literal("Image"), image: Link, width: v.nullable(v.number()), height: v.nullable(v.number()) }), v.object({ type: v.literal("Link"), link: v.string(), label: v.nullable(v.string()) }), v.object({ type: v.literal("TimeStamp"), timestamp: v.string(), display: TimestampType }), v.object({ type: v.literal("EntryCard"), entry: Entry }), v.object({ type: v.literal("Card"), image: Link, top: v.lazy(() => CustomUI), bottom: v.lazy(() => CustomUI) }), v.object({ type: v.literal("Feed"), event: v.string(), data: v.string() }), v.object({ type: v.literal("Button"), label: v.string(), on_click: v.nullable(UIAction) }), v.object({ type: v.literal("InlineSetting"), setting_id: v.string(), setting_kind: SettingKind, on_commit: v.nullable(UIAction) }), v.object({ type: v.literal("Slot"), id: v.string(), child: v.lazy(() => CustomUI) }), v.object({ type: v.literal("Column"), children: v.array(v.lazy(() => CustomUI)) }), v.object({ type: v.literal("Row"), children: v.array(v.lazy(() => CustomUI)) })]);

export const ReleaseStatus = v.picklist(["Releasing", "Complete", "Unknown"]);

export const EntryDetailed = v.object({ id: EntryId, url: v.string(), titles: v.array(v.string()), author: v.optional(v.nullable(v.array(v.string()))), ui: v.optional(v.nullable(v.lazy(() => CustomUI))), meta: v.optional(v.nullable(v.record(v.string(), v.string()))), media_type: MediaType, status: ReleaseStatus, description: v.string(), language: v.string(), cover: v.optional(v.nullable(Link)), poster: v.optional(v.nullable(Link)), episodes: v.array(Episode), genres: v.optional(v.nullable(v.array(v.string()))), rating: v.optional(v.nullable(v.number())), views: v.optional(v.nullable(v.number())), length: v.optional(v.nullable(v.number())) });

export const Action: v.GenericSchema = v.variant("type", [v.object({ type: v.literal("OpenBrowser"), url: v.string() }), v.object({ type: v.literal("Popup"), title: v.string(), content: v.lazy(() => CustomUI), actions: v.array(PopupAction) }), v.object({ type: v.literal("Nav"), title: v.string(), content: v.lazy(() => CustomUI) }), v.object({ type: v.literal("TriggerEvent"), event: v.string(), data: v.string() }), v.object({ type: v.literal("NavEntry"), entry: EntryDetailed })]);

export const DropdownOption = v.object({ label: v.string(), value: v.string() });

export const EntryActivity = v.object({ type: v.literal("EpisodeActivity"), progress: v.number() });

export const SettingValue = v.variant("type", [v.object({ type: v.literal("String"), data: v.string() }), v.object({ type: v.literal("Number"), data: v.number() }), v.object({ type: v.literal("Boolean"), data: v.boolean() }), v.object({ type: v.literal("StringList"), data: v.array(v.string()) })]);

export const SettingsUI = v.variant("type", [v.object({ type: v.literal("CheckBox") }), v.object({ type: v.literal("Slider"), min: v.number(), max: v.number(), step: v.number() }), v.object({ type: v.literal("Dropdown"), options: v.array(DropdownOption) }), v.object({ type: v.literal("MultiDropdown"), options: v.array(DropdownOption) })]);

export const Setting = v.object({ label: v.string(), value: SettingValue, default: SettingValue, visible: v.boolean(), ui: v.optional(v.nullable(SettingsUI)) });

export const EntryDetailedResult = v.object({ entry: EntryDetailed, settings: v.record(v.string(), Setting) });

export const EntryList = v.object({ hasnext: v.optional(v.nullable(v.boolean())), length: v.optional(v.nullable(v.number())), content: v.array(Entry) });

export const EventData = v.variant("type", [v.object({ type: v.literal("SwapContent"), event: v.string(), targetid: v.string(), data: v.string() }), v.object({ type: v.literal("FeedUpdate"), event: v.string(), data: v.string(), page: v.number() }), v.object({ type: v.literal("Action"), event: v.string(), data: v.string() })]);

export const EventResult = v.variant("type", [v.object({ type: v.literal("SwapContent"), customui: v.lazy(() => CustomUI) }), v.object({ type: v.literal("FeedUpdate"), customui: v.array(v.lazy(() => CustomUI)), hasnext: v.nullable(v.boolean()), length: v.nullable(v.number()) })]);

export const SourceType = v.picklist(["Epub", "Pdf", "Imagelist", "Video", "Audio", "Paragraphlist"]);

export const SourceOpenType = v.picklist(["Download", "Stream"]);

export const ExtensionType = v.variant("type", [v.object({ type: v.literal("EntryProvider"), has_search: v.boolean() }), v.object({ type: v.literal("SourceProcessor"), sourcetypes: v.array(SourceType), opentype: v.array(SourceOpenType) }), v.object({ type: v.literal("EntryProcessor"), trigger_map_entry: v.boolean(), trigger_on_entry_activity: v.boolean() }), v.object({ type: v.literal("URLHandler"), url_patterns: v.array(v.string()) })]);

export const ExtensionData = v.object({ id: v.string(), name: v.string(), url: v.string(), icon: v.string(), desc: v.optional(v.nullable(v.string())), author: v.optional(v.array(v.string())), tags: v.optional(v.array(v.string())), lang: v.optional(v.array(v.string())), nsfw: v.boolean(), media_type: v.array(MediaType), extension_type: v.array(ExtensionType), repo: v.optional(v.nullable(v.string())), version: v.string(), license: v.string(), compatible: v.boolean() });

export const ExtensionManagerData = v.object({ name: v.string(), icon: v.nullable(v.string()), repo: v.nullable(v.string()), api_version: v.number() });

export const ExtensionRepo = v.object({ remote_id: v.string(), name: v.string(), description: v.string(), url: v.string() });

export const ImageListAudio = v.object({ link: Link, from: v.number(), to: v.number() });

export const Row = v.object({ cells: v.array(v.lazy(() => Paragraph)) });

export const Paragraph: v.GenericSchema = v.variant("type", [v.object({ type: v.literal("Text"), content: v.string() }), v.object({ type: v.literal("CustomUI"), ui: v.lazy(() => CustomUI) }), v.object({ type: v.literal("Table"), columns: v.array(Row) })]);

export const Permission = v.variant("type", [v.object({ type: v.literal("Storage"), path: v.string(), write: v.boolean() }), v.object({ type: v.literal("Network"), domains: v.array(v.string()) }), v.object({ type: v.literal("ActionPopup") }), v.object({ type: v.literal("ArbitraryNetwork") })]);

export const RemoteExtension = v.object({ remote_id: v.string(), id: v.string(), name: v.string(), url: v.string(), cover: v.nullable(Link), version: v.string(), compatible: v.boolean() });

export const RemoteExtensionResult = v.object({ content: v.array(RemoteExtension), hasnext: v.optional(v.nullable(v.boolean())), length: v.optional(v.nullable(v.number())) });

export const StreamSource = v.object({ name: v.string(), lang: v.string(), url: Link });

export const Subtitles = v.object({ title: v.string(), lang: v.string(), url: Link });

export const Source = v.variant("type", [v.object({ type: v.literal("Epub"), link: Link }), v.object({ type: v.literal("Pdf"), link: Link }), v.object({ type: v.literal("Imagelist"), links: v.array(Link), audio: v.nullable(v.array(ImageListAudio)) }), v.object({ type: v.literal("Video"), sources: v.array(StreamSource), sub: v.array(Subtitles) }), v.object({ type: v.literal("Audio"), sources: v.array(StreamSource) }), v.object({ type: v.literal("Paragraphlist"), paragraphs: v.array(v.lazy(() => Paragraph)) })]);

export const SourceResult = v.object({ source: Source, settings: v.record(v.string(), Setting) });

