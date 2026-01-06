import { DefaultExtension } from "@dion-js/unit-test-utils/extension";
import { mergeAuth, isLoggedIn, getAuthSecret, invalidate } from "auth";
export default class extends DefaultExtension {
	async load() {
		// Test mergeAuth with different auth types
		await mergeAuth({
			domain: "example.com",
			auth: {
				type: "UserPass",
			},
		});

		await mergeAuth({
			domain: "api.example.com",
			auth: {
				type: "ApiKey",
			},
		});

		await mergeAuth({
			domain: "cookie.example.com",
			auth: {
				type: "Cookie",
				loginpage: "https://cookie.example.com/login",
				logonpage: "https://cookie.example.com/dashboard",
			},
		});

		// Test is_logged_in (should be false initially)
		const loggedIn = await isLoggedIn("example.com");
		console.log("Is logged in:", loggedIn);

		// Test invalidate
		await invalidate("example.com");

		// Test get_auth_secret (should throw for unauthenticated accounts)
		let fail = false;
		try {
			await getAuthSecret("example.com");
			fail = true;
		} catch (_e) {
			// Expected error
		}
		if (fail) {
			throw new Error(
				"get_auth_secret did not throw for unauthenticated account",
			);
		}
	}
}
