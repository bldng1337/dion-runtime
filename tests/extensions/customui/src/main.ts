/// <reference types="@dion-js/extension-types" />

import {
	Button,
	Card,
	Column,
	Do,
	Image,
	Link,
	OpenBrowser,
	Popup,
	Row,
	Spinner,
	Text,
	Timestamp,
} from "@dion-js/runtime-lib/ui";
import { FeedRegion, SwapRegion } from "@dion-js/runtime-lib/region";
import { DionExtension } from "@dion-js/runtime-lib";
import { ExtensionSetting } from "@dion-js/runtime-lib/settings";
import { Trigger } from "@dion-js/runtime-lib/trigger.js";

// A demo entry cover. In a real extension this would come from the source.
const DEMO_COVER = { url: "https://example.com/cover.png", header: null };

// ============================================================================
// Regions — declared once; the slot id, swap triggers, and handlers all bind
// to the same instance. `onEvent` is inherited from DionExtension and routes
// events to these automatically.
// ============================================================================

// A SwapRegion whose `reload` event carries a typed string (the entry id),
// and whose `toggle` event is void (no data argument).
const details = new SwapRegion("details", {
	// handler params MUST be annotated so TS infers the EventMap:
	//   { reload: string; toggle: void }
	reload: async (entryId: string) => {
		return Column(
			Text(`Loaded details for ${entryId}`),
			Timestamp(Date.now().toString()),
		);
	},
	toggle: async () => {
		return Text("Toggled!");
	},
});

// A FeedRegion paginating a list of "chapter" cards. The feed carries the
// entry id as typed data.
const chapters = new FeedRegion<{ entryId: string }>(
	"chapters",
	async (data, page) => {
		// Pretend to paginate: 5 chapters per page, 3 pages total.
		const start = page * 5;
		const count = Math.min(5, 15 - start);
		const items = Array.from({ length: count }, (_, i) =>
			Card(
				DEMO_COVER,
				Text(`Chapter ${start + i + 1}`),
				Text(`for ${data.entryId}`),
			),
		);
		return { items, hasNext: start + count < 15 };
	},
);

export default class extends DionExtension {
	settings = {
		repeat: new ExtensionSetting("repeat", false, "Extension"),
	};
	accounts = {};

	regions = {
		details,
		chapters,
  };
  triggers = {
    test: new Trigger("test", async (data: { message: string }) => {
      return {
        type: "SwapContent",
        customui: Column(
          Text(`Test trigger received: ${data.message}`),
          Spinner(),
        ),
      };
    }),
  };

	async detail(entryId: { uid: string }) {
		const entry = {
			id: entryId,
			url: "https://example.com/entry",
			titles: ["CustomUI Demo"],
			media_type: "Book" as const,
			status: "Releasing" as const,
			description: "Demonstrates the CustomUI DSL and Regions.",
			language: "en",
			episodes: [],
			ui: undefined as unknown,
		};

		// Build the CustomUI tree. Note:
		//  - details.build(...) auto-loads on mount (fires `reload` with entryId)
		//  - details.swap(...) produces a typed UIAction bound to the region id
		//  - cond ? ui : undefined works directly in Column (no If helper needed)
		entry.ui = Column(
			Text("CustomUI Demo Extension"),
			Image(DEMO_COVER, 120, 180),
			Link("https://example.com", "Open website"),
			Timestamp(Date.now().toString(), "Relative"),

			// Auto-populating slot: fires `reload` on mount, shows Spinner until it resolves.
			this.regions.details.build({ event: "reload", data: entryId.uid }),

			// Buttons triggering swaps. `swap()` returns a UIAction directly;
			// void events omit the data argument.
			Row(
				Button("Reload", this.regions.details.swap("reload", entryId.uid)),
				Button("Toggle", this.regions.details.swap("toggle")),
			),

			// A button that triggers a plain Action (opens a browser).
			Button("Open site", Do(OpenBrowser("https://example.com"))),

			// A button that opens a Popup. Popup actions take a raw Action
			// (not a UIAction), so we pass OpenBrowser directly.
			Button(
				"More",
				Do(
					Popup("Actions", Text("Choose an action"), [
						{ label: "Visit", onclick: OpenBrowser("https://example.com") },
					]),
				),
			),

			// Paginated feed.
			this.regions.chapters.build({ entryId: entryId.uid }),
		);

		return { entry, settings: {} };
	}
}
