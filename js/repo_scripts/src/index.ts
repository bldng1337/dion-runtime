#!/usr/bin/env bun
import { main } from "./index/build.ts";

main().catch((e) => {
	console.error("Failed to build index");
	if (e instanceof Error) {
		console.error(e.message);
		console.error(e.stack);
	}
	console.error(e);
	process.exit(1);
});
