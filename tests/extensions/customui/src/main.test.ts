/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import { join } from "node:path";

import type {
	CustomUI,
	EntryDetailed,
	Interaction,
} from "@dion-js/runtime-types/runtime";

// ============================================================================
// Integration: mapEntry() builds a valid CustomUI tree using the new model.
// Verifies the tree carries a Slot with subscriptions to both a store signal
// and an entry setting (the AniList pattern), plus a Button/TextInput wired
// up via the new Interaction mechanism.
// ============================================================================

test("mapEntry() returns a CustomUI tree with the new model wired up", async () => {
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	await ext.setEnabled(true);

	const entry: EntryDetailed = {
		id: { uid: "entry-1" },
		url: "",
		titles: [],
		author: null,
		ui: null,
		meta: null,
		media_type: "Book",
		status: "Unknown",
		description: "",
		language: "",
		cover: null,
		episodes: [],
		genres: null,
		rating: null,
		views: null,
		length: null,
	};
	const result = await ext.mapEntry(entry, {});
	expect(result.entry.ui).toBeDefined();
	const ui = result.entry.ui as CustomUI;

	// Top-level node is a Column.
	expect(ui.type).toBe("Column");

	// Find the Slot node (the entryView). It must declare two subscriptions:
	// a Store signal (bind_status) and an EntrySetting (bind).
	const slot = findNode(ui, (n) => n.type === "Slot") as
		| {
				type: "Slot";
				handler: string;
				static_data: string;
				subscriptions: Array<{
					source: { type: string; kind?: string };
					key: string;
					state_key: string;
				}>;
		  }
		| undefined;
	expect(slot).toBeDefined();
	expect(slot?.handler).toBe("customui_entry_view");

	const subs = slot?.subscriptions ?? [];
	expect(subs.length).toBe(2);

	const storeSub = subs.find((s) => s.source.type === "Store");
	const entrySettingSub = subs.find((s) => s.source.type === "EntrySetting");
	expect(storeSub).toBeDefined();
	expect(storeSub?.key).toBe("customui_bind_status:entry-1");
	expect(storeSub?.state_key).toBe("status");
	expect(entrySettingSub).toBeDefined();
	expect(entrySettingSub?.key).toBe("entry-1:customui_bind");
	expect(entrySettingSub?.state_key).toBe("bound");

	// static_data carries entryId + mediaType (captured at build time).
	const statics = JSON.parse(slot?.static_data ?? "{}");
	expect(statics.entryId.uid).toBe("entry-1");
	expect(statics.mediaType).toBe("Book");
	// `status` and `bound` are subscriptions, NOT statics.
	expect(statics.status).toBeUndefined();
	expect(statics.bound).toBeUndefined();

	// The tree has at least one Button whose on_click is an Invoke Interaction
	// pointing at the toast trigger.
	const invokeButton = findNode(
		ui,
		(n) =>
			n.type === "Button" &&
			(n as { on_click: { type: string } | null }).on_click?.type === "Invoke",
	) as
		| {
				type: "Button";
				label: string;
				on_click: Interaction | null;
		  }
		| undefined;
	expect(invokeButton).toBeDefined();
	expect(invokeButton?.on_click?.type).toBe("Invoke");
	if (invokeButton?.on_click?.type === "Invoke") {
		expect(invokeButton.on_click.handler).toBe("customui_toast");
	}
});

// ============================================================================
// Helpers
// ============================================================================

/** Depth-first search for the first CustomUI node matching `pred`. */
function findNode(
	root: CustomUI,
	pred: (n: CustomUI) => boolean,
): CustomUI | undefined {
	if (pred(root)) return root;
	const children = childrenOf(root);
	for (const c of children) {
		const found = findNode(c, pred);
		if (found) return found;
	}
	return undefined;
}

function childrenOf(n: CustomUI): CustomUI[] {
	switch (n.type) {
		case "Column":
		case "Row":
			return n.children;
		case "Card":
			return [n.top, n.bottom];
		case "Slot":
			return [n.child];
		default:
			return [];
	}
}
