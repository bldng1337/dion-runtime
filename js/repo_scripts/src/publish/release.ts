import { mkdir, readdir, readFile, stat, writeFile } from "node:fs/promises";
import { dirname, extname, join, relative, resolve } from "node:path";
import { argv, file } from "bun";
import { shellWord, yamlScalar } from "../utils/quote.ts";
import {
	detectBunVersion,
	type GitHubRef,
	gitDefaultBranch,
	gitRemoteUrl,
	parseRepoRef,
	readRepoPackageUrl,
} from "../utils/github.ts";

export type PublishOptions = {
	cwd?: string;
	/** Directory containing built index assets. Default ".index". */
	source?: string;
	/** GitHub release tag. Default "extensions". */
	tag?: string;
	/** Release title when creating a release. Default: tag. */
	title?: string;
	/** Release notes when creating a release. Default: "Automated extension release". */
	notes?: string;
	/** Target GitHub repository ("owner/repo" or GitHub URL).
	 *  Defaults to GITHUB_REPOSITORY, package.json url/repository, or git remote. */
	repo?: string;
	/** GitHub REST API base URL. Default: GITHUB_API_URL or "https://api.github.com". */
	apiUrl?: string;
	/** Delete existing release assets not present in source. Default: true. */
	prune?: boolean;
	/** Print planned actions without calling GitHub APIs. Default: false. */
	dryRun?: boolean;
	/** Write .github/workflows/release.yml and a publish-extensions npm script, then exit. */
	init?: boolean;
	/** Overwrite an existing workflow file during --init. */
	force?: boolean;
	/** Maximum concurrent asset operations. Default: 5. */
	concurrency?: number;
	/** Auth token (defaults to GH_TOKEN / GITHUB_TOKEN). */
	token?: string;
	/** Injectable fetch for tests. */
	fetch?: typeof globalThis.fetch;
	/** Injectable git remote lookup for tests. */
	remoteUrl?: () => Promise<string | undefined>;
	/** Injectable logger for tests. */
	log?: (msg: string) => void;
};

export type PublishResult = {
	repo: string;
	tag: string;
	createdRelease: boolean;
	uploaded: string[];
	pruned: string[];
	dryRun: boolean;
};

type AssetFile = {
	path: string;
	name: string;
};

type GitHubRelease = {
	id: number;
	upload_url: string;
	html_url?: string;
};

type GitHubAsset = {
	id: number;
	name: string;
};

const DEFAULT_SOURCE = ".index";
const DEFAULT_TAG = "extensions";
const DEFAULT_NOTES = "Automated extension release";
const DEFAULT_API_URL = "https://api.github.com";
const DEFAULT_CONCURRENCY = 5;
const INDEX_FILENAME = "index.repo.json";

const CONTENT_TYPES: Record<string, string> = {
	".json": "application/json",
	".js": "application/javascript",
	".mjs": "application/javascript",
	".html": "text/html",
	".css": "text/css",
	".svg": "image/svg+xml",
	".png": "image/png",
	".jpg": "image/jpeg",
	".jpeg": "image/jpeg",
	".webp": "image/webp",
	".txt": "text/plain",
};

function contentTypeFor(filename: string): string {
	return (
		CONTENT_TYPES[extname(filename).toLowerCase()] ?? "application/octet-stream"
	);
}

function normalizeAssetName(rootDir: string, fullPath: string): string {
	return relative(rootDir, fullPath).replace(/[\\/]/g, "-");
}

export async function collectAssets(rootDir: string): Promise<AssetFile[]> {
	let stats: Awaited<ReturnType<typeof stat>>;
	try {
		stats = await stat(rootDir);
	} catch {
		throw new Error(
			`Source directory "${rootDir}" not found. Run \`dion-build-index\` first.`,
		);
	}
	if (!stats.isDirectory()) {
		throw new Error(`Source path "${rootDir}" exists but is not a directory.`);
	}

	const files: AssetFile[] = [];
	const seen = new Map<string, string>();

	async function walk(dir: string): Promise<void> {
		const entries = (await readdir(dir, { withFileTypes: true })).sort((a, b) =>
			a.name.localeCompare(b.name),
		);
		for (const entry of entries) {
			if (entry.isSymbolicLink()) continue;
			const full = join(dir, entry.name);
			if (entry.isDirectory()) {
				await walk(full);
			} else if (entry.isFile()) {
				const name = normalizeAssetName(rootDir, full);
				const prev = seen.get(name);
				if (prev) {
					throw new Error(
						`Duplicate release asset name "${name}" from "${prev}" and "${full}".`,
					);
				}
				seen.set(name, full);
				files.push({ path: full, name });
			}
		}
	}

	await walk(rootDir);

	if (files.length === 0) {
		throw new Error(`No files found in "${rootDir}" to publish.`);
	}

	return files;
}

