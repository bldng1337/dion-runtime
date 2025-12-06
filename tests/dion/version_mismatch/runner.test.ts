import { expect, test } from "bun:test";
import { Adapter } from "../../../js/dion_runtime";
import * as utils from "../utils";

test("Test Extension", async () => {
  const mockmanager = new utils.MockManagerClient("./version_mismatch");
  const manager = await Adapter.init(mockmanager.client);
  const ext = (await manager.getExtension())[0];
  expect(ext).toBeDefined();
  const extdata = await ext.getData();
  expect(extdata.compatible).toBe(false);
});
