// This file has been generated. DO NOT EDIT.
// dion extension types
// Version: 0.1.0

import { ExtensionType, MediaType } from "../dion_runtime/generated_types";

export type ExtensionMetadata = { id: string; name: string; url: string; icon: string; desc?: string | null; authors?: string[]; tags?: string[]; lang?: string[]; nsfw: boolean; media_type: MediaType[]; extension_type: ExtensionType[]; repo?: string | null; version: string; license: string; api_version: string };

export type RemoteExtensionMeta = { path: string; extdata: ExtensionMetadata };

export type DionRepoIndex = { repo_index_version: number; name: string; url: string; description: string; icon: string; content?: RemoteExtensionMeta[] | null };

