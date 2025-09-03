/// <reference path="../../js/dion_runtime_types/index.d.ts" />
import { readdir, stat } from "node:fs/promises";

for (const path of await readdir(".")) {
	if (!(await stat(path)).isDirectory()) continue;
	if (!(await Bun.file(`${path}/extension.ts`).exists())) continue;
	console.log(`Building ${path}`);
	const res = await Bun.build({
		entrypoints: [`${path}/extension.ts`],
		target: "browser",
		// tsconfig: "./tsconfig.json",
		external: ["network", "permission", "setting", "parse", "convert"],
		format: "esm",
	});
	if (!res.success) throw new AggregateError(res.logs);
	if (res.outputs.length === 0) {
		throw new Error("No outputs found");
	}
	const code = await res.outputs[0]?.text();
	if (code === undefined) {
		throw new Error("No output found");
	}
	const extdata: ExtensionData = {
		id: path,
		repo: "repo",
		icon: "asd",
		name: path,
		version: "1.0.0",
		desc: "Minimal extension impl",
		author: [""],
		license: "0BSD",
		nsfw: false,
		lang: ["en"],
		media_type: ["Video"],
		url: "https://www.example.com",
		tags: [],
		extension_type: [
			"EntryExtension",
			"SourceProcessor",
			"SourceProvider",
			"URLResolve",
		],
	};
	Bun.file(`${path}/extension.dion.js`).write(
		`//${JSON.stringify(extdata)}\n${code}`,
	);
}
