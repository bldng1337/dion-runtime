/// <reference types="dion-runtime-types" />
import { createRequire } from "module";
const require = createRequire(import.meta.url);
const lib = require("./../index.node");

class ExtensionManager {
  path: string;
  manager: any;

  constructor(path: string) {
    this.path = path;
    this.manager = lib._new_extension_manager(path);
  }

  async getExtensions(): Promise<Extension[]> {
    const exts = await lib._get_extensions(this.manager);
    return exts.map((ext: any) => new Extension(ext));
  }
}

class Extension {
  ext: any;

  constructor(ext: any) {
    this.ext = ext;
  }

  async setEnabled(enabled: boolean): Promise<void> {
    await lib._set_enabled(this.ext, enabled);
  }

  async getEnabled(): Promise<boolean> {
    return lib._is_enabled(this.ext);
  }

  async setSetting(id: string, setting: Settingvalues): Promise<void> {
    let settingvalue;
    switch (typeof setting) {
      case "string":
        settingvalue = {
          type: "String",
          val: setting,
          default_val: "",
        };
        break;
      case "number":
        settingvalue = {
          type: "Number",
          val: setting,
          default_val: 0,
        };
        break;
      case "boolean":
        settingvalue = {
          type: "Boolean",
          val: setting,
          default_val: false,
        };
        break;
    }
    await lib._set_setting(this.ext, id, settingvalue);
  }

  async getSetting(id: string): Promise<any> {
    return lib._get_setting(this.ext, id);
  }

  async browse(page: number, sort: any): Promise<any> {
    return lib._browse(this.ext, page, sort);
  }

  async search(page: number, filter: any): Promise<any> {
    return lib._search(this.ext, page, filter);
  }

  async detail(entryid: string, settings: any = {}): Promise<any> {
    return lib._detail(this.ext, entryid, settings);
  }

  async source(epid: string, settings: any = {}): Promise<any> {
    return lib._source(this.ext, epid, settings);
  }
}

export {
  ExtensionManager,
};
