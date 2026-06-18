package android.webkit;

import java.io.InputStream;
import java.util.Map;

/**
 * Minimal {@code WebResourceResponse} stub.
 *
 * <p>Returned from {@link WebViewClient#shouldInterceptRequest(WebView, WebResourceRequest)}.
 * Extensions (e.g. comikey) construct it via the six-argument constructor used
 * below; the desktop runtime never serves a real response, but the class must be
 * instantiable so the extension can load.
 */
public class WebResourceResponse {

    public WebResourceResponse(
            String mimeType,
            String encoding,
            int statusCode,
            String reasonPhrase,
            Map<String, String> responseHeaders,
            InputStream data) {}

    public WebResourceResponse(String mimeType, String encoding, InputStream data) {}

    public void setStatusCodeAndReasonPhrase(int statusCode, String reasonPhrase) {}

    public void setResponseHeaders(Map<String, String> headers) {}

    public void setData(InputStream data) {}
}
