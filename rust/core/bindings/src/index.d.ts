type DataSource = import("./generated/RuntimeTypes").DataSource;
type Permission = import("./generated/RuntimeTypes").Permission;
type SettingUI = import("./generated/RuntimeTypes").SettingUI;
type Settingtype = import("./generated/RuntimeTypes").Settingtype;
type Settingvalue = import("./generated/RuntimeTypes").Settingvalue;
type Source = import("./generated/RuntimeTypes").Source;
type Subtitles = import("./generated/RuntimeTypes").Subtitles;

type Entry = import("./generated/RuntimeTypes").Entry;
type EntryDetailed = import("./generated/RuntimeTypes").EntryDetailed;
type Episode = import("./generated/RuntimeTypes").Episode;
type EpisodeList = import("./generated/RuntimeTypes").EpisodeList;
type ExtensionData = import("./generated/RuntimeTypes").ExtensionData;
type ImageListAudio = import("./generated/RuntimeTypes").ImageListAudio;
type LinkSource = import("./generated/RuntimeTypes").LinkSource;
type MediaType = import("./generated/RuntimeTypes").MediaType;
type ReleaseStatus = import("./generated/RuntimeTypes").ReleaseStatus;
type Sort = import("./generated/RuntimeTypes").Sort;

interface Cookie {
  name: string;
  value: string;
  // domain: string;
  // path: string;
  // expires: number;
  // httpOnly: boolean;
  // secure: boolean;
  // sameSite: string;
}
interface Requestoptions {
  method?: string;
  headers?: { [key: string]: string };
  body?: string;
}
interface DionResponse {
  status: number;
  headers: { [key: string]: string };
  body: string;
  json: any;
  ok: boolean;
}

type Settingvalues= string | number | boolean;

declare function print(a: any): void;
declare module "network" {
  function fetch(url: string, option?: Requestoptions): Promise<DionResponse>;
  function getCookies(): Cookie[];
}
declare module "permission" {
  function requestPermission(permission: Permission): Promise<boolean>;
  function hasPermission(permission: Permission): Promise<boolean>;
}
declare module "setting" {
  function getSetting<T extends Settingvalues>(settingid: string): Promise<T>;
  function setUI(settingid: string, definition: SettingUI): Promise<void>;
  function registerSetting<T extends Settingvalues>(
    settingid: string,
    settingtype: Settingtype,
    defaultvalue: T
  ): Promise<void>;
}

declare module "convert" {
  function decode_base64(input: string): string;
  function encode_base64(input: string): string;
}

declare var appdata: {
  app: string;
  version: string;
  platform: string;
};
