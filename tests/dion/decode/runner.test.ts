/// <reference path="../../../js/dion_runtime_types/index.d.ts" />

import { expect, test } from "bun:test";
import { Adapter } from "../../../js/dion_runtime";
import * as utils from "../utils";

test("test decode", async () => {
  const mockmanager = new utils.MockManagerClient("./decode");
  const manager = await Adapter.init(mockmanager.client);
  const ext = (await manager.getExtension())[0];
  expect(ext).toBeDefined();
  // We only enable here because we only use the load function so we dont need a server supplying demo data
  await ext.setEnabled(true);
});
