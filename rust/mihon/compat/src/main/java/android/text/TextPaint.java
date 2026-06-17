package android.text;

import android.graphics.Paint;

/**
 * Minimal TextPaint stub.
 *
 * TextPaint extends {@link Paint} with a handful of extra fields used by
 * Android's text layout system. Some Mihon/Tachiyomi extensions (notably
 * the Webtoons source, which measures glyph widths to decode obfuscated
 * titles) construct a TextPaint at source creation time, so we provide a
 * stub here to let those extensions load on the desktop JVM.
 */
public class TextPaint extends Paint {

    public int bgColor;
    public int[] drawableState;
    public int linkColor;
    public float underlineThickness;
    public int underlineColor;

    public TextPaint() {
        super();
    }

    public TextPaint(int flags) {
        super(flags);
    }

    public TextPaint(Paint p) {
        this();
        set(p);
    }

    /**
     * Copies the state (including the TextPaint-specific fields) from the
     * given paint into this one.
     */
    public void set(Paint p) {
        if (p instanceof TextPaint) {
            TextPaint tp = (TextPaint) p;
            this.bgColor = tp.bgColor;
            this.drawableState = tp.drawableState;
            this.linkColor = tp.linkColor;
            this.underlineThickness = tp.underlineThickness;
            this.underlineColor = tp.underlineColor;
        }
    }
}
