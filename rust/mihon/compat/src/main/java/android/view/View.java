package android.view;

/**
 * Minimal {@code android.view.View} stub.
 *
 * <p>Some extensions (notably configurable sources and WebView-based video
 * resolvers) reference {@code View} directly — e.g. toggling a button's enabled
 * state or finding a child view. None of these UIs are ever rendered on the
 * desktop JVM, but the class and the referenced methods must exist for the
 * extension to load and link.
 */
public class View {

    /** Visibility constant (mirrors the Android value). */
    public static final int VISIBLE = 0;
    /** Visibility constant (mirrors the Android value). */
    public static final int INVISIBLE = 4;
    /** Visibility constant (mirrors the Android value). */
    public static final int GONE = 8;

    public View() {
    }

    /**
     * @param id ignored; no view hierarchy is ever populated on the JVM
     * @return always {@code null}
     */
    public <T extends View> T findViewById(int id) {
        return null;
    }

    public View getRootView() {
        return this;
    }

    public void setEnabled(boolean enabled) {
        // no-op
    }
}
