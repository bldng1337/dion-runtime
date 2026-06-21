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

    public View() {}

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

    public void setLayoutParams(android.view.ViewGroup.LayoutParams params) {
        // no-op
    }

    /**
     * Measures a view along its main axis. No-op stub returning the suggested
     * size (the spec size). Extensions building UI call this; nothing is
     * rendered on the desktop JVM.
     */
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {}

    public final void measure(int widthMeasureSpec, int heightMeasureSpec) {}

    public final int getMeasuredWidth() {
        return 0;
    }

    public final int getMeasuredHeight() {
        return 0;
    }

    /**
     * Minimal {@code android.view.View.MeasureSpec} stub.
     *
     * <p>Encodes a size + mode into an int and back, mirroring Android's packed
     * measure-spec representation. UI code that builds measure specs (e.g.
     * WebView-based resolvers) references it; the values are passed through
     * verbatim.
     */
    public static class MeasureSpec {

        private static final int MODE_SHIFT = 30;
        private static final int MODE_MASK = 0x3 << MODE_SHIFT;

        public static final int UNSPECIFIED = 0 << MODE_SHIFT;
        public static final int EXACTLY = 1 << MODE_SHIFT;
        public static final int AT_MOST = 2 << MODE_SHIFT;

        private MeasureSpec() {}

        public static int makeMeasureSpec(int size, int mode) {
            return (size & ~MODE_MASK) | (mode & MODE_MASK);
        }

        public static int getMode(int measureSpec) {
            return measureSpec & MODE_MASK;
        }

        public static int getSize(int measureSpec) {
            return measureSpec & ~MODE_MASK;
        }
    }
}
