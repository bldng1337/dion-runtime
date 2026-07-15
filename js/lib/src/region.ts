import type {
	CustomUI,
	EventData,
	EventResult,
	UIAction,
} from "@dion-js/runtime-types/runtime";
import {
	Feed as FeedNode,
	FeedResult,
	Slot,
	Spinner,
	SwapContent,
	SwapResult,
} from "./ui.js";


export abstract class Region {
	/** Produce the declarative node placed in the UI tree. */
	abstract build(): CustomUI;

	/**
	 * Handle a routed event. Return undefined if this region does not claim the event.
	 */
	abstract handle(data: EventData): Promise<EventResult | undefined>;
}

function encode<T>(data: T): string {
	return data === undefined || data === null ? "" : JSON.stringify(data);
}

function decode<T>(raw: string): T {
	return raw === "" ? (undefined as T) : (JSON.parse(raw) as T);
}

export type EventMap = Record<string, unknown>;

// ============================================================================
// SwapRegion
// ============================================================================

export class SwapRegion<E extends EventMap = EventMap> extends Region {
	/** @internal emitted slot id */
	readonly id: string;
	private readonly handlers: { [K in keyof E]: (data: E[K]) => Promise<CustomUI> };
	private readonly placeholder: CustomUI;

	constructor(
		id: string,
		handlers: { [K in keyof E]: (data: E[K]) => Promise<CustomUI> },
		placeholder: CustomUI = Spinner(),
	) {
		super();
		this.id = id;
		this.handlers = handlers;
		this.placeholder = placeholder;
	}


	build(mount?: { event: keyof E; data: E[keyof E] }): CustomUI {
		return Slot(
			this.id,
			this.placeholder,
			mount && SwapContent(this.id, mount.event as string, encode(mount.data)),
		);
	}


	swap<K extends keyof E>(event: K, data?: E[K]): UIAction {
		return SwapContent(this.id, event as string, encode(data as E[K]));
	}

	async handle(ev: EventData): Promise<EventResult | undefined> {
		if (ev.type !== "SwapContent" || ev.targetid !== this.id) return;
		const h = (this.handlers as Record<string, (d: unknown) => Promise<CustomUI>>)[
			ev.event
		];
		if (!h) return;
		return SwapResult(await h(decode(ev.data)));
	}
}

// ============================================================================
// FeedRegion
// ============================================================================

export class FeedRegion<D = void> extends Region {
	readonly id: string;
	private readonly onPage: (
		data: D,
		page: number,
	) => Promise<{ items: CustomUI[]; hasNext?: boolean }>;
	private readonly initialData?: D;

	constructor(
		id: string,
		onPage: (
			data: D,
			page: number,
		) => Promise<{ items: CustomUI[]; hasNext?: boolean }>,
		initialData?: D,
	) {
		super();
		this.id = id;
		this.onPage = onPage;
		this.initialData = initialData;
	}

	build(data?: D): CustomUI {
		return FeedNode(this.id, encode(data ?? this.initialData));
	}

	async handle(ev: EventData): Promise<EventResult | undefined> {
		if (ev.type !== "FeedUpdate" || ev.event !== this.id) return;
		const res = await this.onPage(decode(ev.data), ev.page);
		return FeedResult(res.items, { hasNext: res.hasNext });
	}
}

// ============================================================================
// Router
// ============================================================================

export async function routeEvent(
	regions: Record<string, Region>,
	data: EventData,
): Promise<EventResult | undefined> {
	for (const region of Object.values(regions)) {
		const res = await region.handle(data);
		if (res) return res;
	}
}
