import type { ReleaseStatus } from "@dion-js/runtime-types/runtime";

export function encodeURL(str: string) {
  return encodeURIComponent(str);
}

export function deduplicate<T>(arr: T[]): T[] {
  return arr.filter((e, i) => arr.indexOf(e) === i);
}

export function makeFormdata(
  data: { [key: string]: unknown },
  seperator: string = "&"
) {
  return Object.keys(data)
    .map((key) => stringifypair(key, `${data[key]}`))
    .filter((e) => e !== "")
    .join(seperator);
}

export function isList(a: unknown): a is unknown[] {
  return Array.isArray(a);
}

export function trywrap<T>(a: () => T): T | undefined {
  try {
    return a();
  } catch (e) {
    log("Error in trywrap", (e as Error).message);
    return undefined;
  }
}

function stringifypair(a: string, b: string) {
  if (b.length === 0) return "";
  return `${a}=${b}`;
}

export function makeurl(
  baseurl: string,
  query: { [key: string]: unknown },
  seperator: string = "&"
) {
  return (
    baseurl +
    "?" +
    Object.keys(query)
      .filter((a) => query[a] !== undefined)
      .map((a) =>
        isList(query[a])
          ? (query[a] as Array<unknown>)
              .map((e: unknown) => stringifypair(a, `${e}`))
              .filter((e) => e !== "")
              .join(seperator)
          : stringifypair(a, `${query[a]}`)
      )
      .filter((e) => e !== "")
      .join(seperator)
  );
}

// export async function wait(ms: number): Promise<void> {
//   return new Promise((resolve, reject) => {
//     setTimeout(resolve, ms);
//   });
// }

// var lock: Promise<void> | undefined = undefined;
// export async function ratelimit(ms: number) {
//   if (isPromise(lock)) await lock;
//   lock = wait(ms);
// }

export function parseNumberwithSuffix(
  s: string,
  def?: number
): number | undefined {
  if (s === undefined || s == null) {
    return def;
  }
  let mult = 1;
  const lower = s.toLowerCase();
  if (lower.includes("k")) {
    mult = 1000;
    s = s.replaceAll("k", "");
    s = s.replaceAll("K", "");
  } else if (lower.includes("m")) {
    mult = 1000000;
    s = s.replaceAll("m", "");
    s = s.replaceAll("M", "");
  } else if (lower.includes("b")) {
    mult = 1000000000;
    s = s.replaceAll("b", "");
    s = s.replaceAll("B", "");
  } else if (lower.includes("t")) {
    mult = 1000000000000;
    s = s.replaceAll("t", "");
    s = s.replaceAll("T", "");
  }

  const num = Number(s.replaceAll(",", "").replaceAll(".", ""));
  if (Number.isNaN(num)) {
    return def;
  }
  return num * mult;
}

export function toStatus(s: string | undefined): ReleaseStatus {
  if (s === undefined || s === null || s === "") return "Unknown";
  const lower = s.toLowerCase();
  if (lower.includes("ongoing")) return "Releasing";
  if (lower.includes("releasing")) return "Releasing";
  if (lower.includes("complete")) return "Complete";
  if (lower.includes("finished")) return "Complete";
  if (lower.includes("airing")) return "Releasing";
  if (lower.includes("upcoming")) return "Releasing";
  if (lower.includes("aired")) return "Complete";
  return "Unknown";
}

export function log(...args: unknown[]) {
  console.log(args.map((a) => JSON.stringify(a)).join(" "));
}

export function logwarn(...args: unknown[]) {
  console.warn(args.map((a) => JSON.stringify(a)).join(" "));
}

export function logerr(...args: unknown[]) {
  console.error(args.map((a) => JSON.stringify(a)).join(" "));
}
