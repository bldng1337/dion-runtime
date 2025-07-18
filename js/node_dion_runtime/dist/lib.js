/// <reference types="dion-runtime-types" />
import { createRequire } from "module";
const require = createRequire(import.meta.url);
const lib = require("./../index.node");
class ExtensionManager {
    path;
    manager;
    constructor(path) {
        this.path = path;
        this.manager = lib._new_extension_manager(path);
    }
    async getExtensions() {
        const exts = await lib._get_extensions(this.manager);
        return exts.map((ext) => new Extension(ext));
    }
}
class Extension {
    ext;
    constructor(ext) {
        this.ext = ext;
    }
    async setEnabled(enabled) {
        await lib._set_enabled(this.ext, enabled);
    }
    async isEnabled() {
        return lib._is_enabled(this.ext);
    }
    async setSetting(id, setting) {
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
            default:
                throw new Error("Invalid setting type");
        }
        await lib._set_setting(this.ext, id, settingvalue);
    }
    async getSetting(id) {
        return lib._get_setting(this.ext, id);
    }
    async browse(page, sort) {
        return lib._browse(this.ext, page, sort);
    }
    async fromUrl(url) {
        return lib._from_url(this.ext, url);
    }
    async search(page, filter) {
        return lib._search(this.ext, page, filter);
    }
    async detail(entryid, settings = {}) {
        return lib._detail(this.ext, entryid, settings);
    }
    async source(epid, settings = {}) {
        return lib._source(this.ext, epid, settings);
    }
}
export { ExtensionManager, Extension };
