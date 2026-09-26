declare module "network" {
	function fetch(url: string, option?: Requestoptions): Promise<DionResponse>;
	function getCookies(): Cookie[];
	function getProxyAddress(): Promise<string | undefined>;

	interface Cookie {
		name: string;
		value: string;
	}

	interface Requestoptions {
		method?:
			| "GET"
			| "HEAD"
			| "POST"
			| "PUT"
			| "DELETE"
			| "CONNECT"
			| "TRACE"
			| "PATCH";
		headers?: { [key: string]: string };
		body?: string | Uint8Array;
	}

	interface DionResponse {
		status: number;
		headers: { [key: string]: string };
		/** Raw response bytes, e.g. for downloaded books (epub, cbz, m4b). */
		bytes: Uint8Array;
		/** Decoded text (Content-Type charset with UTF-8 fallback). */
		body: string;
		json: unknown;
		ok: boolean;
	}
}

declare module "permission" {
	import type { EntryId, Permission } from "@dion-js/runtime-types/runtime";
	export function requestPermission(
		permission: Permission,
		msg?: string,
	): Promise<boolean>;
	export function hasPermission(permission: Permission): Promise<boolean>;
}

declare module "setting" {
	import type {
		Setting,
		SettingKind,
		EntryId,
		SettingValue,
	} from "@dion-js/runtime-types/runtime";
	export function getSetting(
		settingid: string,
		settingkind: SettingKind,
	): Promise<Setting>;
	export function registerSetting(
		settingid: string,
		setting: Setting,
		settingkind: SettingKind,
	): Promise<void>;
	export function setEntrySetting(
		entry: EntryId,
		key: String,
		value: SettingValue,
	): Promise<void>;
}

declare module "action" {
	import type { Action } from "@dion-js/runtime-types/runtime";

	export function doAction(action: Action): Promise<void>;
}

declare module "store" {
	export function set(key: string, value: unknown): Promise<void>;
}

declare module "cache" {
	/**
	 * Opens (or attaches to) a persistent KV cache.
	 * Values may be any JSON value or a Uint8Array (stored as raw bytes).
	 * `defaultTtl` (seconds) applies to every `set` without an explicit ttl.
	 */
	export function openKvCache(
		name: string,
		options?: { defaultTtl?: number },
	): Cache;

	/**
	 * Opens (or attaches to) a persistent LRU cache. The least recently
	 * used entries are evicted when `maxEntries` or `maxBytes` is exceeded.
	 */
	export function openLruCache(
		name: string,
		options?: {
			maxEntries?: number;
			maxBytes?: number;
			defaultTtl?: number;
		},
	): Cache;

	export interface Cache {
		/** Returns the value, or undefined when missing/expired. Refreshes LRU recency. */
		get(key: string): Promise<unknown>;
		/** Reads without refreshing LRU recency. */
		peek(key: string): Promise<unknown>;
		set(key: string, value: unknown, ttlSeconds?: number): Promise<void>;
		has(key: string): Promise<boolean>;
		delete(key: string): Promise<void>;
		keys(): Promise<string[]>;
		size(): Promise<number>;
		clear(): Promise<void>;
	}
}

declare module "filesystem" {
	export interface WriteOptions {
		/** Append to the file instead of replacing it. */
		append?: boolean;
		/** Create missing parent directories. */
		createParents?: boolean;
	}

	export interface DirOptions {
		/** Create/remove all missing parent directories / contained files. */
		recursive?: boolean;
	}

	export interface FileStat {
		size: number;
		isDir: boolean;
		isFile: boolean;
		modifiedMs: number | undefined;
		createdMs: number | undefined;
	}

	export interface DirEntry {
		name: string;
		path: string;
		isDir: boolean;
		isFile: boolean;
	}

	/**
	 * Reads a file as UTF-8 text. Paths inside the extension's private data
	 * directory need no permission; anything else requires a granted
	 * `Permission::Storage` (the user is prompted once per directory).
	 */
	export function readTextFile(path: string): Promise<string>;

	/** Reads a file as raw bytes. */
	export function readFile(path: string): Promise<Uint8Array>;

