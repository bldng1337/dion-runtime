import {
	type ExtensionMetadata,
	valibot as vs,
} from "@dion-js/runtime-types/extension";
import { $, file } from "bun";
import * as v from "valibot";

export async function tryFetchGitUrl(options?: {
	repoIndexPath?: string;
}): Promise<string | undefined> {
	let command_res: string | undefined;
	let command_error: unknown | undefined;
	try {
		const res = await $`git config --get remote.origin.url`.quiet();
		command_res = res.stdout.toString().trim();
	} catch (error) {
		command_error = error;
	}
	const repo = v.parse(
		v.omit(vs.DionRepoIndex, ["repo_index_version", "content"]),
		await file(options?.repoIndexPath ?? `../../package.json`).json(),
	);
	if (repo.url !== undefined) {
		return repo.url;
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
