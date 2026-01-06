import { expect, test } from "bun:test";
import type {
	Entry,
	EntryDetailed,
	Source,
} from "@dion-js/runtime-types/runtime";
import { Adapter, ExtensionClient, ManagerClient } from "../index.js";
import { join } from "node:path";

const managerpath = join(
	import.meta.path,
	"../../../../tests/extensions/native/.dist",
);
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
	const manager = await Adapter.init(
		new ManagerClient(
			(_err, _extdata) => {
				return new ExtensionClient(
					(_err, _arg) => "",
					(_err, _key, _arg) => {},
					(_err, _action) => {},
					(_err, _asd) => {
						return false;
					},
					() => {
						return managerpath;
					},
				);
			},
			(_err) => {
				return managerpath;
			},
		),
	);
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
	}
});
