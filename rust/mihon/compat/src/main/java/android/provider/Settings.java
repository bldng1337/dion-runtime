package android.provider;

import android.content.ContentResolver;

/**
 * Minimal {@code android.provider.Settings} stub.
 *
 * <p>Extensions occasionally read system settings (e.g.
 * {@code Settings.Global.HTTP_PROXY}) when deciding how to make requests. No
 * real system settings exist on the desktop JVM, so {@link Global#getString}
 * returns {@code null}; the class (and its inner {@code Global}) must be
 * loadable so the extension class referencing it can load.
 */
public final class Settings {

    private Settings() {
    }

    /** Namespace for global/system-wide settings (mirrors Android). */
    public static final class Global {

        private Global() {
        }

        /**
         * @return always {@code null}; no system settings table exists on the JVM
         */
        public static String getString(ContentResolver cr, String name) {
            return null;
        }
    }
}
