#!/usr/bin/env bun
import { $, file } from "bun";
import { ValiError } from "valibot";
import { bundleFileName, getPackageMeta } from "./utils/parse.ts";

async function build(): Promise<string> {
	const res = await Bun.build({
		entrypoints: ["src/main.ts"],
		loader: {
			".gql": "text",
			".txt": "text",
		},
		minify: true,
		target: "browser",
		tsconfig: "./tsconfig.json",

		external: [
			"network",
			"permission",
			"setting",
			"parse",
			"convert",
			"auth",
			"action",
			"store",
			"cache",
			"filesystem",
			"metadata",
		],
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
	return code;
}

async function main() {
	try {
		await $`rm -rf .dist && mkdir .dist`;
		const [pkg, source] = await Promise.all([getPackageMeta(), build()]);
		// U+2028/U+2029 end a `//` comment in JS though JSON.stringify keeps them raw, which would let manifest fields inject module code.
		const manifest = JSON.stringify(pkg)
			.replaceAll("\u2028", "\\u2028")
			.replaceAll("\u2029", "\\u2029");
		await file(`./.dist/${bundleFileName(pkg.name)}`).write(
			`//${manifest}\n${source}`,
		);
	} catch (e) {
		console.error("Error during build:");
		if (e instanceof ValiError) {
			console.error("Validation error:");
			for (const issue of e.issues) {
				console.error(
					`  ${issue.path?.map((p: unknown) => (p as { key: string }).key).join(".")}: ${issue.message}`,
				);
			}
		} else {
			console.error(e);
		}
		process.exit(1);
	}
}
main();
