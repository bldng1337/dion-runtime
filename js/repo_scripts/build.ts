import { $ } from "bun";

// Anchor every path to this directory so the build also works when it is
// triggered from elsewhere (the bin launchers import this file with the
// caller's working directory).
const root = import.meta.dir;

await $`rm -rf ${root}/.dist`;
const bundle = await Bun.build({
	entrypoints: [
		`${root}/src/bundle.ts`,
		`${root}/src/create.ts`,
		`${root}/src/index.ts`,
	],
	outdir: `${root}/.dist`,
	target: "bun",
	packages: "external",
	minify: true,
	// bytecode: true,
	// format: "cjs",
});
if (!bundle.success) {
	try {
		await $`rm -rf ${root}/.dist`;
	} catch (e) {
		console.error("Failed to remove .dist directory:", e);
	}
	throw new AggregateError(bundle.logs);
}
// for (const output of bundle.outputs) {
// 	if (output?.path.endsWith(".js")) {
// 		await $`chmod +x ${output.path}`;
// 	}
// }
