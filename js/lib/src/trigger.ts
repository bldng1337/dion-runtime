import { EventData, EventResult } from "@dion-js/runtime-types/runtime";

export abstract class BaseTrigger {
	abstract handle(ev: EventData): Promise<EventResult | undefined>;
}

export class Trigger<E> extends BaseTrigger {
	id: string;
	handler: (data: E) => Promise<EventResult>;

	constructor(id: string, handler: (data: E) => Promise<EventResult>) {
		super();
		this.id = id;
		this.handler = handler;
	}

	async handle(ev: EventData): Promise<EventResult | undefined> {
		if (ev.type !== "Trigger" || ev.event !== this.id) return;
		return await this.handler(JSON.parse(ev.data) as E);
	}

	trigger(data: E): EventData {
		return {
			type: "Trigger",
			event: this.id,
			data: JSON.stringify(data),
		};
	}
}

export async function routeTrigger(
	triggers: Record<string, BaseTrigger>,
	ev: EventData,
): Promise<EventResult | undefined> {
	for (const trigger of Object.values(triggers)) {
		const result = await trigger.handle(ev);
		if (result) return result;
	}
}
