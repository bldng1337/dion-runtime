/// <reference types="@types/bun" />
// Integration test for a Dion extension. Runs the BUILT bundle through the real native
// runtime, so always `bun run build` before `bun test`.
//
// Two modes are shown:
//  1. Offline-ish (no backend): just exercise the contract with whatever the extension returns.
//  2. With a mock backend: spin up Bun.serve and inject its URL via a setting so the
//     extension's fetch() hits your controlled routes.

import { beforeAll, describe, expect, it } from "bun:test";
import {
	assertValidEntries,
	assertValidEntry,
	assertValidSource,
	getTestExtension,
	MockManagerClient,
} from "@dion-js/extension-test-utils";
import type { Extension } from "@dion-js/runtime";
import type { Entry, EntryDetailedResult, Setting } from "@dion-js/runtime-types/runtime";
import { join } from "node:path";

let extension: Extension;
let browseResult: Entry[];

beforeAll(async () => {
	// MockManagerClient points at the directory holding .dist/<name>.dion.js.
	const client = new MockManagerClient(join(import.meta.path, "../../.dist"));
	extension = await getTestExtension(client.client);
	await extension.setEnabled(true);
	const data = await extension.getData();
	expect(data.compatible).toBe(true);
	browseResult = [];
});

describe("Extension", () => {
	it("is enabled", async () => {
		expect(extension.enabled).toBe(true);
	});

	it("browses entries", async () => {
		const result = await extension.browse(0);
		expect(result.content.length).toBeGreaterThan(0);
		// assertValidEntries HEAD-checks entry/cover URLs — comment out for offline tests.
		await assertValidEntries(result.content);
		browseResult = result.content;
	});

	it("searches entries", async () => {
		const result = await extension.search(0, "test");
		expect(result.content).toBeDefined();
	});

	it("returns entry detail", async () => {
		if (browseResult.length === 0) throw new Error("No browse result to detail");
		const result = await extension.detail(browseResult[0]!.id, {});
		expect(result.entry).toBeDefined();
		await assertValidEntry(result.entry);
		const detail: EntryDetailedResult = result;

		it("returns a source for an episode", async () => {
			if (detail.entry.episodes.length === 0) return;
			const src = await extension.source(
				detail.entry.episodes[0]!.id,
				(detail.settings ?? {}) as Record<string, Setting>,
			);
			await assertValidSource(src.source);
		});
	});
});

// --- Mode 2: mock backend -----------------------------------------------------
// Uncomment/replace the beforeAll above with this when your extension talks to a server.
//
// import { Adapter } from "@dion-js/runtime";
// import type { Server } from "bun";
//
// let server: Server<unknown>;
// beforeAll(async () => {
//   server = Bun.serve({
//     port: 0,
//     async fetch(req) {
//       const path = new URL(req.url).pathname;
//       if (path === "/list/1") return Response.json([/* Entry[] */]);
//       if (path === "/work/x") return Response.json(/* EntryDetailed */);
//       return new Response("ok");
//     },
//   });
//   const mock = new MockManagerClient(join(import.meta.path, "../../.dist"));
//   const manager = await Adapter.init(mock.client);
//   extension = (await manager.getExtensions())[0]!;
//   // Inject the mock server URL into whatever setting the extension reads as its base URL.
//   await extension.mergeSettingDefinition("backend", "Extension", {
//     visible: false,
//     label: "Backend",
//     default: { type: "String", data: server.url.toString() },
//     value: { type: "String", data: server.url.toString() },
//   });
//   await extension.setEnabled(true);
// });
