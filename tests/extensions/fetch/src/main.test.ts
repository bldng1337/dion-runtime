/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import type {
	Entry,
	EntryDetailed,
	Source,
} from "@dion-js/runtime-types/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";
import { join } from "node:path";

test("test fetch", async () => {
	const server: Server<unknown> = Bun.serve({
		port: 3002,
		async fetch(req) {
			const url = new URL(req.url);
			const path = url.pathname;

			if (path === "/get") {
				return Response.json({ url: url.href });
			} else if (path === "/post") {
				let jsonBody: unknown = {};
				if (req.method === "POST") {
					try {
						jsonBody = await req.json();
					} catch {
						// Ignore parse errors
					}
				}
				return Response.json({ url: url.href, json: jsonBody });
			} else if (path === "/headers") {
				return Response.json({
					headers: Object.fromEntries(req.headers.entries()),
				});
			} else if (path === "/cookies/set") {
				const params = url.searchParams;
				const cookies = Array.from(params.entries()).map(
					([key, value]) => `${key}=${value}`,
				);
				if (cookies !== null) {
					return new Response(
						JSON.stringify({
							cookies: cookies,
						}),
						{
							headers: [
								...cookies.map(
									(cookie) => ["Set-Cookie", cookie] as [string, string],
								),
								["Content-Type", "application/json"],
							],
						},
					);
				}
				return new Response("Bad Request", { status: 400 });
			} else if (path === "/status/404") {
				return new Response("Not Found", { status: 404 });
			} else if (path === "/testCookie") {
				return Response.json({});
			} else if (path === "/getEntries") {
				const entries: Entry[] = [
					{
						id: {
							uid: "test",
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
				return Response.json(entries);
			} else if (path === "/getEntry") {
				const entry: EntryDetailed = {
					id: {
						uid: "test",
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
				return Response.json(entry);
			} else if (path === "/getSource") {
				const source: Source = {
					type: "Epub",
					link: {
						header: null,
						url: "",
					},
				};
				return Response.json(source);
			} else {
				return new Response("Not Found", { status: 404 });
			}
		},
	});

	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;

	await utils.injectServer(server, ext);
	await ext.setEnabled(true);
});
