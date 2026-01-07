export function assert(
	condition: boolean,
	msg: string = "Extension error",
): asserts condition {
	if (!condition) {
		throw new Error(msg);
	}
}

export function assertisArray<T>(
	value: T | T[],
	msg: string = "Extension error",
): asserts value is T[] {
	assert(Array.isArray(value), msg);
}

export function getAssertisArray<T>(
	value: T | T[],
	msg: string = "Extension error",
): T[] {
	assert(Array.isArray(value), msg);
	return value;
}

export function assertDefined<T>(
	value: T,
	msg: string = "Extension error",
): asserts value is NonNullable<T> {
	assert(value !== undefined && value != null, msg);
}

export function getAssertDefined<T>(
	value: T | undefined | null,
	msg: string = "Extension error",
): NonNullable<T> {
	assert(value !== undefined && value != null, msg);
	return value;
}
