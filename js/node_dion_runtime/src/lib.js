const lib = require("./../index.node");

class ExtensionManager {
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
  constructor(ext) {
    this.ext = ext;
  }

  async setEnabled(enabled) {
    await lib._set_enabled(this.ext, enabled);
  }

  async getEnabled() {
    return lib._is_enabled(this.ext);
  }

  async setSetting(id, setting) {
    await lib._set_setting(this.ext, id, setting);
  }

  async getSetting(id) {
    return lib._get_setting(this.ext, id);
  }

  async browse(page, sort) {
    return lib._browse(this.ext, page, sort);
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

module.exports = {
  ExtensionManager,
};
