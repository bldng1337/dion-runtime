/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";
import { join } from "node:path";

test("test settings", async () => {
	const server: Server<unknown> = Bun.serve({
		port: 3003,
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
	await ext.setEnabled(true); // This will run the `load()` method.

	// Check if the setting was registered correctly in `load()`
	const setting = await ext.getSetting("someid", "Extension");
	expect(setting).toBeDefined();
	expect(setting.value.type).toBe("String");
	expect(setting.value.data).toBe("somevalue");

	// Simulate native side changing the setting
	await ext.setSetting("someid", "Extension", {
		type: "String",
		data: "othervalue",
	});

	// This should now succeed
	await ext.browse(0);

	// check if it was actually changed
	const newsetting = await ext.getSetting("someid", "Extension");
	expect(newsetting).toBeDefined();
	expect(newsetting.value.type).toBe("String");
	expect(newsetting.value.data).toBe("othervalue");

	server.stop();
});
