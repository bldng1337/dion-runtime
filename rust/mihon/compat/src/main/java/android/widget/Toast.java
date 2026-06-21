package android.widget;

import android.content.Context;

/**
 * Minimal {@code android.widget.Toast} stub.
 *
 * <p>Extensions sometimes surface a Toast (e.g. an error/notice) during source
 * interaction. No UI is shown on the desktop JVM; {@link #makeText} returns a
 * singleton-like stub and {@link #show()} is a no-op, so the call sites run
 * without error.
 */
public class Toast {

    /** Duration constant (mirrors the Android value). */
    public static final int LENGTH_SHORT = 0;
    /** Duration constant (mirrors the Android value). */
    public static final int LENGTH_LONG = 1;

    private Toast() {
    }

    /**
     * @return a non-null {@code Toast} stub (parameters ignored)
     */
    public static Toast makeText(Context context, CharSequence text, int duration) {
        return new Toast();
    }

    public void show() {
        // no-op
    }
}
