import { copyFile, exists, mkdir, readdir, rm, stat } from "node:fs/promises";
import { join, resolve } from "node:path";
import {
	type DionRepoIndex,
	valibot as vs,
} from "@dion-js/runtime-types/extension";
import { argv, file } from "bun";
import * as v from "valibot";
import { getPackageMeta } from "../utils/parse.ts";

export type BuildIndexOptions = {
	cwd?: string;
	/** Directory containing extension packages. Default "extensions". */
	extensionsDir?: string;
	/** Output directory for the index and copied bundles. Default ".index". */
	out?: string;
	/** Path to the repository package.json. Default "package.json". */
	repoPackage?: string;
	log?: (msg: string) => void;
};

const DEFAULT_EXTENSIONS_DIR = "extensions";
const DEFAULT_OUT = ".index";
const DEFAULT_REPO_PACKAGE = "package.json";

async function listExtensionDirs(extensionsRoot: string): Promise<string[]> {
	const entries = (await readdir(extensionsRoot, { withFileTypes: true })).sort(
		(a, b) => a.name.localeCompare(b.name),
	);
	const dirs: string[] = [];
	for (const entry of entries) {
		if (entry.name.startsWith(".")) continue;
		if (entry.isDirectory()) {
			dirs.push(entry.name);
		} else if (entry.isSymbolicLink()) {
			try {
				const st = await stat(join(extensionsRoot, entry.name));
				if (st.isDirectory()) dirs.push(entry.name);
			} catch {
				// ignore broken symlinks
			}
		}
	}
	return dirs;
}

async function resolveBundleFilename(
	extDir: string,
	dirName: string,
): Promise<{ src: string; filename: string } | undefined> {
	const pkgPath = join(extDir, "package.json");
	let pkgName: string | undefined;
	if (await exists(pkgPath)) {
		try {
			const pkg = (await file(pkgPath).json()) as { name?: unknown };
			if (typeof pkg.name === "string" && pkg.name.trim().length > 0) {
				pkgName = pkg.name.trim();
			}
		} catch {
			// fall back to directory name
		}
	}

	const candidates =
		pkgName && pkgName !== dirName
			? [`${pkgName}.dion.js`, `${dirName}.dion.js`]
			: [`${dirName}.dion.js`];

	for (const filename of candidates) {
		const src = join(extDir, ".dist", filename);
		if (await exists(src)) {
			return { src, filename };
		}
	}
	return undefined;
}

export async function buildIndex(
	options: BuildIndexOptions = {},
): Promise<DionRepoIndex> {
	const cwd = options.cwd ?? process.cwd();
	const extensionsRoot = resolve(
		cwd,
		options.extensionsDir ?? DEFAULT_EXTENSIONS_DIR,
	);
	const outDir = resolve(cwd, options.out ?? DEFAULT_OUT);
	const repoPkgPath = resolve(cwd, options.repoPackage ?? DEFAULT_REPO_PACKAGE);
	const log = options.log ?? ((msg: string) => console.log(msg));

	await rm(outDir, { recursive: true, force: true });
	await mkdir(outDir, { recursive: true });

	const extensions = await listExtensionDirs(extensionsRoot);

	const repojson = v.parse(
		v.omit(vs.DionRepoIndex, ["repo_index_version", "content"]),
		await file(repoPkgPath).json(),
	);

	const builtEntries = await Promise.all(
		extensions.map(async (extension) => {
			const extDir = join(extensionsRoot, extension);
			const found = await resolveBundleFilename(extDir, extension);
			if (!found) {
				console.warn(
					`Built bundle does not exist for extension "${extension}", skipping.`,
				);
				return undefined;
			}
			const dest = join(outDir, found.filename);
			log(`Copying ${found.src} to ${dest}`);
			await copyFile(found.src, dest);
			try {
				const packagejson = await getPackageMeta({
					repoIndexPath: repoPkgPath,
					extensionPath: join(extDir, "package.json"),
					repoUrl: repojson.url,
				});
				return {
					path: found.filename,
					extdata: packagejson,
				};
			} catch (e) {
				console.error(
					`Failed to parse package.json for extension ${extension}:`,
					e,
				);
				return undefined;
			}
		}),
	);

	const indexData: DionRepoIndex = {
		repo_index_version: 1,
		content: builtEntries.filter((meta) => meta !== undefined),
		...repojson,
	};

	await file(join(outDir, "index.repo.json")).write(JSON.stringify(indexData));
	return indexData;
}

export function parseArgs(
	args: string[],
): BuildIndexOptions & { help: boolean } {
	const out: BuildIndexOptions & { help: boolean } = { help: false };
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
		} else if (token === "--extensions") {
			out.extensionsDir = requireValue(token);
		} else if (token.startsWith("--extensions=")) {
			out.extensionsDir = eqValue();
		} else if (token === "--out") {
			out.out = requireValue(token);
		} else if (token.startsWith("--out=")) {
			out.out = eqValue();
		} else if (token === "--repo-pkg") {
			out.repoPackage = requireValue(token);
		} else if (token.startsWith("--repo-pkg=")) {
			out.repoPackage = eqValue();
		} else {
			throw new Error(`Unknown argument: ${token}`);
		}
		current = it.next();
	}
	return out;
}

const usage = `dion-build-index — collect built extensions and generate index.repo.json

Usage: dion-build-index [options]

Options:
  --extensions <dir> Directory containing extension packages (default: extensions)
  --out <dir>        Output directory for the index (default: .index)
  --repo-pkg <path>  Path to repository package.json (default: package.json)
  -h, --help         Show this help
`;

export async function main(): Promise<void> {
	const opts = parseArgs(argv.slice(2));
	if (opts.help) {
		console.log(usage);
		return;
	}
	await buildIndex(opts);
}
