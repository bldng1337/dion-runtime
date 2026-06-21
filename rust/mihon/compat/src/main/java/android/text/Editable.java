package android.text;

/**
 * Minimal {@code android.text.Editable} stub.
 *
 * <p>Real Android's {@code Editable} is a mutable {@link Spanned} returned by
 * editable widgets. Extensions reference the type (e.g. in
 * {@link TextWatcher} callbacks). It needs to exist and remain a subtype of
 * {@link Spanned} for class loading, but no methods are implemented here.
 */
public interface Editable extends Spanned {
}
