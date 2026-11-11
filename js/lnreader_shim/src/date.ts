// boa's Date.parse only understands ISO 8601 and the toString/toUTCString
// formats. Browsers (where plugins are developed and tested) also accept the
// legacy formats sites print, like "2023-05-01 12:34:56" or "May 1, 2023",
// and plugins feed scraped dates straight into `new Date(...)`. This installs
// a `Date` that falls back to a lenient parser following V8's rules: dates
// without a time zone are local time, numeric dates are month/day/year.

const MONTHS = [
	"jan",
	"feb",
	"mar",
	"apr",
	"may",
	"jun",
	"jul",
	"aug",
	"sep",
	"oct",
	"nov",
	"dec",
];

const NativeDate = Date;

interface Parts {
	year: number;
	month: number; // 0-based
	day: number;
	hour: number;
	minute: number;
	second: number;
	millisecond: number;
	/** Offset from UTC in minutes, or undefined for local time. */
	offset?: number;
}

function toTime(parts: Parts): number {
	const { year, month, day, hour, minute, second, millisecond, offset } = parts;
	if (
		month < 0 ||
		month > 11 ||
		day < 1 ||
		day > 31 ||
		hour > 24 ||
		minute > 59 ||
		second > 59
	) {
		return Number.NaN;
	}
	if (offset === undefined) {
		return new NativeDate(
			year,
			month,
			day,
			hour,
			minute,
			second,
			millisecond,
		).getTime();
	}
	return (
		NativeDate.UTC(year, month, day, hour, minute, second, millisecond) -
		offset * 60_000
	);
}

function parseOffset(zone: string | undefined): number | undefined {
	if (!zone) return undefined;
	if (/^(z|utc|gmt)$/i.test(zone)) return 0;
	const match = zone.match(/^(?:utc|gmt)?([+-])(\d{1,2}):?(\d{2})?$/i);
	if (!match) return undefined;
	const minutes = Number(match[2]) * 60 + Number(match[3] ?? 0);
	return match[1] === "-" ? -minutes : minutes;
}

function fraction(digits: string | undefined): number {
	return digits ? Math.floor(Number(`0.${digits}`) * 1000) : 0;
}

function twoDigitYear(year: number, digits: number): number {
	if (digits > 2) return year;
	return year < 50 ? 2000 + year : 1900 + year;
}

/** Lenient parse of the legacy formats; NaN when nothing matches. */
export function parseLegacyDate(input: string): number {
	const text = input.trim().replace(/\s+/g, " ");
	if (!text) return Number.NaN;

	// ISO-like with a space separator or a long fraction.
	const iso = text.match(
		/^([+-]?\d{4,6})-(\d{1,2})-(\d{1,2})(?:[T ](\d{1,2}):(\d{2})(?::(\d{2})(?:[.,](\d+))?)? ?(z|utc|gmt|[+-]\d{2}:?\d{2})?)?$/i,
	);
	if (iso) {
		const hasTime = iso[4] !== undefined;
		return toTime({
			year: Number(iso[1]),
			month: Number(iso[2]) - 1,
			day: Number(iso[3]),
			hour: Number(iso[4] ?? 0),
			minute: Number(iso[5] ?? 0),
			second: Number(iso[6] ?? 0),
			millisecond: fraction(iso[7]),
			// Like ISO: date-only is UTC, date-time without a zone is local.
			offset: hasTime ? parseOffset(iso[8]) : (parseOffset(iso[8]) ?? 0),
		});
	}

	let rest = ` ${text} `;
	let hour = 0;
	let minute = 0;
	let second = 0;
	let millisecond = 0;
	const time = rest.match(
		/[ T,](\d{1,2}):(\d{2})(?::(\d{2})(?:[.,](\d+))?)? ?([ap]\.?m\.?)?(?=[ ,+-]|$)/i,
	);
	if (time) {
		hour = Number(time[1]);
		minute = Number(time[2]);
		second = Number(time[3] ?? 0);
		millisecond = fraction(time[4]);
		const meridiem = time[5]?.replace(/\./g, "").toLowerCase();
		if (meridiem) {
			if (hour < 1 || hour > 12) return Number.NaN;
			hour = (hour % 12) + (meridiem === "pm" ? 12 : 0);
		}
		rest = rest.replace(time[0], " ");
	}

	let offset: number | undefined;
	const zone = rest.match(
		/ ((?:utc|gmt)?[+-]\d{1,2}:?\d{2}|utc|gmt|z)(?= |$)/i,
	);
	if (zone) {
		offset = parseOffset(zone[1]);
		rest = rest.replace(zone[0], " ");
	}
	// Drop weekday names and parenthesized zone names ("(Central European ...)").
	rest = rest.replace(/\([^)]*\)/g, " ");

	const monthName = rest.match(/(?:^|[^a-z])([a-z]{3,})\.?(?=[^a-z]|$)/gi);
	let month = -1;
	for (const word of monthName ?? []) {
		const name = word.replace(/[^a-z]/gi, "").toLowerCase();
		const index = MONTHS.indexOf(name.slice(0, 3));
		if (
			index >= 0 &&
			(name.length === 3 || name.startsWith(MONTHS[index] ?? ""))
		) {
			month = index;
			break;
		}
	}
	const numbers = [...rest.matchAll(/\d+/g)].map((m) => m[0]);

	let year: number;
	let day: number;
	if (month >= 0) {
		// "May 1, 2023", "1 May 2023", "Thu Mar 07 2024", "07-Mar-24"
		if (numbers.length < 2) return Number.NaN;
		const yearIndex = numbers.findIndex((n) => n.length >= 3 || Number(n) > 31);
		const yi = yearIndex >= 0 ? yearIndex : numbers.length - 1;
		const yearText = numbers[yi] ?? "";
		year = twoDigitYear(Number(yearText), yearText.length);
		day = Number(numbers.find((_, i) => i !== yi));
	} else {
		// Numeric: "2023/05/01", "05/01/2023" (month first), "01.05.2023"
		const numeric = rest.match(/(\d{1,4})[/.-](\d{1,2})[/.-](\d{1,4})/);
		if (!numeric) return Number.NaN;
		const [a, b, c] = [numeric[1] ?? "", numeric[2] ?? "", numeric[3] ?? ""];
		if (a.length >= 3) {
			year = Number(a);
			month = Number(b) - 1;
			day = Number(c);
		} else {
			month = Number(a) - 1;
			day = Number(b);
			year = twoDigitYear(Number(c), c.length);
		}
	}
	return toTime({
		year,
		month,
		day,
		hour,
		minute,
		second,
		millisecond,
		offset,
	});
}

function parse(value: unknown): number {
	const native = NativeDate.parse(value as string);
	if (!Number.isNaN(native) || typeof value !== "string") return native;
	return parseLegacyDate(value);
}

/** Replaces the global `Date` with one using the lenient parser. */
export function installLenientDate(): void {
	const scope = globalThis as { Date: DateConstructor };
	if ((scope.Date as unknown as { lenient?: boolean }).lenient) return;
	function LenientDate(this: unknown, ...args: unknown[]): unknown {
		if (!new.target) return NativeDate();
		if (args.length === 1 && typeof args[0] === "string") {
			return Reflect.construct(NativeDate, [parse(args[0])], new.target);
		}
		return Reflect.construct(NativeDate, args, new.target);
	}
	Object.setPrototypeOf(LenientDate, NativeDate);
	Object.defineProperties(LenientDate, {
		prototype: { value: NativeDate.prototype },
		parse: { value: parse, writable: true, configurable: true },
		lenient: { value: true },
	});
	scope.Date = LenientDate as unknown as DateConstructor;
}
