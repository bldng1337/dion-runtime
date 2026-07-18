/// <reference types="@dion-js/extension-types" />

import { Component } from "@dion-js/runtime-lib/component";
import { FeedComponent } from "@dion-js/runtime-lib/feed";
import { Signal, SignalStore } from "@dion-js/runtime-lib/signal";
import { Trigger } from "@dion-js/runtime-lib/trigger";
import {
	Button,
	Card,
	Column,
	Image,
	Link,
	PopView,
	Row,
	ShowToast,
	Spinner,
	Text,
	TextInput,
	Timestamp,
} from "@dion-js/runtime-lib/ui";
import { DionExtension } from "@dion-js/runtime-lib";
import {
	defineEntrySetting,
	defineExtensionSetting,
	defineSearchSetting,
	SettingStore,
} from "@dion-js/runtime-lib/settings";
import { doAction } from "action";
import type {
	CustomUI,
	EntryDetailed,
	EntryDetailedResult,
	Setting,
} from "@dion-js/runtime-types/runtime";
import { EntryExtension } from "@dion-js/runtime-types/extension";

// A demo entry cover. In a real extension this would come from the source.
const DEMO_COVER = { url: "https://example.com/cover.png", header: null };

// ============================================================================
// Types — shared across handlers
// ============================================================================

export interface BindState {
	state: "binding" | "bound" | "error";
	media?: BoundMedia;
	error?: string;
}

export interface BoundMedia {
	id: string;
	title: string;
	cover: string | null;
}

// ============================================================================
// Extension
// ============================================================================

const BIND_SETTING = "customui_bind";

/**
 * Demonstrates the redesigned CustomUI model:
 *  - Extension-level typed setting declarations (entrySettings,
 *    extensionSettings) give Components a typed thing to subscribe to.
 *  - Signals carry transient state; entry settings carry durable state.
 *  - Components (Slot handlers) take a mix of static + subscribed inputs.
 *  - FeedComponents paginate.
 *  - Triggers fire side effects via doAction + signal writes.
 *  - Button / TextInput carry Interactions (Invoke via Trigger, WriteKey via
 *    Signal); the lib introspects the target to pick the wire variant.
 */
export default class extends DionExtension implements EntryExtension {
	// Per-entry setting.
	entrySettings = {
		bind: defineEntrySetting<string>(BIND_SETTING, {
			label: "CustomUI Bind",
			visible: true,
		}),
	};

	// Extension Settings
	settings = {
		repeat: defineExtensionSetting<boolean>("customui_repeat", {
			label: "Repeat",
			default: false,
			visible: true,
		}),
	};
	accounts = {};

	// Transient signals. Reset on worker restart.
	signals = {
		searchQuery: new Signal<string>("customui_search_query"),
		bindStatus: new SignalStore<BindState>("customui_bind_status"),
	};

	// Slot handlers. `entryView` subscribes to BOTH the transient bind status
	// AND the durable entry setting, so it survives restarts.
	components = {
		entryView: new Component<{
			entryId: { uid: string }; // static
			mediaType: string; // static
			status: BindState | undefined; // transient signal
			bound: string; // durable entry setting
		}>("customui_entry_view", async (s) => this.renderEntryView(s)),

		searchResults: new Component<{
			entryId: { uid: string }; // static
			query: string; // reactive (subscribed to searchQuery)
		}>("customui_search_results", async ({ entryId, query }) =>
			this.feeds.search.build({ entryId, query }),
		),
	};

	// Feed handlers.
	feeds = {
		search: new FeedComponent<{
			entryId: { uid: string };
			query: string;
		}>("customui_search_feed", (data, page) => this.searchPage(data, page)),
	};

	// Trigger handlers. Fire-and-forget; side effects via doAction + signals.
	triggers = {
		bind: new Trigger<{ entryId: { uid: string }; media: BoundMedia }>(
			"customui_bind",
			(data) => this.bindMedia(data),
		),
		toast: new Trigger<{ message: string }>("customui_toast", async (data) => {
			await doAction(ShowToast(`Toast: ${data.message}`, "Info"));
		}),
	};

