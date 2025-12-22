export * from "./generated_types.js";
export * as valibot from "./generated_validators.js";
import type {
  EventData,
  EventResult,
  EntryList,
  EntryId,
  EntryDetailedResult,
  EpisodeId,
  SourceResult,
  Setting,
  EntryDetailed,
  EntryActivity,
  Source,
} from "../dion_runtime";

export interface Extension {
  onEvent(data: EventData): Promise<EventResult | undefined>;
  handleProxy?(request: ProxyRequest): Promise<ProxyResponse>;
}

export interface SourceProvider {
  browse(page: number): Promise<EntryList>;
  search(page: number, filter: string): Promise<EntryList>;
  detail(
    entryid: EntryId,
    settings: Record<string, Setting>,
  ): Promise<EntryDetailedResult>;
  source(
    epid: EpisodeId,
    settings: Record<string, Setting>,
  ): Promise<SourceResult>;
  handleUrl?(url: string): Promise<boolean>;
}

export interface EntryExtension {
  mapEntry?(
    entry: EntryDetailed,
    settings: Record<string, Setting>,
  ): Promise<EntryDetailedResult>;
  onEntryActivity?(
    activity: EntryActivity,
    entry: EntryDetailed,
    settings: Record<string, Setting>,
  ): Promise<void>;
}

export interface SourceProcessorExtension {
  mapSource(
    source: Source,
    epid: EpisodeId,
    settings: Record<string, Setting>,
  ): Promise<SourceResult>;
}

export interface ProxyRequest {
  method:
  | "GET"
  | "HEAD"
  | "POST"
  | "PUT"
  | "DELETE"
  | "CONNECT"
  | "TRACE"
  | "PATCH";
  uri: string;
  version: 10 | 11 | 2 | 3;
  headers: { [key: string]: string[] };
  body?: string;
}

export type ProxyResponse =
  | {
    type: "redirect";
    request: ProxyRequest;
  }
  | {
    type: "response";
    status: number;
    headers: { [key: string]: string[] };
    body?: string;
  };
