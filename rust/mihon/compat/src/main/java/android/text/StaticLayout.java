package android.text;

/**
 * Minimal {@code android.text.StaticLayout} stub.
 *
 * <p>The real class lays out (wraps) text for drawing and is constructed by a
 * few Mihon extensions (e.g. comicfury) while building their sources. Those
 * rendering paths are not exercised by the standard browse/search/detail/source
 * flow, but the class must be instantiable so the extension can load. This stub
 * accepts the constructor arguments used by extension bytecode and returns
 * zero-height layouts.
 */
public class StaticLayout extends Layout {

    public StaticLayout(
            CharSequence source,
            TextPaint paint,
            int width,
            Layout.Alignment align,
            float spacingmult,
            float spacingadd,
            boolean includepad) {
        // No-op: real implementation measures and wraps the text.
    }

    public StaticLayout(
            CharSequence source,
            int bufstart,
            int bufend,
            TextPaint paint,
            int outerwidth,
            Layout.Alignment align,
            float spacingmult,
            float spacingadd,
            boolean includepad) {
        // No-op.
    }

    @Override
    public int getLineCount() {
        return 0;
    }

    @Override
    public int getLineTop(int line) {
        return 0;
    }

    @Override
    public int getHeight() {
        return 0;
    }
}
