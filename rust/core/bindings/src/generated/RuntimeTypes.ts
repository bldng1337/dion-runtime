// This file was generated by [ts-rs](https://github.com/Aleph-Alpha/ts-rs). Do not edit this file manually.
import type { JsonValue } from "./serde_json/JsonValue";

export type CustomUI = { "type": "Text", text: string, } | { "type": "Image", image: string, header?: { [key in string]?: string }, } | { "type": "Link", link: string, label?: string, } | { "type": "TimeStamp", timestamp: string, display: TimestampType, } | { "type": "EntryCard", entry: Entry, } | { "type": "Column", children: Array<CustomUI>, } | { "type": "Row", children: Array<CustomUI>, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type DataSource = { "type": "Paragraphlist", paragraphs: Array<string>, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type Entry = { id: string, url: string, title: string, media_type: MediaType, cover?: string, cover_header?: { [key in string]?: string }, author?: Array<string>, rating?: number, views?: number, length?: bigint, };

export type EntryDetailed = { id: string, url: string, title: string, author?: Array<string>, ui?: CustomUI, meta?: Array<MetaData>, media_type: MediaType, status: ReleaseStatus, description: string, language: string, cover?: string, cover_header?: { [key in string]?: string }, episodes: Array<EpisodeList>, genres?: Array<string>, alttitles?: Array<string>, rating?: number, views?: number, length?: number, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type Episode = { id: string, name: string, url: string, cover?: string, cover_header?: { [key in string]?: string }, timestamp?: string, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type EpisodeList = { title: string, episodes: Array<Episode>, };

export type ExtensionData = { id: string, repo?: string, name: string, media_type?: Array<MediaType>, giturl?: string, version?: string, desc?: string, author?: string, license?: string, tags?: Array<string>, nsfw?: boolean, lang: Array<string>, url?: string, icon?: string, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type ImageListAudio = { link: string, from: bigint, to: bigint, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type LinkSource = { "type": "Epub", link: string, } | { "type": "Pdf", link: string, } | { "type": "Imagelist", links: Array<string>, header: { [key in string]?: string }, audio: Array<ImageListAudio>, } | { "type": "M3u8", link: string, sub: Array<Subtitles>, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type MediaType = "Video" | "Comic" | "Audio" | "Book" | "Unknown";

export type MetaData = { key: string, value: JsonValue, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type Permission = { "id": "StoragePermission", path: string, write: boolean, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type ReleaseStatus = "Releasing" | "Complete" | "Unknown";

/**
 * flutter_rust_bridge:non_opaque
 */
export type SettingUI = { "PathSelection": { label: string, pickfolder: boolean, } } | { "Slider": { label: string, min: number, max: number, step: number, } } | { "Checkbox": { label: string, } } | { "Textbox": { label: string, } } | { "Dropdown": { label: string, options: Array<[string, string]>, } };

/**
 * flutter_rust_bridge:non_opaque
 */
export type Settingtype = "Extension" | "Entry" | "Search";

/**
 * flutter_rust_bridge:non_opaque
 */
export type Settingvalue = { "String": { val: string, default_val: string, } } | { "Number": { val: number, default_val: number, } } | { "Boolean": { val: boolean, default_val: boolean, } };

/**
 * flutter_rust_bridge:non_opaque
 */
export type Sort = "Popular" | "Latest" | "Updated";

/**
 * flutter_rust_bridge:non_opaque
 */
export type Source = { "sourcetype": "Data", sourcedata: DataSource, } | { "sourcetype": "Directlink", sourcedata: LinkSource, };

/**
 * flutter_rust_bridge:non_opaque
 */
export type Subtitles = { title: string, url: string, };

export type TimestampType = "Relative" | "Absolute";
