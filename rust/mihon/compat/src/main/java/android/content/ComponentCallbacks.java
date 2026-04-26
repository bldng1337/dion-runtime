package android.content;

import android.content.res.Configuration;

/**
 * Minimal ComponentCallbacks stub.
 */
public interface ComponentCallbacks {
    void onConfigurationChanged(Configuration newConfig);
    void onLowMemory();
}
