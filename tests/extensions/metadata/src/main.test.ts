/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import { copyFile, mkdir, readFile } from "node:fs/promises";
import { join } from "node:path";

const FIXTURES = join(import.meta.dir, "../../../fixtures/metadata");

test("metadata inspection and binary proxy serving", async () => {
	const server = Bun.serve({
		port: 30017,
		async fetch(req) {
			const path = new URL(req.url).pathname;
			if (path === "/sample.epub") {
				return new Response(await readFile(join(FIXTURES, "sample.epub")));
			}
			if (path === "/text") {
				return new Response("hello dion");
			}
			return new Response("Not Found", { status: 404 });
		},
	});

	// Copy the fixtures into the extension's data dir so the local-file flows
	// read real containers through the filesystem module.
	const dataDir = join(import.meta.dir, "../.dist/metadata");
	await mkdir(dataDir, { recursive: true });
	for (const name of ["sample.epub", "sample.m4b", "sample.mp3"]) {
		await copyFile(join(FIXTURES, name), join(dataDir, name));
	}

	const mockmanager = new MockManagerClient(join(import.meta.dir, "../.dist"));
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	await utils.injectServer(server, ext);
	// load() runs every module assertion; enabling fails the test if any
	// of them threw.
	await ext.setEnabled(true);
	await new Promise((resolve) => setTimeout(resolve, 100));

	const proxyAddressSetting = await ext.getSetting("proxyAddress", "Extension");
	expect(proxyAddressSetting.value.type).toBe("String");
	const proxyAddr = (
		proxyAddressSetting.value as { type: "String"; data: string }
	).data;
	expect(proxyAddr).not.toBe("");

	// The proxy serves the binary cover extracted from the local epub; the
	// bytes must match the fixture cover the epub was built from.
	const coverRes = await fetch(`${proxyAddr}/cover`);
	if (!coverRes.ok) {
		console.error(`Failed with body:\n ${await coverRes.text()}`);
	}
	expect(coverRes.status).toBe(200);
	expect(coverRes.headers.get("Content-Type")).toBe("image/png");
	const served = new Uint8Array(await coverRes.arrayBuffer());
	const expected = new Uint8Array(await readFile(join(FIXTURES, "cover.png")));
	expect(served.length).toBe(expected.length);
	expect(Buffer.compare(Buffer.from(served), Buffer.from(expected))).toBe(0);

	server.stop(true);
});
