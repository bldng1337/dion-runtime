import { copyFile, exists, readdir } from "node:fs/promises";
import { join } from "node:path";
import {
	type DionRepoIndex,
	valibot as vs,
} from "@dion-js/runtime-types/extension";
import { $, file } from "bun";
import * as v from "valibot";
import { getPackageMeta } from "./utils/parse.ts";

async function main() {
	const index_folder = ".index";
	const [extensions] = await Promise.all([
		readdir("./extensions"),
		$`rm -rf ${index_folder} && mkdir ${index_folder}`,
	]);

	await Promise.all(
		extensions.map(async (extension) => {
			const dest = join(index_folder, `${extension}.dion.js`);
			const src = join(
				"extensions",
				extension,
				".dist",
				`${extension}.dion.js`,
			);
			if (!(await exists(src))) {
				console.warn(`Source file does not exist: ${src}, skipping.`);
				return;
			}
			// Copy each file
			console.log(`Copying ${src} to ${dest}`);
			await copyFile(src, dest);
		}),
	);

	const repojson = v.parse(
		v.omit(vs.DionRepoIndex, ["repo_index_version", "content"]),
		await file(`./package.json`).json(),
	);

	const extensionindex = (
		await Promise.all(
			extensions.map(async (extension) => {
				const dest = join(index_folder, `${extension}.dion.js`);
				if (!(await exists(dest))) {
					return undefined;
				}
				try {
					const options = {
						repoIndexPath: `./package.json`,
						extensionPath: `./extensions/${extension}/package.json`,
						repoUrl: repojson.url,
					};
					const packagejson = await getPackageMeta(options);

					return {
						path: `${extension}.dion.js`,
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
		)
	).filter((meta) => meta !== undefined);

	await file(`${index_folder}/index.repo.json`).write(
		JSON.stringify({
			repo_index_version: 1,
			content: extensionindex,
			...repojson,
		} as DionRepoIndex),
	);
}

main().catch((e) => {
	console.error("Failed to build index");
	console.error(e.message);
	console.error(e.stack);
	console.error(e);
	process.exit(1);
});
