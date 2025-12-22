import { ProxyRequest, ProxyResponse } from "@dion-js/runtime-types/extension";
import type {
	EntryActivity,
	EntryDetailed,
	EntryDetailedResult,
	EntryId,
	EntryList,
	EpisodeId,
	Setting,
	Source,
	SourceResult,
} from "@dion-js/runtime-types/runtime";
import {
	assert,
	DefaultExtension,
	getServer,
} from "@dion-js/unit-test-utils/extension";
import { getProxyAddress } from "network";
import { getSetting, registerSetting } from "setting";

export default class extends DefaultExtension {
	async load() {
		// Get the proxy address and store it in a setting so the test runner can access it
		const proxyAddress = await getProxyAddress();
		console.log(`[Proxy Test] Extension proxy address: ${proxyAddress}`);

		// Store the proxy address in a setting that the test runner can read
		await registerSetting(
			"proxyAddress",
			{
				visible: false,
				label: "Proxy Address",
				default: {
					type: "String",
					data: "",
				},
				value: {
					type: "String",
					data: proxyAddress || "",
				},
			},
			"Extension",
		);
	}

	async handleProxy(request: ProxyRequest): Promise<ProxyResponse> {
		const server = await getServer();
		console.log(`[Proxy Test] handleProxy called for: ${request.uri}`);

		// Test case 1: Redirect to a different URL
		if (request.uri.includes("/redirect-test")) {
			console.log(`[Proxy Test] Redirecting to /redirected`);
			return {
				type: "redirect",
				request: {
					method: "GET",
					uri: `${server}/redirected`,
					version: 11,
					headers: {},
					body: "",
				},
			};
		}

		// Test case 2: Return a custom response
		if (request.uri.includes("/custom-response")) {
			console.log(`[Proxy Test] Returning custom response`);
			return {
				type: "response",
				status: 200,
				headers: {
					"Content-Type": ["application/json"],
					"X-Custom-Header": ["test-value"],
				},
				body: JSON.stringify({ message: "Custom response from proxy" }),
			};
		}

		// Test case 3: Modify headers and forward
		if (request.uri.includes("/modify-headers")) {
			console.log(`[Proxy Test] Modifying headers and forwarding`);
			// Convert byte array headers back to string format for manipulation
			const newHeaders = {
				...request.headers,
			};
			newHeaders["X-Proxy-Modified"] = ["true"];

			return {
				type: "redirect",
				request: {
					method: request.method,
					uri: `${server}/modify-headers`,
					version: request.version,
					headers: newHeaders,
					body: request.body,
				},
			};
		}

		// Test case 4: Handle POST request with body
		if (request.uri.includes("/echo-body") && request.method === "POST") {
			console.log(`[Proxy Test] Echoing POST body`);
			return {
				type: "response",
				status: 200,
				headers: {
					"Content-Type": ["application/json"],
				},
				body: JSON.stringify({
					echoed: request.body,
					method: request.method,
				}),
			};
		}

		// Test case 5: Return error response
		if (request.uri.includes("/error-test")) {
			console.log(`[Proxy Test] Returning error response`);
			return {
				type: "response",
				status: 404,
				headers: {
					"Content-Type": ["text/plain"],
				},
				body: "Resource not found",
			};
		}

		// Test case 6: Test header format with specific header
		if (request.uri.includes("/header-test")) {
			console.log(`[Proxy Test] Testing header format`);
			// Extract the X-Test-Header value from byte arrays
			const testHeader = request.headers["x-test-header"];
			assert(testHeader !== undefined, "x-test-header is undefined");
			return {
				type: "response",
				status: 200,
				headers: {
					"Content-Type": ["application/json"],
				},
				body: JSON.stringify({
					receivedHeader: testHeader[0],
					uri: request.uri,
				}),
			};
		}

		if (request.uri.includes("/test-https")) {
			return {
				type: "redirect",
				request: {
					method: "GET",
					uri: "https://www.example.com",
					version: 11,
					headers: {},
				},
			};
		}

		// Default: pass through with redirect
		console.log(`[Proxy Test] Default redirect to ${server}`);
		return {
			type: "redirect",
			request: {
				method: request.method,
				uri: `${server}${new URL(request.uri).pathname}`,
				version: request.version,
				headers: request.headers,
				body: request.body,
			},
		};
	}
}
