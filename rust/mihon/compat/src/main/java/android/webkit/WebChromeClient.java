package android.webkit;

import android.graphics.Bitmap;

/**
 * Minimal {@code WebChromeClient} stub.
 *
 * <p>Extensions occasionally set a {@code WebChromeClient} on a {@link WebView}.
 * The desktop runtime never drives a WebView, but the class must be loadable.
 */
public class WebChromeClient {

    public WebChromeClient() {}

    public void onProgressChanged(WebView view, int newProgress) {}

    public void onReceivedTitle(WebView view, String title) {}

    public void onReceivedIcon(WebView view, Bitmap icon) {}
}