async function runWithConcurrency<T>(
	items: readonly T[],
	limit: number,
	worker: (item: T) => Promise<void>,
): Promise<void> {
	const workers = Math.max(1, Math.min(limit, items.length));
	let next = 0;
	let firstError: unknown;

	await Promise.all(
		Array.from({ length: workers }, async () => {
			while (firstError === undefined) {
				const idx = next++;
				if (idx >= items.length) break;
				try {
					await worker(items[idx] as T);
				} catch (err) {
					if (firstError === undefined) firstError = err;
					break;
				}
			}
		}),
	);

	if (firstError !== undefined) {
		throw firstError;
	}
}

async function readErrorBody(res: Response): Promise<string> {
	const text = await res.text().catch(() => "");
	if (!text) return res.statusText || `HTTP ${res.status}`;
	try {
		const parsed = JSON.parse(text) as {
			message?: string;
			errors?: Array<{ code?: string; field?: string; message?: string }>;
		};
		if (parsed.message) {
			const detail = parsed.errors
				?.map((e) => e.message ?? e.code ?? e.field)
				.filter(Boolean)
				.join(", ");
			return detail ? `${parsed.message} (${detail})` : parsed.message;
		}
	} catch {
		// fall back to plain text
	}
	return text.trim();
}

function releaseWorkflowYaml(branch: string, bunVersion: string): string {
	return `name: Publish extension release

on:
  push:
    branches: [${yamlScalar(branch)}]
  workflow_dispatch:

permissions:
  contents: write

concurrency:
  group: extensions-release
  cancel-in-progress: true

jobs:
  publish-release:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Bun
        uses: oven-sh/setup-bun@v2
        with:
          bun-version: ${yamlScalar(bunVersion)}

      - name: Install dependencies
        run: bun install --frozen-lockfile

      - name: Check types
        run: bun run --if-present check-types

      - name: Build extensions
        run: bun run --if-present build

      - name: Build index and publish release
        env:
          GH_TOKEN: \${{ github.token }}
        run: bun run publish-extensions
`;
}

function buildPublishScriptCommand(options: PublishOptions): string {
	const indexParts = ["dion-build-index"];
	const publishParts = ["dion-publish"];
	if (options.source && options.source !== DEFAULT_SOURCE) {
		indexParts.push("--out", shellWord(options.source));
		publishParts.push("--source", shellWord(options.source));
	}
	if (options.tag && options.tag !== DEFAULT_TAG) {
		publishParts.push("--tag", shellWord(options.tag));
	}
	if (options.title && options.title !== (options.tag ?? DEFAULT_TAG)) {
		publishParts.push("--title", shellWord(options.title));
	}
	if (options.prune === false) {
		publishParts.push("--no-prune");
	}
	return `${indexParts.join(" ")} && ${publishParts.join(" ")}`;
}

export async function initReleaseWorkflow(
	options: PublishOptions = {},
): Promise<void> {
	const cwd = options.cwd ?? process.cwd();
	const force = options.force ?? false;
	const log = options.log ?? ((msg: string) => console.log(msg));

	const workflowPath = join(cwd, ".github/workflows/release.yml");
	if (!force && (await file(workflowPath).exists())) {
		log(
			"Workflow already exists at .github/workflows/release.yml (use --force to overwrite)",
		);
	} else {
		const [branch, bunVersion] = await Promise.all([
			gitDefaultBranch(cwd),
			detectBunVersion(cwd),
		]);
		await mkdir(dirname(workflowPath), { recursive: true });
		await writeFile(workflowPath, releaseWorkflowYaml(branch, bunVersion));
		log(`Wrote .github/workflows/release.yml (branch: ${branch})`);
	}

	const pkgPath = join(cwd, "package.json");
	if (await file(pkgPath).exists()) {
		const pkg = (await file(pkgPath).json()) as {
			scripts?: Record<string, string>;
		};
		pkg.scripts ??= {};
		if (pkg.scripts["publish-extensions"] === undefined || force) {
			pkg.scripts["publish-extensions"] = buildPublishScriptCommand(options);
			await writeFile(pkgPath, `${JSON.stringify(pkg, null, "\t")}\n`);
			log('Updated "publish-extensions" script in package.json');
		}
	}
}

