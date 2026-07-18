import type { CustomUI } from "@dion-js/runtime-types/runtime";

function encode<T>(data: T): string {
	return data === undefined || data === null ? "" : JSON.stringify(data);
}

/**
 * A named Feed handler.
 */
export class FeedComponent<D = void> {
	constructor(
		public readonly name: string,
		private readonly handler: (
			data: D,
			page: number,
		) => Promise<{ items: CustomUI[]; hasMore: boolean }>,
	) {}

	/** Produce the Feed node. */
	build(data: D): CustomUI {
		return {
			type: "Feed",
			handler: this.name,
			data: encode(data),
		};
	}

	/** Called by the runtime. */
	async run(
		data: D,
		page: number,
	): Promise<{ items: CustomUI[]; hasMore: boolean }> {
		return this.handler(data, page);
	}
}

export function decodeFeedData<D>(raw: string): D {
	return raw === "" || raw === null ? (undefined as D) : (JSON.parse(raw) as D);
}
