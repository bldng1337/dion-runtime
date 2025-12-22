import { file } from "bun";

async function main() {
	console.log("Including Types");
	const typefile = file("index.d.ts");
	const data = await typefile.text();
	await typefile.write(`import type { Action, EntryActivity, EntryDetailed, EntryDetailedResult, EntryId, EntryList, EpisodeId, ExtensionData, ExtensionRepo, Permission, RemoteExtensionResult, Setting, SettingKind, SettingValue, Source, SourceResult } from "@dion-js/runtime-types/runtime";\n${data}`);
}
main();
