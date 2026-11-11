// The small `@libs/*` helpers LNReader injects into plugins, copied from the
// app (src/plugins/{types,helpers}) so plugins see identical values.

export const NovelStatus = {
	Unknown: "Unknown",
	Ongoing: "Ongoing",
	Completed: "Completed",
	Licensed: "Licensed",
	PublishingFinished: "Publishing Finished",
	Cancelled: "Cancelled",
	OnHiatus: "On Hiatus",
	STUB: "STUB",
	Inactive: "Inactive",
} as const;

export const FilterTypes = {
	TextInput: "Text",
	Picker: "Picker",
	CheckboxGroup: "Checkbox",
	Switch: "Switch",
	ExcludableCheckboxGroup: "XCheckbox",
} as const;

export const defaultCover =
	"https://github.com/lnreader/lnreader-plugins/blob/master/public/static/coverNotAvailable.webp?raw=true";

export const isUrlAbsolute = (url: string): boolean => {
	if (url) {
		if (url.indexOf("//") === 0) return true; // protocol-relative
		if (url.indexOf("://") === -1) return false; // no protocol
		if (url.indexOf(".") === -1) return false; // no TLD
		if (url.indexOf("/") === -1) return false; // no slash
		if (url.indexOf(":") > url.indexOf("/")) return false; // colon after slash
		if (url.indexOf("://") < url.indexOf(".")) return true; // protocol before dot
	}
	return false;
};

function isUtf8(charset?: string): boolean {
	return !charset || /^utf-?8$/i.test(charset);
}

// `urlencode`: the app ships the npm package (iconv-lite backed). Only UTF-8
// encoding is supported here; decoding uses the host TextDecoder, which knows
// the WHATWG legacy encodings (gbk, shift_jis, ...).
export const urlencode = {
	encode(value: string, charset?: string): string {
		if (!isUtf8(charset)) {
			console.warn(
				`urlencode.encode: ${charset} is not supported, using utf-8`,
			);
		}
		return encodeURIComponent(value);
	},
	decode(value: string, charset?: string): string {
		if (isUtf8(charset)) return decodeURIComponent(value);
		const bytes: number[] = [];
		for (let i = 0; i < value.length; i++) {
			const char = value[i];
			if (char === "%" && i + 2 < value.length) {
				bytes.push(Number.parseInt(value.slice(i + 1, i + 3), 16));
				i += 2;
			} else if (char === "+") {
				bytes.push(0x20);
			} else {
				for (const byte of new TextEncoder().encode(char)) bytes.push(byte);
			}
		}
		return new TextDecoder(charset).decode(new Uint8Array(bytes));
	},
};
