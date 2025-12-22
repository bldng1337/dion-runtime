/// <reference types="bun" />
import type { Extension } from "@dion-js/runtime";
import type {
	Entry,
	EntryDetailed,
	Source,
} from "@dion-js/runtime-types/runtime";
import type { Server } from "bun";

export async function injectServer(server: Server<unknown>, ext: Extension) {
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
	});
}

export function getDefaultRoutes() {
	return {
		"/getEntry": () => {
			const entry: EntryDetailed = {
				id: {
					uid: "",
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
						uid: "",
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
	};
}
