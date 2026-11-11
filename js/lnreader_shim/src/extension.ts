// The Dion extension class wrapping one LNReader plugin.

import type {
	Entry,
	EntryDetailed,
	EntryDetailedResult,
	EntryId,
	EntryList,
	Episode,
	EpisodeId,
	Link,
	Paragraph,
	ReleaseStatus,
	Setting,
	SourceResult,
} from "@dion-js/runtime-types/runtime";
import { load } from "cheerio";
import { parseHtmlFragment } from "parse";
import { registerSetting } from "setting";
import { setUserAgent } from "./libs/fetch.ts";
import { isUrlAbsolute, NovelStatus } from "./libs/misc.ts";
import { PluginStorage } from "./libs/storage.ts";
import {
	type ChapterItem,
	imageHeaders,
	instantiatePlugin,
	type LnReaderPlugin,
	type NovelItem,
	resolveUrl,
	type SourceNovel,
} from "./plugin.ts";
import {
	currentFilters,
	pluginSettingValues,
	readBooleanSetting,
	readStringSetting,
	registerFilters,
	registerPluginSettings,
} from "./settings.ts";

/** Host-provided facts about the plugin, written into the generated module. */
export interface PluginMeta {
	/** The LNReader plugin id (the Dion extension id is derived from it). */
	pluginId: string;
	/** ISO 639-1 language code, or "" when unknown. */
	lang?: string;
}

export const LATEST_SETTING = "lnreader:latest";
export const USER_AGENT_SETTING = "lnreader:userAgent";
const PAGE_CONCURRENCY = 4;

function statusOf(status: string | undefined): ReleaseStatus {
	switch (status) {
		case NovelStatus.Ongoing:
		case NovelStatus.OnHiatus:
			return "Releasing";
		case NovelStatus.Completed:
		case NovelStatus.PublishingFinished:
		case NovelStatus.Cancelled:
			return "Complete";
		default:
			return "Unknown";
	}
}

function splitList(value: unknown): string[] {
	return String(value ?? "")
		.split(/[,\n]/)
		.map((part) => part.trim())
		.filter((part) => part.length > 0);
}

/** Items the host can identify: plugins sometimes emit ones without a path. */
function validItems<T extends { path: string }>(items: T[] | undefined): T[] {
	if (!Array.isArray(items)) return [];
	return items.filter(
		(item) => item && typeof item.path === "string" && item.path.length > 0,
	);
}

function timestampOf(releaseTime: unknown): string | undefined {
	if (typeof releaseTime !== "string" || !releaseTime) return undefined;
	const parsed = Date.parse(releaseTime);
	return Number.isNaN(parsed) ? undefined : new Date(parsed).toISOString();
}

/**
 * Runs a plugin call, prefixing errors with the call and appending the JS
 * stack (boa error messages carry no location; the stack has positions in
 * the plugin code).
 */
async function pluginCall<T>(what: string, run: () => Promise<T>): Promise<T> {
	try {
		return await run();
	} catch (error) {
		if (error instanceof Error) {
			const stack = typeof error.stack === "string" ? error.stack.trim() : "";
			error.message = [`${what}: ${error.message}`, stack]
				.filter((part) => part.length > 0)
				.join("\n");
		}
		throw error;
	}
}

// Block-level tags, as the host's paragraph conversion sees them.
const BLOCK_TAGS = new Set([
	"p",
	"div",
	"h1",
	"h2",
	"h3",
	"h4",
	"h5",
	"h6",
	"blockquote",
	"pre",
	"ul",
	"ol",
	"li",
	"table",
	"hr",
	"br",
	"section",
	"article",
	"aside",
	"header",
	"footer",
	"nav",
	"figure",
	"figcaption",
	"details",
	"summary",
	"main",
	"dl",
	"dt",
	"dd",
]);
// Wrappers the host would collapse into a single paragraph.
const CONTAINER_SELECTOR =
	"div, section, article, main, header, footer, aside, nav, figure, center, span, font";

/**
 * Chapter HTML as Dion paragraphs. The host converts each top-level block
 * into one paragraph, so wrapper elements holding block content (a chapter
 * `<div>` around the `<p>`s, `<br>`-separated lines) are unwrapped first.
 * The host drops images, so every `<img>` becomes an image paragraph after
 * the text of the block it sits in; `imageLink` resolves its source.
 */
