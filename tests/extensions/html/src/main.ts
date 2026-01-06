import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";
import { parseHtml, parseHtmlFragment } from "parse";

function basic() {
	const html = `<html><body><div attr="value">some text</div><div>some other text</div></body></html>`;
	const parsed = parseHtml(html);
	const sel = new CSSSelector("div");
	const elarr = parsed.select(sel);
	const el = elarr.first;
	assert(el !== undefined, "div select not working");
	assertDeepEqual("some text", el.text, "parse_html not working");
	assertDeepEqual("body", el.parent?.name, "parse_html not working");
	assertDeepEqual("div", el.name, "parse_html not working");
	assertDeepEqual("value", el.attr("attr"), "parse_html not working");
	assertDeepEqual(2, elarr.length, "parse_html not working");
	assertDeepEqual(
		"some text\nsome other text",
		elarr.map((el) => el.text).join("\n"),
		"parse_html not working",
	);
}

function element() {
	const html = `<div attr="value"> some text <span>some other text</span></div>`;
	const parsed = parseHtmlFragment(html).children.get(0);
	assert(parsed !== undefined, "div select not working");
	assertDeepEqual("div", parsed.name, "Element.name not working");
	assertDeepEqual(
		"some text some other text",
		parsed.text.trim(),
		"Element.text not working",
	);
	assertDeepEqual(
		"some other text",
		parsed.select(new CSSSelector("span")).text,
		"Element.select not working",
	);
	assertDeepEqual("value", parsed.attr("attr"), "Element.attr not working");
	assertDeepEqual(
		"some other text",
		parsed.children.first?.text,
		"Element.children not working",
	);
}
function elementArray() {
	const html = `
    <ul>
    <li attr="1">one</li>
    <li attr="2" class="test">two</li>
    <li attr="3">three</li>
    </ul>`;
	const parsed = parseHtmlFragment(html);
	const elarray = parsed.select(new CSSSelector("ul")).first?.children;
	assert(elarray !== undefined, "Couldnt find ul");
	assertDeepEqual(3, elarray.length, "Wrong Number of children");
	assertDeepEqual(
		["1", "2", "3"],
		elarray.attr("attr"),
		"ElementArray.attr not working",
	);
	assertDeepEqual(
		"2",
		elarray.select(new CSSSelector("li.test")).first?.attr("attr"),
		"ElementArray.select not working",
	);
	assertDeepEqual(
		"2",
		elarray.get(1)?.attr("attr"),
		"ElementArray.get not working",
	);
	assertDeepEqual(
		"one\ntwo\nthree",
		elarray.map((el) => el.text).join("\n"),
		"ElementArray.map not working",
	);
	assertDeepEqual(
		["1", "3"],
		elarray.filter((el) => el.attr("attr") !== "2").attr("attr"),
		"ElementArray.filter not working",
	);
	assertDeepEqual("one", elarray.first?.text, "ElementArray.first not working");
	assertDeepEqual(3, elarray.length, "ElementArray.length not working");
}

export default class extends DefaultExtension {
	async load() {
		basic();
		element();
		elementArray();
	}
}
