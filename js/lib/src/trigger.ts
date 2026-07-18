import type { EventData, Interaction } from "@dion-js/runtime-types/runtime";

function encode<T>(data: T): string {
	return data === undefined || data === null ? "" : JSON.stringify(data);
}

export class Trigger<P = void> {
	constructor(
		public readonly name: string,
		private readonly handler: (payload: P) => Promise<void>,
	) {}

	/**
	 * Produce an `Interaction::Invoke` for use as a `Button.on_click` or a
	 * `TextInput.on_commit`.
	 */
	invoke(payload: P): Interaction {
		return {
			type: "Invoke",
			handler: this.name,
			payload: encode(payload),
		};
	}

	/** Called by the runtime with the decoded payload. */
	async run(payload: P): Promise<void> {
		return this.handler(payload);
	}
}

export function decodeTriggerPayload<P>(raw: string): P {
	return raw === "" || raw === null ? (undefined as P) : (JSON.parse(raw) as P);
}

export function toInvokeEvent(trigger: Trigger, payload: unknown): EventData {
	return {
		type: "Invoke",
		handler: trigger.name,
		payload: encode(payload),
	};
}
