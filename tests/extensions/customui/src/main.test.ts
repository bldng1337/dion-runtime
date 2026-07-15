/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import { join } from "node:path";

// Region logic is unit-tested directly against the runtime-lib source, since
// the napi Extension wrapper does not currently expose `event()`.
import {
	SwapRegion,
	FeedRegion,
	routeEvent,
} from "@dion-js/runtime-lib/region";
import { Text, Column } from "@dion-js/runtime-lib/ui";

// ============================================================================
// Integration: detail() builds a valid CustomUI tree via the builders + regions
// ============================================================================

test("detail() returns a CustomUI tree with regions wired up", async () => {
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	await ext.setEnabled(true);

	const result = await ext.detail({ uid: "entry-1" }, {});

	// The tree is attached to entry.ui
	expect(result.entry.ui).toBeDefined();
	const ui = result.entry.ui as { type: string };

	// Top-level node is a Column
	expect(ui.type).toBe("Column");

	// The tree is a non-empty array of children
	const children = (ui as unknown as { children: unknown[] }).children;
	expect(Array.isArray(children)).toBe(true);
	expect((children as unknown[]).length).toBeGreaterThan(0);
});

// ============================================================================
// Unit: SwapRegion routes by targetid, types events, handles void events
// ============================================================================

test("SwapRegion routes SwapContent events by id and decodes data", async () => {
	const region = new SwapRegion("panel", {
		// annotated params drive the inferred EventMap:
		//   { load: string; clear: void }
		load: async (entryId: string) => Text(`loaded:${entryId}`),
		clear: async () => Text("cleared"),
	});

	// build() emits a Slot node with the region's id and a Spinner placeholder
	const node = region.build() as {
		type: string;
		id: string;
		child: { type: string };
	};
	expect(node.type).toBe("Slot");
	expect(node.id).toBe("panel");
	expect(node.child.type).toBe("Spinner");

	// a typed data event: data is JSON-encoded by swap(), decoded by handle()
	const res1 = await region.handle({
		type: "SwapContent",
		targetid: "panel",
		event: "load",
		data: JSON.stringify("entry-9"),
	});
	expect(res1?.type).toBe("SwapContent");
	expect((res1 as { customui: { text: string } }).customui.text).toBe(
		"loaded:entry-9",
	);

	// a void event: swap("clear") takes no data argument
	const res2 = await region.handle({
		type: "SwapContent",
		targetid: "panel",
		event: "clear",
		data: "",
	});
	expect((res2 as { customui: { text: string } }).customui.text).toBe(
		"cleared",
	);

	// not for this region
	const res3 = await region.handle({
		type: "SwapContent",
		targetid: "other",
		event: "load",
		data: "",
	});
	expect(res3).toBeUndefined();
});

test("SwapRegion.build(mount) wires an on_mount swap action", async () => {
	const region = new SwapRegion("panel", {
		init: async (id: string) => Text(`init:${id}`),
	});
	const node = region.build({ event: "init", data: "abc" }) as {
		on_mount: { type: string; targetid: string; event: string; data: string };
	};
	expect(node.on_mount.type).toBe("SwapContent");
	expect(node.on_mount.targetid).toBe("panel");
	expect(node.on_mount.event).toBe("init");
	expect(JSON.parse(node.on_mount.data)).toBe("abc");
});

// ============================================================================
// Unit: FeedRegion routes by event name and returns paginated results
// ============================================================================

test("FeedRegion routes FeedUpdate and returns items with hasNext", async () => {
	const region = new FeedRegion<{ entryId: string }>(
		"list",
		async (data, page) => ({
			items: [Text(`${data.entryId}:${page}`)],
			hasNext: page < 2,
		}),
	);

	const node = region.build({ entryId: "e1" }) as {
		type: string;
		event: string;
		data: string;
	};
	expect(node.type).toBe("Feed");
	expect(node.event).toBe("list");
	expect(JSON.parse(node.data)).toEqual({ entryId: "e1" });

	const res = await region.handle({
		type: "FeedUpdate",
		event: "list",
		data: JSON.stringify({ entryId: "e1" }),
		page: 0,
	});
	expect(res?.type).toBe("FeedUpdate");
	const feed = res as {
		customui: { text: string }[];
		hasnext: boolean | null;
	};
	expect(feed.customui[0]!.text).toBe("e1:0");
	expect(feed.hasnext).toBe(true);
});

// ============================================================================
// Unit: routeEvent dispatches to the first claiming region
// ============================================================================

test("routeEvent dispatches across a regions collection", async () => {
	const swap = new SwapRegion("s", { go: async (n: number) => Text(`n${n}`) });
	const feed = new FeedRegion("f", async () => ({ items: [Text("item")] }));

	const res = await routeEvent(
		{ swap, feed },
		{
			type: "SwapContent",
			targetid: "s",
			event: "go",
			data: JSON.stringify(42),
		},
	);
	expect((res as { customui: { text: string } }).customui.text).toBe("n42");

	const res2 = await routeEvent(
		{ swap, feed },
		{
			type: "FeedUpdate",
			event: "f",
			data: "",
			page: 0,
		},
	);
	expect((res2 as { customui: { text: string }[] }).customui[0]!.text).toBe(
		"item",
	);

	// unknown target → undefined
	const res3 = await routeEvent(
		{ swap, feed },
		{
			type: "SwapContent",
			targetid: "nope",
			event: "go",
			data: "",
		},
	);
	expect(res3).toBeUndefined();
});

// Sanity: the builders used above compose into a valid tree
test("builders compose", () => {
	const tree = Column(Text("a"), Text("b"));
	expect(tree.type).toBe("Column");
	expect((tree as { children: unknown[] }).children.length).toBe(2);
});
