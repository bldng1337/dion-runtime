import type { CustomUI, Entry, Link } from "@dion-js/runtime-types/runtime";

type CustomUIMaybe = CustomUI | undefined;

export function Text(text: string): CustomUI {
	return {
		type: "Text",
		text: text,
	};
}

export function Timestamp(
	timestamp: string,
	display: "Relative" | "Absolute" = "Relative",
): CustomUI {
	return {
		type: "TimeStamp",
		timestamp: timestamp,
		display: display,
	};
}

export function Image(link: Link, width?: number, height?: number): CustomUI {
	return {
		type: "Image",
		image: link,
		width: width ?? null, //TODO: Lax the types on rust side so its undefined||null
		height: height ?? null,
	};
}

export function HyperLink(url: string, label?: string): CustomUI {
	return {
		type: "Link",
		link: url,
		label: label ?? null, //TODO: Lax the types on rust side so its undefined||null
	};
}

export function Column(...children: CustomUIMaybe[]): CustomUI {
	return {
		type: "Column",
		children: children.filter((x) => x !== undefined) as CustomUI[],
	};
}

export function EntryCard(centry: Entry): CustomUI {
	return {
		type: "EntryCard",
		entry: centry,
	};
}

export function Row(...children: CustomUIMaybe[]): CustomUI {
	return {
		type: "Row",
		children: children.filter((x) => x !== undefined) as CustomUI[],
	};
}

export function If<T extends CustomUI[] | CustomUIMaybe>(
	condition: boolean,
	ui: T,
): T {
	if (condition) {
		return ui;
	}
	if (Array.isArray(ui)) {
		return [] as unknown as T;
	}
	return undefined as T;
}
