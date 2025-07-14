"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
const lib = require("./../index.node");
class ExtensionManager {
    constructor(path) {
        this.path = path;
        this.manager = lib._new_extension_manager(path);
    }
    getExtensions() {
        return __awaiter(this, void 0, void 0, function* () {
            const exts = yield lib._get_extensions(this.manager);
            return exts.map((ext) => new Extension(ext));
        });
    }
}
class Extension {
    constructor(ext) {
        this.ext = ext;
    }
    setEnabled(enabled) {
        return __awaiter(this, void 0, void 0, function* () {
            yield lib._set_enabled(this.ext, enabled);
        });
    }
    getEnabled() {
        return __awaiter(this, void 0, void 0, function* () {
            return lib._is_enabled(this.ext);
        });
    }
    setSetting(id, setting) {
        return __awaiter(this, void 0, void 0, function* () {
            yield lib._set_setting(this.ext, id, setting);
        });
    }
    getSetting(id) {
        return __awaiter(this, void 0, void 0, function* () {
            return lib._get_setting(this.ext, id);
        });
    }
    browse(page, sort) {
        return __awaiter(this, void 0, void 0, function* () {
            return lib._browse(this.ext, page, sort);
        });
    }
    search(page, filter) {
        return __awaiter(this, void 0, void 0, function* () {
            return lib._search(this.ext, page, filter);
        });
    }
    detail(entryid_1) {
        return __awaiter(this, arguments, void 0, function* (entryid, settings = {}) {
            return lib._detail(this.ext, entryid, settings);
        });
    }
    source(epid_1) {
        return __awaiter(this, arguments, void 0, function* (epid, settings = {}) {
            return lib._source(this.ext, epid, settings);
        });
    }
}
module.exports = {
    ExtensionManager,
};
