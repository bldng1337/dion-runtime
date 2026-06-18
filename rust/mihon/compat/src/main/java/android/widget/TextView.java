package android.widget;

import android.content.Context;

/**
 * Minimal {@code android.widget.TextView} stub.
 *
 * <p>Some Mihon extensions (e.g. coronaex) reference {@code TextView} directly
 * (typically calling {@link #setInputType(int)}) while building configurable
 * source preference screens. Those UI paths are never rendered on the desktop
 * JVM, but the class must be resolvable so the extension can load.
 */
public class TextView {

    private CharSequence text = "";
    private int inputType = 0;

    public TextView(Context context) {}

    public void setText(CharSequence text) {
        this.text = text != null ? text : "";
    }

    public CharSequence getText() {
        return text;
    }

    public void setInputType(int type) {
        this.inputType = type;
    }

    public int getInputType() {
        return inputType;
    }

    public void setHint(CharSequence hint) {}
}
