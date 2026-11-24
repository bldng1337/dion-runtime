import { join } from "node:path";
import { $, file } from "bun";

export type GitHubRef = {
	owner: string;
	repo: string;
	slug: string;
	homepage: string;
};

/** Parse a GitHub repository URL (HTTPS or SSH) into owner/repo parts. */
export function parseGitHubRepo(
	url: string | undefined,
): GitHubRef | undefined {
	if (!url) return undefined;
	const trimmed = url.trim();
	const m = trimmed.match(
		/github\.com[/:]([A-Za-z0-9_.-]+)\/([A-Za-z0-9_.-]+?)(?:\.git)?[/?#]?$/i,
	);
	if (!m) return undefined;
	const owner = m[1];
	const repo = m[2];
	return {
		owner,
		repo,
		slug: `${owner}/${repo}`,
		homepage: `https://github.com/${owner}/${repo}`,
	};
}

/** Parse either an "owner/repo" slug or a GitHub URL. */
export function parseRepoRef(input: string | undefined): GitHubRef | undefined {
	if (!input) return undefined;
	const trimmed = input.trim();
	const slugMatch = trimmed.match(/^([A-Za-z0-9_.-]+)\/([A-Za-z0-9_.-]+)$/);
	if (slugMatch) {
		const owner = slugMatch[1];
		const repo = slugMatch[2].replace(/\.git$/i, "");
		return {
			owner,
			repo,
			slug: `${owner}/${repo}`,
			homepage: `https://github.com/${owner}/${repo}`,
		};
	}
	return parseGitHubRepo(trimmed);
}

export async function gitRemoteUrl(cwd: string): Promise<string | undefined> {
	const res = await $`git -C ${cwd} config --get remote.origin.url`
		.quiet()
		.nothrow();
	const out = res.stdout.toString().trim();
	return out.length ? out : undefined;
}

export async function gitDefaultBranch(cwd: string): Promise<string> {
	const res =
		await $`git -C ${cwd} symbolic-ref --short refs/remotes/origin/HEAD`
			.quiet()
			.nothrow();
	const out = res.stdout.toString().trim();
	const branch = out.split("/").slice(1).join("/") || out;
	return branch.length ? branch : "main";
}

export async function readRepoPackageUrl(
	cwd: string,
): Promise<string | undefined> {
	const pkgPath = join(cwd, "package.json");
	if (!(await file(pkgPath).exists())) return undefined;
	try {
		const pkg = (await file(pkgPath).json()) as {
			url?: unknown;
			repository?: unknown;
		};
		if (typeof pkg.url === "string" && pkg.url.trim().length > 0) {
			return pkg.url;
		}
		if (
			typeof pkg.repository === "string" &&
			pkg.repository.trim().length > 0
		) {
			return pkg.repository;
		}
		if (
			pkg.repository &&
			typeof pkg.repository === "object" &&
			"url" in pkg.repository &&
			typeof (pkg.repository as { url?: unknown }).url === "string"
		) {
			const repoUrl = (pkg.repository as { url: string }).url;
			if (repoUrl.trim().length > 0) return repoUrl;
		}
	} catch {
		return undefined;
	}
	return undefined;
}

export async function detectBunVersion(
	cwd: string,
	fallback = "1.2.19",
): Promise<string> {
	const pkgPath = join(cwd, "package.json");
	if (!(await file(pkgPath).exists())) return fallback;
	try {
		const pkg = (await file(pkgPath).json()) as { packageManager?: unknown };
		if (typeof pkg.packageManager === "string") {
			const m = pkg.packageManager.match(/^bun@([0-9]+\.[0-9]+\.[0-9]+.*)$/);
			if (m) return m[1];
		}
	} catch {
		return fallback;
	}
	return fallback;
}
