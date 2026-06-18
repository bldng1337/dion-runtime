package android.webkit;

import android.graphics.Bitmap;

/**
 * Minimal {@code WebViewClient} stub.
 *
 * <p>Mihon extensions that solve web challenges (e.g. comikey) subclass
 * {@code WebViewClient} and override {@link #onPageStarted(WebView, String, Bitmap)}
 * and {@link #shouldInterceptRequest(WebView, WebResourceRequest)}. Those paths
 * are not exercised on the desktop JVM, but the class must be loadable so the
 * extension can be instantiated.
 */
public class WebViewClient {

    public WebViewClient() {}

    public void onPageStarted(WebView view, String url, Bitmap favicon) {}

    public void onPageFinished(WebView view, String url) {}

    public android.webkit.WebResourceResponse shouldInterceptRequest(
            WebView view, WebResourceRequest request) {
        return null;
    }

    @Deprecated
    public android.webkit.WebResourceResponse shouldInterceptRequest(
            WebView view, String url) {
        return null;
    }

    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        return false;
    }

    public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
        return false;
    }
}
