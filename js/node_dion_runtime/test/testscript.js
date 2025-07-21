/// <reference types="dion-runtime-types" />
import { ExtensionManager } from "../dist/lib.js";

async function main() {
	const ext = new ExtensionManager("./../../testextensions");

	const exts = await ext.getExtensions();
	console.log(exts);

	for (const ext of exts) {
		console.log(ext);
		await ext.setEnabled(true);
		console.log(await ext.isEnabled());
		await ext.setSetting("someid", "othervalue");
		console.log("\n\nSetting:");
		console.log(await ext.getSetting("someid"));

		console.log("\n\nBrowse:");
		const entries = await ext.browse(0, "Popular");
		for (const entry of entries) {
			console.log(entry);
		}
		console.log("\n\nSearch:");
		const search = await ext.search(0, "some");
		for (const entry of search) {
			console.log(entry);
		}
		console.log("\n\nDetail:");
		const detail = await ext.detail("someid");
		console.log(detail);
		console.log("\n\nSource:");
		const source = await ext.source("someid");
		console.log(source);
	}
}
main();
