// This file has been generated. DO NOT EDIT.
// dion runtime types
// Version: 0.1.0

export type AuthCreds = { type: "Cookies"; cookies: { [key: string]: string[] } } | { type: "ApiKey"; key: string } | { type: "UserPass"; username: string; password: string };

export type AuthData = { type: "Cookie"; loginpage: string; logonpage: string } | { type: "ApiKey" } | { type: "UserPass" };

export type Account = { domain: string; user_name?: string | null; cover?: string | null; auth: AuthData; creds?: AuthCreds | null };

export type Link = { url: string; header?: { [key: string]: string } | null };

export type EpisodeId = { uid: string; iddata?: string | null };

export type Episode = { id: EpisodeId; name: string; description?: string | null; url: string; cover?: Link | null; timestamp?: string | null };

export type MediaType = "Video" | "Comic" | "Audio" | "Book" | "Unknown";

export type EntryId = { uid: string; iddata?: string | null };

export type SettingKind = "Extension" | "Search";

export type UIAction = { type: "Action"; action: Action } | { type: "SwapContent"; targetid: string; event: string; data: string; placeholder: CustomUI | null };

export type TimestampType = "Relative" | "Absolute";

export type Entry = { id: EntryId; url: string; title: string; media_type: MediaType; cover?: Link | null; author?: string[] | null; rating?: number | null; views?: number | null; length?: number | null };

export type CustomUI = { type: "Text"; text: string } | { type: "Image"; image: Link; width: number | null; height: number | null } | { type: "Link"; link: string; label: string | null } | { type: "TimeStamp"; timestamp: string; display: TimestampType } | { type: "EntryCard"; entry: Entry } | { type: "Card"; image: Link; top: CustomUI; bottom: CustomUI } | { type: "Feed"; event: string; data: string } | { type: "Button"; label: string; on_click: UIAction | null } | { type: "InlineSetting"; setting_id: string; setting_kind: SettingKind; on_commit: UIAction | null } | { type: "Slot"; id: string; child: CustomUI } | { type: "Column"; children: CustomUI[] } | { type: "Row"; children: CustomUI[] };

export type ReleaseStatus = "Releasing" | "Complete" | "Unknown";

export type EntryDetailed = { id: EntryId; url: string; titles: string[]; author?: string[] | null; ui?: CustomUI | null; meta?: { [key: string]: string } | null; media_type: MediaType; status: ReleaseStatus; description: string; language: string; cover?: Link | null; poster?: Link | null; episodes: Episode[]; genres?: string[] | null; rating?: number | null; views?: number | null; length?: number | null };

export type PopupAction = { label: string; onclick: Action };

export type Action = { type: "OpenBrowser"; url: string } | { type: "Popup"; title: string; content: CustomUI; actions: PopupAction[] } | { type: "Nav"; title: string; content: CustomUI } | { type: "TriggerEvent"; event: string; data: string } | { type: "NavEntry"; entry: EntryDetailed };

export type DropdownOption = { label: string; value: string };

export type EntryActivity = { type: "EpisodeActivity"; progress: number };

export type SettingsUI = { type: "CheckBox" } | { type: "Slider"; min: number; max: number; step: number } | { type: "Dropdown"; options: DropdownOption[] };

export type SettingValue = { type: "String"; data: string } | { type: "Number"; data: number } | { type: "Boolean"; data: boolean } | { type: "StringList"; data: string[] };

export type Setting = { label: string; value: SettingValue; default: SettingValue; visible: boolean; ui?: SettingsUI | null };

export type EntryDetailedResult = { entry: EntryDetailed; settings: { [key: string]: Setting } };

export type EntryList = { hasnext?: boolean | null; length?: number | null; content: Entry[] };

export type EventData = { type: "SwapContent"; event: string; targetid: string; data: string } | { type: "FeedUpdate"; event: string; data: string; page: number } | { type: "Action"; event: string; data: string };

export type EventResult = { type: "SwapContent"; customui: CustomUI } | { type: "FeedUpdate"; customui: CustomUI[]; hasnext: boolean | null; length: number | null };

export type SourceType = "Epub" | "Pdf" | "Imagelist" | "Video" | "Audio" | "Paragraphlist";

export type SourceOpenType = "Download" | "Stream";

export type ExtensionType = { type: "EntryProvider"; has_search: boolean } | { type: "SourceProcessor"; sourcetypes: SourceType[]; opentype: SourceOpenType[] } | { type: "EntryProcessor"; trigger_map_entry: boolean; trigger_on_entry_activity: boolean } | { type: "URLHandler"; url_patterns: string[] };

export type ExtensionData = { id: string; name: string; url: string; icon: string; desc?: string | null; author?: string[]; tags?: string[]; lang?: string[]; nsfw: boolean; media_type: MediaType[]; extension_type: ExtensionType[]; repo?: string | null; version: string; license: string; compatible: boolean };

export type ExtensionManagerData = { name: string; icon: string | null; repo: string | null; api_version: number };

export type ExtensionRepo = { remote_id: string; name: string; description: string; url: string };

export type ImageListAudio = { link: Link; from: number; to: number };

export type Row = { cells: Paragraph[] };

export type Paragraph = { type: "Text"; content: string } | { type: "CustomUI"; ui: CustomUI } | { type: "Table"; columns: Row[] };

export type Permission = { type: "Storage"; path: string; write: boolean } | { type: "Network"; domains: string[] } | { type: "ActionPopup" } | { type: "ArbitraryNetwork" };

export type RemoteExtension = { remote_id: string; id: string; name: string; url: string; cover: Link | null; version: string; compatible: boolean };

export type RemoteExtensionResult = { content: RemoteExtension[]; hasnext?: boolean | null; length?: number | null };

export type Subtitles = { title: string; lang: string; url: Link };

export type StreamSource = { name: string; lang: string; url: Link };

export type Source = { type: "Epub"; link: Link } | { type: "Pdf"; link: Link } | { type: "Imagelist"; links: Link[]; audio: ImageListAudio[] | null } | { type: "Video"; sources: StreamSource[]; sub: Subtitles[] } | { type: "Audio"; sources: StreamSource[] } | { type: "Paragraphlist"; paragraphs: Paragraph[] };

export type SourceResult = { source: Source; settings: { [key: string]: Setting } };

