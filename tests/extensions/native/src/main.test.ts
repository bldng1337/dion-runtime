/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";
import { join } from "node:path";

test("test native globals", async () => {
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	await ext.setEnabled(true);
	expect(ext.enabled).toBe(true);
});

test("refresh falls back to detail when not implemented", async () => {
	const server: Server<unknown> = Bun.serve({
		port: 30013,
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

	const detail = await ext.detail(
		{
			uid: "epid",
		},
		{},
	);
	const refreshed = await ext.refresh(detail.entry, {});
	expect(refreshed.entry).toEqual(detail.entry);
});
