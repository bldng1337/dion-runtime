/// <reference path="../../js/dion_runtime_types/index.d.ts" />
import { readdir, stat } from "node:fs/promises";
import * as utils from "./utils";

for (const path of await readdir(".")) {
  if (!(await stat(path)).isDirectory()) continue;
  if (!(await Bun.file(`${path}/extension.ts`).exists())) continue;
  const meta = Bun.file(`${path}/meta.json`);
  if (await meta.exists()) {
    const metajson = await meta.json();
    console.log(`Building ${path} with meta ${metajson}`);
    utils.buildTestExtension(`${path}/extension`, metajson);
    continue;
  }
  console.log(`Building ${path}`);
  utils.buildTestExtension(`${path}/extension`);
}
