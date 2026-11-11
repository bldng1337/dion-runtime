// `@libs/fetch` as LNReader provides it (src/plugins/helpers/fetch.ts in the
// app), implemented on top of the Dion `network` module.

import { fetch as dionFetch } from "network";
import {
	type RawResponse,
	ShimBlob,
	ShimFormData,
	ShimHeaders,
	ShimResponse,
} from "../web.ts";

export const DEFAULT_USER_AGENT =
	"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36";

let userAgent = DEFAULT_USER_AGENT;

export function setUserAgent(value: string | undefined): void {
	userAgent = value?.trim() || DEFAULT_USER_AGENT;
}

export function getUserAgent(): string {
	return userAgent;
}

export interface FetchInit {
	headers?: Record<string, string> | ShimHeaders | [string, string][];
	method?: string;
	body?: unknown;
	signal?: AbortSignalLike;
	[key: string]: unknown;
}

interface AbortSignalLike {
	aborted: boolean;
	reason?: unknown;
	addEventListener?: (type: string, listener: () => void) => void;
}

// The app's defaults (makeInit) minus `Connection` (illegal over HTTP/2) and
// `Accept-Encoding` (the host negotiates and decodes compression itself).
function defaultHeaders(): Record<string, string> {
	return {
		Accept: "*/*",
		"Accept-Language": "*",
		"Sec-Fetch-Mode": "cors",
		"Cache-Control": "max-age=0",
		"User-Agent": userAgent,
	};
}

function buildHeaders(init?: FetchInit): ShimHeaders {
	const headers = new ShimHeaders(defaultHeaders());
	const custom = new ShimHeaders(init?.headers as ShimHeaders);
	custom.forEach((value, name) => headers.set(name, value));
	// The host only decodes the encodings it negotiates itself, so plugin
	// choices other than `identity` are dropped. Like OkHttp (the app's HTTP
	// stack), ranged requests ask for the identity encoding: a byte range of
	// a gzip stream cannot be decoded.
	const encoding = headers.get("accept-encoding");
	if (encoding !== null && encoding.trim().toLowerCase() !== "identity") {
		headers.delete("accept-encoding");
	}
	if (headers.has("range") && !headers.has("accept-encoding")) {
		headers.set("Accept-Encoding", "identity");
	}
	return headers;
}

function encodeBody(
	body: unknown,
	headers: ShimHeaders,
): string | Uint8Array | undefined {
	if (body === undefined || body === null) return undefined;
	if (typeof body === "string") return body;
	if (body instanceof ShimFormData) {
		const { body: encoded, contentType } = body.encode();
		headers.set("Content-Type", contentType);
		return encoded;
	}
	if (body instanceof URLSearchParams) {
		if (!headers.has("content-type")) {
			headers.set(
				"Content-Type",
				"application/x-www-form-urlencoded;charset=UTF-8",
			);
		}
		return body.toString();
	}
	if (body instanceof ShimBlob) {
		if (body.type && !headers.has("content-type")) {
			headers.set("Content-Type", body.type);
		}
		return body.rawBytes();
	}
	if (body instanceof Uint8Array) return body;
	if (body instanceof ArrayBuffer) return new Uint8Array(body);
	if (ArrayBuffer.isView(body)) {
		return new Uint8Array(body.buffer, body.byteOffset, body.byteLength);
	}
	return String(body);
}

function abortError(signal: AbortSignalLike): unknown {
	if (signal.reason !== undefined) return signal.reason;
	const error = new Error("The operation was aborted.");
	error.name = "AbortError";
	return error;
}

export async function fetchApi(
	url: string | URL,
	init?: FetchInit,
): Promise<ShimResponse> {
	const target = String(url);
	const headers = buildHeaders(init);
	const body = encodeBody(init?.body, headers);
	const method = (init?.method ?? "GET").toUpperCase();
	const signal = init?.signal;
	if (signal?.aborted) throw abortError(signal);

	const request = dionFetch(target, {
		method: method as "GET",
		headers: headers.toRecord(),
		body,
	}).then((raw) => new ShimResponse(raw as unknown as RawResponse, target));

	if (!signal?.addEventListener) return request;
	// The host request cannot be cancelled, but the caller stops waiting.
	return new Promise((resolve, reject) => {
		signal.addEventListener?.("abort", () => reject(abortError(signal)));
		request.then(resolve, reject);
	});
}

export async function fetchText(
	url: string | URL,
	init?: FetchInit,
	encoding?: string,
): Promise<string> {
	try {
		const res = await fetchApi(url, init);
		if (!res.ok) return "";
		if (encoding && !/^utf-?8$/i.test(encoding)) {
			return new TextDecoder(encoding).decode(await res.bytes());
		}
		return await res.text();
	} catch {
		return "";
	}
}

export async function fetchProto(): Promise<never> {
	throw new Error("fetchProto is not supported by the Dion LNReader runtime");
}
