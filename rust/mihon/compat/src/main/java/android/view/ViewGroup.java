package android.view;

/**
 * Minimal {@code android.view.ViewGroup} stub.
 *
 * <p>Extensions occasionally reference {@code ViewGroup} or its inner
 * {@link LayoutParams} (e.g. when constructing UI for a configurable source, or
 * when a WebView-based resolver sizes a view). Nothing is actually rendered on
 * the desktop JVM, but the classes must be loadable and linkable.
 */
public class ViewGroup extends View {

    /** Layout size that fills the parent (mirrors the Android value). */
    public static final int MATCH_PARENT = -1;
    /** Layout size that wraps the content (mirrors the Android value). */
    public static final int WRAP_CONTENT = -2;

    /** Adds a child view (no-op on the desktop JVM). */
    public void addView(View child) {}

    /** Adds a child view with the given layout params (no-op on the desktop JVM). */
    public void addView(View child, LayoutParams params) {}

    /**
     * Minimal layout parameters mirroring
     * {@code android.view.ViewGroup.LayoutParams}.
     */
    public static class LayoutParams {

        public int width;
        public int height;

        public LayoutParams(int width, int height) {
            this.width = width;
            this.height = height;
        }

        public LayoutParams(LayoutParams source) {
            this.width = source.width;
            this.height = source.height;
        }

        public LayoutParams() {
            this(WRAP_CONTENT, WRAP_CONTENT);
        }
    }

    /**
     * Margin layout parameters mirroring
     * {@code android.view.ViewGroup.MarginLayoutParams}.
     */
    public static class MarginLayoutParams extends LayoutParams {

        public int leftMargin;
        public int topMargin;
        public int rightMargin;
        public int bottomMargin;
        public int startMargin;
        public int endMargin;

        public MarginLayoutParams() {
            super();
        }

        public MarginLayoutParams(int width, int height) {
            super(width, height);
        }

        public MarginLayoutParams(MarginLayoutParams source) {
            super(source);
            this.leftMargin = source.leftMargin;
            this.topMargin = source.topMargin;
            this.rightMargin = source.rightMargin;
            this.bottomMargin = source.bottomMargin;
        }
    }
}
