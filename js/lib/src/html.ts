import { parseHtmlFragment } from "parse";

export function htmlToText(html: string): string {
	return parseHtmlFragment(html).text.replace(/\s+/g, " ").trim();
}

export function htmlToParagraphTexts(html: string): string[] {
	const fragment = parseHtmlFragment(html);
	const paras = fragment.select(new CSSSelector("p"));
	const texts: string[] = [];
	for (let i = 0; i < paras.length; i++) {
		const text = (paras.get(i)?.text ?? "").replace(/\s+/g, " ").trim();
		if (text.length > 0) {
			texts.push(text);
		}
	}
	if (texts.length > 0) {
		return texts;
	}
	const text = htmlToText(html);
	return text.length > 0 ? [text] : [];
}
