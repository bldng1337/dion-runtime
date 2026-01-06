/// <reference types="bun" />
import { expect, test } from "bun:test";
import {
	MockExtensionClient,
	MockManagerClient,
} from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import { join } from "node:path";

test("test auth - merge and check login status", async () => {
	console.log(join(import.meta.path, "../../.dist"));
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;

	await ext.setEnabled(true);

	// Verify accounts were added
	const accounts = await ext.getAccounts();
	expect(accounts.length).toBeGreaterThanOrEqual(3);

	// Test is_logged_in (should be false initially for all accounts)
	let loggedIn = await ext.isLoggedIn("example.com");
	expect(loggedIn).toBe(false);

	loggedIn = await ext.isLoggedIn("api.example.com");
	expect(loggedIn).toBe(false);

	loggedIn = await ext.isLoggedIn("cookie.example.com");
	expect(loggedIn).toBe(false);
});

test("test auth - get_auth_secret for unauthenticated accounts", async () => {
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);

	mockmanager.getClient.mockImplementation((_err, extdata) => {
		const ext = new MockExtensionClient(
			extdata,
			join(import.meta.path, "../../.dist"),
		);
		return ext.client;
	});

	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;

	await ext.setEnabled(true);

	// Merge an account without credentials
	await ext.mergeAuth({
		domain: "test.example.com",
		cover: null,
		auth: {
			type: "UserPass",
		},
	});

	// Test get_auth_secret for unauthenticated account (should throw)
	try {
		await ext.getAuthSecret("test.example.com");
		expect().fail("Should have thrown an error for unauthenticated account");
	} catch (error) {
		expect(error).toBeDefined();
		expect((error as Error).message).toContain("not logged in");
	}

	// Test get_auth_secret for non-existent account (should throw)
	try {
		await ext.getAuthSecret("nonexistent.example.com");
		expect().fail("Should have thrown an error for non-existent account");
	} catch (error) {
		expect(error).toBeDefined();
		expect((error as Error).message).toContain("not found");
	}
});

test("test auth - invalidate", async () => {
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);

	mockmanager.getClient.mockImplementation((_err, extdata) => {
		const ext = new MockExtensionClient(
			extdata,
			join(import.meta.path, "../../.dist"),
		);
		return ext.client;
	});

	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;

	await ext.setEnabled(true);

	// Merge an account
	await ext.mergeAuth({
		domain: "invalidate.example.com",
		cover: null,
		auth: {
			type: "UserPass",
		},
	});

	// Test invalidate
	await ext.invalidate("invalidate.example.com");

	// Account should still exist
	const accounts = await ext.getAccounts();
	const account = accounts.find(
		(a: { domain: string }) => a.domain === "invalidate.example.com",
	);
	expect(account).toBeDefined();
});

test("test auth - update existing account", async () => {
	const mockmanager = new MockManagerClient(
		join(import.meta.path, "../../.dist"),
	);

	mockmanager.getClient.mockImplementation((_err, extdata) => {
		const ext = new MockExtensionClient(
			extdata,
			join(import.meta.path, "../../.dist"),
		);
		return ext.client;
	});

	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;

	await ext.setEnabled(true);

	// Create an account
	await ext.mergeAuth({
		domain: "update.example.com",
		user_name: "Initial Name",
		cover: null,
		auth: {
			type: "UserPass",
		},
	});

	// Update the account with new cover and name
	await ext.mergeAuth({
		domain: "update.example.com",
		user_name: "Updated Name",
		cover: "https://example.com/new-cover.jpg",
		auth: {
			type: "UserPass",
		},
	});

	// Verify the account was updated
	const accounts = await ext.getAccounts();
	const account = accounts.find(
		(a: { domain: string }) => a.domain === "update.example.com",
	);
	expect(account).toBeDefined();
	expect(account?.user_name).toBe("Updated Name");
	expect(account?.cover).toBe("https://example.com/new-cover.jpg");
});