async function resolveTargetRepo(
	cwd: string,
	options: PublishOptions,
): Promise<GitHubRef> {
	const candidates = [
		options.repo,
		process.env.GITHUB_REPOSITORY,
		await readRepoPackageUrl(cwd),
		await (options.remoteUrl ? options.remoteUrl() : gitRemoteUrl(cwd)),
	];
	for (const candidate of candidates) {
		const parsed = parseRepoRef(candidate);
		if (parsed) return parsed;
	}
	throw new Error(
		"Could not determine target GitHub repository. Pass --repo <owner/repo>, " +
			"set GITHUB_REPOSITORY, or configure package.json url / git remote origin.",
	);
}

export async function publishRelease(
	options: PublishOptions = {},
): Promise<PublishResult> {
	const cwd = options.cwd ?? process.cwd();
	const log = options.log ?? ((msg: string) => console.log(msg));

	if (options.init) {
		await initReleaseWorkflow(options);
		return {
			repo: "",
			tag: options.tag ?? DEFAULT_TAG,
			createdRelease: false,
			uploaded: [],
			pruned: [],
			dryRun: false,
		};
	}

	const sourceDir = resolve(cwd, options.source ?? DEFAULT_SOURCE);
	const tag = options.tag ?? DEFAULT_TAG;
	const title = options.title ?? tag;
	const notes = options.notes ?? DEFAULT_NOTES;
	const prune = options.prune ?? true;
	const dryRun = options.dryRun ?? false;
	const concurrency = Math.max(1, options.concurrency ?? DEFAULT_CONCURRENCY);
	const apiUrl = (
		options.apiUrl ??
		process.env.GITHUB_API_URL ??
		DEFAULT_API_URL
	).replace(/\/+$/, "");

	const [repoRef, assets] = await Promise.all([
		resolveTargetRepo(cwd, options),
		collectAssets(sourceDir),
	]);

	// Upload the repo index last so clients never see a manifest referencing
	// bundles that have not been uploaded yet.
	const indexAsset = assets.find((a) => a.name === INDEX_FILENAME);
	const bundleAssets = assets.filter((a) => a.name !== INDEX_FILENAME);
	const orderedNames = [
		...bundleAssets.map((a) => a.name),
		...(indexAsset ? [indexAsset.name] : []),
	];

	if (dryRun) {
		log(`[dry-run] Repository: ${repoRef.slug}`);
		log(`[dry-run] Release tag: ${tag} (title: ${title})`);
		log(
			`[dry-run] Would upload ${orderedNames.length} asset(s): ${orderedNames.join(", ")}`,
		);
		log(
			`[dry-run] Stale asset pruning: ${prune ? "enabled" : "disabled (--no-prune)"}`,
		);
		return {
			repo: repoRef.slug,
			tag,
			createdRelease: false,
			uploaded: orderedNames,
			pruned: [],
			dryRun: true,
		};
	}

	const token =
		options.token ?? process.env.GH_TOKEN ?? process.env.GITHUB_TOKEN;
	if (!token) {
		throw new Error(
			"Missing GitHub auth token: set GH_TOKEN or GITHUB_TOKEN in the environment.",
		);
	}

	const fetchImpl = options.fetch ?? globalThis.fetch;
	const baseHeaders: Record<string, string> = {
		Authorization: `Bearer ${token}`,
		Accept: "application/vnd.github+json",
		"X-GitHub-Api-Version": "2022-11-28",
		"User-Agent": "@dion-js/extension-scripts",
	};

	const releaseTagUrl = `${apiUrl}/repos/${repoRef.slug}/releases/tags/${encodeURIComponent(tag)}`;

	async function fetchReleaseByTag(): Promise<GitHubRelease | undefined> {
		const res = await fetchImpl(releaseTagUrl, {
			method: "GET",
			headers: baseHeaders,
		});
		if (res.status === 404) return undefined;
		if (!res.ok) {
			const msg = await readErrorBody(res);
			throw new Error(
				`Failed to fetch release "${tag}" in ${repoRef.slug} (${res.status}): ${msg}`,
			);
		}
		return (await res.json()) as GitHubRelease;
	}

	let release = await fetchReleaseByTag();
	let createdRelease = false;

	if (release) {
		log(`Using existing release "${tag}" in ${repoRef.slug}`);
	} else {
		const createRes = await fetchImpl(
			`${apiUrl}/repos/${repoRef.slug}/releases`,
			{
				method: "POST",
				headers: {
					...baseHeaders,
					"Content-Type": "application/json",
				},
				body: JSON.stringify({
					tag_name: tag,
					name: title,
					body: notes,
					draft: false,
					prerelease: false,
				}),
			},
		);

		if (createRes.ok) {
			release = (await createRes.json()) as GitHubRelease;
			createdRelease = true;
			log(`Created release "${tag}" in ${repoRef.slug}`);
		} else if (createRes.status === 422) {
			// Handle concurrent workflow runs creating the release simultaneously.
			const existing = await fetchReleaseByTag();
			if (existing) {
				release = existing;
				log(`Release "${tag}" already exists in ${repoRef.slug}`);
			} else {
				const msg = await readErrorBody(createRes);
				throw new Error(
					`Failed to create release "${tag}" in ${repoRef.slug} (${createRes.status}): ${msg}`,
				);
			}
		} else {
			const msg = await readErrorBody(createRes);
			throw new Error(
				`Failed to create release "${tag}" in ${repoRef.slug} (${createRes.status}): ${msg}`,
			);
		}
	}

	const existingAssets = new Map<string, number>();
	if (!createdRelease) {
		let page = 1;
		while (true) {
			const res = await fetchImpl(
				`${apiUrl}/repos/${repoRef.slug}/releases/${release.id}/assets?per_page=100&page=${page}`,
				{
					method: "GET",
					headers: baseHeaders,
				},
			);
			if (!res.ok) {
				const msg = await readErrorBody(res);
				throw new Error(
					`Failed to list assets for release "${tag}" (${res.status}): ${msg}`,
				);
			}
			const batch = (await res.json()) as GitHubAsset[];
			for (const asset of batch) {
				existingAssets.set(asset.name, asset.id);
			}
			if (batch.length < 100) break;
			page++;
		}
	}

	async function deleteAsset(assetId: number, name: string): Promise<void> {
		const res = await fetchImpl(
			`${apiUrl}/repos/${repoRef.slug}/releases/assets/${assetId}`,
			{
				method: "DELETE",
				headers: baseHeaders,
			},
		);
		if (res.status === 404) return;
		if (!res.ok) {
			const msg = await readErrorBody(res);
			throw new Error(
				`Failed to delete asset "${name}" (id ${assetId}) (${res.status}): ${msg}`,
			);
		}
	}

	const uploadBaseUrl = release.upload_url.replace(/\{[^}]*\}$/, "");

	async function uploadAsset(asset: AssetFile): Promise<void> {
		const existingId = existingAssets.get(asset.name);
		if (existingId !== undefined) {
			await deleteAsset(existingId, asset.name);
		}
		const bytes = await readFile(asset.path);
		const url = `${uploadBaseUrl}?name=${encodeURIComponent(asset.name)}`;
		const res = await fetchImpl(url, {
			method: "POST",
			headers: {
				...baseHeaders,
				"Content-Type": contentTypeFor(asset.name),
			},
			body: bytes,
		});
		if (!res.ok) {
			const msg = await readErrorBody(res);
			throw new Error(
				`Failed to upload asset "${asset.name}" (${res.status}): ${msg}`,
			);
		}
		log(`Uploaded ${asset.name}`);
	}

	await runWithConcurrency(bundleAssets, concurrency, uploadAsset);
	if (indexAsset) {
		await uploadAsset(indexAsset);
	}

	const uploadedSet = new Set(orderedNames);
	const pruned: string[] = [];

	if (prune) {
		const stale = [...existingAssets.entries()].filter(
			([name]) => !uploadedSet.has(name),
		);
		await runWithConcurrency(stale, concurrency, async ([name, id]) => {
			await deleteAsset(id, name);
			pruned.push(name);
			log(`Pruned stale asset ${name}`);
		});
	}

	log(
		`Published ${orderedNames.length} asset(s) to ${repoRef.slug}@${tag}` +
			(pruned.length > 0 ? ` (pruned ${pruned.length} stale)` : ""),
	);

	return {
		repo: repoRef.slug,
		tag,
		createdRelease,
		uploaded: orderedNames,
		pruned: pruned.sort((a, b) => a.localeCompare(b)),
		dryRun: false,
	};
}

