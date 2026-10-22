import { $ } from "bun";
import { patchTimestampTypes } from "../js/runtime_types/patchtypes.ts";

for (const projPath of ["rust/core", "rust/dion_extension"]) {
	await $`cd ${projPath} && cargo test --features=type specta::ts::gen_types`;
}
patchTimestampTypes();
