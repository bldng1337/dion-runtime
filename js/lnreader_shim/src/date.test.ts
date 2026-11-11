import { describe, expect, test } from "bun:test";
import { parseLegacyDate } from "./date.ts";

const local = (...parts: [number, number, number, number?, number?, number?]) =>
	new Date(
		parts[0],
		parts[1],
		parts[2],
		parts[3] ?? 0,
		parts[4] ?? 0,
		parts[5] ?? 0,
	).getTime();

describe("parseLegacyDate", () => {
	test("ISO-like dates with a space or a long fraction", () => {
		expect(parseLegacyDate("2023-05-01 12:34:56")).toBe(
			local(2023, 4, 1, 12, 34, 56),
		);
		expect(parseLegacyDate("2023-05-01 12:34:56.123456")).toBe(
			local(2023, 4, 1, 12, 34, 56) + 123,
		);
		expect(parseLegacyDate("2023-05-01T12:34:56.000000Z")).toBe(
			Date.UTC(2023, 4, 1, 12, 34, 56),
		);
		expect(parseLegacyDate("2023-05-01 12:34 +02:00")).toBe(
			Date.UTC(2023, 4, 1, 10, 34),
		);
		expect(parseLegacyDate("2023-5-1")).toBe(Date.UTC(2023, 4, 1));
	});

	test("month names", () => {
		expect(parseLegacyDate("May 1, 2023")).toBe(local(2023, 4, 1));
		expect(parseLegacyDate("1 May 2023")).toBe(local(2023, 4, 1));
		expect(parseLegacyDate("Thu Mar 07 2024")).toBe(local(2024, 2, 7));
		expect(parseLegacyDate("September 12, 2024 10:05 PM")).toBe(
			local(2024, 8, 12, 22, 5),
		);
		expect(parseLegacyDate("07-Mar-24")).toBe(local(2024, 2, 7));
		expect(parseLegacyDate("Mar 7, 2024 12:00 am GMT")).toBe(
			Date.UTC(2024, 2, 7),
		);
	});

	test("numeric dates", () => {
		expect(parseLegacyDate("2023/05/01")).toBe(local(2023, 4, 1));
		expect(parseLegacyDate("05/01/2023 08:00")).toBe(local(2023, 4, 1, 8));
		expect(parseLegacyDate("12/31/99")).toBe(local(1999, 11, 31));
	});

	test("garbage is NaN", () => {
		for (const text of [
			"",
			"2 days ago",
			"yesterday",
			"13/45/2023",
			"Foo 1, 2023",
		]) {
			expect(parseLegacyDate(text)).toBeNaN();
		}
	});
});
