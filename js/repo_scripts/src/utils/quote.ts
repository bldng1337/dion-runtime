/** A YAML scalar for `value`: plain when that is unambiguous, otherwise a
 * double-quoted (JSON) string so e.g. a branch name cannot inject YAML. */
export function yamlScalar(value: string): string {
	return /^[A-Za-z0-9._/-]+$/.test(value) ? value : JSON.stringify(value);
}

/** A POSIX shell word for `value`: unquoted when it is only safe
 * characters, otherwise single-quoted (no expansion happens inside). */
export function shellWord(value: string): string {
	if (/^[A-Za-z0-9._/:@%+=-]+$/.test(value)) return value;
	return `'${value.replaceAll("'", `'\\''`)}'`;
}

/** `url` when it uses one of `schemes` (e.g. `["http:", "https:"]`),
 * otherwise "". Keeps `javascript:` and similar URLs from index data out of
 * generated `href`/`src` attributes. */
export function safeUrl(url: string | undefined, schemes: string[]): string {
	const trimmed = url?.trim();
	if (!trimmed) return "";
	try {
		return schemes.includes(new URL(trimmed).protocol) ? trimmed : "";
	} catch {
		return "";
	}
}
