#!/usr/bin/env bun
import { copyFile, mkdir, readdir, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { argv, file, $ } from "bun";
import * as v from "valibot";
import { valibot as vs } from "@dion-js/runtime-types/extension";
import Handlebars from "handlebars";
import { loadTemplate } from "../create/loader.ts" with { type: "macro" };

export type SiteOptions = {
	cwd?: string;
	/** Directory containing index.repo.json + built bundles. Default ".index". */
	source?: string;
	/** Output directory for the site. Default ".site". */
	out?: string;
	/** Public URL of index.repo.json. Derived from the GitHub release asset
	 * hosting (releases/download/<tag>/index.repo.json) when not given. */
	indexUrl?: string;
	/** Release tag used when deriving the index URL. Default "extensions". */
	releaseTag?: string;
	/** Write .github/workflows/site.yml + a build-site npm script. */
	init?: boolean;
	/** Overwrite an existing workflow file during --init. */
	force?: boolean;
	/** Injectable git remote for tests. */
	remoteUrl?: () => Promise<string | undefined>;
};

const DEFAULT_SOURCE = ".index";
const DEFAULT_OUT = ".site";
const DEFAULT_RELEASE_TAG = "extensions";

type GitHubRef = { owner: string; repo: string; homepage: string };

function parseGitHubRepo(url: string | undefined): GitHubRef | undefined {
	if (!url) return undefined;
	const m = url.match(
		/github\.com[/:]([A-Za-z0-9_.-]+)\/([A-Za-z0-9_.-]+?)(?:\.git)?[/?#]?$/i,
	);
	if (!m) return undefined;
	return {
		owner: m[1],
		repo: m[2],
		homepage: `https://github.com/${m[1]}/${m[2]}`,
	};
}

async function gitRemoteUrl(cwd: string): Promise<string | undefined> {
	const res = await $`git -C ${cwd} config --get remote.origin.url`
		.quiet()
		.nothrow();
	const out = res.stdout.toString().trim();
	return out.length ? out : undefined;
}

async function gitDefaultBranch(cwd: string): Promise<string> {
	const res =
		await $`git -C ${cwd} symbolic-ref --short refs/remotes/origin/HEAD`
			.quiet()
			.nothrow();
	const out = res.stdout.toString().trim();
	const branch = out.split("/").slice(1).join("/") || out;
	return branch.length ? branch : "main";
}

function workflowYaml(branch: string): string {
	return `name: Deploy extension site

on:
  push:
    branches: [${branch}]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  deploy-site:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: \${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Bun
        uses: oven-sh/setup-bun@v2
        with:
          bun-version: 1.2.19

      - name: Install dependencies
        run: bun install --frozen-lockfile

      - name: Build extensions
        run: bun run --if-present build

      - name: Build index and site
        run: bun run build-site

      - name: Configure Pages
        uses: actions/configure-pages@v5

      - name: Upload site
        uses: actions/upload-pages-artifact@v3
        with:
          path: .site

      - name: Deploy
        id: deployment
        uses: actions/deploy-pages@v4
`;
}

async function initWorkflow(
	cwd: string,
	force: boolean,
	log: (msg: string) => void,
): Promise<void> {
	const workflowPath = join(cwd, ".github/workflows/site.yml");
	if (!force && (await file(workflowPath).exists())) {
		log(
			`Workflow already exists at .github/workflows/site.yml (use --force to overwrite)`,
		);
	} else {
		const branch = await gitDefaultBranch(cwd);
		await mkdir(dirname(workflowPath), { recursive: true });
		await writeFile(workflowPath, workflowYaml(branch));
		log(`Wrote .github/workflows/site.yml (branch: ${branch})`);
	}

	const pkgPath = join(cwd, "package.json");
	if (await file(pkgPath).exists()) {
		const pkg = await file(pkgPath).json();
		pkg.scripts ??= {};
		if (pkg.scripts["build-site"] === undefined) {
			pkg.scripts["build-site"] = "dion-build-index && dion-build-site";
			await writeFile(pkgPath, `${JSON.stringify(pkg, null, "\t")}\n`);
			log('Added "build-site" script to package.json');
		}
	}
	log(
		'Note: GitHub Pages must be enabled with source "GitHub Actions" (Settings → Pages) once.',
	);
}

/** ExtensionType variant names, in stable display order. */
const KIND_ORDER: readonly string[] = [
	"EntryProvider",
	"SourceProcessor",
	"EntryProcessor",
	"URLHandler",
];
const KIND_LABELS: Record<string, string> = {
	EntryProvider: "Entry providers",
	SourceProcessor: "Source processors",
	EntryProcessor: "Entry processors",
	URLHandler: "URL handlers",
};

/** Return the input set ordered by `order`, unknown values sorted last. */
function orderedBy(items: Set<string>, order: readonly string[]): string[] {
	return [
		...order.filter((o) => items.has(o)),
		...[...items].filter((x) => !order.includes(x)).sort(),
	];
}

export async function buildSite(options: SiteOptions = {}): Promise<void> {
	const cwd = options.cwd ?? process.cwd();
	const source = join(cwd, options.source ?? DEFAULT_SOURCE);
	const out = join(cwd, options.out ?? DEFAULT_OUT);
	const releaseTag = options.releaseTag ?? DEFAULT_RELEASE_TAG;
	const log = (msg: string) => console.log(msg);

	const indexPath = join(source, "index.repo.json");
	if (!(await file(indexPath).exists())) {
		throw new Error(
			`No repo index at ${indexPath}. Run \`dion-build-index\` first.`,
		);
	}
	const index = v.parse(vs.DionRepoIndex, await file(indexPath).json());

	const ref =
		parseGitHubRepo(index.url) ??
		parseGitHubRepo(await (options.remoteUrl ?? (() => gitRemoteUrl(cwd)))());
	const indexUrl =
		options.indexUrl ??
		(ref && `${ref.homepage}/releases/download/${releaseTag}/index.repo.json`);
	if (!indexUrl) {
		throw new Error(
			"Could not determine the public index URL: the repo url is not a GitHub " +
				"repository and no git remote was found. Pass --index-url <url> pointing " +
				"at the hosted index.repo.json.",
		);
	}
	const baseDir = indexUrl.slice(0, indexUrl.lastIndexOf("/"));
	const addRepoLink = `dion://repo/add?url=${encodeURIComponent(indexUrl)}`;

	const entries = [...(index.content ?? [])].sort((a, b) =>
		a.extdata.name.localeCompare(b.extdata.name),
	);
	const extensions = entries.map((entry) => {
		const e = entry.extdata;
		const fileUrl = `${baseDir}/${entry.path}`;
		const media = [...e.media_type].filter((m) => m !== "Unknown");
		const langs = [...new Set((e.lang ?? []).map((l) => l.toUpperCase()))];
		const kinds = orderedBy(
			new Set<string>((e.extension_type ?? []).map((t) => t.type)),
			KIND_ORDER,
		);
		return {
			name: e.name,
			version: e.version,
			desc: e.desc ?? "",
			icon: e.icon?.trim() ? e.icon : "",
			initial: (e.name?.[0] ?? "?").toUpperCase(),
			authorsAttr: e.authors?.length ? e.authors.join(", ") : "",
			langs,
			tagsAttr: (e.tags ?? []).map((t) => `#${t}`).join(" "),
			media,
			mediaAttr: media.map((m) => m.toLowerCase()).join(" "),
			kinds,
			kindsAttr: kinds.map((k) => k.toLowerCase()).join(" "),
			nsfw: e.nsfw,
			installLink: `dion://extension/install?url=${encodeURIComponent(fileUrl)}`,
			fileUrl,
			search: [
				e.name,
				e.desc ?? "",
				...(e.tags ?? []),
				...(e.lang ?? []),
				...(e.authors ?? []),
			]
				.join(" ")
				.toLowerCase(),
		};
	});

	const mediaOrder: readonly string[] = ["Book", "Comic", "Video", "Audio"];
	const present = new Set<string>(extensions.flatMap((e) => e.media));
	const mediaTypes = [
		...mediaOrder.filter((m) => present.has(m)),
		...[...present].filter((m) => !mediaOrder.includes(m)).sort(),
	].map((m) => ({ value: m.toLowerCase(), label: m }));

	const extensionKinds = orderedBy(
		new Set<string>(extensions.flatMap((e) => e.kinds)),
		KIND_ORDER,
	).map((k) => ({ value: k.toLowerCase(), label: KIND_LABELS[k] ?? k }));

	const template = Handlebars.compile(await loadTemplate("site/index"));
	const html = template({
		repo: {
			name: index.name,
			description: index.description ?? "",
			icon: index.icon?.trim() ? index.icon : "",
			githubUrl: ref?.homepage ?? "",
		},
		addRepoLink,
		generatedAt: new Date().toLocaleDateString("en-US", {
			year: "numeric",
			month: "short",
			day: "numeric",
		}),
		count: extensions.length,
		isSingle: extensions.length === 1,
		hasNsfw: extensions.some((e) => e.nsfw),
		mediaTypes,
		extensionKinds,
		hasKinds: extensionKinds.length > 1,
		extensions,
	});

	await mkdir(out, { recursive: true });
	await writeFile(join(out, "index.html"), html);
	for (const f of await readdir(source)) {
		const src = join(source, f);
		const dest = join(out, f);
		if (src === dest) continue;
		await copyFile(src, dest);
	}

	log(
		`Site written to ${join(cwd, options.out ?? DEFAULT_OUT)} (${extensions.length} extensions)`,
	);
	log(`  index url: ${indexUrl}`);
	log(`  add repo:  ${addRepoLink}`);

	if (options.init) {
		await initWorkflow(cwd, options.force ?? false, log);
	}
}

function parseArgs(args: string[]): SiteOptions & { help: boolean } {
	const out: SiteOptions & { help: boolean } = { help: false };
	const it = args[Symbol.iterator]();
	let current = it.next();
	while (!current.done) {
		const token = current.value as string;
		const value = (): string | undefined => {
			const n = it.next();
			return n.done ? undefined : (n.value as string);
		};
		if (token === "-h" || token === "--help") {
			out.help = true;
		} else if (token === "--source") {
			out.source = value();
		} else if (token.startsWith("--source=")) {
			out.source = token.slice(token.indexOf("=") + 1);
		} else if (token === "--out") {
			out.out = value();
		} else if (token.startsWith("--out=")) {
			out.out = token.slice(token.indexOf("=") + 1);
		} else if (token === "--index-url") {
			out.indexUrl = value();
		} else if (token.startsWith("--index-url=")) {
			out.indexUrl = token.slice(token.indexOf("=") + 1);
		} else if (token === "--release-tag") {
			out.releaseTag = value();
		} else if (token.startsWith("--release-tag=")) {
			out.releaseTag = token.slice(token.indexOf("=") + 1);
		} else if (token === "--init") {
			out.init = true;
		} else if (token === "--force") {
			out.force = true;
		} else {
			throw new Error(`Unknown argument: ${token}`);
		}
		current = it.next();
	}
	return out;
}

const usage = `dion-build-site — generate a static site for a Dion extension repository

Usage: dion-build-site [options]

Options:
  --source <dir>    Directory containing index.repo.json (default: .index)
  --out <dir>       Output directory (default: .site)
  --index-url <url> Public URL of index.repo.json; the deep-link buttons target
                    this URL. Default: GitHub release asset URL derived from the
                    repo url / git remote:
                    https://github.com/<owner>/<repo>/releases/download/<tag>/index.repo.json
  --release-tag <t> Release tag for the derived index URL (default: extensions)
  --init            Write .github/workflows/site.yml + a build-site npm script
  --force           Overwrite an existing workflow file with --init
  -h, --help        Show this help

The site embeds dion:// deep links ("Add repository" and per-extension
"Install") and can be deployed to GitHub Pages as-is.
`;

export async function main(): Promise<void> {
	const opts = parseArgs(argv.slice(2));
	if (opts.help) {
		console.log(usage);
		return;
	}
	await buildSite(opts);
}