	export function writeTextFile(
		path: string,
		contents: string,
		options?: WriteOptions,
	): Promise<void>;

	export function writeFile(
		path: string,
		data: Uint8Array | string,
		options?: WriteOptions,
	): Promise<void>;

	export function deleteFile(path: string): Promise<void>;

	/** Whether the path exists (follows symlinks). */
	export function exists(path: string): Promise<boolean>;

	export function stat(path: string): Promise<FileStat>;

	export function createDir(path: string, options?: DirOptions): Promise<void>;

	export function removeDir(path: string, options?: DirOptions): Promise<void>;

	export function readDir(path: string): Promise<DirEntry[]>;

	/**
	 * The extension's private data directory; reading and writing below it
	 * never requires a Storage permission. On Android this is an
	 * app-private directory that is always writable.
	 */
	export function getDataDir(): string;

	/** Joins path fragments and normalizes the result (resolving `.`/`..`). */
	export function joinPaths(parts: string[]): string;
}

declare module "metadata" {
	/**
	 * Parses a one-shot metadata snapshot of a container the extension holds
	 * as bytes (from `filesystem.readFile` or `network.fetch(...).bytes`).
	 * Supported: EPUB, ZIP/CBZ, MP4/M4A/M4B (chapters + artwork) and the
	 * audio formats lofty understands (MP3, FLAC, OGG, OPUS, WAV, APE, ...).
	 *
	 * `hint` is a filename or extension used when the content is ambiguous
	 * (e.g. an EPUB missing its `mimetype` entry).
	 */
	export function inspect(
		data: Uint8Array,
		hint?: string,
	): Promise<EpubMetadata | ArchiveMetadata | Mp4Metadata | AudioMetadata>;

	/**
	 * Opens a reusable handle for reading entries (pages, covers,
	 * stylesheets) out of an EPUB or ZIP/CBZ container. The parsed index
	 * stays in runtime memory, so per-entry reads do not re-parse the file.
	 * Audio/MP4 containers have no entries — use `inspect` for those.
	 */
	export function openArchive(
		data: Uint8Array,
		hint?: string,
	): Promise<Archive>;

	export interface Archive {
		/** Container entries: manifest resources for EPUB, all files for ZIP. */
		entries(): Promise<ArchiveEntry[]>;
		/** Reads an entry as raw bytes. */
		read(path: string): Promise<Uint8Array>;
		/** Reads an entry as UTF-8 text (lossy). */
		readText(path: string): Promise<string>;
		/** Re-parses the metadata snapshot of the open container. */
		readonly metadata: Promise<
			EpubMetadata | ArchiveMetadata | Mp4Metadata | AudioMetadata
		>;
	}

	export interface ArchiveEntry {
		path: string;
		/** Uncompressed size in bytes; `undefined` for EPUB manifest entries. */
		size?: number;
		isDir: boolean;
	}

	export interface EpubMetadata {
		type: "epub";
		title?: string;
		creators: { name: string; roles: string[] }[];
		publishers: string[];
		languages: string[];
		/** Publication date as written in the package document. */
		published?: string;
		description?: string;
		identifiers: { scheme?: string; value: string }[];
		subjects: string[];
		/** Manifest path of the cover image, usable with `Archive.read`. */
		coverPath?: string;
		/** All manifest resources; `path` values work with `Archive.read`. */
		resources: { path: string; mediaType?: string }[];
		/** Flattened table of contents. */
		toc: { title?: string; path: string }[];
		/** Reading order as manifest paths. */
		spine: string[];
	}

	export interface ArchiveMetadata {
		type: "archive";
		entries: ArchiveEntry[];
	}

	export interface Chapter {
		title?: string;
		startMs: number;
		/** Derived from the next chapter's start (or the total duration). */
		durationMs?: number;
	}

	export interface Mp4Metadata {
		type: "mp4";
		title?: string;
		artist?: string;
		album?: string;
		albumArtist?: string;
		year?: string;
		genre?: string;
		track?: number;
		trackTotal?: number;
		disc?: number;
		discTotal?: number;
		durationMs?: number;
		description?: string;
		chapters: Chapter[];
		/** Embedded cover art, when present. */
		artwork?: Uint8Array;
	}

