package app.cash.quickjs;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Internal registry backing the Rhino {@link QuickJs#compile compile} /
 * {@link QuickJs#execute execute} shim.
 *
 * <p>The real QuickJs serializes QuickJS bytecode so a compiled script can be
 * cached and re-executed without its source. Rhino has no compatible bytecode
 * format, so {@link QuickJs#compile} stashes the (source, fileName) pair here
 * and hands back an opaque, unique {@code byte[]} token; {@link QuickJs#execute}
 * trades that token back in for the original source and re-evaluates it.
 *
 * <p>This is process-global and intentionally simple: extensions typically
 * compile a small helper script once and execute it many times, so the tokens
 * live for the QuickJs instance's lifetime. A monotonically-increasing id is
 * encoded into the token bytes (with a fixed magic prefix so unrelated
 * {@code byte[]}s are rejected).
 */
final class CompiledScripts {

    static final CompiledScripts INSTANCE = new CompiledScripts();

    private static final byte[] MAGIC = {0x51, 0x4a, 0x53, 0x43}; // "QJSC"

    private final Map<Integer, Entry> entries = new ConcurrentHashMap<>();
    private final AtomicInteger nextId = new AtomicInteger(1);

    private CompiledScripts() {}

    /** Stash {@code sourceCode}/{@code fileName} and return an opaque token. */
    byte[] register(String sourceCode, String fileName) {
        int id = nextId.getAndIncrement();
        entries.put(id, new Entry(sourceCode, fileName));
        byte[] token = new byte[MAGIC.length + 4];
        System.arraycopy(MAGIC, 0, token, 0, MAGIC.length);
        int v = id;
        token[MAGIC.length]     = (byte) (v >>> 24);
        token[MAGIC.length + 1] = (byte) (v >>> 16);
        token[MAGIC.length + 2] = (byte) (v >>> 8);
        token[MAGIC.length + 3] = (byte) v;
        return token;
    }

    /**
     * Resolve a token back to its source. Returns {@code null} if the token was
     * not produced by {@link #register} (e.g. real QuickJS bytecode).
     */
    Entry lookup(byte[] token) {
        if (token == null || token.length != MAGIC.length + 4) return null;
        for (int i = 0; i < MAGIC.length; i++) {
            if (token[i] != MAGIC[i]) return null;
        }
        int id =
            ((token[MAGIC.length]     & 0xFF) << 24) |
            ((token[MAGIC.length + 1] & 0xFF) << 16) |
            ((token[MAGIC.length + 2] & 0xFF) << 8)  |
             (token[MAGIC.length + 3] & 0xFF);
        return entries.get(id);
    }

    static final class Entry {
        final String first;  // sourceCode
        final String second; // fileName
        Entry(String first, String second) {
            this.first = first;
            this.second = second;
        }
    }
}
