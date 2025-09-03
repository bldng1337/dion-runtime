/// <reference path="../../../js/dion_extension_types/index.d.ts" />

import { decode_base64, encode_base64 } from "convert";
import { assert, DefaultExtension } from "../extensionutils";

export default class extends DefaultExtension {
	async load() {
		assert(decode_base64("YXNk") === "asd", "decode_base64 not working");
		assert(encode_base64("asd") === "YXNk", "encode_base64 not working");
		const testcases = [
			"test",
			"some text",
			"some other text",
			"some text\nsome other text",
			"",
			" ",
			"\n",
		];
		for (const testcase of testcases) {
			assert(
				decode_base64(encode_base64(testcase)) === testcase,
				`decode_base64 or encode_base64 not working for ${testcase}`,
			);
		}
	}
}
