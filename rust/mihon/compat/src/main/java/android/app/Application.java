package android.app;

import android.content.ContextWrapper;

/**
 * Minimal {@code Application} stub for Mihon extensions.
 *
 * <p>Mirrors the real Android hierarchy: {@code Application extends ContextWrapper}.
 * All {@link android.content.Context} method implementations are inherited from
 * {@link ContextWrapper}. The runtime's {@code FakeApplication} overrides the
 * methods that need real behaviour.
 */
public class Application extends ContextWrapper {

    public Application() {
        super();
    }
}
