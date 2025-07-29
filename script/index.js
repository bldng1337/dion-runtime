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
    },
  },
  strict: true,
  allowPositionals: true,
});
class Project {
  constructor(path) {
    this._path = path;
  }

  get path() {
    return this._path;
  }

  async lint() {}
  /**
   *
   * @param {bool} release
   */
  async build(release) {}
  async test() {}
  async format() {}
  async clean() {}
}

class RustProject extends Project {
  constructor(path) {
    super(path);
  }

  async lint() {
    await $`cd ${this.path} && cargo clippy --all-targets --all-features -- -D warnings`;
  }

  async build(release) {
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
  constructor(path) {
    super(path);
  }

  async lint() {
    await $`cd ${this.path} && dart analyze`;
  }

  async build(release) {
    const isRustBridge = file(
      paths.join(this.path, "flutter_rust_bridge.yaml")
    ).exists();
    if (isRustBridge) {
      await $`cd ${this.path} && flutter clean && cd lib && rm -rf src`;
      await $`cd ${this.path} && flutter_rust_bridge_codegen generate`;
    }
  }

  async test() {
    for (const testbed of ["test", "integration_test"]) {
      const testpath = paths.join(this.path, testbed);
      if (fs.existsSync(testpath)) {
        for (const file of fs.readdirSync(testpath)) {
          if (file.endsWith(".dart")) {
            await $`cd ${this.path} && flutter test ${paths.join(
              testbed,
              file
            )}`;
          }
        }
      }
    }
  }

  async format() {
    await $`cd ${this.path} && dart format lib -o write`;
  }

  async clean() {
    await $`cd ${this.path} && flutter clean`;
  }
}

class JSProject extends Project {
  constructor(path) {
    super(path);
  }

  async lint() {
    await $`cd ${this.path} && bun run lint`;
  }

  async build(release) {
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

const rustPath = [
  "rust/core",
  "js/node_dion_runtime",
  "dart/rdion_runtime/rust",
];
const dartPath = ["dart/rdion_runtime"];
const jsPath = ["js/node_dion_runtime"];

export const projects = [
  ...rustPath.map((path) => new RustProject(path)),
  ...dartPath.map((path) => new FlutterRustProject(path)),
  ...jsPath.map((path) => new JSProject(path)),
];

function exitPrematurely(message) {
  console.error(message);
  if (!values.tryall) {
    process.exit(1);
  }
}

for (const action of positionals.slice(2)) {
  for (const project of projects) {
    if (values.path !== undefined && project.path != values.path) {
      continue;
    }
    console.log("\x1b[32m%s\x1b[0m", `[${action}]: ${project.path}`);
    switch (action) {
      case "build":
        try {
          await project.build(values.release);
        } catch (e) {
          exitPrematurely(`[${action}]: Failed in ${project.path}`);
        }
        break;
      case "test":
        try {
          await project.test();
        } catch (e) {
          exitPrematurely(`[${action}]: Failed in ${project.path}`);
        }
        break;
      case "format":
        try {
          await project.format();
        } catch (e) {
          exitPrematurely(`[${action}]: Failed in ${project.path}`);
        }
        break;
      case "lint":
        try {
          await project.lint();
        } catch (e) {
          exitPrematurely(`[${action}]: Failed in ${project.path}`);
        }
        break;
      case "clean":
        try {
          await project.clean();
        } catch (e) {
          exitPrematurely(`[${action}]: Failed in ${project.path}`);
        }
        break;
      default:
        exitPrematurely(`Unknown action: ${action}`);
    }
  }
}