	// --------------------------------------------------------------------------
	// Lifecycle: detail() builds the CustomUI tree
	// --------------------------------------------------------------------------

	async mapEntry(
		entry: EntryDetailed,
		settings: Record<string, Setting>,
	): Promise<EntryDetailedResult> {
		const store = new SettingStore(settings);
		entry.ui = this.entryScreen(entry.id);

		return { entry, settings: store.toMap() };
	}

	/** Entry screen: image, links, a Slot bound to entryView, a toast button. */
	private entryScreen(entryId: { uid: string }) {
		return Column(
			Text("CustomUI Redesign Demo"),
			Image(DEMO_COVER, 120, 180),
			Link("https://example.com", "Open website"),
			Timestamp(Date.now().toString(), "Relative"),

			// Slot: subscribes to the transient bindStatus signal AND the
			// durable bind entry setting. The placeholder Spinner shows until
			// the first LoadSlot response arrives.
			this.components.entryView.build({
				entryId, // static
				mediaType: "Book", // static
				status: this.signals.bindStatus.at(entryId.uid), // transient
				bound: this.entrySettings.bind.asSubRef(entryId), // durable
			}),

			// A row of buttons. Passing a Trigger directly is sugar for
			// `trigger.invoke(undefined)`.
			Row(
				Button("Say hi", this.triggers.toast.invoke({ message: "hi" })),
				Button("Toast raw", this.triggers.toast),
			),
		);
	}

	/** Render the entryView Slot content from its merged state. */
	private renderEntryView(s: {
		entryId: { uid: string };
		mediaType: string;
		status: BindState | undefined;
		bound: string;
	}): CustomUI {
		const bound =
			s.bound && s.bound != "null"
				? (JSON.parse(s.bound) as BoundMedia)
				: undefined;
		if (s.status?.state === "binding") return Spinner();
		if (s.status?.state === "error")
			return Column(Text(`Error: ${s.status.error}`));
		if (bound)
			return Column(
				Text(`Bound: ${bound.title}`),
				Button("Re-toast", this.triggers.toast.invoke({ message: "re" })),
			);
		// Unbound: show a search box + a subscribed results Slot.
		return Column(
			TextInput({
				onChange: this.signals.searchQuery, // Signal -> WriteKey (no round-trip)
				debounceMs: 250,
				initial: "",
			}),
			this.components.searchResults.build({
				entryId: s.entryId, // static
				query: this.signals.searchQuery, // bare Signal accepted as SubRef<string>
			}),
		);
	}

	/** Search feed: paginate fake results filtered by the query. */
	private async searchPage(
		data: { entryId: { uid: string }; query: string },
		page: number,
	): Promise<{ items: CustomUI[]; hasMore: boolean }> {
		const q = (data.query ?? "").toLowerCase();
		const start = page * 5;
		const items = Array.from({ length: 5 }, (_, i) => {
			const n = start + i + 1;
			const title = q ? `${q} result ${n}` : `result ${n}`;
			const media: BoundMedia = {
				id: `m-${n}`,
				title,
				cover: null,
			};
			return Card(
				DEMO_COVER,
				Text(title),
				Column(
					Text(`for ${data.entryId.uid}`),
					Button(
						"Bind",
						this.triggers.bind.invoke({ entryId: data.entryId, media }),
					),
				),
			);
		});
		return { items, hasMore: page < 2 };
	}

	/** Bind trigger: publishes the binding status signal + pops the view. */
	private async bindMedia(data: {
		entryId: { uid: string };
		media: BoundMedia;
	}): Promise<void> {
		await this.signals.bindStatus.write(data.entryId.uid, {
			state: "binding",
		});
		try {
			await this.signals.bindStatus.write(data.entryId.uid, {
				state: "bound",
				media: data.media,
			});
		} catch (e) {
			await this.signals.bindStatus.write(data.entryId.uid, {
				state: "error",
				error: String(e),
			});
			await doAction(ShowToast(`Failed to bind: ${e}`, "Error"));
			return;
		}
		await doAction(PopView());
	}
}
