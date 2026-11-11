// Minimal implementations of the web APIs LNReader plugins reach for that the
// Dion JS runtime does not provide natively (Headers, FormData, Blob and a
// fetch-style Response). They only cover what plugins actually use; anything
// else is intentionally left out rather than half-implemented.

export type HeadersLike =
	| ShimHeaders
	| Record<string, string | undefined>
	| Iterable<[string, string]>
	| undefined
	| null;

export class ShimHeaders {
	#map = new Map<string, { name: string; values: string[] }>();

	constructor(init?: HeadersLike) {
		if (!init) return;
		if (init instanceof ShimHeaders) {
			init.forEach((value, name) => this.append(name, value));
		} else if (
			typeof (init as Iterable<unknown>)[Symbol.iterator] === "function"
		) {
			for (const [name, value] of init as Iterable<[string, string]>) {
				this.append(name, value);
			}
		} else {
			for (const [name, value] of Object.entries(init)) {
				if (value !== undefined && value !== null)
					this.append(name, String(value));
			}
		}
	}

	append(name: string, value: string): void {
		const key = String(name).toLowerCase();
		const entry = this.#map.get(key);
		if (entry) entry.values.push(String(value));
		else this.#map.set(key, { name: String(name), values: [String(value)] });
	}

	set(name: string, value: string): void {
		this.#map.set(String(name).toLowerCase(), {
			name: String(name),
			values: [String(value)],
		});
	}

	get(name: string): string | null {
		const entry = this.#map.get(String(name).toLowerCase());
		return entry ? entry.values.join(", ") : null;
	}

	getSetCookie(): string[] {
		return [...(this.#map.get("set-cookie")?.values ?? [])];
	}

	has(name: string): boolean {
		return this.#map.has(String(name).toLowerCase());
	}

	delete(name: string): void {
		this.#map.delete(String(name).toLowerCase());
	}

	forEach(
		callback: (value: string, name: string, headers: ShimHeaders) => void,
		thisArg?: unknown,
	): void {
		for (const [name, value] of this.entries()) {
			callback.call(thisArg, value, name, this);
		}
	}

	*entries(): IterableIterator<[string, string]> {
		const keys = [...this.#map.keys()].sort();
		for (const key of keys) {
			const entry = this.#map.get(key);
			if (entry) yield [key, entry.values.join(", ")];
		}
	}

	*keys(): IterableIterator<string> {
		for (const [name] of this.entries()) yield name;
	}

	*values(): IterableIterator<string> {
		for (const [, value] of this.entries()) yield value;
	}

	[Symbol.iterator](): IterableIterator<[string, string]> {
		return this.entries();
	}

	/** Flattens to the plain object the Dion `network` module expects. */
	toRecord(): Record<string, string> {
		const out: Record<string, string> = {};
		for (const { name, values } of this.#map.values()) {
			out[name] = values.join(", ");
		}
		return out;
	}
}

export class ShimBlob {
	readonly #bytes: Uint8Array;
	readonly type: string;

	constructor(parts: unknown[] = [], options: { type?: string } = {}) {
		const chunks = parts.map(toBytes);
		const size = chunks.reduce((sum, chunk) => sum + chunk.length, 0);
		const bytes = new Uint8Array(size);
		let offset = 0;
		for (const chunk of chunks) {
			bytes.set(chunk, offset);
			offset += chunk.length;
		}
		this.#bytes = bytes;
		this.type = options.type ?? "";
	}

	get size(): number {
		return this.#bytes.length;
	}

	async arrayBuffer(): Promise<ArrayBuffer> {
		return this.#bytes.slice().buffer as ArrayBuffer;
	}

	async bytes(): Promise<Uint8Array> {
		return this.#bytes.slice();
	}

	async text(): Promise<string> {
		return new TextDecoder().decode(this.#bytes);
	}

	slice(start?: number, end?: number, type?: string): ShimBlob {
		return new ShimBlob([this.#bytes.slice(start, end)], { type });
	}

	/** Synchronous access for the request encoder. */
	rawBytes(): Uint8Array {
		return this.#bytes;
	}
}

function toBytes(part: unknown): Uint8Array {
	if (part instanceof Uint8Array) return part;
	if (part instanceof ArrayBuffer) return new Uint8Array(part);
	if (ArrayBuffer.isView(part)) {
		return new Uint8Array(part.buffer, part.byteOffset, part.byteLength);
	}
	if (part instanceof ShimBlob) return part.rawBytes();
	return new TextEncoder().encode(String(part));
}

type FormValue = string | ShimBlob;

export class ShimFormData {
	#entries: { name: string; value: FormValue; filename?: string }[] = [];

	append(name: string, value: unknown, filename?: string): void {
		this.#entries.push(normalizeFormEntry(name, value, filename));
	}

	set(name: string, value: unknown, filename?: string): void {
		const entry = normalizeFormEntry(name, value, filename);
		const index = this.#entries.findIndex((e) => e.name === entry.name);
		this.#entries = this.#entries.filter((e) => e.name !== entry.name);
		this.#entries.splice(index < 0 ? this.#entries.length : index, 0, entry);
	}

	get(name: string): FormValue | null {
		return this.#entries.find((e) => e.name === String(name))?.value ?? null;
	}

	getAll(name: string): FormValue[] {
		return this.#entries
			.filter((e) => e.name === String(name))
			.map((e) => e.value);
	}

	has(name: string): boolean {
		return this.#entries.some((e) => e.name === String(name));
	}

	delete(name: string): void {
		this.#entries = this.#entries.filter((e) => e.name !== String(name));
	}

	forEach(
		callback: (value: FormValue, name: string, form: ShimFormData) => void,
		thisArg?: unknown,
	): void {
		for (const entry of this.#entries) {
			callback.call(thisArg, entry.value, entry.name, this);
		}
	}

	*entries(): IterableIterator<[string, FormValue]> {
		for (const entry of this.#entries) yield [entry.name, entry.value];
	}

	*keys(): IterableIterator<string> {
		for (const entry of this.#entries) yield entry.name;
	}

	*values(): IterableIterator<FormValue> {
		for (const entry of this.#entries) yield entry.value;
	}

	[Symbol.iterator](): IterableIterator<[string, FormValue]> {
		return this.entries();
	}

	/** Encodes the form as `multipart/form-data`, like a browser would. */
	encode(): { body: string | Uint8Array; contentType: string } {
		const boundary = `----DionFormBoundary${Math.random().toString(16).slice(2)}${Date.now().toString(16)}`;
		const textOnly = this.#entries.every((e) => typeof e.value === "string");
		const parts: (string | Uint8Array)[] = [];
		for (const { name, value, filename } of this.#entries) {
			const escaped = escapeFormName(name);
			if (typeof value === "string") {
				parts.push(
					`--${boundary}\r\nContent-Disposition: form-data; name="${escaped}"\r\n\r\n${value}\r\n`,
				);
			} else {
				parts.push(
					`--${boundary}\r\nContent-Disposition: form-data; name="${escaped}"; filename="${escapeFormName(filename ?? "blob")}"\r\nContent-Type: ${value.type || "application/octet-stream"}\r\n\r\n`,
					value.rawBytes(),
					"\r\n",
				);
			}
		}
		parts.push(`--${boundary}--\r\n`);
		const contentType = `multipart/form-data; boundary=${boundary}`;
		if (textOnly) return { body: parts.join(""), contentType };
		return { body: new ShimBlob(parts).rawBytes(), contentType };
	}
}

function normalizeFormEntry(name: string, value: unknown, filename?: string) {
	if (value instanceof ShimBlob) {
		return { name: String(name), value, filename: filename ?? "blob" };
	}
	return { name: String(name), value: String(value) };
}

function escapeFormName(name: string): string {
	return name.replace(/\r/g, "%0D").replace(/\n/g, "%0A").replace(/"/g, "%22");
}

const STATUS_TEXT: Record<number, string> = {
	200: "OK",
	201: "Created",
	202: "Accepted",
	204: "No Content",
	206: "Partial Content",
	301: "Moved Permanently",
	302: "Found",
	303: "See Other",
	304: "Not Modified",
	307: "Temporary Redirect",
	308: "Permanent Redirect",
	400: "Bad Request",
	401: "Unauthorized",
	403: "Forbidden",
	404: "Not Found",
	405: "Method Not Allowed",
	408: "Request Timeout",
	410: "Gone",
	429: "Too Many Requests",
	500: "Internal Server Error",
	502: "Bad Gateway",
	503: "Service Unavailable",
	504: "Gateway Timeout",
};

/** The subset of a Dion `network` response the shim reads. */
export interface RawResponse {
	readonly status: number;
	readonly body: string;
	readonly bytes: Uint8Array;
	readonly headers: Map<string, string> | Record<string, string>;
	readonly url?: string;
}

/** A fetch-style `Response` backed by a Dion network response. */
export class ShimResponse {
	readonly #raw: RawResponse;
	readonly headers: ShimHeaders;
	readonly url: string;
	readonly redirected: boolean;
	readonly type = "basic";
	bodyUsed = false;

	constructor(raw: RawResponse, requestUrl: string) {
		this.#raw = raw;
		const headers = raw.headers;
		this.headers = new ShimHeaders(
			headers instanceof Map ? [...headers.entries()] : headers,
		);
		this.url = raw.url || requestUrl;
		this.redirected = this.url !== requestUrl;
	}

	get status(): number {
		return this.#raw.status;
	}

	get ok(): boolean {
		return this.status >= 200 && this.status < 300;
	}

	get statusText(): string {
		return STATUS_TEXT[this.status] ?? "";
	}

	async text(): Promise<string> {
		this.bodyUsed = true;
		return this.#raw.body;
	}

	async json(): Promise<unknown> {
		return JSON.parse(await this.text());
	}

	async bytes(): Promise<Uint8Array> {
		this.bodyUsed = true;
		return this.#raw.bytes;
	}

	async arrayBuffer(): Promise<ArrayBuffer> {
		const bytes = await this.bytes();
		return bytes.buffer.slice(
			bytes.byteOffset,
			bytes.byteOffset + bytes.byteLength,
		) as ArrayBuffer;
	}

	async blob(): Promise<ShimBlob> {
		return new ShimBlob([await this.bytes()], {
			type: this.headers.get("content-type") ?? "",
		});
	}

	clone(): ShimResponse {
		return new ShimResponse(this.#raw, this.url);
	}
}

/** Installs the polyfills as globals, without replacing native versions. */
export function installGlobals(): void {
	const scope = globalThis as Record<string, unknown>;
	scope.Headers ??= ShimHeaders;
	scope.FormData ??= ShimFormData;
	scope.Blob ??= ShimBlob;
	scope.Response ??= ShimResponse;
	scope.window ??= globalThis;
	scope.self ??= globalThis;
}