	export interface AudioMetadata {
		type: "audio";
		title?: string;
		artist?: string;
		album?: string;
		year?: number;
		genre?: string;
		track?: number;
		durationMs?: number;
		/** Embedded cover art, when present. */
		artwork?: Uint8Array;
	}
}

declare module "auth" {
	type Link = string;
	import type { Account, AuthCreds } from "@dion-js/runtime-types/runtime";

	/**
	 * Initializes/Updates authentication for a given provider.
	 */
	export function mergeAuth(account: Account): Promise<void>;

	/**
	 * Checks if this account is currently authenticated
	 */
	export function isLoggedIn(domain: string): Promise<boolean>;

	/**
	 * Invalidates the logged in state of an account
	 */
	export function invalidate(domain: string): Promise<void>;

	/**
	 * Returns the authentication secrets for the given domain.
	 */
	export function getAuthSecret(domain: string): Promise<AuthCreds>;
}

declare module "convert" {
	function decodeBase64(input: string): string;
	function encodeBase64(input: string): string;
}

declare module "parse" {
	import type { Paragraph } from "@dion-js/runtime-types/runtime";
	export function parseHtml(input: string): DionElement;
	export function parseHtmlFragment(input: string): DionElement;
	export function parseXml(input: string): DionElement;
	export interface DionElement {
		attr(name: string): string;
		select(selector: CSSSelector): DionElementArray;
		parent: DionElement | undefined;
		children: DionElementArray;
		text: string;
		paragraphs: Paragraph[];
		name: string;
	}

	export interface DionElementArray {
		select(selector: CSSSelector): DionElementArray;
		attr(name: string): string[];
		get(index: number): DionElement | undefined;
		map<T>(callback: (element: DionElement) => T): T[];
		filter(callback: (element: DionElement) => boolean): DionElementArray;
		first: DionElement | undefined;
		length: number;
		text: string;
		paragraphs: Paragraph[];
	}
}

// biome-ignore lint/suspicious/noVar: console methods
declare var console: {
	// biome-ignore lint/suspicious/noExplicitAny: console methods
	log(message?: any, ...optionalParams: any[]): void;
	// biome-ignore lint/suspicious/noExplicitAny: console methods
	error(message?: any, ...optionalParams: any[]): void;
	// biome-ignore lint/suspicious/noExplicitAny: console methods
	warn(message?: any, ...optionalParams: any[]): void;
	// biome-ignore lint/suspicious/noExplicitAny: console methods
	info(message?: any, ...optionalParams: any[]): void;
	// biome-ignore lint/suspicious/noExplicitAny: console methods
	debug(message?: any, ...optionalParams: any[]): void;
};

declare class CSSSelector {
	constructor(name: string);
}

declare const appdata: {
	app: string;
	version: string;
	platform: string;
};

declare class URLSearchParams {
	constructor(
		init?: string | Record<string, string> | Iterable<[string, string]>,
	);
	append(name: string, value: string): void;
	delete(name: string, value?: string): void;
	get(name: string): string | undefined;
	getAll(name: string): string[];
	has(name: string, value?: string): boolean;
	set(name: string, value: string): void;
	sort(): void;
	forEach(
		callback: (
			value: string,
			name: string,
			searchParams: URLSearchParams,
		) => void,
		thisArg?: unknown,
	): void;
	entries(): IterableIterator<[string, string]>;
	keys(): IterableIterator<string>;
	values(): IterableIterator<string>;
	[Symbol.iterator](): IterableIterator<[string, string]>;
	readonly size: number;
	toString(): string;
}

declare class URL {
	constructor(input: string, base?: string);
	static canParse(input: string, base?: string): boolean;
	static parse(input: string, base?: string): URL | null;
	hash: string;
	host: string;
	hostname: string;
	href: string;
	readonly origin: string;
	password: string;
	pathname: string;
	port: string;
	protocol: string;
	search: string;
	readonly searchParams: URLSearchParams;
	username: string;
	toString(): string;
	toJSON(): string;
}
