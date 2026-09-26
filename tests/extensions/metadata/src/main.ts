import type {
	ProxyRequest,
	ProxyResponse,
} from "@dion-js/runtime-types/extension";
import {
	assert,
	assertDeepEqual,
	DefaultExtension,
	getServer,
} from "@dion-js/unit-test-utils/extension";
import { getDataDir, joinPaths, readFile } from "filesystem";
import { inspect, openArchive } from "metadata";
import { fetch, getProxyAddress } from "network";
import { registerSetting } from "setting";

/** The test runner copies the repo fixtures here before enabling the
 * extension, so the local-file flows read real containers. */
async function fixture(name: string): Promise<Uint8Array> {
	return readFile(joinPaths([await getDataDir(), name]));
}

/** The `metadata` module inspects local containers read through the
 * `filesystem` module, and `openArchive` keeps a reusable handle whose
 * entries can be read as bytes (covers/pages) or text (chapters). */
async function metadataModule() {
	const epub = await fixture("sample.epub");
	assert(epub instanceof Uint8Array, "readFile returns Uint8Array");

	const meta = await inspect(epub, "sample.epub");
	assert(meta.type === "epub", `expected epub, got ${meta.type}`);
	assertDeepEqual("Test Book", meta.title);
	assertDeepEqual("Test Author", meta.creators[0]?.name);
	assertDeepEqual("/OEBPS/cover.png", meta.coverPath);
	assert(meta.spine.includes("/OEBPS/ch1.xhtml"), "spine contains chapter");
	assert(
		meta.toc.some(
			(item) => item.title === "Chapter 1" && item.path === "/OEBPS/ch1.xhtml",
		),
		"toc flattened",
	);

	const archive = await openArchive(epub, "sample.epub");
	const entries = await archive.entries();
	assert(
		entries.some((entry) => entry.path === "/OEBPS/nav.xhtml"),
		"entries list manifest resources",
	);
	const cover = await archive.read(meta.coverPath as string);
	assert(cover instanceof Uint8Array, "archive.read returns Uint8Array");
	assert(
		cover.length > 0 && cover[0] === 0x89 && cover[1] === 0x50,
		"cover has PNG magic",
	);
	const chapter = await archive.readText("/OEBPS/ch1.xhtml");
	assert(chapter.includes("Hello world"), "readText returns chapter text");
	assertDeepEqual("epub", (await archive.metadata).type, "archive metadata");

	// M4B audiobook: chapters map onto the Audio/Video chapter model and the
	// embedded artwork comes back as bytes.
	const m4b = await inspect(await fixture("sample.m4b"), "sample.m4b");
	assert(m4b.type === "mp4", `expected mp4, got ${m4b.type}`);
	assertDeepEqual("Test Audiobook", m4b.title);
	assertDeepEqual("Test Author", m4b.artist);
	assertDeepEqual(2, m4b.chapters.length);
	assertDeepEqual(0, m4b.chapters[0]?.startMs);
	assertDeepEqual(1500, m4b.chapters[1]?.startMs);
	assert(
		m4b.artwork instanceof Uint8Array && m4b.artwork.length > 0,
		"artwork bytes",
	);

	// MP3: lofty path.
	const mp3 = await inspect(await fixture("sample.mp3"), "sample.mp3");
	assert(mp3.type === "audio", `expected audio, got ${mp3.type}`);
	assertDeepEqual("Test Track", mp3.title);
	assertDeepEqual("Test Artist", mp3.artist);
	assertDeepEqual(2024, mp3.year);
}

/** `network.fetch` exposes binary bodies, so remote containers go through
 * the exact same inspection path as local ones. */
async function binaryFetch() {
	const server = await getServer();
	const response = await fetch(`${server}/sample.epub`);
	assert(
		response.ok,
		`remote epub fetch ok (got ${response.status} from ${server})`,
	);
	const remote = response.bytes;
	assert(remote instanceof Uint8Array, "fetch bytes is Uint8Array");
	const local = await fixture("sample.epub");
	assertDeepEqual(local.length, remote.length, "binary body length");
	const meta = await inspect(remote, "sample.epub");
	assert(meta.type === "epub", "remote epub inspects as epub");
	assertDeepEqual("Test Book", meta.title);

	// Text bodies still decode through the `body` getter.
	const text = await fetch(`${server}/text`);
	assertDeepEqual("hello dion", text.body);
}

export default class extends DefaultExtension {
	async load() {
		const proxyAddress = await getProxyAddress();
		await registerSetting(
			"proxyAddress",
			{
				visible: false,
				label: "Proxy Address",
				default: { type: "String", data: "" },
				value: { type: "String", data: proxyAddress || "" },
			},
			"Extension",
		);
		await metadataModule();
		await binaryFetch();
	}

	/** Serves the epub cover as raw bytes — the flow a local source uses to
	 * expose container content the client cannot decode itself. */
	async handleProxy(request: ProxyRequest): Promise<ProxyResponse> {
		if (request.uri.includes("/cover")) {
			const archive = await openArchive(await fixture("sample.epub"));
			const meta = await archive.metadata;
			if (meta.type !== "epub" || !meta.coverPath) {
				return { type: "response", status: 500, headers: {}, body: "bad epub" };
			}
			return {
				type: "response",
				status: 200,
				headers: { "Content-Type": ["image/png"] },
				body: await archive.read(meta.coverPath),
			};
		}
		return { type: "response", status: 404, headers: {}, body: "not found" };
	}
}
