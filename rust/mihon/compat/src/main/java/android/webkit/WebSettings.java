package android.webkit;

/**
 * Minimal {@code WebSettings} stub returned by {@link WebView#getSettings()}.
 * All setters are no-ops; the values are not stored.
 */
public class WebSettings {

    public void setDomStorageEnabled(boolean flag) {}

    public void setJavaScriptEnabled(boolean flag) {}

    public void setJavaScriptCanOpenWindowsAutomatically(boolean flag) {}

    public void setBlockNetworkImage(boolean flag) {}

    public void setBlockNetworkLoads(boolean flag) {}

    public void setLoadsImagesAutomatically(boolean flag) {}

    public void setDatabaseEnabled(boolean flag) {}

    public void setLoadWithOverviewMode(boolean flag) {}

    public void setUseWideViewPort(boolean flag) {}

    public void setSupportZoom(boolean support) {}

    public void setBuiltInZoomControls(boolean enabled) {}

    public void setDisplayZoomControls(boolean enabled) {}

    public void setCacheMode(int mode) {}

    public void setAppCacheEnabled(boolean flag) {}

    public void setGeolocationEnabled(boolean flag) {}

    public void setUserAgentString(String ua) {}

    public String getUserAgentString() {
        return "";
    }
}