export function htmlToParagraphs(
	html: string,
	imageLink: (src: string) => Link | undefined = (url) => ({ url }),
): Paragraph[] {
	if (!html.trim()) return [];
	const $ = load(html, null, false);
	$(CONTAINER_SELECTOR).each((_, element) => {
		const node = $(element);
		const hasBlock = node
			.children()
			.toArray()
			.some((child) => BLOCK_TAGS.has(child.tagName?.toLowerCase() ?? ""));
		if (hasBlock) node.replaceWith(node.contents());
	});

	const paragraphs: Paragraph[] = [];
	let chunk = "";
	const flush = () => {
		if (chunk.trim()) {
			paragraphs.push(...(parseHtmlFragment(chunk).paragraphs as Paragraph[]));
		}
		chunk = "";
	};
	for (const node of $.root().contents().toArray()) {
		const element = $(node);
		const images = element.is("img")
			? element.toArray()
			: element.find("img").toArray();
		if (images.length === 0) {
			chunk += $.html(node);
			continue;
		}
		if (!element.is("img") && element.text().trim()) chunk += $.html(node);
		flush();
		for (const image of images) {
			const img = $(image);
			const src =
				img.attr("data-src") || img.attr("data-lazy-src") || img.attr("src");
			const link = src ? imageLink(src) : undefined;
			if (link) {
				paragraphs.push({
					type: "CustomUI",
					ui: { type: "Image", image: link, width: null, height: null },
				});
			}
		}
	}
	flush();
	return paragraphs;
}

