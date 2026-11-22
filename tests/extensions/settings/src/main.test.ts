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

	// Browse settings start out host-side empty: the extension returns its
	// definitions with defaults.
	const first = await ext.browse(0, {});
	expect(Object.keys(first.settings).sort()).toEqual(["nsfw", "sort"]);
	expect(first.settings.sort?.value).toEqual({ type: "String", data: "new" });
	expect(first.settings.sort?.ui?.type).toBe("Dropdown");
	expect(first.entries.content[0]?.title).toEndWith("(new)");

	// check if it was actually changed
	const newsetting = await ext.getSetting("someid", "Extension");
	expect(newsetting).toBeDefined();
	expect(newsetting.value.type).toBe("String");
	expect(newsetting.value.data).toBe("othervalue");

	// The host's value is what the extension sees and returns; settings the
	// extension does not define are dropped.
	const sort = first.settings.sort;
	if (!sort) throw new Error("sort setting missing");
	const changed = await ext.browse(0, {
		...first.settings,
		sort: { ...sort, value: { type: "String", data: "top" } },
		zombie: { ...sort, label: "Zombie" },
	});
	expect(changed.entries.content[0]?.title).toEndWith("(top)");
	expect(changed.settings.sort?.value).toEqual({ type: "String", data: "top" });
	expect(changed.settings.zombie).toBeUndefined();

	// search shares the settings and returns all of them, even unread ones.
	const searched = await ext.search(0, "", changed.settings);
	expect(Object.keys(searched.settings).sort()).toEqual(["nsfw", "sort"]);
	expect(searched.settings.sort?.value).toEqual({
		type: "String",
		data: "top",
	});

	server.stop();
});
