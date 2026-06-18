package android.util;

/**
 * Minimal {@code android.util.Log} stub.
 *
 * <p>Android extensions call {@code Log.d/i/w/e/v(tag, msg)} pervasively for
 * diagnostics. We forward those calls to the SLF4J/logback logger used by the
 * desktop runtime so the output is still visible, while matching the Android
 * {@code Log} API surface (each method also returns a message priority level,
 * as the real API does).
 */
public final class Log {

    private static final org.slf4j.Logger LOGGER = org.slf4j.LoggerFactory.getLogger("android.Log");

    private Log() {}

    public static int v(String tag, String msg) {
        LOGGER.trace("[{}] {}", tag, msg);
        return 2; // VERBOSE
    }

    public static int d(String tag, String msg) {
        LOGGER.debug("[{}] {}", tag, msg);
        return 3; // DEBUG
    }

    public static int i(String tag, String msg) {
        LOGGER.info("[{}] {}", tag, msg);
        return 4; // INFO
    }

    public static int w(String tag, String msg) {
        LOGGER.warn("[{}] {}", tag, msg);
        return 5; // WARN
    }

    public static int w(String tag, String msg, Throwable tr) {
        LOGGER.warn("[{}] {}: {}", tag, msg, tr);
        return 5;
    }

    public static int e(String tag, String msg) {
        LOGGER.error("[{}] {}", tag, msg);
        return 6; // ERROR
    }

    public static int e(String tag, String msg, Throwable tr) {
        LOGGER.error("[{}] {}: {}", tag, msg, tr);
        return 6;
    }

    /** Android's {@code Log.println} is occasionally called directly. */
    public static int println(int priority, String tag, String msg) {
        switch (priority) {
            case 2 -> LOGGER.trace("[{}] {}", tag, msg);
            case 3 -> LOGGER.debug("[{}] {}", tag, msg);
            case 4 -> LOGGER.info("[{}] {}", tag, msg);
            case 5 -> LOGGER.warn("[{}] {}", tag, msg);
            case 6, 7 -> LOGGER.error("[{}] {}", tag, msg);
            default -> LOGGER.info("[{}] {}", tag, msg);
        }
        return priority;
    }
}
