// Maps LNReader filters and plugin settings onto Dion settings.
//
// Filters become browse settings keyed by the filter key: the host owns their
// values and passes them to every browse/search call, which returns the merged
// definitions. An excludable checkbox group needs two lists, stored under
// `<key>` (include) and `<key>:exclude`. Plugin settings become
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

async function readSetting(id: string): Promise<SettingValue | undefined> {
	try {
		return (await getSetting(id, "Extension")).value;
	} catch {
		return undefined;
	}
}

/** Browse setting definitions for the plugin's filters. */
export function filterDefinitions(
	filters: Record<string, FilterDefinition> | undefined,
): Record<string, Setting> {
	const definitions: Record<string, Setting> = {};
	for (const [key, filter] of Object.entries(filters ?? {})) {
		for (const [id, definition] of filterToSettings(key, filter)) {
			definitions[id] = definition;
		}
	}
	return definitions;
}

/**
 * `definitions` with the host's values carried over by id where the value
 * type still matches. Settings missing from `definitions` are dropped, so
 * filters a plugin update removed disappear from the host as well.
 */
export function mergeSettings(
	definitions: Record<string, Setting>,
	values: Record<string, Setting>,
): Record<string, Setting> {
	const merged: Record<string, Setting> = {};
	for (const [id, definition] of Object.entries(definitions)) {
		const current = values[id];
		merged[id] =
			current && current.value.type === definition.value.type
				? { ...definition, value: current.value }
				: definition;
	}
	return merged;
}

/**
 * The plugin's filters with the browse settings' values, shaped like the
 * definitions the app passes to `popularNovels` (each keeps `type`/`value`).
 */
export function currentFilters(
	filters: Record<string, FilterDefinition> | undefined,
	settings: Record<string, Setting>,
): Record<string, FilterDefinition> | undefined {
	if (!filters) return undefined;
	const result: Record<string, FilterDefinition> = {};
	for (const [key, filter] of Object.entries(filters)) {
		let value: unknown = filter.value;
		const stored = plainValue(settings[key]?.value);
		switch (filter.type) {
			case FilterTypes.Switch:
				if (typeof stored === "boolean") value = stored;
				break;
			case FilterTypes.CheckboxGroup:
				if (Array.isArray(stored)) value = stored;
				break;
			case FilterTypes.ExcludableCheckboxGroup: {
				const exclude = plainValue(settings[key + EXCLUDE_SUFFIX]?.value);
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
		const value = await readSetting(key);
		if (value) values.set(key, plainValue(value));
	}
	return values;
}

export async function readStringSetting(
	id: string,
): Promise<string | undefined> {
	const value = await readSetting(id);
	return value?.type === "String" ? value.data : undefined;
}
