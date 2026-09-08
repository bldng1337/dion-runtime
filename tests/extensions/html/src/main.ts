import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";
import { parseHtml, parseHtmlFragment, parseXml } from "parse";

function basic() {
	const html = `<html><body><div attr="value">some text</div><div>some other text</div></body></html>`;
	const parsed = parseHtml(html);
	const sel = new CSSSelector("div");
	const elarr = parsed.select(sel);
	const el = elarr.first;
	assert(el !== undefined, "div select not working");
	assertDeepEqual("some text", el.text, "parse_html not working 1");
	assertDeepEqual("body", el.parent?.name, "parse_html not working 2");
	assertDeepEqual("div", el.name, "parse_html not working 3");
	assertDeepEqual("value", el.attr("attr"), "parse_html not working 4");
	assertDeepEqual(2, elarr.length, "parse_html not working 5");
	assertDeepEqual(
		"some text\nsome other text",
		elarr.map((el) => el.text).join("\n"),
		"parse_html not working 6",
	);
}

function element() {
	const html = `<div attr="value"> some text <span>some other text</span></div>`;
	const parsed = parseHtmlFragment(html).children.get(0);
	assert(parsed !== undefined, "div select not working 1");
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

function links() {
	const feed = `<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <id>https://example.org/ebooks/1342.opds</id>
  <title>Pride and Prejudice</title>
  <updated>2024-01-01T00:00:00Z</updated>
  <entry>
    <id>https://example.org/ebooks/1342.opds</id>
    <title>Pride and Prejudice</title>
    <link rel="alternate" type="text/html" href="https://example.org/ebooks/1342"/>
    <link rel="http://opds-spec.org/acquisition" type="application/epub+zip" href="https://example.org/ebooks/1342.epub3.images"/>
    <link rel="http://opds-spec.org/acquisition" type="application/epub+zip" href="https://example.org/ebooks/1342.epub.noimages"/>
    <link rel="http://opds-spec.org/acquisition" type="application/vnd.amazon.ebook" href="https://example.org/ebooks/1342.kf8.images"/>
    <content type="text">Some content</content>
  </entry>
</feed>`;
	const doc = parseHtml(feed);
	const entry = doc.select(new CSSSelector("entry")).first;
	assert(entry !== undefined, "feed entry not found");
	const links = entry.select(new CSSSelector("link"));
	assertDeepEqual(
		[
			"https://example.org/ebooks/1342",
			"https://example.org/ebooks/1342.epub3.images",
			"https://example.org/ebooks/1342.epub.noimages",
			"https://example.org/ebooks/1342.kf8.images",
		],
		links.attr("href"),
		"repeated <link> elements not exposed",
	);
}

/** Trimmed version of a real Project Gutenberg OPDS detail feed: the shape
 * (self-closed `<category/>`, prefixed `<dcterms:...>` tags, acquisition links
 * after the categories) is what used to make the HTML5 parser swallow all but
 * the first of the acquisition links. */
function opds() {
	const feed = `<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:dcterms="http://purl.org/dc/terms/">
<id>http://www.gutenberg.org/ebooks/1342.opds</id>
<title>Pride and Prejudice by Jane Austen</title>
<link rel="search" type="application/opensearchdescription+xml" href="https://www.gutenberg.org/catalog/osd-books.xml"/>
<link rel="self" type="application/atom+xml;profile=opds-catalog" href="/ebooks/1342.opds"/>
<opensearch:itemsPerPage>25</opensearch:itemsPerPage>
<entry>
<updated>2026-09-07T20:28:37Z</updated>
<title>Pride and Prejudice</title>
<content type="xhtml">
<div xmlns="http://www.w3.org/1999/xhtml">
<p>
Summary:
A novel by Jane Austen.</p>
<p>Downloads: 181053</p>
</div>
</content>
<id>urn:gutenberg:1342:2</id>
<author>
<name>Austen, Jane</name>
</author>
<category scheme="http://purl.org/dc/terms/LCSH" term="England -- Fiction"/><category scheme="http://purl.org/dc/terms/LCSH" term="Young women -- Fiction"/>
<category scheme="http://purl.org/dc/terms/LCC" term="PR" label="English literature"/>
<dcterms:language>en</dcterms:language>
<link type="application/epub+zip" rel="http://opds-spec.org/acquisition" title="EPUB (no images)" href="https://www.gutenberg.org/ebooks/1342.epub.noimages"/>
<link type="application/x-mobipocket-ebook" rel="http://opds-spec.org/acquisition" title="Kindle (no images)" href="https://www.gutenberg.org/ebooks/1342.kindle.noimages"/>
<link type="image/jpeg" rel="http://opds-spec.org/image" href="https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg"/>
</entry>
<entry>
<title>Pride and Prejudice</title>
<link type="application/epub+zip" rel="http://opds-spec.org/acquisition" title="EPUB3 (with images)" href="https://www.gutenberg.org/ebooks/1342.epub3.images"/>
</entry>
</feed>`;
	// With an XML prolog, parseHtml must take the XML path.
	const doc = parseHtml(feed);
	assertDeepEqual(2, doc.select(new CSSSelector("entry")).length);

	// The acquisition links follow self-closed <category/> tags: the HTML5
	// parser nested them inside the first category, so a child-combinator
	// selector found nothing and only the first link stayed visible. They must
	// stay direct children of their entry.
	assertDeepEqual(
		[
			"https://www.gutenberg.org/ebooks/1342.epub.noimages",
			"https://www.gutenberg.org/ebooks/1342.kindle.noimages",
			"https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg",
		],
		doc
			.select(new CSSSelector("entry"))
			.first?.select(new CSSSelector("entry > link"))
			.attr("href"),
	);

	const acquisitions = doc
		.select(new CSSSelector("entry"))
		.select(new CSSSelector("link"))
		.filter((l) => l.attr("rel") === "http://opds-spec.org/acquisition");
	assertDeepEqual(
		[
			"https://www.gutenberg.org/ebooks/1342.epub.noimages",
			"https://www.gutenberg.org/ebooks/1342.kindle.noimages",
			"https://www.gutenberg.org/ebooks/1342.epub3.images",
		],
		acquisitions.attr("href"),
	);

	// Repeated self-closed elements stay siblings instead of nesting.
	const entry = doc.select(new CSSSelector("entry")).first;
	assert(entry !== undefined, "entry not found");
	assertDeepEqual(
		["England -- Fiction", "Young women -- Fiction", "PR"],
		entry.children
			.filter((c) => c.name === "category")
			.map((c) => c.attr("term")),
	);

	// Prefixed element names survive, so suffix matching still works.
	assertDeepEqual(
		1,
		entry.children.filter((c) => c.name.endsWith("language")).length,
	);

	// XHTML content paragraphs are reachable through p selectors.
	const contentEl = entry.select(new CSSSelector("content")).first;
	assert(contentEl !== undefined, "content not found");
	const pEls = contentEl.select(new CSSSelector("p"));
	assertDeepEqual(2, pEls.length);
	assertDeepEqual(
		"Summary:\nA novel by Jane Austen.",
		pEls.get(0)?.text.trim(),
	);
	assertDeepEqual("Downloads: 181053", pEls.get(1)?.text.trim());

	// parseXml forces the XML parser for prolog-less documents.
	const rss = parseXml(
		`<rss><channel><item><title>Ep 1</title><enclosure url="https://example.org/1.mp3"/></item>
<item><title>Ep 2</title><enclosure url="https://example.org/2.mp3"/></item></channel></rss>`,
	);
	assertDeepEqual(
		["https://example.org/1.mp3", "https://example.org/2.mp3"],
		rss
			.select(new CSSSelector("item"))
			.select(new CSSSelector("enclosure"))
			.attr("url"),
	);
	assertDeepEqual(2, rss.select(new CSSSelector("channel > item")).length);
}

export default class extends DefaultExtension {
	async load() {
		basic();
		element();
		elementArray();
		links();
		opds();
	}
}
