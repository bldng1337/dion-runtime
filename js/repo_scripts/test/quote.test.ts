import { expect, test } from "bun:test";
import { safeUrl, shellWord, yamlScalar } from "../src/utils/quote.ts";

test("safeUrl keeps only the allowed schemes", () => {
	const http = ["http:", "https:"];
	expect(safeUrl("https://example.com/a.png", http)).toBe(
		"https://example.com/a.png",
	);
	expect(safeUrl("javascript:alert(1)", http)).toBe("");
	expect(safeUrl(" JavaScript:alert(1)", http)).toBe("");
	expect(safeUrl("data:image/png;base64,AA", http)).toBe("");
	expect(safeUrl("data:image/png;base64,AA", [...http, "data:"])).toBe(
		"data:image/png;base64,AA",
	);
	expect(safeUrl("not a url", http)).toBe("");
	expect(safeUrl(undefined, http)).toBe("");
});

test("shellWord quotes anything beyond safe characters", () => {
	expect(shellWord("nightly")).toBe("nightly");
	expect(shellWord("dist/index")).toBe("dist/index");
	expect(shellWord("Release v1")).toBe("'Release v1'");
	expect(shellWord("$(rm -rf ~)")).toBe("'$(rm -rf ~)'");
	expect(shellWord("it's")).toBe("'it'\\''s'");
});

test("yamlScalar quotes values that could break the document", () => {
	expect(yamlScalar("main")).toBe("main");
	expect(yamlScalar("1.2.20")).toBe("1.2.20");
	expect(yamlScalar("main]\njobs:")).toBe('"main]\\njobs:"');
});
