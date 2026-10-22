/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";
import { join } from "node:path";

test("test datetime extension loads", async () => {
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

test("timestamps cross the boundary as canonical ISO-8601 strings", async () => {
	const server: Server<unknown> = Bun.serve({
		port: 30031,
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

	// The extension returned a Temporal.Instant; the host receives the
	// Rust-canonicalized ISO-8601 string.
	const detail = await ext.detail({ uid: "epid" }, {});
	const episode = detail.entry.episodes[0];
	expect(episode?.timestamp).toBe("2024-01-02T03:04:05.000Z");

	// Host -> extension direction: the string survives the round-trip.
	const mapped = await ext.mapEntry(detail.entry, {});
	expect(mapped.entry).toEqual(detail.entry);

	server.stop();
});
