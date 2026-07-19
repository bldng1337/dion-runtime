import type {
	Action,
	Alignment,
	ButtonType,
	ColorToken,
	ContainerType,
	CrossAxisAlignment,
	CustomUI,
	DropdownItem,
	EdgeInsets,
	Entry,
	EntryDetailed,
	Interaction,
	Link,
	MainAxisAlignment,
	MainAxisSize,
	PopupAction,
	SettingKind,
	StackFit,
	TimestampType,
	ToastKind,
	WrapAlignment,
} from "@dion-js/runtime-types/runtime";
import type { TextStyle } from "@dion-js/runtime-types/runtime";
import { Trigger } from "./trigger.js";
import { Signal, SubRef, isSubRef, toSubRef } from "./signal.js";

type CustomUIMaybe = CustomUI | undefined;

// ============================================================================
// Leaf nodes
// ============================================================================

export function Text(text: string, style?: TextStyle | null): CustomUI {
	return {
		type: "Text",
		text: text,
		style: style ?? null,
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

export function Card(
	image: Link,
	top: CustomUI,
	bottom: CustomUI,
	onClick?: InteractionTarget | null,
): CustomUI {
	return {
		type: "Card",
		image,
		top,
		bottom,
		on_click: onClick ? toInteraction(onClick) : null,
	};
}

// ============================================================================
// Container nodes
// ============================================================================

/**
 * Anything that can be resolved into an `Interaction` via `toInteraction`.
 * Used as the type of every `onClick` / `onChange` / `onCommit` parameter so
 * extensions can pass a `Trigger`, `Signal`, or pre-built `Interaction`.
 */
export type InteractionTarget =
	| Signal<unknown>
	| SubRef<unknown>
	// biome-ignore lint/suspicious/noExplicitAny: accepts any typed Trigger
	| Trigger<any>
	| Interaction;

export interface ColumnRowOpts {
	/** How to place children along the main axis (defaults to `Start`). */
	mainAxisAlignment?: MainAxisAlignment;
	/** How to align children on the cross axis (defaults to `Center`). */
	crossAxisAlignment?: CrossAxisAlignment;
	/** Whether the column/row fills all available main-axis space. */
	mainAxisSize?: MainAxisSize;
	/**
	 * When `true` (default), the container becomes scrollable if its contents
	 * overflow — like CSS `overflow: auto`. If the content fits, this is a
	 * no-op.
	 */
	scrollable?: boolean;
}

function isColumnRowOpts(value: unknown): value is ColumnRowOpts {
	if (value === null || typeof value !== "object") return false;
	const keys = Object.keys(value);
	const allowed = new Set([
		"mainAxisAlignment",
		"crossAxisAlignment",
		"mainAxisSize",
		"scrollable",
	]);
	// A CustomUI always has a `type` field; an opts object never does.
	if ("type" in value) return false;
	return keys.length > 0 && keys.every((k) => allowed.has(k));
}

export function Column(...args: CustomUIMaybe[]): CustomUI {
	const last = args[args.length - 1];
	const opts = isColumnRowOpts(last) ? (args.pop() as ColumnRowOpts) : {};
	const children = args.filter((x) => x !== undefined) as CustomUI[];
	return {
		type: "Column",
		children,
		main_axis_alignment: opts.mainAxisAlignment ?? null,
		cross_axis_alignment: opts.crossAxisAlignment ?? null,
		main_axis_size: opts.mainAxisSize ?? null,
		scrollable: opts.scrollable ?? true,
	};
}

export function Row(...args: CustomUIMaybe[]): CustomUI {
	const last = args[args.length - 1];
	const opts = isColumnRowOpts(last) ? (args.pop() as ColumnRowOpts) : {};
	const children = args.filter((x) => x !== undefined) as CustomUI[];
	return {
		type: "Row",
		children,
		main_axis_alignment: opts.mainAxisAlignment ?? null,
		cross_axis_alignment: opts.crossAxisAlignment ?? null,
		main_axis_size: opts.mainAxisSize ?? null,
		scrollable: opts.scrollable ?? true,
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
export function toInteraction(target: InteractionTarget): Interaction {
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
export interface ButtonOpts {
	buttonType?: ButtonType;
	color?: ColorToken;
}

export function Button(
	label: string,
	onClick?: InteractionTarget | null,
	opts: ButtonOpts = {},
): CustomUI {
	const on_click = onClick ? toInteraction(onClick) : null;
	return {
		type: "Button",
		label,
		on_click,
		button_type: opts.buttonType ?? null,
		color: opts.color ?? null,
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
	onCommit?: InteractionTarget | null,
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
	onChange?: InteractionTarget;
	debounceMs?: number;
	initial?: string;
	/** Fired on Enter / blur. Same target rules as `onChange`. */
	onCommit?: InteractionTarget;
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
// Layout primitives
// ============================================================================

export function Padding(padding: EdgeInsets, child: CustomUI): CustomUI {
	return {
		type: "Padding",
		padding,
		child,
	};
}

/** Convenience: uniform padding on all sides. */
export function PaddingAll(all: number, child: CustomUI): CustomUI {
	return Padding({ left: all, top: all, right: all, bottom: all }, child);
}

/** Convenience: symmetric horizontal/vertical padding. */
export function PaddingSymmetric(
	horizontal: number,
	vertical: number,
	child: CustomUI,
): CustomUI {
	return Padding(
		{ left: horizontal, right: horizontal, top: vertical, bottom: vertical },
		child,
	);
}

export interface ContainerOpts {
	containerType?: ContainerType;
	color?: ColorToken;
	borderColor?: ColorToken;
	padding?: EdgeInsets;
	width?: number;
	height?: number;
	alignment?: Alignment;
	emphasized?: boolean;
}

export function Container(child: CustomUI, opts: ContainerOpts = {}): CustomUI {
	return {
		type: "Container",
		child,
		container_type: opts.containerType ?? null,
		color: opts.color ?? null,
		border_color: opts.borderColor ?? null,
		padding: opts.padding ?? null,
		width: opts.width ?? null,
		height: opts.height ?? null,
		alignment: opts.alignment ?? null,
		emphasized: opts.emphasized ?? null,
	};
}

export function Clickable(
	child: CustomUI,
	onClick?: InteractionTarget | null,
	onLongClick?: InteractionTarget | null,
): CustomUI {
	return {
		type: "Clickable",
		child,
		on_click: onClick ? toInteraction(onClick) : null,
		on_long_click: onLongClick ? toInteraction(onLongClick) : null,
	};
}

export function Expanded(child: CustomUI, flex = 1): CustomUI {
	return {
		type: "Expanded",
		child,
		flex,
	};
}

export function SizedBox(
	width?: number | null,
	height?: number | null,
	child?: CustomUI | null,
): CustomUI {
	return {
		type: "SizedBox",
		width: width ?? null,
		height: height ?? null,
		child: child ?? null,
	};
}

export function Spacer(flex = 1): CustomUI {
	return {
		type: "Spacer",
		flex,
	};
}

export interface WrapOpts {
	spacing?: number;
	runSpacing?: number;
	alignment?: WrapAlignment;
}

export function Wrap(...args: CustomUIMaybe[]): CustomUI {
	const last = args[args.length - 1];
	const opts = isWrapOpts(last) ? (args.pop() as WrapOpts) : {};
	const children = args.filter((x) => x !== undefined) as CustomUI[];
	return {
		type: "Wrap",
		children,
		spacing: opts.spacing ?? null,
		run_spacing: opts.runSpacing ?? null,
		alignment: opts.alignment ?? null,
	};
}

function isWrapOpts(value: unknown): value is WrapOpts {
	if (value === null || typeof value !== "object") return false;
	if ("type" in value) return false;
	const keys = Object.keys(value);
	const allowed = new Set(["spacing", "runSpacing", "alignment"]);
	return keys.length > 0 && keys.every((k) => allowed.has(k));
}

export function Center(child: CustomUI): CustomUI {
	return {
		type: "Center",
		child,
	};
}

export function Align(alignment: Alignment, child: CustomUI): CustomUI {
	return {
		type: "Align",
		alignment,
		child,
	};
}

export interface StackOpts {
	alignment?: Alignment;
	fit?: StackFit;
}

export function Stack(...args: CustomUIMaybe[]): CustomUI {
	const last = args[args.length - 1];
	const opts = isStackOpts(last) ? (args.pop() as StackOpts) : {};
	const children = args.filter((x) => x !== undefined) as CustomUI[];
	return {
		type: "Stack",
		children,
		alignment: opts.alignment ?? null,
		fit: opts.fit ?? null,
	};
}

function isStackOpts(value: unknown): value is StackOpts {
	if (value === null || typeof value !== "object") return false;
	if ("type" in value) return false;
	const keys = Object.keys(value);
	const allowed = new Set(["alignment", "fit"]);
	return keys.length > 0 && keys.every((k) => allowed.has(k));
}

export function Divider(): CustomUI {
	return { type: "Divider" };
}

// ============================================================================
// Container widgets
// ============================================================================

export interface ListTileOpts {
	leading?: CustomUI;
	title?: CustomUI;
	subtitle?: CustomUI;
	trailing?: CustomUI;
	onClick?: InteractionTarget | null;
	onLongClick?: InteractionTarget | null;
}

export function ListTile(opts: ListTileOpts): CustomUI {
	return {
		type: "ListTile",
		leading: opts.leading ?? null,
		title: opts.title ?? null,
		subtitle: opts.subtitle ?? null,
		trailing: opts.trailing ?? null,
		on_click: opts.onClick ? toInteraction(opts.onClick) : null,
		on_long_click: opts.onLongClick ? toInteraction(opts.onLongClick) : null,
	};
}

export function Badge(child: CustomUI, color?: ColorToken | null): CustomUI {
	return {
		type: "Badge",
		child,
		color: color ?? null,
	};
}

// ============================================================================
// Display primitives
// ============================================================================

export interface FoldableTextOpts {
	maxLines?: number;
	style?: TextStyle | null;
	animate?: boolean;
}

export function FoldableText(
	text: string,
	opts: FoldableTextOpts = {},
): CustomUI {
	return {
		type: "FoldableText",
		text,
		max_lines: opts.maxLines ?? 3,
		style: opts.style ?? null,
		animate: opts.animate ?? true,
	};
}

export function StarDisplay(fill: number, maxStars = 5): CustomUI {
	return {
		type: "StarDisplay",
		fill,
		max_stars: maxStars,
	};
}

export interface DropdownOpts {
	items: DropdownItem[];
	initialValue?: string | null;
	onChange?: InteractionTarget | null;
}

export function Dropdown(opts: DropdownOpts): CustomUI {
	return {
		type: "Dropdown",
		items: opts.items,
		initial_value: opts.initialValue ?? null,
		on_change: opts.onChange ? toInteraction(opts.onChange) : null,
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
