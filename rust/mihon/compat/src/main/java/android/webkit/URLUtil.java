package android.webkit;

/**
 * Minimal {@code URLUtil} stub mirroring the subset of
 * {@code android.webkit.URLUtil} used by extensions.
 *
 * <p>Extensions call {@link #isValidUrl(String)} to validate user/remote URLs
 * (e.g. before opening them). The real Android implementation accepts a range
 * of schemes; this stub treats {@code http}, {@code https}, and {@code file}
 * URLs as valid, which covers extension usage.
 */
public final class URLUtil {

    private URLUtil() {
    }

    /**
     * Returns {@code true} if the given URL uses a recognized scheme.
     *
     * @param url the URL to check (may be {@code null})
     * @return {@code true} for {@code http(s):} / {@code file:} URLs,
     *     {@code false} otherwise (including {@code null})
     */
    public static boolean isValidUrl(String url) {
        if (url == null) {
            return false;
        }
        String lower = url.toLowerCase();
        return lower.startsWith("http://")
            || lower.startsWith("https://")
            || lower.startsWith("file://");
    }
}
