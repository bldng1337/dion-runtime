/// <reference path="../../../js/dion_runtime_types/index.d.ts" />

import { expect, test } from "bun:test";
import type { Server } from "bun";
import { Adapter } from "../../../js/dion_runtime";
import * as utils from "../utils.js";

test("test arguments", async () => {
  const server: Server = Bun.serve({
    routes: {
      ...utils.getDefaultRoutes(),
    },
  });

  const mockmanager = new utils.MockManagerClient("./arguments");
  const manager = await Adapter.init(mockmanager.client);
  const ext = (await manager.getExtension())[0];
  expect(ext).toBeDefined();

  await utils.injectServer(server, ext);
  await ext.setEnabled(true);

  await ext.browse(0);
  await ext.search(0, "");
  const entry = await ext.detail(
    {
      uid: "epid",
    },
    {},
  );
  await ext.fromurl("");
  await ext.mapEntry(entry.entry, {});
  await ext.onEntryActivity(
    {
      type: "EpisodeActivity",
      progress: 23,
    },
    entry.entry,
    {},
  );
  const source = await ext.source(
    {
      uid: "epid",
    },
    {},
  );
  await ext.mapSource(
    source.source,
    {
      uid: "epid",
    },
    {},
  );
});
