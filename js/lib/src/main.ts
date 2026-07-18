import type {
	Account,
	EventData,
	EventResult,
} from "@dion-js/runtime-types/runtime";
import type {
	Extension,
	ProxyRequest,
	ProxyResponse,
} from "@dion-js/runtime-types/extension";
import type { AuthAccount } from "./auth.ts";
import type { Component } from "./component.js";
import type { FeedComponent } from "./feed.js";
import type { Trigger } from "./trigger.js";
import type {
	EntrySettingHandle,
	ExtensionSetting,
	Settingvalues,
} from "./settings.js";

type bindable = { bind: (ext: DionExtension) => unknown }; //This is probably not really better than casting to any

function findByName<T>(
	registry: Record<string, T>,
	name: string,
): T | undefined {
	for (const v of Object.values(registry)) {
		if (
			v !== null &&
			typeof v === "object" &&
			(name as unknown) === (v as { name?: string }).name
		) {
			return v;
		}
	}
	return undefined;
}

export abstract class DionExtension implements Extension {
	abstract settings: { [key: string]: ExtensionSetting<Settingvalues> };
	abstract accounts: { [key: string]: AuthAccount };
	abstract entrySettings: { [key: string]: EntrySettingHandle<Settingvalues> };

	signals: { [key: string]: unknown } = {};
	// biome-ignore lint/suspicious/noExplicitAny: registry holds heterogeneous handlers
	components: { [key: string]: Component<any> } = {};
	// biome-ignore lint/suspicious/noExplicitAny: registry holds heterogeneous handlers
	feeds: { [key: string]: FeedComponent<any> } = {};
	// biome-ignore lint/suspicious/noExplicitAny: registry holds heterogeneous handlers
	triggers: { [key: string]: Trigger<any> } = {};

	async validate(acc: Account): Promise<Account | undefined> {
		for (const account of Object.values(this.accounts)) {
			if (
				!(
					account.domain === acc.domain &&
					account.authType.type === acc.auth.type
				)
			) {
				continue;
			}
			const data = await account.validate(account);
			return {
				...account.getDefinition(),
				user_name: data?.userName,
				cover: data?.profilePic,
			};
		}
	}

	async load() {
		for (const setting of Object.values(this.settings)) {
			await setting.register();
		}
		for (const account of Object.values(this.accounts)) {
			await account.register();
		}

		if ("browse" in this) this.browse = (this.browse as bindable).bind(this);
		if ("search" in this) this.search = (this.search as bindable).bind(this);
		if ("detail" in this) this.detail = (this.detail as bindable).bind(this);
		if ("source" in this) this.source = (this.source as bindable).bind(this);
		if ("handleUrl" in this)
			this.handleUrl = (this.handleUrl as bindable).bind(this);
		if ("mapEntry" in this)
			this.mapEntry = (this.mapEntry as bindable).bind(this);
		if ("onEntryActivity" in this)
			this.onEntryActivity = (this.onEntryActivity as bindable).bind(this);
		if ("mapSource" in this)
			this.mapSource = (this.mapSource as bindable).bind(this);
		await this.onload();
	}

	async onEvent(data: EventData): Promise<EventResult | undefined> {
		switch (data.type) {
			case "LoadSlot": {
				const component = findByName(this.components, data.handler);
				if (!component) return undefined;
				const values: Record<string, unknown> = {};
				for (const [k, v] of Object.entries(data.values)) {
					values[k] = v === null ? null : JSON.parse(v);
				}
				const customui = await component.run(data.static_data, values);
				return { type: "SlotContent", customui };
			}
			case "LoadPage": {
				const feed = findByName(this.feeds, data.handler);
				if (!feed) return undefined;
				const parsed =
					data.data === "" || data.data === null
						? undefined
						: JSON.parse(data.data);
				const res = await feed.run(parsed, data.page);
				return {
					type: "FeedPage",
					items: res.items,
					has_more: res.hasMore,
				};
			}
			case "Invoke": {
				const trigger = findByName(this.triggers, data.handler);
				if (!trigger) return undefined;
				const payload =
					data.payload === "" || data.payload === null
						? undefined
						: JSON.parse(data.payload);
				await trigger.run(payload);
				return undefined;
			}
		}
	}

	async handleProxy?(request: ProxyRequest): Promise<ProxyResponse>;

	async onload(): Promise<void> {
		// Empty implementation - can be overridden by subclasses
	}
}
