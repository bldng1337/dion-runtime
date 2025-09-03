/// <reference path="../../../js/dion_runtime_types/index.d.ts" />

import { expect, test } from "bun:test";
import type { Server } from "bun";
import { ExtensionManager } from "../../../js/dion_runtime";
import * as utils from "../utils";

test("test arguments", async () => {
	const server: Server = Bun.serve({
		routes: {
			...utils.getDefaultRoutes(),
		},
	});

	const mockmanager = new utils.MockManagerClient("./arguments");
	const manager = await ExtensionManager.init(mockmanager.client);
	const ext = (await manager.getExtension())[0];
	expect(ext).toBeDefined();

	await utils.injectServer(server, ext);
	await ext.setEnabled(true);

	await ext.browse(0);
	await ext.search(0, "");
	const entry = await ext.detail("", {});
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
	const source = await ext.source("epid", {});
	await ext.mapSource(source.source, {});
});
