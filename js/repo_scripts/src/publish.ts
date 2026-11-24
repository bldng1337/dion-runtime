#!/usr/bin/env bun
import { main } from "./publish/release.ts";

main().catch((e) => {
	console.error(e instanceof Error ? e.message : e);
	process.exit(1);
});
