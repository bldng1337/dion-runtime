#!/usr/bin/env bun
import { main } from "./site/build.ts";

main().catch((e) => {
	console.error(e);
	process.exit(1);
});
