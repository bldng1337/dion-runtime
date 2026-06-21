package android.text;

import java.util.regex.Pattern;

/**
 * Minimal {@code android.text.Html} stub.
 *
 * <p>Extensions call {@link #fromHtml(String, int)} to convert HTML description
 * text into a {@link Spanned}. The real implementation renders inline markup;
 * this stub strips tags so the returned plain text is usable as a description
 * string (via {@link Spanned#toString()}).
 */
public final class Html {

    /** Legacy conversion mode flag (mirrors the Android constant value). */
    public static final int FROM_HTML_MODE_LEGACY = 0;

    private static final Pattern TAG = Pattern.compile("<[^>]*>");

    private Html() {
    }

    /**
     * Converts HTML into a {@link Spanned}, dropping all markup.
     *
     * @param source the HTML source (may be {@code null})
     * @param flags  ignored (accepted for API compatibility)
     * @return a {@link Spanned} whose {@code toString()} is the stripped text
     */
    public static Spanned fromHtml(String source, int flags) {
        return new SpannedString(source == null ? "" : TAG.matcher(source).replaceAll(""));
    }

    /** Simple {@link Spanned} backed by a {@link String}. */
    private static final class SpannedString implements Spanned {
        private final String text;

        SpannedString(String text) {
            this.text = text;
        }

        @Override
        public int length() {
            return text.length();
        }

        @Override
        public char charAt(int index) {
            return text.charAt(index);
        }

        @Override
        public CharSequence subSequence(int start, int end) {
            return text.subSequence(start, end);
        }

        @Override
        public String toString() {
            return text;
        }
    }
}
