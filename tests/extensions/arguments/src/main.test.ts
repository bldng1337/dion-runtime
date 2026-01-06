/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";
import { join } from "node:path";

test("test arguments", async () => {
	const server: Server<unknown> = Bun.serve({
		port: 30012,
		routes: {
			...utils.getDefaultRoutes(),
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
});
