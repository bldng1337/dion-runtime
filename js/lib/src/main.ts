import type {
	Extension,
	ProxyRequest,
	ProxyResponse,
} from "@dion-js/runtime-types/extension";
import type {
	Account,
	EventData,
	EventResult,
} from "@dion-js/runtime-types/runtime";
import type { Settingvalues } from "setting";
import type { AuthAccount } from "./auth.ts";
import type { ExtensionSetting } from "./settings.js";

type bindable = { bind: (ext: DionExtension) => unknown }; //This is probably not really better than casting to any
export abstract class DionExtension implements Extension {
	abstract settings: { [key: string]: ExtensionSetting<Settingvalues> };
	abstract accounts: { [key: string]: AuthAccount };

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
	abstract onEvent(data: EventData): Promise<EventResult | undefined>;
	async handleProxy?(request: ProxyRequest): Promise<ProxyResponse>;

	async onload(): Promise<void> {
		// Empty implementation - can be overridden by subclasses
	}
}
