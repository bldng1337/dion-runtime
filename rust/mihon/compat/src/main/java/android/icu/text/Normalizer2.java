package android.icu.text;

/**
 * Normalizer mirroring {@code android.icu.text.Normalizer2}.
 *
 * <p>{@code android.icu.*} is Android's re-export of ICU4J. {@code Normalizer2}
 * transforms Unicode text into an equivalent composed or decomposed form. This
 * stub wraps the corresponding ICU4J {@code com.ibm.icu.text.Normalizer2}
 * obtained from the standard factory methods and forwards the common API.
 */
public abstract class Normalizer2 {

    private final com.ibm.icu.text.Normalizer2 delegate;

    protected Normalizer2(com.ibm.icu.text.Normalizer2 delegate) {
        this.delegate = delegate;
    }

    public static Normalizer2 getNFCInstance() {
        return new Normalizer2Impl(
            com.ibm.icu.text.Normalizer2.getNFCInstance()
        );
    }

    public static Normalizer2 getNFDInstance() {
        return new Normalizer2Impl(
            com.ibm.icu.text.Normalizer2.getNFDInstance()
        );
    }

    public static Normalizer2 getNFKCInstance() {
        return new Normalizer2Impl(
            com.ibm.icu.text.Normalizer2.getNFKCInstance()
        );
    }

    public static Normalizer2 getNFKDInstance() {
        return new Normalizer2Impl(
            com.ibm.icu.text.Normalizer2.getNFKDInstance()
        );
    }

    public static Normalizer2 getNFKCCasefoldInstance() {
        return new Normalizer2Impl(
            com.ibm.icu.text.Normalizer2.getNFKCCasefoldInstance()
        );
    }

    public static Normalizer2 getInstance(
        java.io.InputStream data,
        String name,
        com.ibm.icu.text.Normalizer2.Mode mode
    ) {
        return new Normalizer2Impl(
            com.ibm.icu.text.Normalizer2.getInstance(data, name, mode)
        );
    }

    /** {@return the wrapped ICU4J normalizer.} */
    com.ibm.icu.text.Normalizer2 delegate() {
        return delegate;
    }

    public String normalize(CharSequence src) {
        return delegate.normalize(src);
    }

    public java.lang.StringBuilder normalize(
        CharSequence src,
        java.lang.StringBuilder dest
    ) {
        return delegate.normalize(src, dest);
    }

    public java.lang.StringBuilder normalizeSecondAndAppend(
        java.lang.StringBuilder first,
        CharSequence second
    ) {
        return delegate.normalizeSecondAndAppend(first, second);
    }

    public java.lang.StringBuilder append(
        java.lang.StringBuilder first,
        CharSequence second
    ) {
        return delegate.append(first, second);
    }

    public String getDecomposition(int c) {
        return delegate.getDecomposition(c);
    }

    public String getRawDecomposition(int c) {
        return delegate.getRawDecomposition(c);
    }

    public int getCombiningClass(int c) {
        return delegate.getCombiningClass(c);
    }

    public boolean isNormalized(CharSequence s) {
        return delegate.isNormalized(s);
    }

    /** Concrete normalizer wrapping an ICU4J instance. */
    private static final class Normalizer2Impl extends Normalizer2 {

        Normalizer2Impl(com.ibm.icu.text.Normalizer2 delegate) {
            super(delegate);
        }
    }
}
