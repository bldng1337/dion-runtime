import type {
	Extension,
	ProxyRequest,
	ProxyResponse,
} from "@dion-js/runtime-types/extension";
import type { EventData, EventResult } from "@dion-js/runtime-types/runtime";
import type { Settingvalues } from "setting";
import type { ExtensionSetting } from "./settings.js";

export abstract class DionExtension implements Extension {
	abstract settings: { [key: string]: ExtensionSetting<Settingvalues> };

	async load() {
		for (const setting of Object.values(this.settings)) {
			await setting.register();
		}

		if ("browse" in this) this.browse = (this.browse as any).bind(this);
		if ("search" in this) this.search = (this.search as any).bind(this);
		if ("detail" in this) this.detail = (this.detail as any).bind(this);
		if ("source" in this) this.source = (this.source as any).bind(this);
		if ("handleUrl" in this)
			this.handleUrl = (this.handleUrl as any).bind(this);
		if ("mapEntry" in this) this.mapEntry = (this.mapEntry as any).bind(this);
		if ("onEntryActivity" in this)
			this.onEntryActivity = (this.onEntryActivity as any).bind(this);
		if ("mapSource" in this)
			this.mapSource = (this.mapSource as any).bind(this);
		await this.onload();
	}
	abstract onEvent(data: EventData): Promise<EventResult | undefined>;
	async handleProxy?(request: ProxyRequest): Promise<ProxyResponse>;

	async onload() {}
}
