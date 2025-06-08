//{"id":"123","repo":"repo","icon":"https://9animetv.to/images/favicon.png","name":"9Anime","version":"1.0.0","description":"A Anime Streaming Site","author":"","license":"0BSD","keywords":["anime","series"],"nsfw":false,"lang":["en"],"media_type":["video"],"url":"https://9animetv.to"}
import { fetch, getCookies } from "network";
import { registerSetting, getSetting } from "setting";
import { requestPermission } from "permission";
import { decode_base64, encode_base64 } from "convert";
import { parse_html_fragment, parse_html } from "parse";
function test() {
  console.log("external test");
  return true;
}

function assert(condition, msg = "Extension error") {
  if (!condition) {
    throw new Error(`Assert failed: ${msg}`);
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
    episodes: [getEpisode()],
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
    // TODO: Finish Implementing permissions
    // {
    //   const permission = await requestPermission(
    //     { id: "storage", path: "some" },
    //     "some permission"
    //   );
    //   assert(permission == true, "permission not working");
    // }
    // {
    //   const permission = await requestPermission(
    //     { id: "storage", path: "other" },
    //     "other"
    //   );
    //   assert(permission == false, "permission not working");
    // }

    console.log("other");
    assert(decode_base64("YXNk") == "asd", "decode_base64 not working");
    assert(encode_base64("asd") == "YXNk", "encode_base64 not working");
    assert(
      decode_base64(encode_base64("test")) == "test",
      "decode_base64 or encode_base64 not working"
    );
    console.log({ some: "test" });
    assert(test() == true, "external function not working");
    const res = await fetch("https://www.example.com");
    assert(res.body.length > 0, "fetch not working");

    let setting = {
      settingtype: "Extension",
      setting: {
        val: {
          type: "String",
          val: "somevalue",
          default_val: "somedefault",
        },
        ui: {
          type: "Textbox",
          label: "somelabel",
        },
      },
    };
    await registerSetting("someid", setting);
    console.log(JSON.stringify(await getSetting("someid")));
    assert(
      (await getSetting("someid")).setting.val.val == "somevalue",
      "setting not working"
    );
    // await fetch("https://www.google.com");
    // const cookies = await getCookies();
    // assert(cookies.length > 0, "cookies not working");
    // parse_html(res.body);
    let html = `<html><body><div attr="value">some text</div><div>some other text</div></body></html>`;
    let parsed = parse_html(html);
    let sel = new CSSSelector("div");
    let elarr = parsed.select(sel);
    let el = elarr.first;
    console.log(el.text);
    assert(el.text == "some text", "parse_html not working");
    assert(el.parent.name == "body", "parse_html not working");
    assert(el.name == "div", "parse_html not working");
    assert(el.attr("attr") == "value", "parse_html not working");
    assert(elarr.length == 2, "parse_html not working");
    assert(
      elarr.map((el) => el.text).join("\n") == "some text\nsome other text",
      "parse_html not working"
    );
    console.log("paragraphs");
    console.log(elarr.paragraphs.join("\n"));
    assert(elarr.paragraphs.join("\n") == "some text\nsome other text", "parse_html not working");
  }

  async browse(page, sort) {
    assert(
      (await getSetting("someid")).setting.val.val == "othervalue",
      "setting not working"
    );
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
    assert(entryid == "someid", "entryid is wrong");
    assert(typeof entryid == "string", "entryid must be a string");
    return getEntryDetailed();
  }
  async source(epid) {
    assert(typeof epid == "string", "epid must be a string");
    return getSource();
  }
}
