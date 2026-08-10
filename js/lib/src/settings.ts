import type {
	CustomUI,
	EntryDetailed,
	EntryId,
	Setting,
	SettingKind,
	SettingsUI,
	SettingValue,
} from "@dion-js/runtime-types/runtime";
import { getSetting, registerSetting, setEntrySetting } from "setting";
import { assertDefined } from "./asserts.js";
import type { SubRef } from "./signal.js";
import { logerr } from "./util.js";

export type Settingvalues = SettingValue extends { data: infer D } ? D : never;

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
		defaultval: ExcludeLiteral<T>;
		label?: string;
		visible?: boolean;
		ui?: UI<T>;
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
		if (setting.default.type !== toSettingValue(defaultval).type) {
			console.log("Setting type changed, overwriting");
			console.log(
				`${setting.default.type} !== ${toSettingValue(defaultval).type}`,
			);
			this.settings[id] = {
				label: label ?? id,
				visible: visible,
				default: toSettingValue(defaultval),
				value: toSettingValue(defaultval),
				ui: ui?.getDefinition() ?? null,
			};
			return defaultval as ExcludeLiteral<T>;
		}
		setting.ui = ui?.getDefinition();
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
		new_setting.value = toSettingValue(await extension_setting.get());
		if (setting === undefined) {
			this.settings[extension_setting.id] = new_setting;
			return new_setting.value.data as ExcludeLiteral<T>;
		}
		if (setting.default.type !== new_setting.default.type) {
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
		return map;
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

export class SettingCustomUI<T extends Settingvalues> extends UI<T> {
	ui: CustomUI;
	constructor(ui: CustomUI) {
		super();
		this.ui = ui;
	}

	getDefinition(): SettingsUI {
		return {
			type: "CustomUI",
			ui: this.ui,
		};
	}
	fitsDefinition(ui: SettingsUI): boolean {
		return ui.type == "CustomUI" && this.compareCustomUI(ui.ui, this.ui);
	}
	compareCustomUI(ui: CustomUI, other: CustomUI): boolean {
		if (ui.type !== other.type) return false;
		switch (ui.type) {
			case "Text":
				return ui.text === (other as typeof ui).text;
			case "Image":
				return (
					ui.image === (other as typeof ui).image &&
					ui.width === (other as typeof ui).width &&
					ui.height === (other as typeof ui).height
				);
			case "Link":
				return (
					ui.link === (other as typeof ui).link &&
					ui.label === (other as typeof ui).label
				);
			case "Timestamp":
				return (
					ui.timestamp === (other as typeof ui).timestamp &&
					ui.display === (other as typeof ui).display
				);
			case "EntryCard":
				return (
					JSON.stringify(ui.entry) ===
					JSON.stringify((other as typeof ui).entry)
				);
			case "Card":
				return (
					ui.image === (other as typeof ui).image &&
					this.compareCustomUI(ui.top, (other as typeof ui).top) &&
					this.compareCustomUI(ui.bottom, (other as typeof ui).bottom)
				);
			case "Spinner":
				return true;
			case "Feed":
				return (
					ui.handler === (other as typeof ui).handler &&
					ui.data === (other as typeof ui).data
				);
			case "Button":
				return (
					ui.label === (other as typeof ui).label &&
					JSON.stringify(ui.on_click) ===
						JSON.stringify((other as typeof ui).on_click)
				);
			case "InlineSetting":
				return (
					ui.setting_id === (other as typeof ui).setting_id &&
					ui.setting_kind === (other as typeof ui).setting_kind &&
					JSON.stringify(ui.on_commit) ===
						JSON.stringify((other as typeof ui).on_commit)
				);
			case "Slot":
				return (
					ui.handler === (other as typeof ui).handler &&
					this.compareCustomUI(ui.child, (other as typeof ui).child) &&
					ui.static_data === (other as typeof ui).static_data &&
					JSON.stringify(ui.subscriptions) ===
						JSON.stringify((other as typeof ui).subscriptions)
				);
			case "TextInput":
				return (
					JSON.stringify(ui.on_change) ===
						JSON.stringify((other as typeof ui).on_change) &&
					ui.debounce_ms === (other as typeof ui).debounce_ms &&
					ui.initial === (other as typeof ui).initial &&
					JSON.stringify(ui.on_commit) ===
						JSON.stringify((other as typeof ui).on_commit)
				);
			case "Column":
			case "Row": {
				const uiChildren = ui.children;
				const otherChildren = (other as typeof ui).children;
				if (uiChildren.length !== otherChildren.length) return false;
				for (let i = 0; i < uiChildren.length; i++) {
					if (!uiChildren[i] || !otherChildren[i]) return false;
					if (!this.compareCustomUI(uiChildren[i]!, otherChildren[i]!))
						return false;
				}
				return true;
			}
			default:
				return false;
		}
	}
}

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

export class EntrySettingHandle<T extends Settingvalues> {
	id: string;
	visible = true;
	label?: string;

	constructor(id: string) {
		this.id = id;
	}

	toSetting(
		store: SettingStore,
		defaultval: ExcludeLiteral<T>,
		ui?: UI<ExcludeLiteral<T>>,
		visible?: boolean,
	): EntrySetting<T> {
		if (!store.touched.includes(this.id)) {
			store.touched.push(this.id);
		}
		const setting = store.settings[this.id];
		if (setting === undefined) {
			console.log("Setting not found, creating");
			store.settings[this.id] = {
				label: this.label ?? this.id,
				visible: visible ?? this.visible,
				default: toSettingValue(defaultval),
				value: toSettingValue(defaultval),
				ui: ui?.getDefinition() ?? null,
			};
			return new EntrySetting(this, store, defaultval);
		}
		if (typeof setting.default.data !== typeof defaultval) {
			console.log("Setting type changed, overwriting");
			console.log(`${typeof setting.default.data} !== ${typeof defaultval}`);
			store.settings[this.id] = {
				label: this.label ?? this.id,
				visible: visible ?? this.visible,
				default: toSettingValue(defaultval),
				value: toSettingValue(defaultval),
				ui: ui?.getDefinition() ?? null,
			};
			return new EntrySetting(this, store, defaultval);
		}
		setting.ui = ui?.getDefinition();
		setting.visible = visible ?? this.visible;
		setting.label = this.label ?? this.id;
		setting.default = toSettingValue(defaultval);
		store.settings[this.id] = setting;
		return new EntrySetting(this, store, defaultval);
	}

	async setSetting(entry: EntryId, value: ExcludeLiteral<T>) {
		await setEntrySetting(entry, this.id, toSettingValue(value));
	}

	asSubRef(entryId: EntryId): SubRef<T> {
		return {
			kind: "entrySetting",
			entryId,
			settingId: this.id,
		};
	}
}

export class EntrySetting<T extends Settingvalues> {
	handle: EntrySettingHandle<T>;
	store: SettingStore;
	defaultvalue: ExcludeLiteral<T>;
	visible = true;
	label?: string;
	ui?: UI<T>;

	constructor(
		handle: EntrySettingHandle<T>,
		store: SettingStore,
		defaultvalue: ExcludeLiteral<T>,
	) {
		this.handle = handle;
		this.store = store;
		this.defaultvalue = defaultvalue;
	}

	get<T extends Settingvalues>(): ExcludeLiteral<T> {
		const id = this.handle.id;
		assertDefined(
			this.store.settings[id],
			`[SettingStore.get] Setting not found: ${id}`,
		);
		return this.store.settings[id].value.data as ExcludeLiteral<T>;
	}

	setUI(ui: UI<T>): this {
		const setting = this.store.settings[this.handle.id];
		if (setting) {
			setting.ui = ui.getDefinition();
			this.store.settings[this.handle.id] = setting;
		}
		this.ui = ui;
		return this;
	}

	define(): this {
		this.store.getOrDefine({
			id: this.handle.id,
			defaultval: this.defaultvalue,
			label: this.label,
			visible: this.visible,
			ui: this.ui,
		});
		return this;
	}

	tryGet<T extends Settingvalues>(id: string): ExcludeLiteral<T> | undefined {
		return this.store.settings[id]?.value.data as ExcludeLiteral<T>;
	}

	asSubRef(entryId: EntryId): SubRef<T> {
		return {
			kind: "entrySetting",
			entryId,
			settingId: this.handle.id,
		};
	}
}

export function defineExtensionSetting<T extends Settingvalues>(
	id: string,
	options: {
		label?: string;
		default: ExcludeLiteral<T>;
		visible?: boolean;
		ui?: UI<ExcludeLiteral<T>>;
	},
): ExtensionSetting<T> {
	const setting = new ExtensionSetting<T>(id, options.default, "Extension");
	if (options.label) {
		setting.setLabel(options.label);
	}
	if (options.visible !== undefined) {
		setting.setVisible(options.visible);
	}
	if (options.ui) {
		setting.setUI(options.ui);
	}
	return setting;
}

export function defineSearchSetting<T extends Settingvalues>(
	id: string,
	options: {
		label?: string;
		default: ExcludeLiteral<T>;
		visible?: boolean;
		ui?: UI<ExcludeLiteral<T>>;
	},
): ExtensionSetting<T> {
	const setting = new ExtensionSetting<T>(id, options.default, "Search");
	if (options.label) {
		setting.setLabel(options.label);
	}
	if (options.visible !== undefined) {
		setting.setVisible(options.visible);
	}
	if (options.ui) {
		setting.setUI(options.ui);
	}
	return setting;
}

export function defineEntrySetting<T extends Settingvalues>(
	id: string,
	options: {
		label?: string;
		visible?: boolean;
	},
): EntrySettingHandle<T> {
	const handle = new EntrySettingHandle<T>(id);
	if (options.label) {
		handle.label = options.label;
	}
	if (options.visible !== undefined) {
		handle.visible = options.visible;
	}
	return handle;
}
