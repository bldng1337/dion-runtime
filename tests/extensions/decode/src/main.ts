import { assert, DefaultExtension } from "@dion-js/unit-test-utils/extension";
import { decodeBase64, encodeBase64 } from "convert";

export default class extends DefaultExtension {
	async load() {
		assert(decodeBase64("YXNk") === "asd", "decode_base64 not working");
		assert(encodeBase64("asd") === "YXNk", "encode_base64 not working");
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
				decodeBase64(encodeBase64(testcase)) === testcase,
				`decode_base64 or encode_base64 not working for ${testcase}`,
			);
		}
	}
}
