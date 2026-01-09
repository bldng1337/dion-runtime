#!/usr/bin/env bun
// @bun
import P from"fs/promises";import J from"path";var{argv:K}=globalThis.Bun;import S from"handlebars";function b(j,x){return new Promise((C)=>{process.stdout.write(`${j}${x?` (${x})`:""}: `);let G=[];process.stdin.resume(),process.stdin.once("data",(L)=>{G.push(L),process.stdin.pause();let z=Buffer.concat(G).toString().trim();C(z.length?z:x??"")})})}function q(j){return j.toLowerCase().replace(/[^a-z0-9-_]+/g,"-").replace(/^-+|-+$/g,"").slice(0,64)||"extension"}function y(j){return j.split(",").map((x)=>x.trim()).filter(Boolean)}function I(){return crypto.randomUUID()}async function R(j){await P.mkdir(j,{recursive:!0})}async function N(j,x){await R(J.dirname(j)),await P.writeFile(j,x)}async function F(j,x){return S.compile(j,{noEscape:!0})(x)}function T(j){let x={yes:!1},C=j[Symbol.iterator](),G=[],L=C.next();while(!L.done){let z=L.value;if(z==="-y"||z==="--yes")x.yes=!0;else if(z==="--description"){let B=C.next();if(!B.done)x.description=B.value}else if(z.startsWith("--description="))x.description=z.split("=",2)[1]??"";else if(z==="--url"){let B=C.next();if(!B.done)x.url=B.value}else if(z.startsWith("--url="))x.url=z.split("=",2)[1]??"";else if(z==="--author"){let B=C.next();if(!B.done)x.author=B.value}else if(z.startsWith("--author="))x.author=z.split("=",2)[1]??"";else if(z==="--icon"){let B=C.next();if(!B.done)x.icon=B.value}else if(z.startsWith("--icon="))x.icon=z.split("=",2)[1]??"";else if(z==="--keywords"){let B=C.next();if(!B.done)x.keywords=B.value}else if(z.startsWith("--keywords="))x.keywords=z.split("=",2)[1]??"";else if(z==="--media"){let B=C.next();if(!B.done)x.media=B.value}else if(z.startsWith("--media="))x.media=z.split("=",2)[1]??"";else if(z==="--name"||z==="-n"){let B=C.next();if(!B.done)x.name=B.value}else if(z.startsWith("--name="))x.name=z.split("=",2)[1]??"";else if(!z.startsWith("-"))G.push(z);L=C.next()}if(G.length>0)x.path=G[0];if(G.length>1)x.name=G[1];return x}async function M(j,x,C,G){if(j!==void 0)return j;if(G)return C;return await b(x,C)}async function U(){let j=T(K.slice(2)),x=await M(j.name,"Extension name","my-extension",j.yes),C=q(x),G=x,L=await M(j.description,"Description","A Dion extension",j.yes),z=await M(j.url,"Website URL","https://example.com/",j.yes),B=await M(j.author,"Author","Author",j.yes),V=await M(j.icon,"Icon URL","https://placehold.co/256x256/EEE/31343C.png?text=Icon",j.yes),W=y(await M(j.keywords,"Keywords (comma separated)","example, dion",j.yes)),X=(await M(j.media,"Media types (comma sep: Video,Comic,Audio,Book,Unknown)","Book",j.yes)).split(",").map((Q)=>Q.trim()).filter(Boolean),E;if(!j.path)E=J.resolve(".",C);else if(j.path.includes("/")||j.path.includes("\\"))E=J.resolve(j.path);else E=J.resolve(j.path,C);if(await P.exists(E))console.error(`Directory already exists: ${E}`),process.exit(1);let Y=await`{\r
    "name": "{{name}}",\r
    "version": "1.0.0",\r
    "description": "{{description}}",\r
    "icon": "{{icon}}",\r
    "keywords": {{keywords}},\r
    "api_version": "*",\r
    "lang": [],\r
    "nsfw": false,\r
    "url": "{{url}}",\r
    "extension_type": [],\r
    "media_type": {{media_type}},\r
    "authors": ["{{author}}"],\r
    "license": "ISC",\r
    "id": "{{id}}",\r
    "private": true,\r
    "type": "module",\r
    "scripts": {\r
       	"test": "bun test",\r
       	"lint": "bunx biome check",\r
       	"format": "bunx biome format --write",\r
       	"build": "bunx dion-bundle",\r
       	"check-types": "bunx tsc --noEmit"\r
    },\r
    "dependencies": {\r
       	"@dion-js/runtime-lib": "catalog:",\r
       	"valibot": "catalog:",\r
       	"@dion-js/unit-test-utils": "catalog:"\r
    },\r
    "devDependencies": {\r
       	"@types/bun": "catalog:",\r
       	"@biomejs/biome": "catalog:",\r
       	"@dion-js/runtime": "catalog:",\r
       	"@dion-js/runtime-types": "catalog:",\r
       	"@dion-js/extension-types": "catalog:",\r
       	"@dion-js/config": "catalog:",\r
       	"dion-bundle-extension": "catalog:",\r
       	"dion-push-extension": "catalog:",\r
       	"dion-test-asserts": "catalog:",\r
       	"typescript": "catalog:"\r
    }\r
}\r
`,Z=await`{\r
	"extends": "@dion-js/config/typescript.json",\r
	"$schema": "https://json.schemastore.org/tsconfig",\r
	"include": ["src/**/*"]\r
}\r
`,_=await`{\r
  "$schema": "https://biomejs.dev/schemas/2.1.1/schema.json",\r
  "extends": ["@dion-js/config/biome.json"]\r
}\r
`,$=await`import { DionExtension } from "@dion-js/runtime-lib";\r
import { SourceProvider } from "@dion-js/runtime-types/extension";\r
import type {\r
	EntryDetailedResult,\r
	EntryId,\r
	EntryList,\r
	EpisodeId,\r
	EventData,\r
	EventResult,\r
	Setting,\r
	SourceResult,\r
} from "@dion-js/runtime-types/runtime";\r
\r
export default class extends DionExtension implements SourceProvider {\r
	settings = {};\r
	async onEvent(_data: EventData): Promise<EventResult | undefined> {\r
		return undefined;\r
	}\r
	async browse(page: number): Promise<EntryList> {\r
		return {\r
			content: [\r
				{\r
					id: { uid: "test-entry" },\r
					title: "Test Entry",\r
					url: "https://example.com",\r
					media_type: "Video",\r
				},\r
			],\r
			hasnext: false,\r
			length: 0,\r
		};\r
	}\r
	async search(page: number, filter: string): Promise<EntryList> {\r
		return {\r
			content: [\r
				{\r
					id: { uid: "test-entry" },\r
					title: "Test Entry",\r
					url: "https://example.com",\r
					media_type: "Video",\r
				},\r
			],\r
			hasnext: false,\r
			length: 0,\r
		};\r
	}\r
	async detail(\r
		entryid: EntryId,\r
		settings: Record<string, Setting>,\r
	): Promise<EntryDetailedResult> {\r
		return {\r
			entry: {\r
				id: {\r
					uid: "ads",\r
				},\r
				url: "https://example.com",\r
				titles: [],\r
				media_type: "Video",\r
				status: "Unknown",\r
				description: "",\r
				language: "",\r
				episodes: [\r
					{\r
						id: {\r
							uid: "episode-1",\r
						},\r
						name: "Episode 1",\r
						url: "https://example.com",\r
					},\r
				],\r
			},\r
			settings: settings,\r
		};\r
	}\r
	async source(\r
		epid: EpisodeId,\r
		settings: Record<string, Setting>,\r
	): Promise<SourceResult> {\r
		return {\r
			settings: settings,\r
			source: {\r
				type: "Paragraphlist",\r
				paragraphs: [\r
					{\r
						type: "Text",\r
						content: "Some Content.",\r
					},\r
				],\r
			},\r
		};\r
	}\r
	async handleUrl?(url: string): Promise<boolean> {\r
		return false;\r
	}\r
}\r
`,A=await`/** biome-ignore-all lint/style/noNonNullAssertion: These are tests so if they fail it is fine */\r
/** biome-ignore-all lint/suspicious/noEmptyBlockStatements: These are tests */\r
/// <reference types="@types/bun" />\r
import { beforeAll, describe, expect, it } from "bun:test";\r
import {\r
	assertValidEntries,\r
	assertValidEntry,\r
	assertValidSource,\r
	getTestExtension,\r
	MockManagerClient,\r
} from "@dion-js/extension-test-utils";\r
import type { Extension } from "@dion-js/runtime";\r
import type {\r
	Entry,\r
	EntryDetailedResult,\r
	Setting,\r
} from "@dion-js/runtime-types/runtime";\r
import { join } from "node:path";\r
\r
let extension: Extension;\r
let client: MockManagerClient;\r
\r
let browseResult: Entry[];\r
let detailResult: EntryDetailedResult;\r
\r
beforeAll(async () => {\r
	client = new MockManagerClient(join(import.meta.path, "../../.dist"));\r
	extension = await getTestExtension(client.client);\r
	browseResult = [];\r
});\r
\r
describe("Extension", () => {\r
	it("should start", async () => {\r
		await extension!.setEnabled(true);\r
		const data = await extension!.getData();\r
		expect(data.compatible).toBe(true);\r
		expect(extension.enabled).toBe(true);\r
	});\r
	it("should be able to browse", async () => {\r
		if (extension.enabled === false) throw new Error("Extension not enabled");\r
		const result = await extension!.browse(0);\r
		expect(result).toBeDefined();\r
		expect(result.content.length).toBeGreaterThan(0);\r
		await assertValidEntries(result.content);\r
		browseResult = result.content;\r
	});\r
	it("should be able to search", async () => {\r
		if (extension.enabled === false) throw new Error("Extension not enabled");\r
		const result = await extension!.search(0, "second");\r
		await assertValidEntries(result.content);\r
		expect(result).toBeDefined();\r
	});\r
	it("should be able to detail", async () => {\r
		if (extension.enabled === false) throw new Error("Extension not enabled");\r
		if (browseResult === undefined || (browseResult?.length ?? 0) <= 0)\r
			throw new Error("No browse result");\r
		const result = await extension!.detail(browseResult[0]!.id, {});\r
		expect(result).toBeDefined();\r
		detailResult = result;\r
		await assertValidEntry(result.entry);\r
	});\r
	it("should be able to source", async () => {\r
		if (extension.enabled === false) throw new Error("Extension not enabled");\r
		if (detailResult === undefined || detailResult?.entry.episodes.length <= 0)\r
			throw new Error("No detail result");\r
		const result = await extension!.source(\r
			detailResult!.entry.episodes[0]!.id,\r
			(detailResult?.settings ?? {}) as { [key: string]: Setting },\r
		);\r
		await assertValidSource(result.source);\r
		expect(result).toBeDefined();\r
	});\r
});\r
`,H={name:C,id:I(),description:L,icon:V,url:z,author:B,keywords:JSON.stringify(W),media_type:JSON.stringify(X),title:G};await R(E),await N(J.join(E,"package.json"),await F(Y,H)),await N(J.join(E,"tsconfig.json"),Z),await N(J.join(E,"biome.json"),_),await N(J.join(E,"src","main.ts"),$),await N(J.join(E,"src","main.test.ts"),A),console.log(`
Created extension at ${E}`),console.log("Next steps:"),console.log(`- cd ${J.relative(process.cwd(),E)}`),console.log("- bun install"),console.log("- bun run build"),console.log("- bun test"),console.log("- bun run pushdev")}U().catch((j)=>{console.error(j),process.exit(1)});
