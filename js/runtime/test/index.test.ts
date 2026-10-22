import { afterAll, expect, test } from "bun:test";
import { mkdirSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import type {
	Entry,
	EntryDetailed,
	Source,
} from "@dion-js/runtime-types/runtime";
import {
	Adapter,
	ExtensionClient,
	ManagerClient,
	setLogger,
	setLogLevel,
} from "../index.js";

const managerpath = join(
	import.meta.path,
	"../../../../tests/extensions/native/.dist",
);

/** Builds a manager whose extension bundles live in `dir`. */
function managerFor(dir: string) {
	return Adapter.init(
		new ManagerClient(
			(_err, _extdata) => {
				return new ExtensionClient(
					(_err, _arg) => "",
					(_err, _key, _arg) => {},
					(_err, _action) => {},
					(_err, _asd) => {
						return true;
					},
					() => {
						return dir;
					},
					(_err, _entry, _key, _value) => {},
					(_err, _key, _value) => {},
				);
			},
			(_err) => {
				return dir;
			},
		),
	);
}
console.log(managerpath);
const server = Bun.serve({
	port: 3001,
	routes: {
		"/getEntry": () => {
			const entry: EntryDetailed = {
				id: {
					uid: "epid",
				},
				url: "",
				titles: [],
				author: null,
				ui: null,
				meta: null,
				media_type: "Video",
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
			return new Response(JSON.stringify(entry));
		},
		"/getEntries": () => {
			const entries: Entry[] = [
				{
					id: {
						uid: "epid",
					},
					url: "",
					title: "",
					media_type: "Video",
					cover: null,
					author: null,
					rating: null,
					views: null,
					length: null,
				},
			];
			return new Response(JSON.stringify(entries));
		},
		"/getSource": () => {
			const source: Source = {
				type: "Epub",
				link: {
					header: null,
					url: "",
				},
			};
			return new Response(JSON.stringify(source));
		},
	},
});
console.log(`Hosting on: ${server.url}`);

test("DionExtensionManager", async () => {
	const manager = await managerFor(managerpath);
	const exts = await manager.getExtensions();
	console.log(`Got ${exts.length} Extensions`);
	expect(exts.length).toBeGreaterThan(0);
	for (const ext of exts) {
		await ext.mergeSettingDefinition("testdataserver", "Extension", {
			visible: true,
			label: "Server",
			default: {
				type: "String",
				data: server.url.toString(),
			},
			value: {
				type: "String",
				data: server.url.toString(),
			},
			ui: null,
		});
		await ext.setEnabled(true);

		await ext.browse(0);
		await ext.search(0, "");
		const entry = await ext.detail(
			{
				uid: "epid",
			},
			{},
		);
		await ext.fromurl("");
		await ext.mapEntry(entry.entry, {});
		await ext.onEntryActivity(
			{
				type: "EpisodeActivity",
				progress: 23,
			},
			entry.entry,
			{},
		);
		const source = await ext.source(
			{
				uid: "epid",
			},
			{},
		);
		await ext.mapSource(
			source.source,
			{
				uid: "epid",
			},
			{},
		);

		// Storage usage splits into cache / extension / data buckets and
		// caches can be cleared without touching the rest.
		const usage = await ext.storageUsage();
		expect(typeof usage.cache).toBe("number");
		expect(typeof usage.data).toBe("number");
		expect(usage.extensionBytes).toBeGreaterThan(0);
		await ext.clearCache();
		const afterClear = await ext.storageUsage();
		expect(afterClear.cache).toBe(0);
		expect(afterClear.extensionBytes).toBe(usage.extensionBytes);
	}
});

test("setLogger forwards runtime logs to the host", async () => {
	const seen: string[] = [];
	setLogger((_err, entry) => {
		seen.push(`${entry.level}:${entry.message}`);
	});
	expect(() => setLogLevel("warn")).not.toThrow();

	// A bundle whose first line is not a `//`-comment manifest fails to
	// load during discovery; the runtime reports that through the logger.
	const dir = join(tmpdir(), `dion-logger-${Date.now()}`);
	mkdirSync(dir, { recursive: true });
	writeFileSync(
		join(dir, "broken.dion.js"),
		"this file has no manifest comment",
		"utf8",
	);
	const manager = await managerFor(dir);
	expect((await manager.getExtensions()).length).toBe(0);
	// The log crosses a threadsafe function into JS; give it a tick.
	for (
		let i = 0;
		i < 20 && !seen.some((m) => m.includes("broken.dion.js"));
		i++
	) {
		await new Promise((resolve) => setTimeout(resolve, 50));
	}
	expect(
		seen.some((m) => m.startsWith("error") && m.includes("broken.dion.js")),
	).toBe(true);
});

afterAll(() => {
	server.stop();
});