export function parseArgs(args: string[]): PublishOptions & { help: boolean } {
	const out: PublishOptions & { help: boolean } = { help: false };
	const it = args[Symbol.iterator]();
	let current = it.next();
	while (!current.done) {
		const token = current.value as string;
		const requireValue = (flag: string): string => {
			const n = it.next();
			if (n.done || (n.value as string).startsWith("-")) {
				throw new Error(`Missing value for ${flag}`);
			}
			return n.value as string;
		};
		const eqValue = (): string => token.slice(token.indexOf("=") + 1);

		if (token === "-h" || token === "--help") {
			out.help = true;
		} else if (token === "--source") {
			out.source = requireValue(token);
		} else if (token.startsWith("--source=")) {
			out.source = eqValue();
		} else if (token === "--tag") {
			out.tag = requireValue(token);
		} else if (token.startsWith("--tag=")) {
			out.tag = eqValue();
		} else if (token === "--title") {
			out.title = requireValue(token);
		} else if (token.startsWith("--title=")) {
			out.title = eqValue();
		} else if (token === "--notes") {
			out.notes = requireValue(token);
		} else if (token.startsWith("--notes=")) {
			out.notes = eqValue();
		} else if (token === "--repo") {
			out.repo = requireValue(token);
		} else if (token.startsWith("--repo=")) {
			out.repo = eqValue();
		} else if (token === "--api-url") {
			out.apiUrl = requireValue(token);
		} else if (token.startsWith("--api-url=")) {
			out.apiUrl = eqValue();
		} else if (token === "--concurrency") {
			const parsed = Number.parseInt(requireValue(token), 10);
			if (!Number.isFinite(parsed) || parsed < 1) {
				throw new Error("--concurrency must be a positive integer");
			}
			out.concurrency = parsed;
		} else if (token.startsWith("--concurrency=")) {
			const parsed = Number.parseInt(eqValue(), 10);
			if (!Number.isFinite(parsed) || parsed < 1) {
				throw new Error("--concurrency must be a positive integer");
			}
			out.concurrency = parsed;
		} else if (token === "--no-prune") {
			out.prune = false;
		} else if (token === "--prune") {
			out.prune = true;
		} else if (token === "--dry-run") {
			out.dryRun = true;
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

const usage = `dion-publish — publish a built Dion extension repository to a GitHub release

Usage: dion-publish [options]

Options:
  --source <dir>      Directory containing built index assets (default: .index)
  --tag <tag>         GitHub release tag (default: extensions)
  --title <title>     Release title when creating a release (default: <tag>)
  --notes <text>      Release notes when creating a release
  --repo <owner/repo> Target GitHub repository (default: GITHUB_REPOSITORY,
                      package.json url/repository, or git origin remote)
  --api-url <url>     GitHub API base URL (default: GITHUB_API_URL or
                      https://api.github.com)
  --concurrency <n>   Max concurrent asset uploads/deletes (default: 5)
  --no-prune          Keep existing release assets not present in source
  --dry-run           Print planned release actions without modifying GitHub
  --init              Write .github/workflows/release.yml and a
                      publish-extensions npm script, then exit
  --force             Overwrite an existing workflow file with --init
  -h, --help          Show this help

Authentication:
  Set GH_TOKEN or GITHUB_TOKEN (e.g. \${{ github.token }} in GitHub Actions)
  with contents: write permission.
`;

export async function main(): Promise<void> {
	const opts = parseArgs(argv.slice(2));
	if (opts.help) {
		console.log(usage);
		return;
	}
	await publishRelease(opts);
}
