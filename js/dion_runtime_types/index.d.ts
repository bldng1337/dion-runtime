// This file has been generated. DO NOT EDIT.
// dion runtime types

type Subtitles = { title: string; lang: string; url: Link }

type UIAction = { type: "Action"; action: Action } | { type: "SwapContent"; targetid: string; event: string; data: string; placeholder: CustomUI | null }

type EventResult = { type: "SwapContent"; customui: CustomUI } | { type: "FeedUpdate"; customui: CustomUI[]; hasnext: boolean | null; length: number | null }

type ExtensionType = { type: "EntryProvider"; has_search: boolean } | { type: "EntryDetailedProvider"; id_types: string[] } | { type: "SourceProvider"; id_types: string[] } | { type: "SourceProcessor"; sourcetypes: SourceType[]; opentype: SourceOpenType[] } | { type: "EntryProcessor"; trigger_map_entry: boolean; trigger_on_entry_activity: boolean } | { type: "URLHandler"; url_patterns: string[] }

type ReleaseStatus = "Releasing" | "Complete" | "Unknown"

type MediaType = "Video" | "Comic" | "Audio" | "Book" | "Unknown"

type TimestampType = "Relative" | "Absolute"

type Link = { url: string; header?: { [key: string]: string } | null }

type Action = { type: "OpenBrowser"; url: string } | { type: "Popup"; title: string; content: CustomUI; actions: PopupAction[] } | { type: "Nav"; title: string; content: CustomUI } | { type: "TriggerEvent"; event: string; data: string } | { type: "NavEntry"; entry: EntryDetailed }

type Paragraph = { type: "Text"; content: string } | { type: "CustomUI"; ui: CustomUI } | { type: "Table"; columns: Row[] }

type SourceType = "Epub" | "Pdf" | "Imagelist" | "Video" | "Audio" | "Paragraphlist"

type Setting = { label: string; value: SettingValue; default: SettingValue; visible: boolean; ui?: SettingsUI | null }

type RemoteExtension = { id: string; exturl: string; name: string; cover: Link | null; version: string; compatible: boolean }

type EntryActivity = { type: "EpisodeActivity"; progress: number }

type StreamSource = { name: string; lang: string; url: Link }

type EventData = { type: "SwapContent"; event: string; targetid: string; data: string } | { type: "FeedUpdate"; event: string; data: string; page: number } | { type: "Action"; event: string; data: string }

type AuthData = { Cookie: { loginpage: string; logonpage: string } } | "ApiKey" | "UserPass"

type EntryId = { uid: string; iddata?: string | null }

type Entry = { id: EntryId; url: string; title: string; media_type: MediaType; cover?: Link | null; author?: string[] | null; rating?: number | null; views?: number | null; length?: number | null }

type ExtensionData = { id: string; name: string; url: string; icon: string; desc?: string | null; author?: string[]; tags?: string[]; lang?: string[]; nsfw: boolean; media_type: MediaType[]; extension_type: ExtensionType[]; repo?: string | null; version: string; license: string; compatible: boolean }

type ImageListAudio = { link: Link; from: number; to: number }

type Row = { cells: Paragraph[] }

type Source = { type: "Epub"; link: Link } | { type: "Pdf"; link: Link } | { type: "Imagelist"; links: Link[]; audio: ImageListAudio[] | null } | { type: "Video"; sources: StreamSource[]; sub: Subtitles[] } | { type: "Audio"; sources: StreamSource[] } | { type: "Paragraphlist"; paragraphs: Paragraph[] }

type ExtensionManagerData = { name: string; icon: string | null; repo: string | null; api_version: number }

type SettingsUI = { type: "CheckBox" } | { type: "Slider"; min: number; max: number; step: number } | { type: "Dropdown"; options: DropdownOption[] }

type EntryDetailedResult = { entry: EntryDetailed; settings: { [key: string]: Setting } }

type EntryDetailed = { id: EntryId; url: string; titles: string[]; author?: string[] | null; ui?: CustomUI | null; meta?: { [key: string]: string } | null; media_type: MediaType; status: ReleaseStatus; description: string; language: string; cover?: Link | null; poster?: Link | null; episodes: Episode[]; genres?: string[] | null; rating?: number | null; views?: number | null; length?: number | null }

type SourceResult = { source: Source; settings: { [key: string]: Setting } }

type DropdownOption = { label: string; value: string }

type Episode = { id: EpisodeId; name: string; description?: string | null; url: string; cover?: Link | null; timestamp?: string | null }

type CustomUI = { type: "Text"; text: string } | { type: "Image"; image: Link; width: number | null; height: number | null } | { type: "Link"; link: string; label: string | null } | { type: "TimeStamp"; timestamp: string; display: TimestampType } | { type: "EntryCard"; entry: Entry } | { type: "Card"; image: Link; top: CustomUI; bottom: CustomUI } | { type: "Feed"; event: string; data: string } | { type: "Button"; label: string; on_click: UIAction | null } | { type: "InlineSetting"; setting_id: string; setting_kind: SettingKind; on_commit: UIAction | null } | { type: "Slot"; id: string; child: CustomUI } | { type: "Column"; children: CustomUI[] } | { type: "Row"; children: CustomUI[] }

type PopupAction = { label: string; onclick: Action }

type Account = { domain: string; user_name: string | null; cover: string | null; auth: AuthData; creds: { [key: string]: string } | null }

type Permission = { type: "Storage"; path: string; write: boolean } | { type: "Network"; domain: string } | { type: "ActionPopup" } | { type: "ArbitraryNetwork" }

type SettingKind = "Extension" | "Search"

type RemoteExtensionResult = { content: RemoteExtension[]; hasnext?: boolean | null; length?: number | null }

type ExtensionRepo = { name: string; description: string; url: string; id: string }

type SettingValue = { type: "String"; data: string } | { type: "Number"; data: number } | { type: "Boolean"; data: boolean } | { type: "StringList"; data: string[] }

type EntryList = { hasnext?: boolean | null; length?: number | null; content: Entry[] }

type SourceOpenType = "Download" | "Stream"

type EpisodeId = { uid: string; iddata?: string | null }

