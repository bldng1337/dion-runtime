import { existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

// Bun only links a package's bins when the target file already exists at
// `bun install` time. The bundled CLI in .dist does not exist on a fresh
// checkout, which left the bins unlinked and made `bunx dion-bundle` fall
// back to fetching a (nonexistent) `dion-bundle` package from the registry.
// The bin entrypoints therefore live in this committed directory, load the
// real CLI from .dist, and build .dist on demand when it is missing.
export async function run(name: "bundle" | "create" | "index"): Promise<void> {
	const root = join(dirname(fileURLToPath(import.meta.url)), "..");
	const entry = join(root, ".dist", `${name}.js`);
	if (!existsSync(entry)) {
		console.error(
			`@dion-js/extension-scripts: .dist/${name}.js not found, building it...`,
		);
		await import(pathToFileURL(join(root, "build.ts")).href);
	}
	await import(pathToFileURL(entry).href);
}
