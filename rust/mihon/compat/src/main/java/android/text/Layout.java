package android.text;

import android.graphics.Canvas;

/**
 * Minimal {@code android.text.Layout} stub.
 *
 * <p>The real class is a large abstract base for text layout engines. A few
 * Mihon extensions (e.g. comicfury) reference {@code Layout}, its nested
 * {@link Alignment} enum and {@link android.text.StaticLayout} while building
 * their sources (typically to compose text onto images). Those code paths are
 * not exercised by the standard browse/search/detail/source flow, but the
 * classes must be resolvable on the classpath so the extension can load. This
 * stub provides the surface area that extension bytecode links against.
 */
public abstract class Layout {

    /** Alignment values used by {@link android.text.StaticLayout}. */
    public enum Alignment {
        ALIGN_NORMAL,
        ALIGN_OPPOSITE,
        ALIGN_CENTER,
        ALIGN_LEFT,
        ALIGN_RIGHT,
    }

    public abstract int getLineCount();

    public abstract int getLineTop(int line);

    public int getHeight() {
        return 0;
    }

    public void draw(Canvas canvas) {
        // No-op: real implementation renders the laid-out text onto the canvas.
    }
}
