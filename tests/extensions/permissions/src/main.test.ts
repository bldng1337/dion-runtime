/// <reference types="bun" />
import { expect, test } from "bun:test";
import {
	MockExtensionClient,
	MockManagerClient,
} from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";

test("test permission", async () => {
	const mockmanager = new MockManagerClient("./.dist");

	mockmanager.getClient.mockImplementation((_err, extdata) => {
		const ext = new MockExtensionClient(extdata, "./.dist");
		ext.requestPermission.mockImplementation((_err, _permission, msg) => {
			if (msg === "deny") {
				return false;
			}
			return true;
		});
		return ext.client;
	});

	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	// We only enable here because we only use the load function so we dont need a server supplying demo data
	await ext.setEnabled(true);
});
