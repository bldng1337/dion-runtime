package android.util;

import java.util.LinkedHashMap;

/**
 * Minimal {@code android.util.LruCache} stub.
 *
 * <p>Some extensions cache parsed responses in an {@code LruCache}. This stub
 * provides the linked-hash-map-backed {@code get}/{@code put} API they use,
 * silently ignoring the size budget (the desktop JVM has ample heap, so strict
 * eviction is unnecessary for loading/testing extensions).
 *
 * @param <K> key type
 * @param <V> value type
 */
public class LruCache<K, V> {

    private final LinkedHashMap<K, V> map = new LinkedHashMap<>(16, 0.75f, true);

    /**
     * @param maxSize ignored (accepted for API compatibility); eviction is a no-op
     */
    public LruCache(int maxSize) {
    }

    public final V get(K key) {
        if (key == null) {
            return null;
        }
        synchronized (map) {
            return map.get(key);
        }
    }

    public final V put(K key, V value) {
        if (key == null || value == null) {
            return null;
        }
        synchronized (map) {
            return map.put(key, value);
        }
    }
}
