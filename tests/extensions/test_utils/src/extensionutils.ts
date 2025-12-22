/// <reference types="@dion-js/extension-types" />

import type {
	EntryExtension,
	Extension,
	SourceProcessorExtension,
	SourceProvider,
} from "@dion-js/runtime-types/extension";
import type {
	EntryActivity,
	EntryDetailed,
	EntryDetailedResult,
	EntryId,
	EntryList,
	EpisodeId,
	EventData,
	EventResult,
	Setting,
	Source,
	SourceResult,
} from "@dion-js/runtime-types/runtime";
import { fetch } from "network";
import { getSetting } from "setting";

export class DefaultExtension
	implements Extension, SourceProvider, EntryExtension, SourceProcessorExtension
{
	async onEvent(data: EventData): Promise<EventResult | undefined> {
		switch (data.type) {
			case "Action":
				return;
			case "FeedUpdate":
				return {
					type: data.type,
					customui: [],
					hasnext: null,
					length: null,
				};
			case "SwapContent":
				return {
					type: data.type,
					customui: {
						type: "Text",
						text: "asd",
					},
				};
		}
	}

	async mapSource(
		source: Source,
		epid: EpisodeId,
		settings: Record<string, Setting>,
	): Promise<SourceResult> {
		return {
			source: source,
			settings: settings,
		};
	}
	async mapEntry(
		entry: EntryDetailed,
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		return {
			entry: entry,
			settings: settings,
		};
	}
	async onEntryActivity(
		_activity: EntryActivity,
		_entry: EntryDetailed,
		_settings: Record<string, Setting>,
	): Promise<void> {}

	async browse(_page: number): Promise<EntryList> {
		const server = await getServer();
		const data = await fetch(`${server}/getEntries`);
		return {
			content: data.json,
		};
	}
	async search(_page: number, _filter: string): Promise<EntryList> {
		const server = await getServer();
		const data = await fetch(`${server}/getEntries`);
		return {
			content: data.json,
		};
	}
	async handleUrl(_url: string): Promise<boolean> {
		return true;
	}
	async detail(
		_entryid: EntryId,
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		const server = await getServer();
		const data = await fetch(`${server}/getEntry`);
		return {
			entry: data.json,
			settings: settings,
		};
	}
	async source(
		_epid: EpisodeId,
		settings: Record<string, Setting>,
	): Promise<SourceResult> {
		const server = await getServer();
		const data = await fetch(`${server}/getSource`);
		return {
			source: data.json,
			settings: settings,
		};
	}
}

export async function getServer() {
	const res = await getSetting("testdataserver", "Extension");
	const server = res.value.data as string;
	if (res.value.type !== "String") {
		throw Error("Failed to get Server");
	}
	if (server.endsWith("/")) {
		return server.substring(0, server.length - 1);
	}
	return server;
}

export function assert(
	condition: boolean,
	msg = "Extension error",
): asserts condition {
	if (!condition) {
		throw new Error(`Assert failed: ${msg}`);
	}
}

export function assertDeepEqual(expect: unknown, is: unknown, msg = "Assert") {
	const [ok, err] = deepEqual(expect, is);
	if (!ok) {
		throw new Error(` ${msg} failed: ${err}`);
	}
}

function deepEqual(expect: unknown, is: unknown, path = ""): [boolean, string] {
	if (typeof expect !== typeof is) {
		return [
			false,
			`Failed at ${path}. Expected ${typeof expect} but got ${typeof is}`,
		];
	}
	if (Array.isArray(expect) && Array.isArray(is)) {
		if (expect.length !== is.length) {
			return [
				false,
				`Failed at ${path}. Expected array of length ${expect.length} but got length ${is.length} \nexpected: ${JSON.stringify(expect)}\ngot: ${JSON.stringify(is)}`,
			];
		}
		for (let i = 0; i < expect.length; i++) {
			const [ok, err] = deepEqual(expect[i], is[i], `${path}[${i}]`);
			if (!ok) {
				return [false, err];
			}
		}
	} else if (expect instanceof Object && is instanceof Object) {
		for (const key of Object.keys(expect)) {
			//@ts-expect-error
			const [ok, err] = deepEqual(expect[key], is[key], `${path}.${key}`);
			if (!ok) {
				return [false, err];
			}
		}
	} else if (expect !== is) {
		return [
			false,
			`Failed at ${path}. Expected ${expect} but got ${is} \nexpected: ${JSON.stringify(expect)}\ngot: ${JSON.stringify(is)}`,
		];
	}
	return [true, ""];
}
