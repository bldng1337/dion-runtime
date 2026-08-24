import { type Mock, mock } from "bun:test";
import { Adapter, ExtensionClient, ManagerClient } from "@dion-js/runtime";
import type {
	Action,
	CustomUI,
	Entry,
	EntryDetailed,
	EntryId,
	ExtensionData,
	Link,
	Paragraph,
	Permission,
	SettingValue,
	Source,
} from "@dion-js/runtime-types/runtime";
import { Parser } from "m3u8-parser";
import fetch from "node-fetch";

export class MockExtensionClient {
	name: string;
	client: ExtensionClient;
	loadData: Mock<(err: Error | null, key: string) => string>;
	storeData: Mock<(err: Error | null, key: string, value: string) => void>;
	doAction: Mock<(err: Error | null, action: Action) => void>;
	requestPermission: Mock<
		(
			err: Error | null,
			permission: Permission,
			msg?: string | undefined | null,
		) => boolean
	>;
	getPath: Mock<(err: Error | null) => string>;
	setEntrySetting: Mock<
		(
			err: Error | null,
			entry: EntryId,
			key: string,
			value: SettingValue,
		) => void
	>;
	storeSet: Mock<(err: Error | null, key: string, value: unknown) => void>;
	constructor(extdata: ExtensionData, basepath: string) {
		this.name = extdata.name;
		this.loadData = mock((_err: Error | null, _arg: unknown) => "");
		this.storeData = mock(
			(_err: Error | null, _key: unknown, _arg: unknown): void => {
				// Empty mock implementation
			},
		);
		this.doAction = mock((_err: Error | null, _action: unknown): void => {
			// Empty mock implementation
		});
		this.requestPermission = mock((_err: Error | null, _asd: Permission) => {
			return false;
		});
		this.getPath = mock(() => {
			return `${basepath}/${extdata.name}`;
		});
		this.setEntrySetting = mock(
			(
				_err: Error | null,
				_entry: EntryId,
				_key: string,
				_value: SettingValue,
			): void => {
				// Empty mock implementation
			},
		);
		this.storeSet = mock(
			(_err: Error | null, _key: string, _value: unknown): void => {
				// Empty mock implementation
			},
		);
		this.client = new ExtensionClient(
			this.loadData,
			this.storeData,
			this.doAction,
			this.requestPermission,
			this.getPath,
			this.setEntrySetting,
			this.storeSet,
		);
	}
}

export class MockManagerClient {
	client: ManagerClient;
	extensions: MockExtensionClient[];
	managerpath: string;
	getClient: Mock<(err: Error | null, arg: ExtensionData) => ExtensionClient>;
	getPath: Mock<(err: Error | null) => string>;

	constructor(managerpath: string = ".") {
		this.managerpath = managerpath;
		this.extensions = [];
		this.getClient = mock((_err: Error | null, extdata: ExtensionData) => {
			const ext = new MockExtensionClient(extdata, managerpath);
			this.extensions.push(ext);
			return ext.client;
		});
		this.getPath = mock((_err: Error | null) => {
			return managerpath;
		});
		this.client = new ManagerClient(this.getClient, this.getPath);
	}
}

export async function getTestExtension(client: ManagerClient) {
	const adapter = await Adapter.init(client);
	const ext = (await adapter.getExtensions())[0];
	if (ext === undefined)
		throw new Error("Extension couldnt be loaded! Maybe build failed?");
	return ext;
}

export async function wait(ms: number): Promise<void> {
	return new Promise((resolve, _reject) => {
		setTimeout(resolve, ms);
	});
}

let lock: Promise<void> = Promise.resolve();
export async function ratelimit(ms: number) {
	const previous = lock;
	let release!: () => void;
	lock = new Promise<void>((resolve) => {
		release = resolve;
	});
	try {
		await previous;
		await wait(ms);
	} finally {
		release();
	}
}

const time = 50;

export function assert(condition: boolean, message: string): asserts condition {
	if (!condition) throw new Error(message);
}

function assertWarn(condition: boolean, message: string): asserts condition {
	if (!condition) console.warn(message);
}

export async function assertValidM3U8(
	link: Link,
	options?: {
		assertmsg?: string;
	},
) {
	console.log(`Checking ${link.url}`);
	await ratelimit(time);
	const response = await fetch(link.url, { headers: link.header ?? undefined });
	assertWarn(
		response.ok,
		`${options?.assertmsg} ${link.url} is not a valid url or not reachable`,
	);
	const parser = new Parser({
		uri: link.url,
	});
	parser.push(await response.text());
	parser.end();
	assertWarn(
		parser.manifest.segments.length > 0,
		`${options?.assertmsg} ${link.url} is not a valid m3u8 url`,
	);
}

export async function assertValidImageURL(
	link: Link,
	options?: {
		assertmsg?: string;
	},
) {
	await ratelimit(time);
	const response = await fetch(link.url, { headers: link.header ?? undefined });
	assertWarn(
		response.ok,
		`${options?.assertmsg} ${link.url} is not a valid url or not reachable`,
	);
	assertWarn(
		response.headers
			.get("content-type")
			?.toLocaleLowerCase()
			.includes("image") ?? false,
		`${options?.assertmsg}  ${link.url} is not an image url`,
	);
}

export async function assertValidURL(
	link: Link,
	options?: {
		assertmsg?: string;
	},
) {
	await ratelimit(time);
	const response = await fetch(link.url, { headers: link.header ?? undefined });
	assertWarn(
		response.ok,
		`${options?.assertmsg} ${link.url} is not a valid url or not reachable`,
	);
}

