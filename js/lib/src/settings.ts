import type {
	Setting,
	SettingKind,
	SettingsUI,
	SettingValue,
} from "@dion-js/runtime-types/runtime";
import { getSetting, registerSetting, type Settingvalues } from "setting";
import { assertDefined } from "./asserts.js";
import { logerr } from "./util.js";

type ExcludeLiteral<T> = T extends string
	? string
	: T extends number
		? number
		: T extends boolean
			? boolean
			: T;

function toSettingValue(val: Settingvalues): SettingValue {
	if (typeof val === "string") {
		return {
			type: "String",
			data: val,
		};
	}
	if (typeof val === "number") {
		return {
			type: "Number",
			data: val,
		};
	}
	if (typeof val === "boolean") {
		return {
			type: "Boolean",
			data: val,
		};
	}
	throw new Error("Invalid setting type");
}

export class SettingStore {
	settings: Record<string, Setting>;
	touched: string[]; //Check if settings is touched to prevent zombie settings
	constructor(settings: Record<string, Setting>) {
		this.settings = settings;
		this.touched = [];
	}
	getOrDefine<T extends Settingvalues>({
		id,
		defaultval,
		label,
		visible = true,
		ui,
	}: {
		id: string;
		defaultval: T;
		label?: string;
		visible?: boolean;
		ui?: UI<ExcludeLiteral<T>>;
	}): ExcludeLiteral<T> {
		if (!this.touched.includes(id)) {
			this.touched.push(id);
		}
		const setting = this.settings[id];
		if (setting === undefined) {
			console.log("Setting not found, creating");
			this.settings[id] = {
				label: label ?? id,
				visible: visible,
				default: toSettingValue(defaultval),
				value: toSettingValue(defaultval),
				ui: ui?.getDefinition() ?? null,
			};
			return defaultval as ExcludeLiteral<T>;
		}
		if (typeof setting.default.data !== typeof defaultval) {
			console.log("Setting type changed, overwriting");
			console.log(`${typeof setting.default.data} !== ${typeof defaultval}`);
			this.settings[id] = {
				label: label ?? id,
				visible: visible,
				default: toSettingValue(defaultval),
				value: toSettingValue(defaultval),
				ui: ui?.getDefinition() ?? null,
			};
			return defaultval as ExcludeLiteral<T>;
		}
		if (setting.ui && ui && !ui.fitsDefinition(setting.ui)) {
			console.log(`Setting UI changed for ${id}, overwriting`);
			setting.ui = ui.getDefinition();
		}
		setting.visible = visible;
		setting.label = label ?? id;
		setting.default = toSettingValue(defaultval);
		this.settings[id] = setting;
		return setting.value.data as ExcludeLiteral<T>;
	}

	async inherit<T extends Settingvalues>(
		extension_setting: ExtensionSetting<T>,
	): Promise<ExcludeLiteral<T>> {
		const setting = this.settings[extension_setting.id];
		const new_setting = extension_setting.getDefinition();
		new_setting.value =
			toSettingValue(await extension_setting.get()) ?? new_setting.value;
		if (setting === undefined) {
			this.settings[extension_setting.id] = new_setting;
			return new_setting.value.data as ExcludeLiteral<T>;
		}
		if (typeof setting.default.data !== typeof new_setting.default.data) {
			this.settings[extension_setting.id] = new_setting;
			return new_setting.value.data as ExcludeLiteral<T>;
		}
		if (setting.default.data === setting.value.data) {
			setting.value = new_setting.value;
		}
		setting.default = new_setting.default;
		setting.ui = new_setting.ui;
		setting.visible = new_setting.visible;
		setting.label = new_setting.label;
		this.settings[extension_setting.id] = setting;
		return setting.value.data as ExcludeLiteral<T>;
	}

	get<T extends Settingvalues>(id: string): ExcludeLiteral<T> {
		assertDefined(
			this.settings[id],
			`[SettingStore.get] Setting not found: ${id}`,
		);
		return this.settings[id].value.data as ExcludeLiteral<T>;
	}

	tryGet<T extends Settingvalues>(id: string): ExcludeLiteral<T> | undefined {
		return this.settings[id]?.value.data as ExcludeLiteral<T>;
	}

