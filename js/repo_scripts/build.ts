import { $ } from "bun";
await $`rm -rf .dist && mkdir .dist`;
const bundle = await Bun.build({
	entrypoints: ["src/bundle.ts", "src/create.ts", "src/index.ts"],
	outdir: ".dist",
	target: "bun",
	packages: "external",
	minify: true,
	// bytecode: true,
	// format: "cjs",
});
if (!bundle.success) {
	try {
		await $`rm -rf .dist`;
	} catch (e) {
		console.error("Failed to remove .dist directory:", e);
	}
	throw new AggregateError(bundle.logs);
}
for (const output of bundle.outputs) {
	if (output?.path.endsWith(".js")) {
		await $`chmod +x ${output.path}`;
	}
}
