// `@libs/storage` as LNReader provides it (src/plugins/helpers/storage.ts).
//
// The app backs it with synchronous MMKV. Dion's persistent stores are async,
// so the plugin's items are loaded into memory once (`PluginStorage.open`) and
// every change is written back in the background.

import { type Cache, openKvCache } from "cache";

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
	readonly #cache: Cache | undefined;
	#pending: Promise<unknown> = Promise.resolve();

	private constructor(cache: Cache | undefined) {
		this.#cache = cache;
	}

	static async open(name: string): Promise<PluginStorage> {
		let cache: Cache | undefined;
		try {
			cache = openKvCache(name);
		} catch (error) {
			console.warn(`LNReader storage is not persistent: ${error}`);
		}
		const storage = new PluginStorage(cache);
		if (cache) {
			for (const key of await cache.keys()) {
				const item = await cache.get(key);
				if (item && typeof item === "object" && "value" in item) {
					storage.#items.set(key, item as StoredItem);
				}
			}
		}
		return storage;
	}

	/** Resolves once every background write issued so far has finished. */
	flush(): Promise<unknown> {
		return this.#pending;
	}

	#persist(write: (cache: Cache) => Promise<unknown>): void {
		const cache = this.#cache;
		if (!cache) return;
		this.#pending = this.#pending
			.then(() => write(cache))
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
		// Round-trip through JSON like the app does, so stored values never
		// keep references to live plugin objects.
		const stored = JSON.parse(JSON.stringify(item)) as StoredItem;
		this.#persist((cache) => cache.set(key, stored));
	}

	get(key: string, raw?: boolean): unknown {
		if (this.#transient.has(key)) {
			const value = this.#transient.get(key);
			return raw ? { created: new Date(0).toISOString(), value } : value;
		}
		const item = this.#items.get(key);
		if (!item) return undefined;
		if (item.expires) {
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
			this.#persist((cache) => cache.delete(key));
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
