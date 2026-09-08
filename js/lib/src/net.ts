import { fetch, type Requestoptions } from "network";

export async function fetchJson<T>(
	url: string,
	options?: Requestoptions,
): Promise<T> {
	const res = await fetch(url, options);
	if (!res.ok) {
		throw new Error(`Request failed (${res.status}): ${url}`);
	}
	return res.json as T;
}

export async function fetchText(
	url: string,
	options?: Requestoptions,
): Promise<string> {
	const res = await fetch(url, options);
	if (!res.ok) {
		throw new Error(`Request failed (${res.status}): ${url}`);
	}
	return res.body;
}
