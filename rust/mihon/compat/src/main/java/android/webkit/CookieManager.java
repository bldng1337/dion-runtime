package android.webkit;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Minimal CookieManager stub with in-memory cookie storage.
 */
public class CookieManager {

    private static final CookieManager INSTANCE = new CookieManager();

    private final Map<String, List<String>> mCookies = new HashMap<>();
    private boolean mAcceptCookie = true;
    private boolean mAcceptThirdPartyCookies = true;

    private CookieManager() {
    }

    /**
     * Get the singleton CookieManager instance.
     */
    public static CookieManager getInstance() {
        return INSTANCE;
    }

    /**
     * Sets a cookie for the given URL.
     */
    public void setCookie(String url, String value) {
        if (value == null || value.isEmpty()) return;
        if (!mAcceptCookie) return;

        String host = extractHost(url);
        if (host == null) return;

        synchronized (mCookies) {
            List<String> cookies = mCookies.computeIfAbsent(host, k -> new ArrayList<>());
            String cookieName = extractCookieName(value);
            if (cookieName != null) {
                cookies.removeIf(c -> cookieName.equals(extractCookieName(c)));
            }
            cookies.add(value);
        }
    }

    /**
     * Gets cookies for the given URL as a single string.
     * Returns null if no cookies are stored for the URL.
     */
    public String getCookie(String url) {
        String host = extractHost(url);
        if (host == null) return null;

        synchronized (mCookies) {
            List<String> cookies = mCookies.get(host);
            if (cookies == null || cookies.isEmpty()) return null;

            StringBuilder sb = new StringBuilder();
            for (String cookie : cookies) {
                if (sb.length() > 0) sb.append("; ");
                String nameValue = cookie.split(";")[0].trim();
                sb.append(nameValue);
            }
            return sb.toString();
        }
    }

    /**
     * Sets whether the application's WebView instances should send and accept cookies.
     */
    public void setAcceptCookie(boolean accept) {
        mAcceptCookie = accept;
    }

    /**
     * Gets whether the application's WebView instances send and accept cookies.
     */
    public boolean acceptCookie() {
        return mAcceptCookie;
    }

    /**
     * Sets whether the WebView should accept third-party cookies.
     */
    public void setAcceptThirdPartyCookies(Object webView, boolean accept) {
        mAcceptThirdPartyCookies = accept;
    }

    /**
     * Gets whether the WebView should accept third-party cookies.
     */
    public boolean acceptThirdPartyCookies(Object webView) {
        return mAcceptThirdPartyCookies;
    }

    /**
     * Removes all cookies.
     */
    public void removeAllCookie() {
        synchronized (mCookies) {
            mCookies.clear();
        }
    }

    /**
     * Removes all session cookies (cookies without a max-age or expiry).
     * In this simplified stub, all cookies are treated as session cookies.
     */
    public void removeSessionCookie() {
        synchronized (mCookies) {
            mCookies.clear();
        }
    }

    /**
     * Gets whether there are any stored cookies.
     */
    public boolean hasCookies() {
        synchronized (mCookies) {
            return !mCookies.isEmpty();
        }
    }

    /**
     * Ensures all cookies are written to persistent storage.
     * No-op in this stub since cookies are kept in memory only.
     */
    public void flush() {
        // No persistent storage in stub
    }

    // ========== Internal Helpers ==========

    /**
     * Extract the host from a URL string for use as a cookie storage key.
     */
    private String extractHost(String url) {
        if (url == null || url.isEmpty()) return null;
        try {
            return new URI(url).getHost();
        } catch (URISyntaxException e) {
            // Fallback: strip scheme, path, and port
            String host = url;
            int schemeEnd = host.indexOf("://");
            if (schemeEnd >= 0) {
                host = host.substring(schemeEnd + 3);
            }
            int pathStart = host.indexOf('/');
            if (pathStart >= 0) {
                host = host.substring(0, pathStart);
            }
            int portStart = host.lastIndexOf(':');
            if (portStart >= 0) {
                host = host.substring(0, portStart);
            }
            return host.isEmpty() ? null : host;
        }
    }

    /**
     * Extract the cookie name (the part before the first '=') from a cookie string.
     */
    private String extractCookieName(String cookie) {
        if (cookie == null) return null;
        int eqIdx = cookie.indexOf('=');
        if (eqIdx < 0) return null;
        return cookie.substring(0, eqIdx).trim();
    }
}