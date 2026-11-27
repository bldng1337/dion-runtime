import { mkdir, mkdtemp, readFile, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { expect, test } from "bun:test";
import { file } from "bun";
import { parseArgs, publishRelease } from "../src/publish/release.ts";
import { parseRepoRef } from "../src/utils/github.ts";

type RecordedRequest = {
	method: string;
	url: string;
	contentType?: string | null;
	bodyText?: string;
};

async function makeIndexFixture(
	files: Record<string, string> = {
		"foo.dion.js": "//{}foo",
		"bar.dion.js": "//{}bar",
		"index.repo.json": '{"repo_index_version":1,"content":[]}',
	},
): Promise<string> {
	const dir = await mkdtemp(join(tmpdir(), "dion-publish-"));
	await mkdir(join(dir, ".index"), { recursive: true });
	for (const [rel, content] of Object.entries(files)) {
		const full = join(dir, ".index", rel);
		await mkdir(join(full, ".."), { recursive: true });
		await writeFile(full, content);
	}
	await file(join(dir, "package.json")).write(
		JSON.stringify(
			{
				name: "test-repo",
				url: "https://github.com/example/extensions",
				packageManager: "bun@1.2.19",
			},
			null,
			"\t",
		),
	);
	return dir;
}

test("parseRepoRef parses slugs and GitHub URLs", () => {
	expect(parseRepoRef("owner/repo")).toEqual({
		owner: "owner",
		repo: "repo",
		slug: "owner/repo",
		homepage: "https://github.com/owner/repo",
	});
	expect(parseRepoRef("https://github.com/owner/repo.git")).toEqual({
		owner: "owner",
		repo: "repo",
		slug: "owner/repo",
		homepage: "https://github.com/owner/repo",
	});
	expect(parseRepoRef("git@github.com:owner/repo.git")).toEqual({
		owner: "owner",
		repo: "repo",
		slug: "owner/repo",
		homepage: "https://github.com/owner/repo",
	});
	expect(parseRepoRef("https://example.com/not-github")).toBeUndefined();
});

test("publishRelease creates release and uploads index.repo.json last", async () => {
	const dir = await makeIndexFixture();
	const calls: RecordedRequest[] = [];

	const mockFetch = (async (input: RequestInfo | URL, init?: RequestInit) => {
		const url = String(input);
		const method = init?.method ?? "GET";
		const headers = new Headers(init?.headers);
		calls.push({
			method,
			url,
			contentType: headers.get("Content-Type"),
			bodyText: typeof init?.body === "string" ? init.body : undefined,
		});

		if (method === "GET" && url.endsWith("/releases/tags/extensions")) {
			return new Response(JSON.stringify({ message: "Not Found" }), {
				status: 404,
			});
		}
		if (method === "POST" && url.endsWith("/releases")) {
			return new Response(
				JSON.stringify({
					id: 42,
					upload_url:
						"https://uploads.github.com/repos/example/extensions/releases/42/assets{?name,label}",
				}),
				{ status: 201 },
			);
		}
		if (method === "POST" && url.includes("uploads.github.com")) {
			return new Response(JSON.stringify({ id: 1 }), { status: 201 });
		}
		if (method === "PATCH" && url.includes("/releases/assets/")) {
			return new Response(JSON.stringify({}), { status: 200 });
		}
		throw new Error(`Unexpected request: ${method} ${url}`);
	}) as typeof globalThis.fetch;

	const result = await publishRelease({
		cwd: dir,
		token: "test-token",
		fetch: mockFetch,
		log: () => undefined,
	});

	expect(result.createdRelease).toBe(true);
	expect(result.repo).toBe("example/extensions");
	expect(result.tag).toBe("extensions");
	expect(result.uploaded).toEqual([
		"bar.dion.js",
		"foo.dion.js",
		"index.repo.json",
	]);
	expect(result.pruned).toEqual([]);

	const uploadNames = calls
		.filter((c) => c.url.includes("uploads.github.com"))
		.map((c) => new URL(c.url).searchParams.get("name"));
	expect(uploadNames.every((name) => name?.endsWith(".partial"))).toBe(true);
	const renamed = calls
		.filter((c) => c.method === "PATCH")
		.map((c) => (JSON.parse(c.bodyText ?? "{}") as { name: string }).name);
	expect(renamed.at(-1)).toBe("index.repo.json");
	expect(renamed.slice(0, -1).sort()).toEqual(["bar.dion.js", "foo.dion.js"]);
});

test("publishRelease replaces existing assets, paginates asset list, and prunes stale assets", async () => {
	const dir = await makeIndexFixture();
	const deletedIds: number[] = [];
	const renamedNames: string[] = [];

	const page1 = Array.from({ length: 100 }, (_, i) => ({
		id: i + 1,
		name: i === 0 ? "foo.dion.js" : `stale-${i}.dion.js`,
	}));
	const page2 = [
		{ id: 200, name: "index.repo.json" },
		{ id: 201, name: "removed.dion.js" },
	];

	const mockFetch = (async (input: RequestInfo | URL, init?: RequestInit) => {
		const url = String(input);
		const method = init?.method ?? "GET";

		if (method === "GET" && url.endsWith("/releases/tags/extensions")) {
			return new Response(
				JSON.stringify({
					id: 99,
					upload_url:
						"https://uploads.github.com/repos/example/extensions/releases/99/assets{?name,label}",
				}),
				{ status: 200 },
			);
		}
		if (method === "GET" && url.includes("/releases/99/assets")) {
			const page = new URL(url).searchParams.get("page");
			return new Response(JSON.stringify(page === "1" ? page1 : page2), {
				status: 200,
			});
		}
		if (method === "DELETE" && url.includes("/releases/assets/")) {
			const id = Number(url.split("/").pop());
			deletedIds.push(id);
			return new Response(null, { status: 204 });
		}
		if (method === "POST" && url.includes("uploads.github.com")) {
			return new Response(JSON.stringify({ id: 999 }), { status: 201 });
		}
		if (method === "PATCH" && url.includes("/releases/assets/")) {
			const { name } = JSON.parse(String(init?.body)) as { name: string };
			renamedNames.push(name);
			return new Response(JSON.stringify({}), { status: 200 });
		}
		throw new Error(`Unexpected request: ${method} ${url}`);
	}) as typeof globalThis.fetch;

	const result = await publishRelease({
		cwd: dir,
		token: "test-token",
		fetch: mockFetch,
		log: () => undefined,
	});

	expect(result.createdRelease).toBe(false);
	expect(renamedNames.at(-1)).toBe("index.repo.json");
	// Replaced existing assets (foo.dion.js id=1, index.repo.json id=200)
	expect(deletedIds).toContain(1);
	expect(deletedIds).toContain(200);
	// Pruned stale assets across both pages (99 from page 1 + removed.dion.js)
	expect(deletedIds).toContain(201);
	expect(result.pruned).toContain("removed.dion.js");
	expect(result.pruned).toContain("stale-1.dion.js");
	expect(result.pruned.length).toBe(100);
});

test("publishRelease honors prune: false", async () => {
	const dir = await makeIndexFixture({
		"foo.dion.js": "//{}foo",
	});
	const deletedIds: number[] = [];

	const mockFetch = (async (input: RequestInfo | URL, init?: RequestInit) => {
		const url = String(input);
		const method = init?.method ?? "GET";
		if (method === "GET" && url.endsWith("/releases/tags/extensions")) {
			return new Response(
				JSON.stringify({
					id: 10,
					upload_url:
						"https://uploads.github.com/repos/example/extensions/releases/10/assets{?name,label}",
				}),
				{ status: 200 },
			);
		}
		if (method === "GET" && url.includes("/releases/10/assets")) {
			return new Response(
				JSON.stringify([{ id: 55, name: "keep-me.dion.js" }]),
				{ status: 200 },
			);
		}
		if (method === "DELETE") {
			deletedIds.push(Number(url.split("/").pop()));
			return new Response(null, { status: 204 });
		}
		if (method === "POST" && url.includes("uploads.github.com")) {
			return new Response(JSON.stringify({ id: 56 }), { status: 201 });
		}
		if (method === "PATCH" && url.includes("/releases/assets/")) {
			return new Response(JSON.stringify({}), { status: 200 });
		}
		throw new Error(`Unexpected request: ${method} ${url}`);
	}) as typeof globalThis.fetch;

	const result = await publishRelease({
		cwd: dir,
		token: "test-token",
		prune: false,
		fetch: mockFetch,
		log: () => undefined,
	});

	expect(deletedIds).toEqual([]);
	expect(result.pruned).toEqual([]);
});

test("publishRelease recovers when release creation races (422)", async () => {
	const dir = await makeIndexFixture({ "foo.dion.js": "//{}foo" });
	let getCount = 0;

	const mockFetch = (async (input: RequestInfo | URL, init?: RequestInit) => {
		const url = String(input);
		const method = init?.method ?? "GET";
		if (method === "GET" && url.endsWith("/releases/tags/extensions")) {
			getCount++;
			if (getCount === 1) {
				return new Response(JSON.stringify({ message: "Not Found" }), {
					status: 404,
				});
			}
			return new Response(
				JSON.stringify({
					id: 77,
					upload_url:
						"https://uploads.github.com/repos/example/extensions/releases/77/assets{?name,label}",
				}),
				{ status: 200 },
			);
		}
		if (method === "POST" && url.endsWith("/releases")) {
			return new Response(
				JSON.stringify({
					message: "Validation Failed",
					errors: [{ code: "already_exists" }],
				}),
				{ status: 422 },
			);
		}
		if (method === "GET" && url.includes("/releases/77/assets")) {
			return new Response(JSON.stringify([]), { status: 200 });
		}
		if (method === "POST" && url.includes("uploads.github.com")) {
			return new Response(JSON.stringify({ id: 1 }), { status: 201 });
		}
		if (method === "PATCH" && url.includes("/releases/assets/")) {
			return new Response(JSON.stringify({}), { status: 200 });
		}
		throw new Error(`Unexpected request: ${method} ${url}`);
	}) as typeof globalThis.fetch;

	const result = await publishRelease({
		cwd: dir,
		token: "test-token",
		fetch: mockFetch,
		log: () => undefined,
	});

	expect(result.createdRelease).toBe(false);
	expect(result.uploaded).toEqual(["foo.dion.js"]);
});

test("publishRelease flattens nested paths and rejects collisions", async () => {
	const dir = await makeIndexFixture({
		"nested/ext.dion.js": "//{}nested",
	});
	const res = await publishRelease({
		cwd: dir,
		dryRun: true,
		log: () => undefined,
	});
	expect(res.dryRun).toBe(true);
	expect(res.uploaded).toEqual(["nested-ext.dion.js"]);

	const colliding = await makeIndexFixture({
		"a/b.dion.js": "1",
		"a-b.dion.js": "2",
	});
	await expect(
		publishRelease({ cwd: colliding, dryRun: true, log: () => undefined }),
	).rejects.toThrow(/Duplicate release asset name/);
});

test("publishRelease --init writes workflow and package script without network", async () => {
	const dir = await mkdtemp(join(tmpdir(), "dion-publish-init-"));
	await file(join(dir, "package.json")).write(
		JSON.stringify(
			{
				name: "my-extensions",
				packageManager: "bun@1.2.20",
			},
			null,
			"\t",
		),
	);

	await publishRelease({
		cwd: dir,
		init: true,
		tag: "nightly",
		log: () => undefined,
	});

	const workflow = await readFile(
		join(dir, ".github/workflows/release.yml"),
		"utf8",
	);
	expect(workflow).toContain("bun-version: 1.2.20");
	expect(workflow).toContain("cancel-in-progress: false");
	expect(workflow).toContain("bun run publish-extensions");
	expect(workflow).toContain("GH_TOKEN: ${{ github.token }}");

	const pkg = JSON.parse(await readFile(join(dir, "package.json"), "utf8"));
	expect(pkg.scripts["publish-extensions"]).toBe(
		"dion-build-index && dion-publish --tag nightly",
	);
});

test("publishRelease fails cleanly on missing directory or missing token", async () => {
	const emptyDir = await mkdtemp(join(tmpdir(), "dion-publish-missing-"));
	await expect(
		publishRelease({
			cwd: emptyDir,
			repo: "example/repo",
			token: "tok",
			log: () => undefined,
		}),
	).rejects.toThrow(/dion-build-index/);

	const validDir = await makeIndexFixture();
	const prevGh = process.env.GH_TOKEN;
	const prevGithub = process.env.GITHUB_TOKEN;
	delete process.env.GH_TOKEN;
	delete process.env.GITHUB_TOKEN;
	try {
		await expect(
			publishRelease({ cwd: validDir, log: () => undefined }),
		).rejects.toThrow(/GH_TOKEN/);
	} finally {
		if (prevGh !== undefined) process.env.GH_TOKEN = prevGh;
		if (prevGithub !== undefined) process.env.GITHUB_TOKEN = prevGithub;
	}
});

test("parseArgs parses options and rejects invalid arguments", () => {
	const parsed = parseArgs([
		"--source",
		"dist-index",
		"--tag=v1",
		"--title",
		"Release v1",
		"--repo",
		"org/repo",
		"--no-prune",
		"--dry-run",
		"--concurrency=3",
	]);
	expect(parsed).toEqual({
		help: false,
		source: "dist-index",
		tag: "v1",
		title: "Release v1",
		repo: "org/repo",
		prune: false,
		dryRun: true,
		concurrency: 3,
	});
	expect(() => parseArgs(["--unknown"])).toThrow(/Unknown argument/);
	expect(() => parseArgs(["--tag"])).toThrow(/Missing value/);
});

test("publishRelease replaces a stale partial upload", async () => {
	const dir = await makeIndexFixture({ "foo.dion.js": "//{}foo" });
	const deletedIds: number[] = [];
	const mockFetch = (async (input: RequestInfo | URL, init?: RequestInit) => {
		const url = String(input);
		const method = init?.method ?? "GET";
		if (method === "GET" && url.endsWith("/releases/tags/extensions")) {
			return new Response(
				JSON.stringify({
					id: 5,
					upload_url:
						"https://uploads.github.com/repos/example/extensions/releases/5/assets{?name,label}",
				}),
				{ status: 200 },
			);
		}
		if (method === "GET" && url.includes("/releases/5/assets")) {
			return new Response(
				JSON.stringify([
					{ id: 7, name: "foo.dion.js" },
					{ id: 8, name: "foo.dion.js.partial" },
				]),
				{ status: 200 },
			);
		}
		if (method === "DELETE") {
			deletedIds.push(Number(url.split("/").pop()));
			return new Response(null, { status: 204 });
		}
		if (method === "POST" && url.includes("uploads.github.com")) {
			return new Response(JSON.stringify({ id: 9 }), { status: 201 });
		}
		if (method === "PATCH" && url.endsWith("/releases/assets/9")) {
			return new Response(JSON.stringify({}), { status: 200 });
		}
		throw new Error(`Unexpected request: ${method} ${url}`);
	}) as typeof globalThis.fetch;

	const result = await publishRelease({
		cwd: dir,
		token: "test-token",
		fetch: mockFetch,
		log: () => undefined,
	});

	// The leftover partial goes first, then the live asset it replaces.
	expect(deletedIds.slice(0, 2)).toEqual([8, 7]);
	expect(result.uploaded).toContain("foo.dion.js");
});
