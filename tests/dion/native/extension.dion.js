//{"id":"native","repo":"repo","icon":"asd","compatible":true,"name":"native","version":"1.0.0","desc":"Minimal extension impl","author":[""],"license":"0BSD","nsfw":false,"lang":["en"],"media_type":["Video"],"url":"https://www.example.com","tags":[],"extension_type":[{"type":"EntryProcessor","trigger_map_entry":true,"trigger_on_entry_activity":true},{"type":"SourceProcessor","opentype":["Download","Stream"],"sourcetypes":["Epub","Imagelist","M3u8","Paragraphlist","Pdf"]},{"type":"SourceProvider","id_types":["testext"]},{"type":"EntryProvider","has_search":true},{"type":"EntryDetailedProvider","id_types":["testext"]},{"type":"URLHandler"}]}
// extensionutils.ts
import { fetch } from "network";
import { getSetting } from "setting";

class DefaultExtension {
  async onEvent(data) {
    switch (data.type) {
      case "Action":
        return;
      case "FeedUpdate":
        return {
          type: data.type,
          customui: [],
          hasnext: null,
          length: null
        };
      case "SwapContent":
        return {
          type: data.type,
          customui: {
            type: "Text",
            text: "asd"
          }
        };
    }
  }
  async mapSource(source, epid, settings) {
    return {
      source,
      settings
    };
  }
  async mapEntry(entry, settings) {
    return {
      entry,
      settings
    };
  }
  async onEntryActivity(_activity, _entry, _settings) {}
  async browse(_page) {
    const server = await getServer();
    const data = await fetch(`${server}/getEntries`);
    return {
      content: data.json
    };
  }
  async search(_page, _filter) {
    const server = await getServer();
    const data = await fetch(`${server}/getEntries`);
    return {
      content: data.json
    };
  }
  async handleUrl(_url) {
    return true;
  }
  async detail(_entryid, settings) {
    const server = await getServer();
    const data = await fetch(`${server}/getEntry`);
    return {
      entry: data.json,
      settings
    };
  }
  async source(_epid, settings) {
    const server = await getServer();
    const data = await fetch(`${server}/getSource`);
    return {
      source: data.json,
      settings
    };
  }
}
async function getServer() {
  const res = await getSetting("testdataserver", "Extension");
  const server = res.value.data;
  if (res.value.type !== "String") {
    throw Error("Failed to get Server");
  }
  if (server.endsWith("/")) {
    return server.substring(0, server.length - 1);
  }
  return server;
}

// native/extension.ts
class extension_default extends DefaultExtension {
}
export {
  extension_default as default
};
