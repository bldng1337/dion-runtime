/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";

test("Test Extension", async () => {
	const mockmanager = new MockManagerClient("./.dist");
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	const extdata = await ext.getData();
	expect(extdata.compatible).toBe(false);
});
