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
		body?: string;
	}

	interface DionResponse {
		status: number;
		headers: { [key: string]: string };
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
