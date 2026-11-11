// Maps LNReader filters and plugin settings onto Dion settings.
//
// Filters become `Search` settings keyed by the filter key, so the host's
// search-filter UI edits them. An excludable checkbox group needs two lists,
// stored under `<key>` (include) and `<key>:exclude`. Plugin settings become
// `Extension` settings keyed by their storage key; the app stores those values
// in plugin storage, which is where plugins read them back.

import type {
	DropdownOption,
	Setting,
	SettingValue,
} from "@dion-js/runtime-types/runtime";
import { getSetting, registerSetting } from "setting";
import { FilterTypes } from "./libs/misc.ts";
import type {
	FilterDefinition,
	FilterOption,
	PluginSettingDefinition,
} from "./plugin.ts";

export const EXCLUDE_SUFFIX = ":exclude";

function options(list: FilterOption[] | undefined): DropdownOption[] {
	return (list ?? []).map((o) => ({
		label: String(o.label),
		value: String(o.value),
	}));
}

function stringList(value: unknown): string[] {
	return Array.isArray(value) ? value.map(String) : [];
}

function setting(
	label: string,
	value: SettingValue,
	ui?: Setting["ui"],
): Setting {
	return { label, value, default: value, visible: true, ui };
}

/** Dion setting definitions for one LNReader filter. */
export function filterToSettings(
	key: string,
	filter: FilterDefinition,
): [string, Setting][] {
	const label = String(filter.label ?? key);
	switch (filter.type) {
		case FilterTypes.Picker:
			return [
				[
					key,
					setting(
						label,
						{ type: "String", data: String(filter.value ?? "") },
						{ type: "Dropdown", options: options(filter.options) },
					),
				],
			];
		case FilterTypes.Switch:
			return [
				[
					key,
					setting(
						label,
						{ type: "Boolean", data: !!filter.value },
						{ type: "CheckBox" },
					),
				],
			];
		case FilterTypes.CheckboxGroup:
			return [
				[
					key,
					setting(
						label,
						{ type: "StringList", data: stringList(filter.value) },
						{ type: "MultiDropdown", options: options(filter.options) },
					),
				],
			];
		case FilterTypes.ExcludableCheckboxGroup: {
			const value = (filter.value ?? {}) as {
				include?: unknown;
				exclude?: unknown;
			};
			const ui = {
				type: "MultiDropdown" as const,
				options: options(filter.options),
			};
			return [
				[
					key,
					setting(
						`${label} (include)`,
						{ type: "StringList", data: stringList(value.include) },
						ui,
					),
				],
				[
					key + EXCLUDE_SUFFIX,
					setting(
						`${label} (exclude)`,
						{ type: "StringList", data: stringList(value.exclude) },
						ui,
					),
				],
			];
		}
		default:
			return [
				[
					key,
					setting(label, { type: "String", data: String(filter.value ?? "") }),
				],
			];
	}
}

/** Dion setting definition for one LNReader plugin setting. */
export function pluginSettingToSetting(
	key: string,
	definition: PluginSettingDefinition,
): Setting {
	const label = String(definition.label ?? key);
	switch (definition.type) {
		case "Switch":
			return setting(
				label,
				{ type: "Boolean", data: !!definition.value },
				{ type: "CheckBox" },
			);
		case "Select":
			return setting(
				label,
				{ type: "String", data: String(definition.value ?? "") },
				{ type: "Dropdown", options: options(definition.options) },
			);
		case "CheckboxGroup":
			return setting(
				label,
				{ type: "StringList", data: stringList(definition.value) },
				{ type: "MultiDropdown", options: options(definition.options) },
			);
		default:
			return setting(label, {
				type: "String",
				data: String(definition.value ?? ""),
			});
	}
}

function plainValue(value: SettingValue | undefined): unknown {
	return value?.data;
}

async function readSetting(
	id: string,
	kind: "Search" | "Extension",
): Promise<SettingValue | undefined> {
	try {
		return (await getSetting(id, kind)).value;
	} catch {
		return undefined;
	}
}

export async function registerFilters(
	filters: Record<string, FilterDefinition> | undefined,
): Promise<void> {
	for (const [key, filter] of Object.entries(filters ?? {})) {
		for (const [id, definition] of filterToSettings(key, filter)) {
			await registerSetting(id, definition, "Search");
		}
	}
}

/**
 * The plugin's filters with the user's current values, shaped like the
 * definitions the app passes to `popularNovels` (each keeps `type`/`value`).
 */
export async function currentFilters(
	filters: Record<string, FilterDefinition> | undefined,
): Promise<Record<string, FilterDefinition> | undefined> {
	if (!filters) return undefined;
	const result: Record<string, FilterDefinition> = {};
	for (const [key, filter] of Object.entries(filters)) {
		let value: unknown = filter.value;
		const stored = plainValue(await readSetting(key, "Search"));
		switch (filter.type) {
			case FilterTypes.Switch:
				if (typeof stored === "boolean") value = stored;
				break;
			case FilterTypes.CheckboxGroup:
				if (Array.isArray(stored)) value = stored;
				break;
			case FilterTypes.ExcludableCheckboxGroup: {
				const exclude = plainValue(
					await readSetting(key + EXCLUDE_SUFFIX, "Search"),
				);
				const fallback = (filter.value ?? {}) as {
					include?: string[];
					exclude?: string[];
				};
				value = {
					include: Array.isArray(stored) ? stored : (fallback.include ?? []),
					exclude: Array.isArray(exclude) ? exclude : (fallback.exclude ?? []),
				};
				break;
			}
			default:
				if (typeof stored === "string") value = stored;
		}
		result[key] = { ...filter, value };
	}
	return result;
}

export async function registerPluginSettings(
	settings: Record<string, PluginSettingDefinition>,
): Promise<void> {
	for (const [key, definition] of Object.entries(settings)) {
		await registerSetting(
			key,
			pluginSettingToSetting(key, definition),
			"Extension",
		);
	}
}

/** Current values of the plugin settings, keyed like the plugin reads them. */
export async function pluginSettingValues(
	settings: Record<string, PluginSettingDefinition>,
): Promise<Map<string, unknown>> {
	const values = new Map<string, unknown>();
	for (const key of Object.keys(settings)) {
		const value = await readSetting(key, "Extension");
		if (value) values.set(key, plainValue(value));
	}
	return values;
}

export async function readStringSetting(
	id: string,
	kind: "Search" | "Extension",
): Promise<string | undefined> {
	const value = await readSetting(id, kind);
	return value?.type === "String" ? value.data : undefined;
}

export async function readBooleanSetting(
	id: string,
	kind: "Search" | "Extension",
): Promise<boolean | undefined> {
	const value = await readSetting(id, kind);
	return value?.type === "Boolean" ? value.data : undefined;
}
