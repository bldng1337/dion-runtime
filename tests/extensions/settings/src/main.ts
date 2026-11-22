import type { EntryListResult, Setting } from "@dion-js/runtime-types/runtime";
import {
	StoreSetting,
	Dropdown,
	SettingStore,
	defineStoreSetting,
} from "@dion-js/runtime-lib/settings.js";
import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";
import { getSetting, registerSetting } from "setting";

const searchSettings = {
	sort: defineStoreSetting<string>("sort", {
		label: "Sort",
		default: "new",
		ui: new Dropdown([
			{ label: "New", value: "new" },
			{ label: "Top", value: "top" },
		]),
	}),
	nsfw: defineStoreSetting<boolean>("nsfw", { default: false }),
};

function searchStore(settings: Record<string, Setting>): SettingStore {
	const store = new SettingStore(settings);
	for (const setting of Object.values(searchSettings)) setting.get(store);
	return store;
}

export default class extends DefaultExtension {
	async load() {
		const setting: Setting = {
			default: {
				type: "String",
				data: "somedefault",
			},
			value: {
				type: "String",
				data: "somevalue",
			},
			label: "SomeLabel",
			visible: true,
		};
		await registerSetting("someid", setting, "Extension");
		const gotsetting = await getSetting("someid", "Extension");
		assertDeepEqual(
			setting,
			gotsetting,
			`setting should be equal to what was registered`,
		);
		assert(
			gotsetting.value.type === "String" &&
				gotsetting.value.data === "somevalue",
			"Setting should be set to somevalue",
		);
		let rejected = false;
		try {
			await getSetting("someid", "Search" as "Extension");
		} catch {
			rejected = true;
		}
		assert(rejected, "Search settings are no longer stored by the runtime");
	}

	async browse(
		page: number,
		settings: Record<string, Setting>,
	): Promise<EntryListResult> {
		const setting = await getSetting("someid", "Extension");
		assert(
			setting.value.type === "String" && setting.value.data === "othervalue",
			"Setting should be set to othervalue on the native side",
		);
		const store = searchStore(settings);
		const sort = searchSettings.sort.get(store);
		const result = await super.browse(page, settings);
		return {
			entries: {
				...result.entries,
				content: result.entries.content.map((e) => ({
					...e,
					title: `${e.title} (${sort})`,
				})),
			},
			settings: store.toMap(),
		};
	}

	async search(
		page: number,
		filter: string,
		settings: Record<string, Setting>,
	): Promise<EntryListResult> {
		// Reads no setting itself: the store still returns all of them.
		const store = searchStore(settings);
		const result = await super.search(page, filter, settings);
		return { entries: result.entries, settings: store.toMap() };
	}
}
