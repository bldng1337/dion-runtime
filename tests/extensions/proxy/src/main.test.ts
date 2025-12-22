/// <reference types="bun" />
import { expect, test } from "bun:test";
import { MockManagerClient } from "@dion-js/extension-test-utils";
import { Adapter } from "@dion-js/runtime";
import type {
	Entry,
	EntryDetailed,
	Source,
} from "@dion-js/runtime-types/runtime";
import * as utils from "@dion-js/unit-test-utils/test";
import type { Server } from "bun";

test("test handleProxy", async () => {
	let redirectCount = 0;
	let modifyHeadersCount = 0;

	const server: Server<unknown> = Bun.serve({
		port: 3002,
		async fetch(req) {
			const url = new URL(req.url);
			const path = url.pathname;

			if (path === "/redirected") {
				redirectCount++;
				return Response.json({
					message: "Successfully redirected",
					redirectCount,
				});
			} else if (path === "/modify-headers") {
				const proxyModified = req.headers.get("X-Proxy-Modified");
				modifyHeadersCount++;
				return Response.json({
					proxyModified,
					modifyHeadersCount,
				});
			} else if (path === "/get") {
				return Response.json({ url: url.href });
			} else if (path === "/post") {
				let jsonBody: unknown = {};
				if (req.method === "POST") {
					try {
						jsonBody = await req.json();
					} catch {
						// Ignore parse errors
					}
				}
				return Response.json({ url: url.href, json: jsonBody });
			} else if (path === "/headers") {
				return Response.json({
					headers: Object.fromEntries(req.headers.entries()),
				});
			} else if (path === "/cookies/set") {
				const params = url.searchParams;
				const cookies = Array.from(params.entries()).map(
					([key, value]) => `${key}=${value}`,
				);
				if (cookies !== null) {
					return new Response(
						JSON.stringify({
							cookies: cookies,
						}),
						{
							headers: [
								...cookies.map(
									(cookie) => ["Set-Cookie", cookie] as [string, string],
								),
								["Content-Type", "application/json"],
							],
						},
					);
				}
				return new Response("Bad Request", { status: 400 });
			} else if (path === "/status/404") {
				return new Response("Not Found", { status: 404 });
			} else if (path === "/testCookie") {
				return Response.json({});
			} else if (path === "/getEntries") {
				const entries: Entry[] = [
					{
						id: {
							uid: "test",
						},
						url: "",
						title: "",
						media_type: "Video",
						cover: null,
						author: null,
						rating: null,
						views: null,
						length: null,
					},
				];
				return Response.json(entries);
			} else if (path === "/getEntry") {
				const entry: EntryDetailed = {
					id: {
						uid: "test",
					},
					url: "",
					titles: [],
					author: null,
					ui: null,
					meta: null,
					media_type: "Video",
					status: "Unknown",
					description: "",
					language: "",
					cover: null,
					episodes: [],
					genres: null,
					rating: null,
					views: null,
					length: null,
				};
				return Response.json(entry);
			} else if (path === "/getSource") {
				const source: Source = {
					type: "Epub",
					link: {
						header: null,
						url: "",
					},
				};
				return Response.json(source);
			} else {
				return new Response("Not Found", { status: 404 });
			}
		},
	});

	const mockmanager = new MockManagerClient("./.dist");
	const manager = await Adapter.init(mockmanager.client);
	const ext = (await manager.getExtensions())[0];
	expect(ext).toBeDefined();
	if (!ext) return;
	await utils.injectServer(server, ext);
	await ext.setEnabled(true);

	// Wait a bit for the extension to initialize
	await new Promise((resolve) => setTimeout(resolve, 100));

	// Get the proxy address from the extension setting
	const proxyAddressSetting = await ext.getSetting("proxyAddress", "Extension");
	expect(proxyAddressSetting).toBeDefined();
	expect(proxyAddressSetting.value.type).toBe("String");

	const proxyAddr = (
		proxyAddressSetting.value as { type: "String"; data: string }
	).data;
	expect(proxyAddr).toBeDefined();
	expect(proxyAddr).not.toBe("");

	console.log(`Testing proxy at: ${proxyAddr}`);

	// Test 1: Redirect
	console.log("Test 1: Testing redirect...");
	const redirectRes = await fetch(`${proxyAddr}/redirect-test`);
	if (!redirectRes.ok) {
		console.error(`Failed with body:\n ${await redirectRes.text()}`);
	}
	expect(redirectRes.status).toBe(200);
	const redirectJson = (await redirectRes.json()) as { message: string };
	expect(redirectJson.message).toBe("Successfully redirected");
	expect(redirectCount).toBeGreaterThan(0);

	// Test 2: Custom response
	console.log("Test 2: Testing custom response...");
	const customRes = await fetch(`${proxyAddr}/custom-response`);
	if (!customRes.ok) {
		console.error(`Failed with body:\n ${await customRes.text()}`);
	}
	expect(customRes.status).toBe(200);
	const customJson = (await customRes.json()) as { message: string };
	expect(customJson.message).toBe("Custom response from proxy");
	expect(customRes.headers.get("X-Custom-Header")).toBe("test-value");
	expect(customRes.headers.get("Content-Type")).toContain("application/json");

	// Test 3: Modify headers
	console.log("Test 3: Testing header modification...");
	const headersRes = await fetch(`${proxyAddr}/modify-headers`);
	if (!headersRes.ok) {
		console.error(`Failed with body:\n ${await headersRes.text()}`);
	}
	expect(headersRes.status).toBe(200);
	const headersJson = (await headersRes.json()) as { proxyModified: string };
	expect(headersJson.proxyModified).toBe("true");
	expect(modifyHeadersCount).toBeGreaterThan(0);

	// Test 4: Echo body (POST request)
	console.log("Test 4: Testing POST with body...");
	const testBody = JSON.stringify({ test: "data" });
	const echoRes = await fetch(`${proxyAddr}/echo-body`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: testBody,
	});
	expect(echoRes.status).toBe(200);
	const echoJson = (await echoRes.json()) as { echoed: string; method: string };
	expect(echoJson.echoed).toBe(testBody);
	expect(echoJson.method).toBe("POST");

	// Test 5: Error response
	console.log("Test 5: Testing error response...");
	const errorRes = await fetch(`${proxyAddr}/error-test`);
	expect(errorRes.status).toBe(404);
	const errorText = await errorRes.text();
	expect(errorText).toBe("Resource not found");

	// Test 6: Header format
	console.log("Test 6: Testing header format...");
	const headerTestRes = await fetch(`${proxyAddr}/header-test`, {
		headers: {
			"X-Test-Header": "test-value",
		},
	});
	if (!headerTestRes.ok) {
		console.error(`Failed with body:\n ${await headerTestRes.text()}`);
	}
	expect(headerTestRes.status).toBe(200);
	const headerTestJson = (await headerTestRes.json()) as {
		receivedHeader: string;
		uri: string;
	};
	expect(headerTestJson.receivedHeader).toBe("test-value");
	expect(headerTestJson.uri).toContain("/header-test");

	// Test 7: Https proxy
	console.log("Test 7: Testing Https proxy...");
	const httpsRes = await fetch(`${proxyAddr}/test-https`, {
		headers: {},
	});
	if (!httpsRes.ok) {
		console.error(`Failed with body:\n ${await headerTestRes.text()}`);
	}
	expect(httpsRes.status).toBe(200);

	console.log("All proxy tests passed!");

	// Clean up
	server.stop();
});
