#!/usr/bin/env bun
import { main } from "./create/index.ts";

main().catch((e) => {
	console.error(e);
	process.exit(1);
});
