import {
	assert,
	DefaultExtension,
	getServer,
} from "@dion-js/unit-test-utils/extension";
import { fetch, getCookies } from "network";

async function testGet(httpbin: string) {
	const res = await fetch(`${httpbin}/get`);
	assert(res.status === 200, "GET request failed");
	const json = JSON.parse(res.body);
	assert(json.url === `${httpbin}/get`, "GET request url is wrong");
}

async function testPost(httpbin: string) {
	const res = await fetch(`${httpbin}/post`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({ test: "value" }),
	});
	assert(res.status === 200, "POST request failed");
	const json = JSON.parse(res.body);
	assert(json.json.test === "value", "POST request body is wrong");
}

async function testHeaders(httpbin: string) {
	const res = await fetch(`${httpbin}/headers`, {
		headers: {
			"X-Test-Header": "test-value",
		},
	});
	assert(res.status === 200, "Headers request failed");
	const json = res.json;
	assert(
		json.headers["x-test-header"] === "test-value",
		`Headers not sent correctly \n\n\n${res.body}`,
	);
}

async function testCookies(httpbin: string) {
	await fetch(`${httpbin}/cookies/set?name=value`);
	const cookies = getCookies();
	assert(
		cookies.some((c) => c.name === "name" && c.value === "value"),
		`Cookies not set correctly expected name=value got ${JSON.stringify(
			cookies,
		)}`,
	);
	const cookie = await fetch(`${httpbin}/testCookie`);
	assert(cookie.status === 200, "Cookie request failed");
	assert(cookie.body === "{}", "Cookie request returned wrong body");
}

async function testError(httpbin: string) {
	const res = await fetch(`${httpbin}/status/404`);
	assert(res.status === 404, "Error handling for 404 failed");
	assert(res.ok === false, "Error handling for 404 failed");
}

export default class extends DefaultExtension {
	async load() {
		const httpbin = await getServer();
		await testGet(httpbin);
		await testPost(httpbin);
		await testHeaders(httpbin);
		await testCookies(httpbin);
		await testError(httpbin);
	}
}
