package android.text;

/**
 * Minimal {@code android.text.Spanned} stub.
 *
 * <p>Mihon/Aniyomi extensions obtain a {@code Spanned} from
 * {@link android.text.Html#fromHtml(String, int)} when parsing HTML-formatted
 * descriptions. Like the real Android type, this extends {@link CharSequence}
 * so the result can be passed to APIs expecting a {@code CharSequence} (e.g.
 * setting a description) without a {@code ClassCastException}. None of the
 * span-querying methods are implemented because no UI is rendered on the JVM.
 */
public interface Spanned extends CharSequence {}
