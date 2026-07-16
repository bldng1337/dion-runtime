import type {
	Action,
	CustomUI,
	Entry,
	EntryDetailed,
	EventResult,
	Link,
	PopupAction,
	SettingKind,
	TimestampType,
	UIAction,
} from "@dion-js/runtime-types/runtime";

type CustomUIMaybe = CustomUI | undefined;

// ============================================================================
// Leaf nodes
// ============================================================================

export function Text(text: string): CustomUI {
	return {
		type: "Text",
		text: text,
	};
}

export function Timestamp(
	timestamp: string,
	display: TimestampType = "Relative",
): CustomUI {
	return {
		type: "Timestamp",
		timestamp: timestamp,
		display: display,
	};
}

export function Image(image: Link, width?: number, height?: number): CustomUI {
	return {
		type: "Image",
		image: image,
		width: width ?? null,
		height: height ?? null,
	};
}

export function Spinner(): CustomUI {
	return {
		type: "Spinner",
	};
}

export function Link(url: string, label?: string): CustomUI {
	return {
		type: "Link",
		link: url,
		label: label ?? null,
	};
}

export function EntryCard(entry: Entry): CustomUI {
	return {
		type: "EntryCard",
		entry: entry,
	};
}

export function Card(image: Link, top: CustomUI, bottom: CustomUI): CustomUI {
	return {
		type: "Card",
		image: image,
		top: top,
		bottom: bottom,
	};
}

// ============================================================================
// Container nodes ============================================================================

export function Column(...children: CustomUIMaybe[]): CustomUI {
	return {
		type: "Column",
		children: children.filter((x) => x !== undefined) as CustomUI[],
	};
}

export function Row(...children: CustomUIMaybe[]): CustomUI {
	return {
		type: "Row",
		children: children.filter((x) => x !== undefined) as CustomUI[],
	};
}

// ============================================================================
// Interactive nodes ============================================================================

export function Feed(event: string, data = ""): CustomUI {
	return {
		type: "Feed",
		event: event,
		data: data,
	};
}

export function Button(
	label: string,
	onClick: UIAction | null = null,
): CustomUI {
	return {
		type: "Button",
		label: label,
		on_click: onClick,
	};
}

export function InlineSetting(
	settingId: string,
	settingKind: SettingKind,
	onCommit: UIAction | null = null,
): CustomUI {
	return {
		type: "InlineSetting",
		setting_id: settingId,
		setting_kind: settingKind,
		on_commit: onCommit,
	};
}

export function Slot(
	id: string,
	child: CustomUI,
	onMount?: UIAction,
): CustomUI {
	return {
		type: "Slot",
		id: id,
		child: child,
		on_mount: onMount ?? null,
	};
}

// ============================================================================
// Action builders
// ============================================================================

export function OpenBrowser(url: string): Action {
	return {
		type: "OpenBrowser",
		url: url,
	};
}

export function TriggerEvent(event: string, data = ""): Action {
	return {
		type: "TriggerEvent",
		event: event,
		data: data,
	};
}

export function Nav(title: string, content: CustomUI): Action {
	return {
		type: "Nav",
		title: title,
		content: content,
	};
}

export function NavEntry(entry: EntryDetailed): Action {
	return {
		type: "NavEntry",
		entry: entry,
	};
}

export function Popup(
	title: string,
	content: CustomUI,
	actions: PopupAction[],
): Action {
	return {
		type: "Popup",
		title: title,
		content: content,
		actions: actions,
	};
}

// ============================================================================
// UIAction builders
// ============================================================================

export function Do(action: Action): UIAction {
	return {
		type: "Action",
		action: action,
	};
}

export function SwapContent(
	targetId: string,
	event: string,
	data = "",
	placeholder?: CustomUI,
): UIAction {
	return {
		type: "SwapContent",
		targetid: targetId,
		event: event,
		data: data,
		placeholder: placeholder ?? null,
	};
}

// ============================================================================
// EventResult builders ============================================================================

export function SwapResult(customui: CustomUI): EventResult {
	return {
		type: "SwapContent",
		customui: customui,
	};
}

export function FeedResult(
	items: CustomUI[],
	opts: { hasNext?: boolean; length?: number } = {},
): EventResult {
	return {
		type: "FeedUpdate",
		customui: items,
		hasnext: opts.hasNext ?? null,
		length: opts.length ?? null,
	};
}
