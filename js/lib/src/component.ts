import type {
	CustomUI,
	Subscription,
	SubscriptionSource,
} from "@dion-js/runtime-types/runtime";
import { Spinner } from "./ui.js";
import {
	Signal,
	SubRef,
	entrySettingKey,
	isSubRef,
	toSubRef,
} from "./signal.js";

type WireSubscription = {
	source: SubscriptionSource;
	key: string;
	stateKey: string;
};

/**
 * A named Slot handler. The state type `S` is an object whose keys become
 * field names in the handler's `state` argument.
 * A field in `build()`'s `inputs` can be **static** (a plain value, captured
 * at build time and threaded into every handler call) or a **subscription**
 * (a Signal/SubRef, resolved fresh on each fire).
 */
export class Component<
	S extends Record<string, unknown> = Record<string, unknown>,
> {
	constructor(
		public readonly name: string,
		private readonly handler: (state: S) => Promise<CustomUI>,
	) {}

	/**
	 * Produce the Slot node. Each field of `inputs` is either:
	 *   - a static value (typed `S[K]`)
	 *   - a subscription (`Signal<S[K]> | SubRef<S[K]>`)
	 * The default `child` is `Spinner()`, shown until the first `LoadSlot`
	 * response arrives.
	 */
	build(inputs: InputsFor<S>, child: CustomUI = Spinner()): CustomUI {
		const statics: Record<string, unknown> = {};
		const subscriptions: WireSubscription[] = [];
		for (const [k, v] of Object.entries(inputs)) {
			if (v instanceof Signal || isSubRef(v)) {
				const ref = toSubRef(v as Signal<unknown> | SubRef<unknown>);
				let source: SubscriptionSource;
				let key: string;
				if (ref.kind === "store") {
					source = { type: "Store" };
					key = ref.key;
				} else if (ref.kind === "setting") {
					source = { type: "Setting", kind: ref.settingKind };
					key = ref.id;
				} else {
					source = { type: "EntrySetting" };
					key = entrySettingKey(ref.entryId, ref.settingId);
				}
				subscriptions.push({
					source,
					key,
					stateKey: k,
				});
			} else {
				statics[k] = v;
			}
		}
		const wireSubs: Subscription[] = subscriptions.map((s) => ({
			source: s.source,
			key: s.key,
			state_key: s.stateKey,
		}));
		return {
			type: "Slot",
			handler: this.name,
			child,
			static_data: JSON.stringify(statics),
			subscriptions: wireSubs,
		};
	}

	/**
	 * Called by the runtime: merges the Slot's static data with the latest
	 * subscription values and runs the handler.
	 */
	async run(
		staticData: string,
		values: Record<string, unknown>,
	): Promise<CustomUI> {
		const parsed =
			staticData === "" || staticData === null ? {} : JSON.parse(staticData);
		const state = { ...parsed, ...values } as S;
		return this.handler(state);
	}
}

export type InputsFor<S> = {
	[K in keyof S]: S[K] | Signal<S[K]> | SubRef<S[K]>;
};
