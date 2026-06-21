package android.graphics.pdf;

import android.graphics.Bitmap;
import android.graphics.Rect;
import android.os.ParcelFileDescriptor;

/**
 * Minimal {@code android.graphics.pdf.PdfRenderer} stub.
 *
 * <p>A handful of extensions (e.g. those wrapping PDF-based content) reference
 * this class while fetching a source. Rendering PDFs to bitmaps is not feasible
 * on the desktop JVM, but the class (and its inner {@link Page}) must be
 * loadable so the extension links. {@link #getPageCount()} reports zero and
 * {@link #openPage(int)} throws so callers fail loudly rather than silently.
 */
public class PdfRenderer implements AutoCloseable {

    public static final int RENDER_MODE_FOR_DISPLAY = 1;
    public static final int RENDER_MODE_FOR_PRINT = 2;

    public PdfRenderer(ParcelFileDescriptor input) {}

    /** {@return the page count (always {@code 0} in this stub).} */
    public int getPageCount() {
        return 0;
    }

    /** Throws: no pages are available in this stub. */
    public Page openPage(int index) {
        throw new IndexOutOfBoundsException("PdfRenderer stub has no pages");
    }

    @Override
    public void close() {}

    /** Minimal {@code PdfRenderer.Page} stub. */
    public class Page implements AutoCloseable {

        public static final int RENDER_MODE_FOR_DISPLAY = PdfRenderer.RENDER_MODE_FOR_DISPLAY;
        public static final int RENDER_MODE_FOR_PRINT = PdfRenderer.RENDER_MODE_FOR_PRINT;

        Page() {}

        public int getWidth() {
            return 0;
        }

        public int getHeight() {
            return 0;
        }

        public void render(Bitmap destination, Rect srcRect, Matrix matrix, int renderMode) {}

        @Override
        public void close() {}
    }

    /** Minimal {@code android.graphics.Matrix} stand-in for {@link Page#render}. */
    public static class Matrix {}
}