	toMap(): Record<string, Setting> {
		const map: Record<string, Setting> = {};
		for (const key of this.touched) {
			assertDefined(
				this.settings[key],
				`[SettingStore.toMap] Setting not found: ${key}`,
			);
			map[key] = this.settings[key];
		}
		return this.settings;
	}
}

export class ExtensionSetting<T extends Settingvalues> {
	id: string;
	type: SettingKind;
	defaultvalue: ExcludeLiteral<T>;
	ui?: UI<ExcludeLiteral<T>>;
	visible = true;
	label?: string;

	constructor(id: string, defaultvalue: ExcludeLiteral<T>, type: SettingKind) {
		this.id = id;
		this.defaultvalue = defaultvalue;
		this.type = type;
	}

	setUI(ui: UI<ExcludeLiteral<T>>) {
		this.ui = ui;
		return this;
	}

	setVisible(visible: boolean) {
		this.visible = visible;
		return this;
	}

	setLabel(label: string) {
		this.label = label;
		return this;
	}

	getDefinition(): Setting {
		return {
			value: toSettingValue(this.defaultvalue),
			default: toSettingValue(this.defaultvalue),
			ui: this.ui?.getDefinition() ?? null,
			label: this.label ?? this.id,
			visible: this.visible,
		};
	}

	async register() {
		await registerSetting(this.id, this.getDefinition(), this.type);
	}

	async get(): Promise<ExcludeLiteral<T>> {
		try {
			const setting = await getSetting(this.id, this.type);
			return setting.value.data as ExcludeLiteral<T>;
		} catch (e) {
			logerr(`Error: Failed to get setting: ${this.id} - ${e}`);
			return this.defaultvalue;
		}
	}
}

export abstract class UI<T extends Settingvalues> {
	abstract getDefinition(): SettingsUI;
	abstract fitsDefinition(ui: SettingsUI): boolean;
	__(t: T) {
		//Type hack needed so TS keeps T
		return t;
	}
}
//TODO: Implement on rust side
// export class PathSelection extends UI<string> {
// 	picktype: "folder" | "file";
// 	label: string;
// 	constructor(label: string, picktype: "folder" | "file" = "folder") {
// 		super();
// 		this.label = label;
// 		this.picktype = picktype;
// 	}
// 	getDefinition(): SettingUI {
// 		return {
// 			label: this.label,
// 			type: "PathSelection",
// 			pickfolder: this.picktype === "folder",
// 		};
// 	}
// }

export class Slider extends UI<number> {
	min: number;
	max: number;
	step: number;

	constructor(min: number, max: number, step: number) {
		super();
		this.min = min;
		this.max = max;
		this.step = step;
	}
	getDefinition(): SettingsUI {
		return {
			type: "Slider",
			min: this.min,
			max: this.max,
			step: this.step,
		};
	}
	fitsDefinition(ui: SettingsUI): boolean {
		return (
			ui.type === "Slider" &&
			ui.max === this.max &&
			ui.min === this.min &&
			ui.step === this.step
		);
	}
}

export class Checkbox extends UI<boolean> {
	getDefinition(): SettingsUI {
		return {
			type: "CheckBox",
		};
	}
	fitsDefinition(ui: SettingsUI): boolean {
		return ui.type === "CheckBox";
	}
}

// TODO: Implement on rust side
// export class Textbox extends UI<string> {
// 	label: string;
// 	constructor(label: string) {
// 		super();
// 		this.label = label;
// 	}
// 	getDefinition(): SettingUI {
// 		return {
// 			type: "Textbox",
// 			label: this.label,
// 		};
// 	}
// }

export class Dropdown extends UI<string> {
	options: { value: string; label: string }[];
	constructor(options: { value: string; label: string }[]) {
		super();
		this.options = options;
	}
	getDefinition(): SettingsUI {
		return {
			type: "Dropdown",
			options: this.options,
		};
	}
	fitsDefinition(ui: SettingsUI): boolean {
		if (ui.type !== "Dropdown") return false;
		for (const option of ui.options) {
			if (
				!this.options.find(
					(o) => o.value === option.value && o.label === option.label,
				)
			)
				return false;
		}
		return true;
	}
}
