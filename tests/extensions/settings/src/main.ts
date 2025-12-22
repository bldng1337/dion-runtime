import type { EntryList, Setting } from "@dion-js/runtime-types/runtime";
import {
	assert,
	assertDeepEqual,
	DefaultExtension,
} from "@dion-js/unit-test-utils/extension";
import { getSetting, registerSetting } from "setting";

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
	}

	async browse(page: number): Promise<EntryList> {
		const setting = await getSetting("someid", "Extension");
		assert(
			setting.value.type === "String" && setting.value.data === "othervalue",
			"Setting should be set to othervalue on the native side",
		);
		return super.browse(page);
	}
}
