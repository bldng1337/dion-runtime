/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";

test("test decode", async () => {
	const mockmanager = new MockManagerClient("./.dist");
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	// We only enable here because we only use the load function so we dont need a server supplying demo data
	await ext.setEnabled(true);
});
