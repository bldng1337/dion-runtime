type DataSource = import("./generated/RuntimeTypes").DataSource;
type Permission = import("./generated/RuntimeTypes").Permission;
type SettingUI = import("./generated/RuntimeTypes").SettingUI;
type Settingtype = import("./generated/RuntimeTypes").Settingtype;
type Settingvalue = import("./generated/RuntimeTypes").Settingvalue;
type Source = import("./generated/RuntimeTypes").Source;
type Subtitles = import("./generated/RuntimeTypes").Subtitles;
type Setting = import("./generated/RuntimeTypes").Setting;
type ExtensionSetting = import("./generated/RuntimeTypes").ExtensionSetting;

type Entry = import("./generated/RuntimeTypes").Entry;
type EntryDetailed = import("./generated/RuntimeTypes").EntryDetailed;
type Episode = import("./generated/RuntimeTypes").Episode;
type ExtensionData = import("./generated/RuntimeTypes").ExtensionData;
type ImageListAudio = import("./generated/RuntimeTypes").ImageListAudio;
type LinkSource = import("./generated/RuntimeTypes").LinkSource;
type MediaType = import("./generated/RuntimeTypes").MediaType;
type ReleaseStatus = import("./generated/RuntimeTypes").ReleaseStatus;
type Sort = import("./generated/RuntimeTypes").Sort;

interface Cookie {
  name: string;
  value: string;
}

interface Requestoptions {
  method?: string;
  headers?: { [key: string]: string };
  body?: string;
}

interface DionResponse {
  status: number;
  // headers: { [key: string]: string };
  body: string;
  json: any;
  ok: boolean;
}

type Settingvalues = string | number | boolean;

declare var console: Console

declare module "network" {
  function fetch(url: string, option?: Requestoptions): Promise<DionResponse>;
  function getCookies(): Cookie[];
}

declare module "permission" {
  function requestPermission(permission: Permission): Promise<boolean>;
  function hasPermission(permission: Permission): Promise<boolean>;
}

declare module "setting" {
  function getSetting(settingid: string): Promise<ExtensionSetting>;
  function registerSetting(
    settingid: string,
    setting: ExtensionSetting
  ): Promise<void>;
}

declare module "convert" {
  function decode_base64(input: string): string;
  function encode_base64(input: string): string;
}

declare module "parse" {
  function parse_html(input: string): Element;
  function parse_html_fragment(input: string): Element;
}

interface Element {
  attr(name: string): string;
  select(selector: CSSSelector): ElementArray;
  parent: Element | undefined;
  children: ElementArray;
  text: string;
  paragraphs: string[];
  name: string;
}

interface ElementArray {
  select(selector: CSSSelector): ElementArray;
  attr(name: string): string[];
  get(index: number): Element | undefined;
  map<T>(callback: (element: Element) => T): T[];
  filter(callback: (element: Element) => boolean): ElementArray;
  first: Element | undefined;
  length: number;
  text: string;
  paragraphs: string[];
}

declare class CSSSelector {
  constructor(name: string);
}

declare var appdata: {
  app: string;
  version: string;
  platform: string;
};
