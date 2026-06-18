package android.webkit;

/**
 * Minimal {@code ValueCallback} stub used by {@link WebView#evaluateJavascript}.
 *
 * @param <T> the value type
 */
public interface ValueCallback<T> {
    void onReceiveValue(T value);
}
