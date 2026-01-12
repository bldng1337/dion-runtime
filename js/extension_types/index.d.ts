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
	import type { Permission } from "@dion-js/runtime-types/runtime";
	export function requestPermission(
		permission: Permission,
		msg?: string,
	): Promise<boolean>;
	export function hasPermission(permission: Permission): Promise<boolean>;
}

declare module "setting" {
	import type { Setting, SettingKind } from "@dion-js/runtime-types/runtime";
	export function getSetting(
		settingid: string,
		settingkind: SettingKind,
	): Promise<Setting>;
	export function registerSetting(
		settingid: string,
		setting: Setting,
		settingkind: SettingKind,
	): Promise<void>;
	export type Settingvalues = string | number | boolean;
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
