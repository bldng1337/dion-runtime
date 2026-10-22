import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

/**
 * Post-processing for the specta-generated files.
 *
 * The Rust models carry real `chrono::DateTime<Utc>` values, but upstream
 * specta-typescript can only export chrono types as `string`. The runtime
 * actually accepts more on the extension boundary: ISO-8601 strings
 * (epoch digit strings and epoch numbers are parsed leniently too), and
 * anything with a `toJSON()` method — `Temporal.Instant`,
 * `Temporal.ZonedDateTime`, `Date`, ... — which the executor converts via
 * `toJSON()` before JSON serialization. This pass widens the generated
 * types (and the valibot validators to match) so the TS surface matches
 * runtime behavior. Timestamps *returned* by the runtime are always
 * ISO-8601 strings.
 *
 * Every replacement is asserted, so a generator change that alters these
 * shapes fails loudly here instead of silently regressing.
 */
export function patchTimestampTypes() {
	const genDir = join(import.meta.dir, "gen", "dion_runtime");

	{
		const path = join(genDir, "generated_types.ts");
		let content = readFileSync(path, "utf8");
		content = insertBeforeFirstExport(
			content,
			`/**
 * A timestamp as it may be passed to the runtime: an ISO-8601 string
 * (preferred), an epoch-seconds/milliseconds number or digit string
 * (parsed leniently), or an object whose \`toJSON()\` returns an ISO-8601
 * string — \`Temporal.Instant\`, \`Temporal.ZonedDateTime\`, \`Date\`, ...
 * The runtime calls \`toJSON()\` before serializing. Timestamps returned
 * by the runtime are always ISO-8601 strings.
 */
export type TimestampInput = string | number | TimestampObject;

/** Anything with a \`toJSON()\` returning an ISO-8601 string. */
export interface TimestampObject {
	toJSON(): string;
}
`,
		);
		content = replaceOnce(
			content,
			"timestamp?: string | null",
			"timestamp?: TimestampInput | null",
			path,
		);
		content = replaceOnce(
			content,
			"timestamp: string; display: TimestampType",
			"timestamp: TimestampInput; display: TimestampType",
			path,
		);
		writeFileSync(path, content);
	}

	{
		const path = join(genDir, "generated_validators.ts");
		let content = readFileSync(path, "utf8");
		content = replaceOnce(
			content,
			'Row as RowType } from "./generated_types.js";',
			'Row as RowType, TimestampObject as TimestampObjectType } from "./generated_types.js";',
			path,
		);
		content = insertBeforeFirstExport(
			content,
			'export const timestampInput = v.union([v.string(), v.number(), v.custom<TimestampObjectType>((input) => typeof input === "object" && input !== null && typeof (input as TimestampObjectType).toJSON === "function")]);\n\n',
		);
		content = replaceOnce(
			content,
			"timestamp: v.optional(v.nullable(v.string()))",
			"timestamp: v.optional(v.nullable(timestampInput))",
			path,
		);
		content = replaceOnce(
			content,
			"timestamp: v.string(), display: TimestampType",
			"timestamp: timestampInput, display: TimestampType",
			path,
		);
		writeFileSync(path, content);
	}
}

function insertBeforeFirstExport(content: string, block: string): string {
	const index = content.indexOf("\nexport ");
	if (index === -1) {
		throw new Error("patchTimestampTypes: no export found to anchor on");
	}
	return `${content.slice(0, index)}\n${block}${content.slice(index + 1)}`;
}

function replaceOnce(
	content: string,
	from: string,
	to: string,
	path: string,
): string {
	const first = content.indexOf(from);
	if (first === -1) {
		throw new Error(
			`patchTimestampTypes: anchor not found in ${path}: ${JSON.stringify(from)} — the generator output changed; update this patch`,
		);
	}
	if (content.indexOf(from, first + 1) !== -1) {
		throw new Error(
			`patchTimestampTypes: anchor is ambiguous in ${path}: ${JSON.stringify(from)}`,
		);
	}
	return content.replace(from, to);
}
