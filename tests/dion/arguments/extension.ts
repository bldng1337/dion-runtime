/// <reference path="../../../js/dion_extension_types/index.d.ts" />
import { assert, DefaultExtension } from "../extensionutils";

export default class extends DefaultExtension {
	browse(page: number): Promise<EntryList> {
		assert(typeof page === "number", "Argument page of browse is not a number");
		return super.browse(page);
	}
	detail(
		entryid: string,
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		assert(
			typeof entryid === "string",
			"Argument entryid of detail is not a string",
		);
		assert(
			typeof settings === "object" && settings !== null,
			"Argument settings of detail is not an object",
		);
		return super.detail(entryid, settings);
	}

	fromUrl(url: string): Promise<boolean> {
		assert(typeof url === "string", "Argument url of fromUrl is not a string");
		return super.fromUrl(url);
	}

	mapEntry(
		entry: EntryDetailed,
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		assert(
			typeof entry === "object" && entry !== null,
			"Argument entry of mapEntry is not an object",
		);
		assert(
			typeof settings === "object" && settings !== null,
			"Argument settings of mapEntry is not an object",
		);
		return super.mapEntry(entry, settings);
	}

	mapSource(
		source: Source,
		settings: Record<string, Setting>,
	): Promise<SourceResult> {
		assert(
			typeof source === "object" && source !== null,
			"Argument source of mapSource is not an object",
		);
		assert(
			typeof settings === "object" && settings !== null,
			"Argument settings of mapSource is not an object",
		);
		return super.mapSource(source, settings);
	}

	onEntryActivity(
		activity: EntryActivity,
		entry: EntryDetailed,
		settings: Record<string, Setting>,
	): Promise<void> {
		assert(
			typeof activity === "object" && activity !== null,
			"Argument activity of onEntryActivity is not an object",
		);
		assert(
			typeof entry === "object" && entry !== null,
			"Argument entry of onEntryActivity is not an object",
		);
		assert(
			typeof settings === "object" && settings !== null,
			"Argument settings of onEntryActivity is not an object",
		);
		return super.onEntryActivity(activity, entry, settings);
	}

	search(page: number, filter: string): Promise<EntryList> {
		assert(typeof page === "number", "Argument page of search is not a number");
		assert(
			typeof filter === "string",
			"Argument filter of search is not a string",
		);
		return super.search(page, filter);
	}

	source(
		epid: string,
		settings: Record<string, Setting>,
	): Promise<SourceResult> {
		assert(typeof epid === "string", "Argument epid of source is not a string");
		assert(
			typeof settings === "object" && settings !== null,
			"Argument settings of source is not an object",
		);
		return super.source(epid, settings);
	}
}
