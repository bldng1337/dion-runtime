// Loads LNReader plugin code the way the app does (pluginManager.initPlugin).

import { gcm } from "@noble/ciphers/aes.js";
import { bytesToUtf8, utf8ToBytes } from "@noble/ciphers/utils.js";
import { load } from "cheerio";
import dayjs from "dayjs";
import { Parser } from "htmlparser2";
import { fetchApi, fetchProto, fetchText, getUserAgent } from "./libs/fetch.ts";
import {
	defaultCover,
	FilterTypes,
	isUrlAbsolute,
	NovelStatus,
	urlencode,
} from "./libs/misc.ts";
import { type PluginStorage, WebStorage } from "./libs/storage.ts";

export interface NovelItem {
	name: string;
	path: string;
	cover?: string;
}

export interface ChapterItem {
	name: string;
	path: string;
	chapterNumber?: number;
	releaseTime?: string;
	page?: string;
	scanlator?: string | string[];
}

export interface SourceNovel extends NovelItem {
	genres?: string;
	summary?: string;
	author?: string;
	artist?: string;
	status?: string;
	chapters?: ChapterItem[];
	totalPages?: number;
}

export interface FilterOption {
	label: string;
	value: string;
}

export interface FilterDefinition {
	type: string;
	label: string;
	value: unknown;
	options?: FilterOption[];
}

export interface PluginSettingDefinition {
	type?: string;
	label: string;
	value: unknown;
	options?: FilterOption[];
}

export interface ImageRequestInit {
	headers?: Record<string, string> | { forEach: unknown };
	[key: string]: unknown;
}

export interface LnReaderPlugin {
	id: string;
	name: string;
	site: string;
	version: string;
	icon?: string;
	filters?: Record<string, FilterDefinition>;
	pluginSettings?: Record<string, PluginSettingDefinition>;
	imageRequestInit?: ImageRequestInit;
	webStorageUtilized?: boolean;
	popularNovels(
		pageNo: number,
		options?: {
			showLatestNovels?: boolean;
			filters?: Record<string, FilterDefinition>;
		},
	): Promise<NovelItem[]>;
	searchNovels(searchTerm: string, pageNo: number): Promise<NovelItem[]>;
	parseNovel(novelPath: string): Promise<SourceNovel>;
	parsePage?(
		novelPath: string,
		page: string,
	): Promise<{ chapters?: ChapterItem[] }>;
	parseChapter(chapterPath: string): Promise<string>;
	resolveUrl?(path: string, isNovel?: boolean): string;
}

// Mirrors the `packages` table in the app's pluginManager.
const packages: Record<string, unknown> = {
	htmlparser2: { Parser },
	cheerio: { load },
	dayjs,
	urlencode,
	"@libs/novelStatus": { NovelStatus },
	"@libs/fetch": { fetchApi, fetchText, fetchProto },
	"@libs/isAbsoluteUrl": { isUrlAbsolute },
	"@libs/filterInputs": { FilterTypes },
	"@libs/defaultCover": { defaultCover },
	"@libs/aes": { gcm },
	"@libs/utils": { utf8ToBytes, bytesToUtf8 },
	// Not provided by the app, but two published plugins import it.
	"@/types/constants": { NovelStatus, defaultCover },
};

/**
 * Evaluates plugin code and returns its default export. Like the app, the
 * code runs as a sloppy-mode function body with CommonJS `require`/`module`.
 */
export function instantiatePlugin(
	code: string,
	storage: PluginStorage,
): LnReaderPlugin {
	const webStorage = new WebStorage();
	const requireShim = (name: string): unknown => {
		if (name === "@libs/storage") {
			return { storage, localStorage: webStorage, sessionStorage: webStorage };
		}
		if (!(name in packages)) {
			console.warn(`LNReader plugin requires unknown package ${name}`);
		}
		return packages[name];
	};
	const factory = new Function(
		"require",
		"module",
		`const exports = module.exports = {};\n${code};\nreturn exports.default`,
	) as (require: (name: string) => unknown, module: object) => unknown;
	const plugin = factory(requireShim, {}) as LnReaderPlugin | undefined;
	if (!plugin || typeof plugin !== "object") {
		throw new Error("LNReader plugin has no default export");
	}
	for (const method of [
		"popularNovels",
		"searchNovels",
		"parseNovel",
		"parseChapter",
	]) {
		if (
			typeof (plugin as unknown as Record<string, unknown>)[method] !==
			"function"
		) {
			throw new Error(`LNReader plugin does not implement ${method}`);
		}
	}
	return plugin;
}

/** Plain header record for cover/image links, defaulting the User-Agent. */
export function imageHeaders(plugin: LnReaderPlugin): Record<string, string> {
	const headers: Record<string, string> = {};
	const source = plugin.imageRequestInit?.headers;
	if (
		source &&
		typeof (source as { forEach?: unknown }).forEach === "function"
	) {
		(source as { forEach(cb: (v: string, k: string) => void): void }).forEach(
			(value, key) => {
				headers[key] = value;
			},
		);
	} else if (source) {
		for (const [key, value] of Object.entries(source)) {
			if (typeof value === "string") headers[key] = value;
		}
	}
	if (!Object.keys(headers).some((key) => key.toLowerCase() === "user-agent")) {
		headers["User-Agent"] = getUserAgent();
	}
	return headers;
}

/** The app's resolveUrl helper (src/services/plugin/fetch.ts). */
export function resolveUrl(
	plugin: LnReaderPlugin,
	path: string,
	isNovel?: boolean,
): string {
	if (isUrlAbsolute(path)) return path;
	try {
		if (plugin.resolveUrl) return plugin.resolveUrl(path, isNovel);
	} catch {
		return path;
	}
	return plugin.site + path;
}
