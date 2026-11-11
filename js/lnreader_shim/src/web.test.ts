import { describe, expect, test } from "bun:test";
import { ShimBlob, ShimFormData, ShimHeaders } from "./web.ts";

describe("ShimHeaders", () => {
	test("is case-insensitive and joins repeated values", () => {
		const headers = new ShimHeaders({ "Content-Type": "text/html" });
		headers.append("set-cookie", "a=1");
		headers.append("Set-Cookie", "b=2");
		expect(headers.get("content-type")).toBe("text/html");
		expect(headers.get("SET-COOKIE")).toBe("a=1, b=2");
		expect(headers.getSetCookie()).toEqual(["a=1", "b=2"]);
		expect([...headers.keys()]).toEqual(["content-type", "set-cookie"]);
		headers.delete("Content-Type");
		expect(headers.has("content-type")).toBe(false);
	});

	test("accepts entries and other headers", () => {
		const copy = new ShimHeaders(new ShimHeaders([["X-A", "1"]]));
		expect(copy.toRecord()).toEqual({ "x-a": "1" });
	});
});

describe("ShimFormData", () => {
	test("encodes text fields as multipart", () => {
		const form = new ShimFormData();
		form.append("action", "search");
		form.append("q", 'a "quoted" term');
		form.set("action", "list");
		const { body, contentType } = form.encode();
		const boundary = contentType.split("boundary=")[1];
		expect(typeof body).toBe("string");
		expect(body).toBe(
			`--${boundary}\r\nContent-Disposition: form-data; name="action"\r\n\r\nlist\r\n` +
				`--${boundary}\r\nContent-Disposition: form-data; name="q"\r\n\r\na "quoted" term\r\n` +
				`--${boundary}--\r\n`,
		);
	});

	test("encodes blobs as binary parts", async () => {
		const form = new ShimFormData();
		form.append(
			"file",
			new ShimBlob([new Uint8Array([1, 2, 3])], { type: "x/y" }),
			"f.bin",
		);
		const { body } = form.encode();
		expect(body).toBeInstanceOf(Uint8Array);
		const text = new TextDecoder().decode(body as Uint8Array);
		expect(text).toContain(
			'filename="f.bin"\r\nContent-Type: x/y\r\n\r\n\u0001\u0002\u0003\r\n',
		);
	});
});
