import { $, file } from "bun";

for (const projPath of ["rust/core", "rust/dion_extension"]) {
	await $`cd ${import.meta.dir} && cd ../.. && cd ${projPath} && cargo test --features=type specta::ts::gen_types`;
}
