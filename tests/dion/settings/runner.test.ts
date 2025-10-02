/// <reference path="../../../js/dion_runtime_types/index.d.ts" />

import { expect, test } from "bun:test";
import type { Server } from "bun";
import { Adapter } from "../../../js/dion_runtime";
import * as utils from "../utils";

test("test settings", async () => {
  const server: Server = Bun.serve({
    port: 3003,
    routes: {
      ...utils.getDefaultRoutes(),
    },
  });

  const mockmanager = new utils.MockManagerClient("./settings");
  const manager = await Adapter.init(mockmanager.client);
  const ext = (await manager.getExtension())[0];
  expect(ext).toBeDefined();

  await utils.injectServer(server, ext);
  await ext.setEnabled(true); // This will run the `load()` method.

  // Check if the setting was registered correctly in `load()`
  const setting = await ext.getSetting("someid", "Extension");
  expect(setting).toBeDefined();
  expect(setting.value.type).toBe("String");
  expect(setting.value.data).toBe("somevalue");

  // Simulate native side changing the setting
  await ext.setSetting("someid", "Extension", {
    type: "String",
    data: "othervalue",
  });

  // This should now succeed
  await ext.browse(0);

  // check if it was actually changed
  const newsetting = await ext.getSetting("someid", "Extension");
  expect(newsetting).toBeDefined();
  expect(newsetting.value.type).toBe("String");
  expect(newsetting.value.data).toBe("othervalue");

  server.stop();
});
