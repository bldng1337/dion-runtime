import type {
	Action,
	CustomUI,
	Entry,
	EntryDetailed,
	Interaction,
	Link,
	PopupAction,
	SettingKind,
	TimestampType,
	ToastKind,
} from "@dion-js/runtime-types/runtime";
import { Trigger } from "./trigger.js";
import { Signal, SubRef, isSubRef, toSubRef } from "./signal.js";

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
// Container nodes
// ============================================================================

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
// Interactive nodes
// ============================================================================

/**
 * Resolves a typed target (`Signal` or `Trigger`) into the right `Interaction`
 * variant. `Signal` -> `WriteKey` (Dart-local, no round-trip).
 * `Trigger` -> `Invoke` (extension round-trip).
 */
export function toInteraction(
	target:
		| Signal<unknown>
		| SubRef<unknown>
		// biome-ignore lint/suspicious/noExplicitAny: accepts any typed Trigger
		| Trigger<any>
		| Interaction,
): Interaction {
	if (target instanceof Trigger) {
		// Bare Trigger is sugar for `trigger.invoke(undefined)`.
		return target.invoke(undefined);
	}
	if (target instanceof Signal || isSubRef(target)) {
		const ref = toSubRef(target as Signal<unknown> | SubRef<unknown>);
		// WriteKey only makes sense for store keys. For setting refs the author
		// should be using a Trigger to commit; fall back to a no-op key here.
		const key = ref.kind === "store" ? ref.key : "";
		return {
			type: "WriteKey",
			key,
			value: "",
		};
	}
	// Already an Interaction.
	return target;
}

/**
 * A Button. `onClick` may be:
 *   - a `Trigger` (sugar for `trigger.invoke(undefined)`)
 *   - a `Trigger.invoke(payload)` (`Interaction::Invoke` with a payload)
 *   - a `Signal` (writes to the signal's key on click; rare)
 *   - an `Interaction` (already-built wire value)
 *   - undefined/null (no on_click)
 */
export function Button(
	label: string,
	onClick?:
		| // biome-ignore lint/suspicious/noExplicitAny: accepts any typed Trigger
		Trigger<any>
		| Signal<unknown>
		| SubRef<unknown>
		| Interaction
		| null,
): CustomUI {
	const on_click = onClick ? toInteraction(onClick) : null;
	return {
		type: "Button",
		label,
		on_click,
	};
}

/**
 * An InlineSetting. Renders the host's native widget for the named setting
 * and fires `onCommit` when the user changes it. `onCommit` follows the same
 * rules as `Button`'s `onClick`.
 */
export function InlineSetting(
	settingId: string,
	settingKind: SettingKind,
	onCommit?:
		| // biome-ignore lint/suspicious/noExplicitAny: accepts any typed Trigger
		Trigger<any>
		| Signal<unknown>
		| SubRef<unknown>
		| Interaction
		| null,
): CustomUI {
	const on_commit = onCommit ? toInteraction(onCommit) : null;
	return {
		type: "InlineSetting",
		setting_id: settingId,
		setting_kind: settingKind,
		on_commit,
	};
}

export interface TextInputOpts {
	/**
	 * Fired (debounced) on each edit. A `Signal` becomes `WriteKey`
	 * (Dart-local, no round-trip — ideal for feeding a subscribed Slot).
	 * A `Trigger` becomes `Invoke` (round-trip).
	 */
	onChange?:
		| // biome-ignore lint/suspicious/noExplicitAny: accepts any typed Trigger
		Trigger<any>
		| Signal<unknown>
		| SubRef<unknown>
		| Interaction;
	debounceMs?: number;
	initial?: string;
	/** Fired on Enter / blur. Same target rules as `onChange`. */
	onCommit?:
		| // biome-ignore lint/suspicious/noExplicitAny: accepts any typed Trigger
		Trigger<any>
		| Signal<unknown>
		| SubRef<unknown>
		| Interaction;
}

export function TextInput(opts: TextInputOpts = {}): CustomUI {
	return {
		type: "TextInput",
		on_change: opts.onChange ? toInteraction(opts.onChange) : null,
		debounce_ms: opts.debounceMs ?? null,
		initial: opts.initial ?? null,
		on_commit: opts.onCommit ? toInteraction(opts.onCommit) : null,
	};
}

// ============================================================================
// Action builders
//
// These produce `Action` values, passed to `doAction` from the `action` host
// module or used inside `Popup`'s `actions` array.
// ============================================================================

export function OpenBrowser(url: string): Action {
	return {
		type: "OpenBrowser",
		url: url,
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

export function PopView(): Action {
	return {
		type: "PopView",
	};
}

export function ShowToast(message: string, kind: ToastKind = "Info"): Action {
	return {
		type: "ShowToast",
		message,
		kind,
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
