import { readdirSync, rmSync, type Stats, statSync } from "node:fs";
import { join } from "node:path";

function deleteTargetFiles(dir: string): void {
	let entries: string[];
	try {
		entries = readdirSync(dir);
	} catch (error) {
		console.error(`Error reading directory ${dir}:`, error);
		return;
	}

	for (const entry of entries) {
		const fullPath = join(dir, entry);
		let stat: Stats;
		try {
			stat = statSync(fullPath);
		} catch (error) {
			console.error(`Error stating ${fullPath}:`, error);
			continue;
		}

		if (stat.isDirectory()) {
			if (entry === ".httpcache") {
				try {
					rmSync(fullPath, { recursive: true, force: true });
					console.log(`Deleted directory: ${fullPath}`);
				} catch (error) {
					console.error(`Error deleting directory ${fullPath}:`, error);
				}
			} else if (entry !== "native") {
				deleteTargetFiles(fullPath);
			}
		} else if (stat.isFile()) {
			if (entry === ".httpcache" || entry.endsWith(".dion.js")) {
				try {
					rmSync(fullPath);
					console.log(`Deleted file: ${fullPath}`);
				} catch (error) {
					console.error(`Error deleting file ${fullPath}:`, error);
				}
			}
		}
	}
}

const rootDir = process.cwd();
console.log(`Starting cleanup from: ${rootDir}`);
deleteTargetFiles(rootDir);
console.log("Cleanup completed.");
