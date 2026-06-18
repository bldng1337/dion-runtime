package android.webkit;

import java.util.Map;

/**
 * Minimal {@code WebResourceRequest} stub.
 *
 * <p>Passed to {@link WebViewClient#shouldInterceptRequest(WebView, WebResourceRequest)}.
 * The desktop runtime never actually intercepts requests, but the interface must
 * be resolvable for extensions that override the method.
 */
public interface WebResourceRequest {
    android.net.Uri getUrl();
    Map<String, String> getRequestHeaders();
    String getMethod();
    boolean hasGesture();
    boolean isForMainFrame();
    boolean isRedirect();
}
