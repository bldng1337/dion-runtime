/// <reference types="dion-runtime-types" />

interface Cookie {
  name: string;
  value: string;
}

interface Requestoptions {
  method?: "GET"|"HEAD"|"POST"|"PUT"|"DELETE"|"CONNECT"|"TRACE"|"PATCH";
  headers?: { [key: string]: string };
  body?: string;
}

interface DionResponse {
  status: number;
  headers: Map<String,String>;
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
  function requestPermission(permission: Permission,msg?:string): Promise<boolean>;
  function hasPermission(permission: Permission): Promise<boolean>;
}

declare module "setting" {
  function getSetting(
    settingid: string,
    settingkind: SettingKind
  ): Promise<Setting>;
  function registerSetting(
    settingid: string,
    setting:Setting,
    settingkind: SettingKind
  ): Promise<void>;
}

declare module "convert" {
  function decode_base64(input: string): string;
  function encode_base64(input: string): string;
}

declare module "parse" {
  function parse_html(input: string): DionElement;
  function parse_html_fragment(input: string): DionElement;
}

interface DionElement {
  attr(name: string): string;
  select(selector: CSSSelector): DionElementArray;
  parent: DionElement | undefined;
  children: DionElementArray;
  text: string;
  paragraphs: Paragraph[];
  name: string;
}

interface DionElementArray {
  select(selector: CSSSelector): DionElementArray;
  attr(name: string): string[];
  get(index: number): DionElement | undefined;
  map<T>(callback: (DionElement: DionElement) => T): T[];
  filter(callback: (DionElement: DionElement) => boolean): DionElementArray;
  first: DionElement | undefined;
  length: number;
  text: string;
  paragraphs: Paragraph[];
}

declare class CSSSelector {
  constructor(name: string);
}

declare var appdata: {
  app: string;
  version: string;
  platform: string;
};

interface SourceProvider {
  browse(page: number): Promise<EntryList>;
  search(page: number, filter: string): Promise<EntryList>;
  fromUrl(url: string): Promise<boolean>;
  detail(entryid: string, settings: Record<string, Setting>): Promise<EntryDetailedResult>;
  source(epid: string, settings: Record<string, Setting>): Promise<SourceResult>;
}

interface EntryExtension {
  mapEntry(entry: EntryDetailed, settings: Record<string, Setting>): Promise<EntryDetailedResult>;
  onEntryActivity(activity: EntryActivity, entry: EntryDetailed, settings: Record<string, Setting>): Promise<void>;
}

interface SourceProcessorExtension {
  mapSource(source: Source, settings: Record<string, Setting>): Promise<SourceResult>;
}
