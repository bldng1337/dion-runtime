import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";

/** The VM exposes WHATWG URL globals; extensions use them to build query
 * strings instead of hand-rolling encodeURIComponent chains. */
function urlGlobals() {
	const url = new URL("https://example.org/a/b?x=1&page=two#top");
	assertDeepEqual("https:", url.protocol);
	assertDeepEqual("example.org", url.hostname);
	assertDeepEqual("/a/b", url.pathname);
	assertDeepEqual("?x=1&page=two", url.search);
	assertDeepEqual("#top", url.hash);
	assertDeepEqual("1", url.searchParams.get("x"));
	assertDeepEqual("two", url.searchParams.get("page"));

	// searchParams mutations are reflected on the URL and vice versa.
	url.searchParams.set("page", "3");
	assertDeepEqual("?x=1&page=3", url.search);
	url.search = "?q=a%20b";
	assertDeepEqual("a b", url.searchParams.get("q"));
	assertDeepEqual("https://example.org/a/b?q=a%20b#top", url.toString());

	const params = new URLSearchParams({ q: "big cats", rows: "20" });
	assertDeepEqual("q=big%20cats&rows=20", params.toString());
	assertDeepEqual(2, params.size);
	assertDeepEqual(
		"q=big cats,rows=20",
		[...params].map(([k, v]) => `${k}=${v}`).join(","),
	);

	assertDeepEqual(
		"https://example.org/next?page=2",
		new URL("/next?page=2", "https://example.org/list").toString(),
	);
	assert(URL.canParse("https://example.org/"));
	assert(!URL.canParse("ht tp://bad"));

	const abs = URL.parse("/x", "https://example.org/");
	assert(abs !== null, "URL.parse should succeed");
	assertDeepEqual("/x", abs.pathname);
}

export default class extends DefaultExtension {
	async load() {
		urlGlobals();
	}
}
