package android.os;

/**
 * Minimal {@code android.os.Build} stub.
 *
 * <p>Extensions occasionally read {@link VERSION#SDK_INT} (e.g. to pick a code
 * path by Android version) or {@link VERSION#RELEASE} for user-agent strings.
 * The desktop runtime is not Android, so we report a recent stable API level
 * (34 / Android 14) and an empty release string; this is enough for extensions
 * that only use these values to select between equivalent code paths.
 */
public class Build {

    public static final String MANUFACTURER = "unknown";
    public static final String MODEL = "unknown";
    public static final String BRAND = "unknown";
    public static final String DEVICE = "unknown";
    public static final String PRODUCT = "unknown";
    public static final String HARDWARE = "unknown";
    public static final String FINGERPRINT = "unknown";
    public static final String ID = "unknown";
    public static final String DISPLAY = "unknown";
    public static final String BOARD = "unknown";
    public static final String HOST = "unknown";
    public static final String TYPE = "unknown";
    public static final String USER = "unknown";
    public static final String TIME = "0";

    /** Nested version information mirroring {@code android.os.Build.VERSION}. */
    public static class VERSION {
        /** The user-visible SDK level; report a recent stable API (Android 14). */
        public static final int SDK_INT = 34;

        public static final String SDK = "34";
        public static final String RELEASE = "";
        public static final String INCREMENTAL = "";
        public static final String CODENAME = "REL";

        /** Security patch date used by some user-agent builders. */
        public static final String SECURITY_PATCH = "";
    }

    /** Nested device manufacturer branding (rarely used by extensions). */
    public static class MANUFACTURER {}

    private Build() {}
}
