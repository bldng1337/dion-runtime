// This file has been generated. DO NOT EDIT.
// dion extension types
// Version: 0.1.0
import * as v from "valibot";

import { ExtensionType, MediaType } from "../dion_runtime/generated_validators";

export const ExtensionMetadata = v.object({ id: v.string(), name: v.string(), url: v.string(), icon: v.string(), desc: v.optional(v.nullable(v.string())), authors: v.optional(v.array(v.string())), tags: v.optional(v.array(v.string())), lang: v.optional(v.array(v.string())), nsfw: v.boolean(), media_type: v.array(MediaType), extension_type: v.array(ExtensionType), repo: v.optional(v.nullable(v.string())), version: v.string(), license: v.string(), api_version: v.string() });

export const RemoteExtensionMeta = v.object({ path: v.string(), extdata: ExtensionMetadata });

export const DionRepoIndex = v.object({ repo_index_version: v.number(), name: v.string(), url: v.string(), description: v.string(), icon: v.string(), content: v.optional(v.nullable(v.array(RemoteExtensionMeta))) });

