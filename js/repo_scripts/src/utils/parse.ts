import {
	type ExtensionMetadata,
	valibot as vs,
} from "@dion-js/runtime-types/extension";
import { dirname, join, resolve } from "node:path";
import { $, file } from "bun";
import * as v from "valibot";

export function bundleFileName(packageName: string): string {
	return `${packageName.replace(/^@[^/]+\//, "").replaceAll(/[\\/]/g, "-")}.dion.js`;
}

async function findRepoPackageJson(start: string): Promise<string | undefined> {
	let dir = dirname(resolve(start));
	while (true) {
		const candidate = join(dir, "package.json");
		if (await file(candidate).exists()) {
			try {
				const json = (await file(candidate).json()) as { url?: unknown };
				if (typeof json.url === "string") return candidate;
			} catch {
				// not a usable package.json; keep walking up
			}
		}
		const parent = dirname(dir);
		if (parent === dir) return undefined;
		dir = parent;
	}
}

export async function tryFetchGitUrl(options?: {
	repoIndexPath?: string;
}): Promise<string | undefined> {
	const repoIndexPath =
		options?.repoIndexPath ?? (await findRepoPackageJson(process.cwd()));
	if (repoIndexPath !== undefined) {
		const repo = v.safeParse(
			v.omit(vs.DionRepoIndex, ["repo_index_version", "content"]),
			await file(repoIndexPath).json(),
		);
		if (repo.success && repo.output.url !== undefined) {
			return repo.output.url;
		}
	}
	let command_res: string | undefined;
	let command_error: unknown | undefined;
	try {
		const res = await $`git config --get remote.origin.url`.quiet();
		command_res = res.stdout.toString().trim();
	} catch (error) {
		command_error = error;
	}
	if (command_error !== undefined) {
		console.error(`Failed to get Repo URL from git config: ${command_error}`);
		return undefined;
	}
	return command_res;
}

export async function getPackageMeta(options?: {
	repoUrl?: string;
	extensionPath?: string;
	repoIndexPath?: string;
}): Promise<ExtensionMetadata> {
	const data = v.parse(
		v.omit(vs.ExtensionMetadata, ["repo"]),
		await file(options?.extensionPath ?? `./package.json`).json(),
	);
	if (options?.repoUrl === undefined) {
		return {
			...data,
			repo: await tryFetchGitUrl({ repoIndexPath: options?.repoIndexPath }),
		};
	}
	return {
		...data,
		repo: options?.repoUrl,
	};
}
