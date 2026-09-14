import { mkdtemp, readFile, readdir } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { file } from "bun";
import { expect, test } from "bun:test";
import { buildSite } from "../src/site/build.ts";

function extdata(overrides: Record<string, unknown> = {}) {
	return {
		id: "00000000-0000-0000-0000-000000000000",
		name: "ext",
		url: "https://example.com",
		icon: "",
		authors: ["someone"],
		tags: ["test"],
		lang: ["en"],
		nsfw: false,
		media_type: ["Book"],
		extension_type: [{ type: "EntryProvider", has_search: true }],
		version: "1.0.0",
		license: "MIT",
		api_version: "*",
		...overrides,
	};
}

async function makeFixtureRepo(): Promise<string> {
	const dir = await mkdtemp(join(tmpdir(), "dion-site-"));
	const index = {
		repo_index_version: 1,
		name: "Test Repo",
		url: "https://github.com/example/repo",
		description: "A test repo",
		icon: "https://example.com/icon.png",
		content: [
			{ path: "foo.dion.js", extdata: extdata({ name: "foo" }) },
			{
				path: "bar.dion.js",
				extdata: extdata({
					id: "00000000-0000-0000-0000-000000000001",
					name: "bar",
					nsfw: true,
					media_type: ["Video"],
				}),
			},
		],
	};
	await file(join(dir, ".index/index.repo.json")).write(JSON.stringify(index));
	await file(join(dir, ".index/foo.dion.js")).write("//{}test");
	await file(join(dir, ".index/bar.dion.js")).write("//{}test");
	await file(join(dir, "package.json")).write('{\n\t"name": "test-repo"\n}\n');
	return dir;
}

test("buildSite derives release index url and embeds deep links", async () => {
	const dir = await makeFixtureRepo();
	await buildSite({ cwd: dir, init: true });

	const html = await readFile(join(dir, ".site/index.html"), "utf8");
	const expectedIndexUrl = encodeURIComponent(
		"https://github.com/example/repo/releases/download/extensions/index.repo.json",
	);
	expect(html).toContain(`dion://repo/add?url=${expectedIndexUrl}`);
	expect(html).toContain(
		`dion://extension/install?url=${encodeURIComponent(
			"https://github.com/example/repo/releases/download/extensions/foo.dion.js",
		)}`,
	);
	// nsfw toggle only appears when nsfw extensions exist
	expect(html).toContain('id="nsfw-toggle"');
	// media chips use lowercase values matching the row data attributes
	expect(html).toContain('data-media="video"');
	// bundles and index are copied alongside the site
	const outFiles = await readdir(join(dir, ".site"));
	expect(outFiles).toContain("index.html");
	expect(outFiles).toContain("index.repo.json");
	expect(outFiles).toContain("foo.dion.js");

	// --init wrote the workflow and the npm script
	const workflow = await readFile(
		join(dir, ".github/workflows/site.yml"),
		"utf8",
	);
	expect(workflow).toContain("actions/deploy-pages@v4");
	const pkg = JSON.parse(await readFile(join(dir, "package.json"), "utf8"));
	expect(pkg.scripts["build-site"]).toBeDefined();
});

test("buildSite honors an explicit --index-url", async () => {
	const dir = await makeFixtureRepo();
	await buildSite({
		cwd: dir,
		out: "site-out",
		indexUrl: "https://pages.example.com/base/index.repo.json",
	});

	const html = await readFile(join(dir, "site-out/index.html"), "utf8");
	expect(html).toContain(
		`dion://repo/add?url=${encodeURIComponent(
			"https://pages.example.com/base/index.repo.json",
		)}`,
	);
	expect(html).toContain(
		`dion://extension/install?url=${encodeURIComponent(
			"https://pages.example.com/base/foo.dion.js",
		)}`,
	);
});

test("buildSite fails with guidance when no index exists", async () => {
	const dir = await mkdtemp(join(tmpdir(), "dion-empty-"));
	await expect(buildSite({ cwd: dir })).rejects.toThrow(/dion-build-index/);
});
