// This file has been generated. DO NOT EDIT.
// dion runtime types

type SettingKind = "Extension" | "Search"

type EntryDetailedResult = { entry: EntryDetailed; settings: { [key: string]: Setting } }

type ImageListAudio = { link: Link; from: number; to: number }

type ExtensionType = "SourceProvider" | "URLResolve" | "SourceProcessor" | "EntryExtension"

type PopupAction = { label: string; onclick: Action }

type Link = { url: string; header?: { [key: string]: string } | null }

type Mp3Chapter = { title: string; url: Link }

type Paragraph = { type: "Text"; content: string } | { type: "CustomUI"; ui: CustomUI }

type Episode = { id: string; name: string; description?: string | null; url: string; cover?: Link | null; timestamp?: string | null }

type ExtensionRepo = { name: string; description: string; id: string; extensions: RemoteExtension[] }

type DropdownOption = { label: string; value: string }

type ReleaseStatus = "Releasing" | "Complete" | "Unknown"

type SettingsUI = { type: "CheckBox" } | { type: "Slider"; min: number; max: number; step: number } | { type: "Dropdown"; options: DropdownOption[] }

type Subtitles = { title: string; url: Link }

type Account = { domain: string; user_name: string | null; cover: string | null; auth: AuthData; creds: { [key: string]: string } | null }

type Action = { type: "OpenBrowser"; url: string } | { type: "Popup"; title: string; content: CustomUI; actions: PopupAction[] } | { type: "Nav"; title: string; content: CustomUI } | { type: "TriggerEvent"; event: string; data: string }

type EntryActivity = { type: "EpisodeActivity"; progress: number }

type TimestampType = "Relative" | "Absolute"

type CustomUI = { type: "Text"; text: string } | { type: "Image"; image: Link; width: number | null; height: number | null } | { type: "Link"; link: string; label: string | null } | { type: "TimeStamp"; timestamp: string; display: TimestampType } | { type: "EntryCard"; entry: Entry } | { type: "Button"; label: string; on_click: UIAction | null } | { type: "InlineSetting"; setting_id: string; on_commit: UIAction | null } | { type: "Slot"; id: string; child: CustomUI } | { type: "Column"; children: CustomUI[] } | { type: "Row"; children: CustomUI[] }

type EntryDetailed = { id: string; url: string; titles: string[]; author?: string[] | null; ui?: CustomUI | null; meta?: { [key: string]: string } | null; media_type: MediaType; status: ReleaseStatus; description: string; language: string; cover?: Link | null; episodes: Episode[]; genres?: string[] | null; rating?: number | null; views?: number | null; length?: number | null }

type SettingValue = { type: "String"; data: string } | { type: "Number"; data: number } | { type: "Boolean"; data: boolean } | { type: "StringList"; data: string[] }

type EntryList = { hasnext?: boolean | null; length?: number | null; content: Entry[] }

type Permission = { type: "Storage"; path: string; write: boolean } | { type: "Network"; domain: string } | { type: "ActionPopup" } | { type: "ArbitraryNetwork" }

type Entry = { id: string; url: string; title: string; media_type: MediaType; cover?: Link | null; author?: string[] | null; rating?: number | null; views?: number | null; length?: number | null }

type UIAction = { type: "Action"; action: Action } | { type: "SwapContent"; targetid: string | null; event: string; placeholder: CustomUI | null }

type RemoteExtension = { extension_url: string; compatible: boolean; data: ExtensionData }

type SourceResult = { source: Source; settings: { [key: string]: Setting } }

type Source = { type: "Epub"; link: Link } | { type: "Pdf"; link: Link } | { type: "Imagelist"; links: Link[]; audio: ImageListAudio[] | null } | { type: "M3u8"; link: Link; sub: Subtitles[] } | { type: "Mp3"; chapters: Mp3Chapter[] } | { type: "Paragraphlist"; paragraphs: Paragraph[] }

type Setting = { label: string; value: SettingValue; default: SettingValue; visible: boolean; ui?: SettingsUI | null }

type MediaType = "Video" | "Comic" | "Audio" | "Book" | "Unknown"

type ExtensionData = { id: string; repo?: string | null; name: string; media_type?: MediaType[] | null; extension_type?: ExtensionType[] | null; version?: string | null; desc?: string | null; author?: string[]; license?: string | null; tags?: string[] | null; nsfw?: boolean | null; lang?: string[]; url?: string | null; icon?: string | null }

type AuthData = { Cookie: { loginpage: string; logonpage: string } } | { ApiKey: null } | { UserPass: null }

