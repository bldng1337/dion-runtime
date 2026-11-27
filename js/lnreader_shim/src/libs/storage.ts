// `@libs/storage` as LNReader provides it (src/plugins/helpers/storage.ts).
//
// The app backs it with synchronous MMKV. Dion's persistent stores are async,
// so the plugin's items are loaded into memory once (`PluginStorage.open`) and
// every change is written back in the background.
//
// Items live in a JSON file in the extension's data dir rather than in a
// `cache` store: clearing an extension's cache must not wipe plugin data
// (logins, settings plugins keep for themselves).

import { type Cache, openKvCache } from "cache";
import {
	exists,
	getDataDir,
	joinPaths,
	readTextFile,
	writeTextFile,
} from "filesystem";

interface StoredItem {
	created: string | Date;
	value: unknown;
	expires?: number;
}

export class PluginStorage {
	readonly #items = new Map<string, StoredItem>();
	// Values the host owns (plugin settings): readable through `get` like in
	// the app, but never persisted here.
	readonly #transient = new Map<string, unknown>();
	readonly #path: string | undefined;
	#pending: Promise<unknown> = Promise.resolve();
	#dirty = false;

	private constructor(path: string | undefined) {
		this.#path = path;
	}

	static async open(name: string): Promise<PluginStorage> {
		let path: string | undefined;
		try {
			path = joinPaths([getDataDir(), `${name}.storage.json`]);
		} catch (error) {
			console.warn(`LNReader storage is not persistent: ${error}`);
		}
		const storage = new PluginStorage(path);
		if (path && (await exists(path))) {
			try {
				const parsed = JSON.parse(await readTextFile(path)) as Record<
					string,
					StoredItem
				>;
				for (const [key, item] of Object.entries(parsed)) {
					if (item && typeof item === "object" && "value" in item) {
						storage.#items.set(key, item);
					}
				}
			} catch (error) {
				console.warn(`LNReader storage file is unreadable: ${error}`);
			}
		} else if (path) {
			await storage.#migrateFromCache(name);
		}
		return storage;
	}

	/** Earlier versions kept the items in a kv cache of the same name. */
	async #migrateFromCache(name: string): Promise<void> {
		let cache: Cache;
		try {
			cache = openKvCache(name);
		} catch {
			return;
		}
		for (const key of await cache.keys()) {
			const item = await cache.get(key);
			if (item && typeof item === "object" && "value" in item) {
				this.#items.set(key, item as StoredItem);
			}
		}
		if (this.#items.size > 0) {
			this.#schedulePersist();
			await this.flush();
			await cache.clear();
		}
	}

	/** Resolves once every background write issued so far has finished. */
	flush(): Promise<unknown> {
		return this.#pending;
	}

	/** Coalesces bursts of changes into one write of the whole file. */
	#schedulePersist(): void {
		const path = this.#path;
		if (!path) return;
		if (this.#dirty) return;
		this.#dirty = true;
		this.#pending = this.#pending
			.then(() => {
				this.#dirty = false;
				return writeTextFile(
					path,
					JSON.stringify(Object.fromEntries(this.#items)),
				);
			})
			.catch((error) =>
				console.warn(`LNReader storage write failed: ${error}`),
			);
	}

	setTransient(key: string, value: unknown): void {
		this.#transient.set(key, value);
	}

	set(key: string, value: unknown, expires?: Date | number): void {
		const item: StoredItem = {
			created: new Date().toISOString(),
			value,
			expires: expires instanceof Date ? expires.getTime() : expires,
		};
		this.#transient.delete(key);
		this.#items.set(key, item);
		// Persisted as JSON like the app does, so stored values never keep
		// references to live plugin objects once reloaded.
		this.#schedulePersist();
	}

	get(key: string, raw?: boolean): unknown {
		if (this.#transient.has(key)) {
			const value = this.#transient.get(key);
			return raw ? { created: new Date(0).toISOString(), value } : value;
		}
		const item = this.#items.get(key);
		if (!item) return undefined;
		// `expires: 0` is a timestamp too (already expired), not "no expiry".
		if (typeof item.expires === "number") {
			if (Date.now() > item.expires) {
				this.delete(key);
				return undefined;
			}
		}
		return raw ? { ...item } : item.value;
	}

	delete(key: string): void {
		this.#transient.delete(key);
		if (this.#items.delete(key)) {
			this.#schedulePersist();
		}
	}

	clearAll(): void {
		for (const key of this.getAllKeys()) this.delete(key);
	}

	getAllKeys(): string[] {
		return [...this.#items.keys()];
	}
}

/**
 * The app fills these from its WebView; Dion has none, so they stay empty.
 */
export class WebStorage {
	get(): unknown {
		return undefined;
	}
}
