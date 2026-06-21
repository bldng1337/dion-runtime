package android.widget;

import android.content.Context;

/**
 * Minimal {@code android.widget.Button} stub.
 *
 * <p>Extensions occasionally reference {@code Button} (typically via casts from
 * {@code findViewById}) while building preference UIs that are never rendered
 * on the desktop JVM. It extends {@link TextView} to mirror Android's real
 * hierarchy; only the constructors are needed for class loading.
 */
public class Button extends TextView {

    public Button(Context context) {
        super(context);
    }
}
