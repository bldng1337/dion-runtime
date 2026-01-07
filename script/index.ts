import { $, file } from "bun";
import * as fs from "node:fs";
import * as paths from "node:path";
import { parseArgs } from "node:util";

const { values, positionals } = parseArgs({
	args: Bun.argv,
	options: {
		release: {
			type: "boolean",
			default: false,
			short: "r",
		},
		tryall: {
			type: "boolean",
			default: false,
			short: "t",
		},
		path: {
			type: "string",
			default: undefined,
			short: "p",
			multiple: true,
		},
	},
	strict: true,
	allowPositionals: true,
});
class Project {
	_path: string;
	constructor(path: string) {
		this._path = path;
	}

	get path() {
		return this._path;
	}

	async lint() {
		// Base implementation - should be overridden by subclasses
	}
	async build(release: boolean) {
		// Base implementation - should be overridden by subclasses
	}
	async test() {
		// Base implementation - should be overridden by subclasses
	}
	async format() {
		// Base implementation - should be overridden by subclasses
	}
	async clean() {
		// Base implementation - should be overridden by subclasses
	}
}

class RustProject extends Project {
	async lint() {
		await $`cd ${this.path} && cargo clippy --all-targets --all-features -- -D warnings`;
	}

	async build(release: boolean) {
		await $`cd ${this.path} && cargo build ${release ? "--release" : ""}`;
	}

	async test() {
		await $`cd ${this.path} && cargo test`;
	}

	async format() {
		await $`cd ${this.path} && cargo fmt`;
	}

	async clean() {
		await $`cd ${this.path} && cargo clean`;
	}
}

class FlutterRustProject extends Project {
	async lint() {
		// await $`cd ${this.path} && cd rust && cargo clippy --all-targets --all-features -- -D warnings`;
		// await $`cd ${this.path} && dart analyze`;
	}

	async build(_release: boolean) {
		const isRustBridge = await file(
			paths.join(this.path, "flutter_rust_bridge.yaml"),
		).exists();
		if (isRustBridge) {
			await $`cd ${this.path} && flutter clean && cd lib && rm -rf src`;
			await $`cd ${this.path}/example && flutter clean`;
			await $`cd ${this.path} && flutter_rust_bridge_codegen generate`;
			await $`cd ${this.path}/rust && cargo build`;
		}
	}

	async test() {
		await $`cd ${this.path} && flutter pub get`;
		for (const path of [this.path, paths.join(this.path, "example")]) {
			for (const testbed of ["test", "integration_test"]) {
				const testpath = paths.join(path, testbed);
				if (fs.existsSync(testpath)) {
					for (const file of fs.readdirSync(testpath)) {
						if (file.endsWith(".dart")) {
							await $`cd ${path} && flutter test ${paths.join(testbed, file)} --timeout none`;
						}
					}
				}
			}
		}
	}

	async format() {
		await $`cd ${this.path} && cd rust && cargo clean`;
		await $`cd ${this.path} && dart format lib -o write`;
	}

	async clean() {
		await $`cd ${this.path} && cd rust && cargo fmt`;
		await $`cd ${this.path} && flutter clean`;
	}
}

class JSProject extends Project {
	async lint() {
		await $`cd ${this.path} && bun run lint`;
	}

	async build(release: boolean) {
		if (release) {
			const res = await $`cd ${this.path} && bun run build:release`.nothrow();
			if (res.exitCode === 0) return;
		}
		await $`cd ${this.path} && bun run build`;
	}

	async test() {
		await $`cd ${this.path} && bun run test`;
	}

	async format() {
		await $`cd ${this.path} && bun run format`;
	}

	async clean() {
		await $`cd ${this.path} && bun run clean`;
	}
}

const rustPath = ["rust/core", "rust/dion_extension"];
const dartPath = ["dart/rdion_runtime"];
const jsPath = ["js/runtime"];

export const projects = [
	...rustPath.map((path) => new RustProject(path)),
	...dartPath.map((path) => new FlutterRustProject(path)),
	...jsPath.map((path) => new JSProject(path)),
];

function exitPrematurely(message: string) {
	console.error(message);
	if (!values.tryall) {
		process.exit(1);
	}
}

for (const action of positionals.slice(2)) {
	for (const project of projects) {
		if (
			Array.isArray(values.path) &&
			values.path.length > 0 &&
			!values.path.some((p) => project.path.startsWith(p))
		) {
			continue;
		}
		console.log("\x1b[32m%s\x1b[0m", `[${action}]: ${project.path}`);
		switch (action) {
			case "build":
				try {
					await project.build(values.release);
				} catch (_e) {
					exitPrematurely(`[${action}]: Failed in ${project.path}`);
				}
				break;
			case "test":
				try {
					await project.test();
				} catch (_e) {
					exitPrematurely(`[${action}]: Failed in ${project.path}`);
				}
				break;
			case "format":
				try {
					await project.format();
				} catch (_e) {
					exitPrematurely(`[${action}]: Failed in ${project.path}`);
				}
				break;
			case "lint":
				try {
					await project.lint();
				} catch (_e) {
					exitPrematurely(`[${action}]: Failed in ${project.path}`);
				}
				break;
			case "clean":
				try {
					await project.clean();
				} catch (_e) {
					exitPrematurely(`[${action}]: Failed in ${project.path}`);
				}
				break;
			default:
				exitPrematurely(`Unknown action: ${action}`);
		}
	}
}
