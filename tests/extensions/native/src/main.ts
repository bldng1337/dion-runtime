import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";
import { openKvCache, openLruCache } from "cache";
import {
	createDir,
	deleteFile,
	exists,
	getDataDir,
	joinPaths,
	readDir,
	readFile,
	readTextFile,
	removeDir,
	stat,
	writeFile,
	writeTextFile,
} from "filesystem";

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

/** The VM exposes the `cache` module: persistent KV and LRU caches below
 * the extension data dir. Cache names are unique per run because the Rust
 * test suite loads this extension many times in parallel against the same
 * data dir. */
async function cacheModule(runId: string) {
	const kv = openKvCache(`kv-${runId}`, { defaultTtl: 60 });
	assert((await kv.get("missing")) === undefined, "missing key is undefined");
	await kv.set("str", "value");
	await kv.set("obj", { nested: [1, 2, 3] });
	await kv.set("bin", new Uint8Array([0, 1, 255]));
	assertDeepEqual("value", await kv.get("str"), "kv string roundtrip");
	assertDeepEqual(
		{ nested: [1, 2, 3] },
		await kv.get("obj"),
		"kv object roundtrip",
	);
	const bin = await kv.get("bin");
	assert(bin instanceof Uint8Array, "binary value roundtrips as Uint8Array");
	assertDeepEqual(
		[0, 1, 255],
		Array.from(bin as Uint8Array),
		"kv binary roundtrip",
	);
	assert(await kv.has("str"), "has reports existing key");
	assert(!(await kv.has("missing")), "has reports missing key");
	assertDeepEqual(3, await kv.size(), "size counts live entries");
	assert(
		(await kv.keys()).sort().join(",") === "bin,obj,str",
		"keys lists live keys",
	);
	await kv.delete("str");
	assert(!(await kv.has("str")), "delete removes entries");
	await kv.clear();
	assert((await kv.size()) === 0, "clear empties the cache");

	// A cache opened twice shares state (same name, same index).
	const shared = openKvCache(`shared-${runId}`);
	await shared.set("k", "v");
	assert(
		(await openKvCache(`shared-${runId}`).get("k")) === "v",
		"same-name handles share entries",
	);

	// LRU eviction by entry count, honoring recency on get.
	const lru = openLruCache(`lru-${runId}`, { maxEntries: 2 });
	await lru.set("a", 1);
	await lru.set("b", 2);
	await lru.get("a"); // a is now most recently used
	await lru.set("c", 3); // evicts b
	assert((await lru.get("b")) === undefined, "lru evicts least recently used");
	assert((await lru.get("a")) === 1, "lru keeps recently used");
	assert((await lru.get("c")) === 3, "lru keeps newest");

	// peek() must not refresh recency.
	const peeked = openLruCache(`peek-${runId}`, { maxEntries: 2 });
	await peeked.set("a", 1);
	await peeked.set("b", 2);
	await peeked.peek("a");
	await peeked.set("c", 3); // evicts a
	assert((await peeked.get("a")) === undefined, "peek keeps recency untouched");
}

/** The VM exposes the `filesystem` module: permission-gated file access
 * with the extension data dir always accessible. Directory names are
 * unique per run because the Rust test suite loads this extension many
 * times in parallel against the same data dir. */
async function filesystemModule(runId: string) {
	const dataDir = await getDataDir();
	assert(typeof dataDir === "string" && dataDir.length > 0, "data dir set");

	const dir = joinPaths([dataDir, `fstest-${runId}`, "nested"]);
	assert(
		dir === joinPaths([dataDir, `fstest-${runId}/nested`]),
		"joinPaths normalizes separators",
	);
	await createDir(dir, { recursive: true });
	assert(await exists(dir), "created dir exists");

	const file = joinPaths([dir, "hello.txt"]);
	assert(!(await exists(file)), "file does not exist yet");
	await writeTextFile(file, "hello dion");
	assert(await exists(file), "written file exists");
	assertDeepEqual("hello dion", await readTextFile(file), "text roundtrip");
	await writeTextFile(file, "!", { append: true });
	assertDeepEqual("hello dion!", await readTextFile(file), "append option");

	const info = await stat(file);
	assert(info.isFile && !info.isDir, "stat reports a file");
	assert(info.size === 11, "stat reports size");
	assert(
		typeof info.modifiedMs === "number" && info.modifiedMs > 0,
		"stat reports mtime",
	);

	const blob = new Uint8Array([0, 1, 2, 250, 251]);
	await writeFile(joinPaths([dir, "blob.bin"]), blob);
	const readBack = await readFile(joinPaths([dir, "blob.bin"]));
	assert(readBack instanceof Uint8Array, "readFile returns Uint8Array");
	assertDeepEqual(
		Array.from(blob),
		Array.from(readBack as Uint8Array),
		"binary roundtrip",
	);

	const names = (await readDir(dir)).map((entry) => entry.name).sort();
	assertDeepEqual(["blob.bin", "hello.txt"], names, "readDir lists entries");

	await deleteFile(file);
	assert(!(await exists(file)), "deleteFile removes the file");

	await removeDir(joinPaths([dataDir, `fstest-${runId}`]), {
		recursive: true,
	});
	assert(
		!(await exists(joinPaths([dataDir, `fstest-${runId}`]))),
		"removeDir recursive",
	);

	// Access outside the data dir goes through the Storage permission flow;
	// the test hosts grant every request, so the sibling directory becomes
	// writable after one (auto-approved) prompt for its parent.
	const permDir = `dion-fs-permtest-${runId}`;
	const outside = joinPaths([dataDir, "..", permDir, "out.txt"]);
	await writeTextFile(outside, "outside", { createParents: true });
	assertDeepEqual(
		"outside",
		await readTextFile(outside),
		"outside-data-dir access after permission",
	);
	// A second access to the same tree must not re-prompt (granted once).
	await writeTextFile(outside, "outside2");
	assertDeepEqual(
		"outside2",
		await readTextFile(outside),
		"granted tree reuse",
	);
	await removeDir(joinPaths([dataDir, "..", permDir]), {
		recursive: true,
	});
}

export default class extends DefaultExtension {
	async load() {
		urlGlobals();
		const runId = `${Date.now().toString(36)}${Math.random()
			.toString(36)
			.slice(2, 8)}`;
		await cacheModule(runId);
		await filesystemModule(runId);
	}
}
