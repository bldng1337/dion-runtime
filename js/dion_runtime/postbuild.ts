import { file } from "bun";

async function main() {
	console.log("Including Types");
	const typefile = file("index.d.ts");
	const data = await typefile.text();
	await typefile.write(`/// <reference types="@dion-js/runtime-types" />\n${data}`);
}
main();
