package android.app;

import android.content.Intent;
import android.os.Bundle;

/**
 * Minimal {@code android.app.Activity} stub.
 *
 * <p>Some extensions define a {@code *UrlActivity} that deep-links a specific
 * search/entry URL into the app; these extend {@code Activity}. Such
 * activities are never started on the desktop JVM, but the base class must
 * exist (with the methods the subclass overrides/calls) for the extension to
 * load. {@code getIntent}/{@code onCreate}/{@code finish} are no-ops returning
 * harmless defaults.
 */
public class Activity {

    public Activity() {
    }

    /**
     * @return always {@code null}; no real activity launch happens on the JVM
     */
    public Intent getIntent() {
        return null;
    }

    public void onCreate(Bundle savedInstanceState) {
        // no-op
    }

    public void finish() {
        // no-op
    }
}
