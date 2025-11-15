/// <reference path="../../js/dion_runtime_types/index.d.ts" />

import { type Mock, mock } from "bun:test";
import type { Server } from "bun";
import {
  type Extension,
  ExtensionClient,
  ManagerClient,
} from "../../js/dion_runtime";

export class MockExtensionClient {
  name: string;
  client: ExtensionClient;
  loadData: Mock<(err: Error | null, key: string) => string>;
  storeData: Mock<(err: Error | null, key: string, value: string) => void>;
  doAction: Mock<(err: Error | null, action: Action) => void>;
  requestPermission: Mock<
    (
      err: Error | null,
      permission: Permission,
      msg?: string | undefined | null,
    ) => boolean
  >;
  getPath: Mock<(err: Error | null) => string>;
  constructor(extdata: ExtensionData, basepath: string) {
    this.name = extdata.name;
    this.loadData = mock((_err, _arg) => "");
    this.storeData = mock((_err, _key, _arg) => {});
    this.doAction = mock((_err, _action) => {});
    this.requestPermission = mock((_err, _asd) => {
      return false;
    });
    this.getPath = mock(() => {
      return `${basepath}/${extdata.name}`;
    });
    this.client = new ExtensionClient(
      this.loadData,
      this.storeData,
      this.doAction,
      this.requestPermission,
      this.getPath,
    );
  }
}

export class MockManagerClient {
  client: ManagerClient;
  extensions: MockExtensionClient[];
  managerpath: string;
  getClient: Mock<(err: Error | null, arg: ExtensionData) => ExtensionClient>;
  getPath: Mock<(err: Error | null) => string>;

  constructor(managerpath: string = ".") {
    this.managerpath = managerpath;
    this.extensions = [];
    this.getClient = mock((_err, extdata) => {
      const ext = new MockExtensionClient(extdata, managerpath);
      this.extensions.push(ext);
      return ext.client;
    });
    this.getPath = mock((_err) => {
      return managerpath;
    });
    this.client = new ManagerClient(this.getClient, this.getPath);
  }
}

export async function injectServer(server: Server, ext: Extension) {
  await ext.mergeSettingDefinition("testdataserver", "Extension", {
    visible: true,
    label: "Server",
    default: {
      type: "String",
      data: server.url.toString(),
    },
    value: {
      type: "String",
      data: server.url.toString(),
    },
  });
}

export function getDefaultRoutes() {
  return {
    "/getEntry": () => {
      const entry: EntryDetailed = {
        id: {
          uid: "",
        },
        url: "",
        titles: [],
        author: null,
        ui: null,
        meta: null,
        media_type: "Video",
        status: "Unknown",
        description: "",
        language: "",
        cover: null,
        episodes: [],
        genres: null,
        rating: null,
        views: null,
        length: null,
      };
      return new Response(JSON.stringify(entry));
    },
    "/getEntries": () => {
      const entries: Entry[] = [
        {
          id: {
            uid: "",
          },
          url: "",
          title: "",
          media_type: "Video",
          cover: null,
          author: null,
          rating: null,
          views: null,
          length: null,
        },
      ];
      return new Response(JSON.stringify(entries));
    },
    "/getSource": () => {
      const source: Source = {
        type: "Epub",
        link: {
          header: null,
          url: "",
        },
      };
      return new Response(JSON.stringify(source));
    },
  };
}

export async function buildTestExtension({
  exttype,
  extpath,
}: {
  exttype?: ExtensionType[];
  extpath?: string;
} = {}) {
  console.log(`Building ${extpath ?? "extension"}.ts`);
  const res = await Bun.build({
    entrypoints: [`${extpath ?? "extension"}.ts`],
    target: "browser",
    // tsconfig: "./tsconfig.json",
    external: ["network", "permission", "setting", "parse", "convert"],
    format: "esm",
  });
  if (!res.success) throw new AggregateError(res.logs);
  if (res.outputs.length === 0) {
    throw new Error("No outputs found");
  }
  const code = await res.outputs[0]?.text();
  if (code === undefined) {
    throw new Error("No output found");
  }
  const extdata: ExtensionData = {
    id: "123",
    compatible: true,
    repo: "repo",
    icon: "asd",
    name: "Minimal",
    version: "1.0.0",
    desc: "Minimal extension impl",
    author: [""],
    license: "0BSD",
    nsfw: false,
    lang: ["en"],
    media_type: ["Video"],
    url: "https://www.example.com",
    tags: [],
    extension_type: exttype ?? [
      {
        type: "EntryProcessor",
        trigger_map_entry: true,
        trigger_on_entry_activity: true,
      },
      {
        type: "SourceProcessor",
        opentype: ["Download", "Stream"],
        sourcetypes: ["Epub", "Imagelist", "M3u8", "Paragraphlist", "Pdf"],
      },
      {
        type: "SourceProvider",
        id_types: ["testext"],
      },
      {
        type: "EntryProvider",
        has_search: true,
      },
      {
        type: "EntryDetailedProvider",
        id_types: ["testext"],
      },
      {
        type: "URLHandler",
        url_patterns: ["*"],
      },
    ],
  };
  Bun.file(`${extpath ?? "extension"}.dion.js`).write(
    `//${JSON.stringify(extdata)}\n${code}`,
  );
}
