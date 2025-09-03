/// <reference path="../../../js/dion_extension_types/index.d.ts" />
import { getSetting, registerSetting } from "setting";
import { assert, assertDeepEqual, DefaultExtension } from "../extensionutils";

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