export function createExtension(meta: PluginMeta, code: string) {
	return class LnReaderExtension {
		plugin!: LnReaderPlugin;
		storage!: PluginStorage;

		async load(): Promise<void> {
			await registerSetting(
				USER_AGENT_SETTING,
				{
					label: "User agent",
					value: { type: "String", data: "" },
					default: { type: "String", data: "" },
					visible: true,
				},
				"Extension",
			);
			await registerSetting(
				LATEST_SETTING,
				{
					label: "Latest novels",
					value: { type: "Boolean", data: false },
					default: { type: "Boolean", data: false },
					visible: true,
					ui: { type: "CheckBox" },
				},
				"Search",
			);
			setUserAgent(await readStringSetting(USER_AGENT_SETTING, "Extension"));
			this.storage = await PluginStorage.open(`lnreader-${meta.pluginId}`);

			let plugin = instantiatePlugin(code, this.storage);
			const settings = plugin.pluginSettings;
			if (settings && Object.keys(settings).length > 0) {
				await registerPluginSettings(settings);
				await this.syncPluginSettings(plugin);
				// Plugins often read their settings in the constructor, so build
				// it again now that the stored values are visible.
				plugin = instantiatePlugin(code, this.storage);
			}
			await registerFilters(plugin.filters);
			this.plugin = plugin;
		}

		/** Last plugin setting values handed to the plugin, as JSON. */
		syncedSettings = "";

		/**
		 * Makes the host's plugin setting values visible through storage.
		 * Returns whether they changed since the last sync.
		 */
		async syncPluginSettings(plugin: LnReaderPlugin): Promise<boolean> {
			if (!plugin.pluginSettings) return false;
			const values = await pluginSettingValues(plugin.pluginSettings);
			for (const [key, value] of values) {
				this.storage.setTransient(key, value);
			}
			const snapshot = JSON.stringify([...values]);
			const changed = snapshot !== this.syncedSettings;
			this.syncedSettings = snapshot;
			return changed;
		}

		async beforeCall(): Promise<void> {
			setUserAgent(await readStringSetting(USER_AGENT_SETTING, "Extension"));
			if (await this.syncPluginSettings(this.plugin)) {
				// Settings changed: rebuild the plugin so constructor reads see them.
				this.plugin = instantiatePlugin(code, this.storage);
			}
		}

		toEntry(item: NovelItem): Entry {
			return {
				id: { uid: item.path },
				url: resolveUrl(this.plugin, item.path, true),
				title: String(item.name ?? ""),
				media_type: "Book",
				cover: this.cover(item.cover),
			};
		}

		cover(cover: string | undefined) {
			if (!cover) return undefined;
			let url = cover;
			if (!url.startsWith("data:") && !isUrlAbsolute(url)) {
				try {
					url = new URL(url, this.plugin.site).href;
				} catch {
					// keep the plugin's value
				}
			}
			return { url, header: imageHeaders(this.plugin) };
		}

		toEntryList(items: NovelItem[] | undefined): EntryList {
			const content = validItems(items).map((item) => this.toEntry(item));
			return { content, hasnext: content.length > 0 };
		}

		async onEvent(): Promise<undefined> {
			return undefined;
		}

		async validate(): Promise<undefined> {
			return undefined;
		}

		async browse(page: number): Promise<EntryList> {
			await this.beforeCall();
			const showLatestNovels =
				(await readBooleanSetting(LATEST_SETTING, "Search")) ?? false;
			const filters = await currentFilters(this.plugin.filters);
			// Dion pages start at 0, LNReader pages at 1.
			const items = await pluginCall("popularNovels", () =>
				this.plugin.popularNovels(page + 1, { showLatestNovels, filters }),
			);
			return this.toEntryList(items);
		}

		async search(page: number, filter: string): Promise<EntryList> {
			if (!filter.trim()) return this.browse(page);
			await this.beforeCall();
			const items = await pluginCall("searchNovels", () =>
				this.plugin.searchNovels(filter, page + 1),
			);
			return this.toEntryList(items);
		}

		async chapters(path: string, novel: SourceNovel): Promise<ChapterItem[]> {
			const chapters = [...(novel.chapters ?? [])];
			const totalPages = Number(novel.totalPages ?? 0);
			if (!this.plugin.parsePage || totalPages < 1) return chapters;
			// Page 1 comes from parseNovel unless it returned no chapters (the
			// app fetches a page only when it has nothing stored for it).
			const pages: string[] = [];
			for (let page = chapters.length > 0 ? 2 : 1; page <= totalPages; page++) {
				pages.push(String(page));
			}
			for (let start = 0; start < pages.length; start += PAGE_CONCURRENCY) {
				const batch = pages.slice(start, start + PAGE_CONCURRENCY);
				const results = await Promise.all(
					batch.map((page) =>
						pluginCall("parsePage", async () =>
							this.plugin.parsePage?.(path, page),
						),
					),
				);
				for (const result of results)
					chapters.push(...(result?.chapters ?? []));
			}
			return chapters;
		}

		toEpisode(chapter: ChapterItem): Episode {
			const scanlator = Array.isArray(chapter.scanlator)
				? chapter.scanlator.join(", ")
				: chapter.scanlator;
			return {
				id: { uid: chapter.path },
				name: String(chapter.name ?? ""),
				url: resolveUrl(this.plugin, chapter.path, false),
				description: scanlator || undefined,
				timestamp: timestampOf(chapter.releaseTime),
			};
		}

		async detail(
			entryid: EntryId,
			settings: Record<string, Setting>,
		): Promise<EntryDetailedResult> {
			await this.beforeCall();
			const path = entryid.uid;
			const novel = await pluginCall("parseNovel", () =>
				this.plugin.parseNovel(path),
			);
			const chapters = await this.chapters(path, novel);
			const extra: Record<string, string> = {};
			if (novel.artist) extra["lnreader:artist"] = novel.artist;
			if (novel.status) extra["lnreader:status"] = novel.status;
			const entry: EntryDetailed = {
				id: { uid: path },
				url: resolveUrl(this.plugin, novel.path || path, true),
				titles: [novel.name]
					.filter((name) => !!name)
					.map((name) => String(name)),
				author: splitList(novel.author),
				meta: extra,
				media_type: "Book",
				status: statusOf(novel.status),
				description: String(novel.summary ?? "").trim(),
				language: meta.lang ?? "",
				cover: this.cover(novel.cover),
				episodes: validItems(chapters).map((chapter) =>
					this.toEpisode(chapter),
				),
				genres: splitList(novel.genres),
			};
			return { entry, settings };
		}

		async source(
			epid: EpisodeId,
			settings: Record<string, Setting>,
		): Promise<SourceResult> {
			await this.beforeCall();
			const html = await pluginCall("parseChapter", () =>
				this.plugin.parseChapter(epid.uid),
			);
			const chapterUrl = resolveUrl(this.plugin, epid.uid, false);
			const imageLink = (src: string): Link | undefined => {
				if (src.startsWith("data:")) return { url: src };
				try {
					return {
						url: new URL(src, chapterUrl).href,
						header: imageHeaders(this.plugin),
					};
				} catch {
					return undefined;
				}
			};
			return {
				source: {
					type: "Paragraphlist",
					paragraphs: htmlToParagraphs(String(html ?? ""), imageLink),
					audio: null,
				},
				settings,
			};
		}
	};
}
