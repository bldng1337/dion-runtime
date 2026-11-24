import { mkdir, mkdtemp, readdir, readFile, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { expect, test } from "bun:test";
import { buildIndex, parseArgs } from "../src/index/build.ts";

function extPackageJson(overrides: Record<string, unknown> = {}) {
	return {
		id: "00000000-0000-0000-0000-000000000000",
		name: "alpha",
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

test("buildIndex copies built bundles and writes index.repo.json", async () => {
	const dir = await mkdtemp(join(tmpdir(), "dion-index-"));
	await writeFile(
		join(dir, "package.json"),
		JSON.stringify({
			name: "Test Repo",
			url: "https://github.com/example/repo",
			description: "Test extensions",
			icon: "https://example.com/icon.png",
		}),
	);

	// Built extension with folder name matching package name
	await mkdir(join(dir, "pkgs/alpha/.dist"), { recursive: true });
	await writeFile(
		join(dir, "pkgs/alpha/package.json"),
		JSON.stringify(extPackageJson({ name: "alpha" })),
	);
	await writeFile(join(dir, "pkgs/alpha/.dist/alpha.dion.js"), "//{}alpha");

	// Built extension whose package.json name differs from directory name
	await mkdir(join(dir, "pkgs/beta-dir/.dist"), { recursive: true });
	await writeFile(
		join(dir, "pkgs/beta-dir/package.json"),
		JSON.stringify(
			extPackageJson({
				id: "00000000-0000-0000-0000-000000000001",
				name: "beta-ext",
			}),
		),
	);
	await writeFile(
		join(dir, "pkgs/beta-dir/.dist/beta-ext.dion.js"),
		"//{}beta",
	);

	// Unbuilt extension and a stray non-directory file should be skipped
	await mkdir(join(dir, "pkgs/unbuilt"), { recursive: true });
	await writeFile(join(dir, "pkgs/README.md"), "ignore me");

	const index = await buildIndex({
		cwd: dir,
		extensionsDir: "pkgs",
		out: ".custom-index",
		log: () => undefined,
	});

	expect(index.repo_index_version).toBe(1);
	expect(index.name).toBe("Test Repo");
	expect((index.content ?? []).map((e) => e.path)).toEqual([
		"alpha.dion.js",
		"beta-ext.dion.js",
	]);

	const outFiles = (await readdir(join(dir, ".custom-index"))).sort();
	expect(outFiles).toEqual([
		"alpha.dion.js",
		"beta-ext.dion.js",
		"index.repo.json",
	]);

	const written = JSON.parse(
		await readFile(join(dir, ".custom-index/index.repo.json"), "utf8"),
	);
	expect(written.content.length).toBe(2);
});

test("dion-build-index parseArgs parses flags", () => {
	expect(
		parseArgs([
			"--extensions",
			"packages",
			"--out=dist",
			"--repo-pkg=repo.json",
		]),
	).toEqual({
		help: false,
		extensionsDir: "packages",
		out: "dist",
		repoPackage: "repo.json",
	});
	expect(() => parseArgs(["--bad"])).toThrow(/Unknown argument/);
});
