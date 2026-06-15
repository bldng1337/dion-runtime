// Reference Dion extension: a Book SourceProvider.
//
// Copy this file to `src/main.ts` and adapt the selectors/URLs to your target site.
// It demonstrates: subclassing DionExtension, a typed setting, network.fetch + parseHtml,
// stable ids, and echoing `settings` back from detail/source.

import { DionExtension } from "@dion-js/runtime-lib";
import { ExtensionSetting, SettingStore } from "@dion-js/runtime-lib/settings";
import { Text } from "@dion-js/runtime-lib/ui";
import { SourceProvider } from "@dion-js/runtime-types/extension";
import type {
  Entry,
  EntryDetailedResult,
  EntryId,
  EntryList,
  EpisodeId,
  EventData,
  EventResult,
  Link,
  Setting,
  SourceResult,
} from "@dion-js/runtime-types/runtime";
import { fetch } from "network";
import { parseHtml } from "parse";
import type { DionElement } from "parse";

const BASE = "https://example.com";

function abs(href: string): string {
  if (!href) return href;
  if (href.startsWith("http")) return href;
  return BASE + (href.startsWith("/") ? href : `/${href}`);
}

export default class extends DionExtension implements SourceProvider {
  // Declared settings are auto-registered by DionExtension.load().
  settings = {
    showAdult: new ExtensionSetting<boolean>("showAdult", false, "Extension")
      .setLabel("Show adult content")
      .setVisible(true),
  };

  accounts = {};

  async onEvent(_data: EventData): Promise<EventResult | undefined> {
    return undefined;
  }

  async browse(page: number): Promise<EntryList> {
    // The host is 0-indexed; many sites are 1-indexed.
    const res = await fetch(`${BASE}/list/${page + 1}`);
    const doc = parseHtml(res.body);
    const cards = doc.select(new CSSSelector("article.card"));

    const content: Entry[] = cards.map((card) => toEntry(card));
    const next = doc.select(new CSSSelector("a.next")).first !== undefined;

    return { content, hasnext: next, length: content.length };
  }

  async search(_page: number, filter: string): Promise<EntryList> {
    const res = await fetch(`${BASE}/search?q=${encodeURIComponent(filter)}`);
    const doc = parseHtml(res.body);
    const content = doc
      .select(new CSSSelector("article.card"))
      .map((card) => toEntry(card));
    return { content, hasnext: false };
  }

  async detail(
    entryid: EntryId,
    settings: Record<string, Setting>,
  ): Promise<EntryDetailedResult> {
    const setting_store = new SettingStore(settings);
    const res = await fetch(`${BASE}/work/${entryid.uid}`);
    const doc = parseHtml(res.body);
    const root = doc.select(new CSSSelector("main")).first ?? doc;

    const episodes = root
      .select(new CSSSelector("ol.chapters a"))
      .map((a, i) => ({
        id: { uid: `${entryid.uid}#${i}` },
        name: a.text.trim(),
        url: abs(a.attr("href")),
      }));

    return {
      entry: {
        id: entryid,
        url: `${BASE}/work/${entryid.uid}`,
        titles: [root.select(new CSSSelector("h1")).first?.text?.trim() ?? ""],
        media_type: "Book",
        status: "Unknown",
        description:
          root.select(new CSSSelector(".description")).first?.text?.trim() ??
          "",
        language: "en",
        episodes,
        cover: coverLink(root),
        author: null,
        ui: null,
        meta: null,
        poster: null,
        genres: null,
        rating: null,
        views: null,
        length: null,
      },
      settings: setting_store.toMap(),
    };
  }

  async source(
    epid: EpisodeId,
    settings: Record<string, Setting>,
  ): Promise<SourceResult> {
    const res = await fetch(`${BASE}/chapter/${epid.uid}`);
    const doc = parseHtml(res.body);
    // parseHtml exposes .paragraphs so HTML maps directly to a Paragraphlist source.
    const paragraphs = doc.select(new CSSSelector(".content")).first
      ?.paragraphs ?? [Text("No content found.")];

    return {
      source: { type: "Paragraphlist", paragraphs },
      settings,
    };
  }

  async handleUrl(url: string): Promise<boolean> {
    // Return true if this extension can handle a deep link the user pasted.
    return url.startsWith(`${BASE}/work/`);
  }
}

function toEntry(card: DionElement): Entry {
  const a = card.select(new CSSSelector("a.title")).first!;
  const cover = card.select(new CSSSelector("img")).first?.attr("src");
  return {
    id: { uid: a.attr("href").split("/").pop() ?? a.attr("href") },
    url: abs(a.attr("href")),
    title: a.text.trim(),
    media_type: "Book",
    cover: cover ? link(abs(cover)) : null,
    author: null,
    rating: null,
    views: null,
    length: null,
  };
}

function coverLink(root: DionElement): Link | null {
  const src = root.select(new CSSSelector("img.cover")).first?.attr("src");
  return src ? link(abs(src)) : null;
}

function link(url: string): Link {
  return { url, header: null };
}