function sample<T>(arr: T[] | undefined | null, n: number): T[] {
	if (arr === undefined || arr === null) return [];
	if (arr.length <= n) return arr;
	const result = new Array(n);
	for (let i = 0; i < n; i++) {
		result[i] = arr[Math.floor(Math.random() * arr.length)];
	}
	return result;
}

function getTitle(entry: Entry | EntryDetailed) {
	if ("title" in entry) return entry.title;
	return entry.titles[0];
}

export async function assertValidEntry(entry: Entry | EntryDetailed) {
	await assertValidURL(
		{ url: entry.url },
		{
			assertmsg: `Entry ${getTitle(entry)} (${entry.id}) has no valid entry.url`,
		},
	);
	if (entry.cover !== undefined && entry.cover !== null) {
		await assertValidImageURL(entry.cover, {
			assertmsg: `Entry ${getTitle(entry)} (${entry.id}) has no valid entry.cover`,
		});
	}
	if ("episodes" in entry) {
		for (const episode of sample(entry.episodes, 5)) {
			await assertValidURL(
				{ url: episode.url },
				{
					assertmsg: `Entry ${getTitle(entry)} (${entry.id}) has an invalid episode url ${episode.url} for episode ${episode.name}`,
				},
			);
		}
	}
	if ("ui" in entry && entry.ui !== undefined && entry.ui !== null) {
		await assertValidUI(entry.ui);
	}
}

async function assertValidUI(ui: CustomUI) {
	if ("children" in ui && ui.children !== undefined && ui.children !== null) {
		for (const child of ui.children) {
			await assertValidUI(child);
		}
	}
	if ("child" in ui && ui.child !== undefined && ui.child !== null) {
		await assertValidUI(ui.child);
	}
	if (ui.type === "Card") {
		if (ui.top !== undefined && ui.top !== null) await assertValidUI(ui.top);
		if (ui.bottom !== undefined && ui.bottom !== null) {
			await assertValidUI(ui.bottom);
		}
	}
	if (ui.type === "ListTile") {
		for (const slot of [ui.leading, ui.title, ui.subtitle, ui.trailing]) {
			if (slot !== undefined && slot !== null) await assertValidUI(slot);
		}
	}
	switch (ui.type) {
		case "EntryCard":
			await assertValidEntry(ui.entry);
			break;
		case "Image":
			await assertValidImageURL(ui.image, {
				assertmsg: `CustomUI has an invalid image url ${ui.image}`,
			});
			break;
		case "Link":
			await assertValidURL(
				{ url: ui.link },
				{
					assertmsg: `CustomUI has an invalid link ${ui.link}`,
				},
			);
			break; //TODO Assert Timestamps
	}
}

export async function assertValidEntries(entries: (Entry | EntryDetailed)[]) {
	for (const entry of sample(entries, 5)) {
		await assertValidEntry(entry);
	}
}

export async function assertValidSource(source: Source) {
	switch (source.type) {
		case "Epub":
		case "Pdf":
			await assertValidURL(source.link, {
				assertmsg: `Source ${source.type} has no valid link`,
			});
			break;
		case "Audio":
			for (const chapter of sample(source.sources, 5)) {
				await assertValidURL(chapter.url, {
					assertmsg: `Source ${source.type} has an invalid source ${chapter.name} ${chapter.url}`,
				});
			}
			break;
		case "Imagelist":
			for (const image of sample(source.links, 5)) {
				await assertValidImageURL(image, {
					assertmsg: `Source ${source.type} has an invalid image url ${image}`,
				});
			}
			for (const audio of sample(source.audio, 5)) {
				await assertValidURL(audio.link, {
					assertmsg: `Source ${source.type} has an invalid url ${audio.link}`,
				});
			}
			break;
		case "Video":
			for (const videosource of source.sources) {
				await assertValidM3U8(videosource.url, {
					assertmsg: `Source ${videosource.name} has no valid link`,
				});
			}
			for (const subtitle of sample(source.sub, 5)) {
				await assertValidURL(subtitle.url, {
					assertmsg: `Source ${source.type} has an invalid ${subtitle.title} subtitle link ${subtitle.url}`,
				});
			}
			break;
		case "Paragraphlist":
			for (const paragraph of sample(source.paragraphs, 5)) {
				await assertValidParagraph(paragraph);
			}
			break;
	}
}

async function assertValidParagraph(paragraph: Paragraph) {
	switch (paragraph.type) {
		case "CustomUI":
			await assertValidUI(paragraph.ui);
			break;
		case "Table":
			for (const row of paragraph.columns) {
				for (const cell of sample(row.cells, 5)) {
					await assertValidParagraph(cell);
				}
			}
			break;
	}
}

export async function isValidEntry(entry: Entry | EntryDetailed) {
	try {
		await assertValidEntry(entry);
		return true;
	} catch (e) {
		if (e instanceof Error) {
			console.error(e.message);
		} else {
			console.error(e);
		}
		return false;
	}
}

export async function isValidEntries(entries: (Entry | EntryDetailed)[]) {
	try {
		await assertValidEntries(entries);
		return true;
	} catch (e) {
		if (e instanceof Error) {
			console.error(e.message);
		} else {
			console.error(e);
		}
		return false;
	}
}

export async function isValidSource(source: Source) {
	try {
		await assertValidSource(source);
		return true;
	} catch (e) {
		if (e instanceof Error) {
			console.error(e.message);
		} else {
			console.error(e);
		}
		return false;
	}
}
