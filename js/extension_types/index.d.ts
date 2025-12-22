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
		json: any;
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

declare module "convert" {
	function decode_base64(input: string): string;
	function encode_base64(input: string): string;
}

declare module "parse" {
	import type { Paragraph } from "@dion-js/runtime-types/runtime";
	export function parse_html(input: string): DionElement;
	export function parse_html_fragment(input: string): DionElement;
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

declare var console: {
	log(message?: any, ...optionalParams: any[]): void;
	error(message?: any, ...optionalParams: any[]): void;
	warn(message?: any, ...optionalParams: any[]): void;
	info(message?: any, ...optionalParams: any[]): void;
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
