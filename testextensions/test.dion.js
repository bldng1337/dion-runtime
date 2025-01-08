//{"id":"123","repo":"repo","icon":"https://9animetv.to/images/favicon.png","name":"9Anime","version":"1.0.0","description":"A Anime Streaming Site","author":"","license":"0BSD","keywords":["anime","series"],"nsfw":false,"lang":["en"],"media_type":["video"],"url":"https://9animetv.to"}
import { fetch, getCookies } from "network";
import { registerSetting, getSetting } from "setting";
import { requestPermission } from "permission";
import { decode_base64,encode_base64 } from "convert";

function test() {
  print("external test");
  return true;
}

function assert(condition, msg = "Extension error") {
  if (!condition) {
    throw new Error(msg);
  }
}

function getEntry() {
  return {
    id: "someid",
    url: "someurl",
    title: "sometext",
    media_type: "video",
    cover: "somecover",
    cover_header: { some: "header" },
    author: ["someauther"],
    rating: 0.5,
    views: 100,
    length: 1000,
  };
}
function getEpisode() {
  return {
    id: "someid",
    name: "sometext",
    url: "someurl",
    cover: "somecover",
    cover_header: { some: "header" },
    timestamp: "somedate",
  };
}

function getEpisodeList() {
  return {
    title: "sometext",
    episodes: [getEpisode()],
  };
}

function getEntryDetailed() {
  return {
    id: "someid",
    url: "someurl",
    title: "sometext",
    media_type: "video",
    status: "Complete",
    language: "somelanguage",
    description: "somedescription",
    cover: "somecover",
    cover_header: { some: "header" },
    episodes: [getEpisodeList()],
    genres: ["somegenre"],
    alttitles: ["somealttitle"],
    author: ["someauther"],
    rating: 0.5,
    views: 100,
    length: 1000,
  };
}

function getSource() {
  return {
    sourcetype: "directlink",
    sourcedata: {
      type: "epub",
      link: "epid",
    },
  };
}

export default class {
  constructor() {
    this.test = "some test";
  }
  async load() {
    const permission = await requestPermission({id:"storage",path:"some"},"some permission");
    assert(permission==true,"permission not working");
    print("other");
    assert(decode_base64("YXNk")=="asd","decode_base64 not working");
    assert(encode_base64("asd")=="YXNk","encode_base64 not working");
    assert(decode_base64(encode_base64("test"))=="test","decode_base64 or encode_base64 not working");
    print({ some: "test" });
    assert(test()==true,"external function not working");
    const res = await fetch("https://www.example.com");
    assert(res.body.length > 0, "fetch not working");
    await registerSetting("someid", "entry", "somevalue");
    assert((await getSetting("someid"))=="somevalue","setting not working");
    await fetch("www.google.com");
    const cookies = await getCookies();
    assert(cookies.length > 0, "cookies not working");
  }
  async browse(page, sort) {
    assert((await getSetting("someid")) == "othervalue", "setting not working");
    assert(typeof page == "number", "page must be a number");
    assert(typeof sort == "string", "sort must be a string");
    return [getEntry()];
  }
  async search(page, filter) {
    assert(typeof page == "number", "page must be a number");
    assert(typeof filter == "string", "filter must be a string");
    return [getEntry()];
  }
  async detail(entryid) {
    assert(entryid=="someid","entryid is wrong");
    assert(typeof entryid == "string", "entryid must be a string");
    return getEntryDetailed();
  }
  async source(epid) {
    assert(typeof epid == "string", "epid must be a string");
    return getSource();
  }
}
