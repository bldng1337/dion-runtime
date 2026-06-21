package android.webkit;

import android.content.Context;

/**
 * Minimal {@code WebView} stub.
 *
 * <p>Mihon extensions that need to solve web challenges (e.g. comikey) construct
 * a {@code WebView} and drive it via a {@link WebViewClient}. That flow is not
 * used on the desktop JVM, but the class must be constructable so the extension
 * can load. All methods are no-ops / defaults.
 */
public class WebView {

    public WebView(Context context) {}

    public WebSettings getSettings() {
        return new WebSettings();
    }

    public void setWebViewClient(WebViewClient client) {}

    public void setWebChromeClient(WebChromeClient client) {}

    public void addJavascriptInterface(Object object, String name) {}

    public void removeJavascriptInterface(String name) {}

    public void loadUrl(String url) {}

    public void loadUrl(
        String url,
        java.util.Map<String, String> additionalHttpHeaders
    ) {}

    public void loadData(String data, String mimeType, String encoding) {}

    public void loadDataWithBaseURL(
        String baseUrl,
        String data,
        String mimeType,
        String encoding,
        String historyUrl
    ) {}

    public void reload() {}

    public boolean canGoBack() {
        return false;
    }

    public void goBack() {}

    public String getUrl() {
        return null;
    }

    public String getTitle() {
        return null;
    }

    public void evaluateJavascript(
        String script,
        ValueCallback<String> resultCallback
    ) {}

    public void post(Runnable action) {}

    public void setLayoutParams(android.view.ViewGroup.LayoutParams params) {}

    public void stopLoading() {}

    public void destroy() {}

    public void onPause() {}

    public void onResume() {}

    /**
     * Hardware layer type constant mirroring {@code View.LAYER_TYPE_HARDWARE}.
     * Extensions call {@link #setLayerType(int, Paint)} (typically with
     * {@link #LAYER_TYPE_SOFTWARE}) when driving a WebView to solve challenges.
     */
    public static final int LAYER_TYPE_NONE = 0;
    public static final int LAYER_TYPE_SOFTWARE = 1;
    public static final int LAYER_TYPE_HARDWARE = 2;

    public void setLayerType(int layerType, android.graphics.Paint paint) {}
}
