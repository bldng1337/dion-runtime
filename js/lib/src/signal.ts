import { set } from "store";
import type { EntryId, SettingKind } from "@dion-js/runtime-types/runtime";

// ============================================================================
// SubRef: a typed reference to a subscribable value
// ============================================================================

/**
 * A reference to something a Slot can subscribe to.
 *  - `store`        : a key in the per-extension signal bus (transient).
 *  - `setting`      : an extension or search setting by id (durable, global).
 *  - `entrySetting` : a per-(entry, settingId) value (durable, per-entry).
 *
 * The `type` field is phantom: it carries the TypeScript type of the value
 * for inference, but is never present at runtime.
 */
export type SubRef<T = unknown> =
	| { kind: "store"; key: string; type?: T }
	| { kind: "setting"; id: string; settingKind: SettingKind; type?: T }
	| {
			kind: "entrySetting";
			entryId: EntryId;
			settingId: string;
			type?: T;
	  };

/** Returns true if `v` is a `SubRef`. */
export function isSubRef<T>(v: unknown): v is SubRef<T> {
	if (typeof v !== "object" || v === null) return false;
	const kind = (v as { kind?: unknown }).kind;
	return kind === "store" || kind === "setting" || kind === "entrySetting";
}

// ============================================================================
// Signal
// ============================================================================

/**
 * A single publish-only value identified by a stable wire name. Authors write
 * via `await signal.write(value)`; subscribers (Slots that declared this
 * Signal in their inputs) rebuild with the new value.
 *
 * `Signal.write(123)` is a compile error if the Signal was declared with a
 * different type `T`.
 */
export class Signal<T> {
	constructor(public readonly name: string) {}

	async write(value: T): Promise<void> {
		return set(this.name, value);
	}

	/** This Signal as a `SubRef<T>`, for use in `Component.build()`. */
	at(): SubRef<T> {
		return { kind: "store", key: this.name };
	}
}

// ============================================================================
// SignalStore
// ============================================================================

/**
 * A keyed collection of values of the same type, namespaced under one prefix.
 * `store.at("entry-1")` produces a `SubRef<T>` keyed to `"${name}:entry-1"`.
 *
 * Use this for per-entry signals (e.g. per-entry bind status): the prefix
 * groups them, the subKey selects the specific entry.
 */
export class SignalStore<T> {
	constructor(public readonly name: string) {}

	async write(subKey: string, value: T): Promise<void> {
		return set(`${this.name}:${subKey}`, value);
	}

	/** A `SubRef<T>` for the value at `subKey`, for use in `Component.build()`. */
	at(subKey: string): SubRef<T> {
		return { kind: "store", key: `${this.name}:${subKey}` };
	}
}

// ============================================================================
// Normalization
// ============================================================================

/**
 * Normalize a `Signal<T>` or `SubRef<T>` to a `SubRef<T>`. A bare `Signal`
 * becomes `{ kind: "store", key: signal.name }`.
 */
export function toSubRef<T>(s: Signal<T> | SubRef<T>): SubRef<T> {
	if (s instanceof Signal) {
		return { kind: "store", key: s.name };
	}
	return s;
}

/**
 * Compute the wire key for an entry setting: `${entryId.uid}:${settingId}`.
 */
export function entrySettingKey(entryId: EntryId, settingId: string): string {
	return `${entryId.uid}:${settingId}`;
}
