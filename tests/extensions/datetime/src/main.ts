import type {
	EntryDetailed,
	EntryDetailedResult,
	Setting,
} from "@dion-js/runtime-types/runtime";
import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";

const AIRED = "2024-01-02T03:04:05Z";

/** Timestamps flow through the runtime as ISO-8601 strings, but the types
 * allow passing real date objects: `detail` returns a `Temporal.Instant`
 * (converted via its `toJSON` at the Rust boundary) and `mapEntry` shows
 * what the host hands back — canonical ISO-8601 strings. */
export default class extends DefaultExtension {
	async detail(
		_entryid: Parameters<DefaultExtension["detail"]>[0],
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		const entry: EntryDetailed = {
			id: { uid: "epid" },
			url: "",
			titles: ["Datetime"],
			media_type: "Book",
			status: "Unknown",
			description: "",
			language: "",
			episodes: [
				{
					id: { uid: "ep1" },
					name: "Chapter 1",
					url: "",
					timestamp: Temporal.Instant.from(AIRED),
				},
			],
		};
		return { entry, settings };
	}

	async mapEntry(
		entry: EntryDetailed,
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		const timestamp = entry.episodes[0]?.timestamp;
		assert(
			timestamp === undefined ||
				timestamp === null ||
				typeof timestamp === "string",
			"host-provided timestamps are ISO-8601 strings",
		);
		return { entry, settings };
	}

	async load() {
		// Production side: timestamp fields accept Temporal objects directly.
		const episodeTimestamp: EntryDetailed["episodes"][number]["timestamp"] =
			Temporal.Instant.from(AIRED);
		assertDeepEqual(
			AIRED,
			(episodeTimestamp as { toJSON(): string }).toJSON(),
			"Temporal.Instant is a valid Episode.timestamp",
		);
	}
}
