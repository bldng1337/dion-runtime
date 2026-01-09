import { $, file } from "bun";
import { exists, stat } from "node:fs/promises";
import * as paths from "node:path";
import { test, expect } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import { join } from "node:path";
const path = join(import.meta.path, "../../..");
console.log(path);
await $`cd ${path} && bunx dion-build-index`;

test("repo extension test", async () => {
	const server = Bun.serve({
		async fetch(req) {
			console.log("Request URL:", req.url);
			const url = new URL(req.url);
			let filePath = paths.join(
				__dirname,
				"../../.index",
				decodeURIComponent(url.pathname),
			);
			// If path is a directory, serve index.html
			if ((await exists(filePath)) && (await stat(filePath)).isDirectory()) {
				filePath = paths.join(filePath, "index.html");
			}
			if ((await exists(filePath)) && (await stat(filePath)).isFile()) {
				return new Response(Bun.file(filePath));
			} else {
				return new Response("Not Found", { status: 404 });
			}
		},
	});
	// Optionally, wait for the server to be ready before running tests
	await new Promise((resolve) => setTimeout(resolve, 100));

	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);
	const manager = await Adapter.init(mockmanager.client);

	const repo = await manager.getRepo(
		`http://127.0.0.1:${server.port}/index.repo.json`,
	);
	expect(repo).toBeDefined();
	if (!repo) return;
	const exts = await manager.browseRepo(repo, 0);
	expect(exts.content.length).toBeGreaterThan(0);
});
