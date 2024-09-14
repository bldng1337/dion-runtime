//{"repo":"repo","icon":"https://9animetv.to/images/favicon.png","name":"9Anime","version":"1.0.0","description":"A Anime Streaming Site","author":"","license":"0BSD","keywords":["anime","series"],"nsfw":false,"lang":["en"],"media_type":["video"],"url":"https://9animetv.to"}
import { fetch, getCookies } from "network";
import { registerSetting, getSetting } from "setting";

function test() {
  print("external test");
}

function assert(condition, msg = "Extension error") {
  if (!condition) {
    throw new Error(msg);
  }
}

/*
#[derive(Serialize, Deserialize, Debug)]
pub struct Entry {
    pub id: String,
    pub url: String,
    pub title: String,
    #[serde(alias = "type")]
    pub media_type: MediaType,

    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    pub cover_header: Option<HashMap<String, String>>,

    pub auther: Option<Vec<String>>,
    pub rating: Option<f32>,
    pub views: Option<f32>,
    pub length: Option<i64>,
}
*/
function getEntry() {
  return {
    id: "someid",
    url: "someurl",
    title: "sometext",
    media_type: "video",
    cover: "somecover",
    cover_header: { some: "header" },
    auther: ["someauther"],
    rating: 0.5,
    views: 100,
    length: 1000,
  };
}
/*
#[derive(Serialize, Deserialize, Debug)]
pub struct Episode {
    pub id: String,
    pub name: String,
    pub url: String,
    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    pub cover_header: Option<HashMap<String, String>>,
    pub timestamp: Option<String>,
}
    */
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

/*
#[derive(Serialize, Deserialize, Debug)]
pub struct EpisodeList {
    pub title: String,
    pub episodes: Vec<Episode>,
}
    */
function getEpisodeList() {
  return {
    title: "sometext",
    episodes: [getEpisode()],
  };
}

/*
#[derive(Serialize, Deserialize, Debug)]
pub struct EntryDetailed {
    pub id: String,
    pub url: String,
    pub title: String,
    #[serde(alias = "type")]
    pub media_type: MediaType,
    pub status: ReleaseStatus,

    pub cover: Option<String>,
    #[serde(alias = "coverheader")]
    pub cover_header: Option<HashMap<String, String>>,
    
    pub episodes: Vec<EpisodeList>,
    pub genres: Option<Vec<String>>,
    pub alttitles: Option<Vec<String>>,
    pub auther: Option<Vec<String>>,
    pub rating: Option<f32>,
    pub views: Option<f32>,
    pub length: Option<i64>,
}
    */
function getEntryDetailed() {
  return {
    id: "someid",
    url: "someurl",
    title: "sometext",
    media_type: "video",
    status: "Complete",
    cover: "somecover",
    cover_header: { some: "header" },
    episodes: [getEpisodeList()],
    genres: ["somegenre"],
    alttitles: ["somealttitle"],
    auther: ["someauther"],
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
    print("other");
    print({ some: "test" });
    test();
    const res = await fetch("https://www.example.com");
    assert(res.body.length > 0, "fetch not working");
    await registerSetting("someid", "entry", "somevalue");
    assert((await getSetting("someid")) == "somevalue", "setting not working");
    await fetch("www.google.com");
    const cookies = await getCookies();
    assert(cookies.length > 0, "cookies not working");
  }
  /*
  pub async fn browse(
        &self,
        page: i64,
        sort: Sort,
        token: Option<CancellationToken>
    )-> Result<Vec<Entry>>
        */
  async browse(page, sort) {
    assert(typeof page == "number", "page must be a number");
    assert(typeof sort == "string", "sort must be a string");
    return [getEntry()];
  }
  /*
  pub async fn search(
        &self,
        page: i64,
        filter: &str,
        token: Option<CancellationToken>
    )-> Result<Vec<Entry>>
        */
  async search(page, filter) {
    assert(typeof page == "number", "page must be a number");
    assert(typeof filter == "string", "filter must be a string");
    return [getEntry()];
  }
  /*
  pub async fn detail(
        &self,
        entryid: &str,
        token: Option<CancellationToken>
    )-> Result<EntryDetailed> 
        */
  async detail(entryid) {
    assert(typeof entryid == "string", "entryid must be a string");
    return getEntryDetailed();
  }
  /*
  pub async fn source(&self, epid: &String, token: Option<CancellationToken>)-> Result<Source> 
  */
  async source(epid) {
    assert(typeof epid == "string", "epid must be a string");
    return getSource();
  }
}
