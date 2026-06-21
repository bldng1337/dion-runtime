package android.icu.text;

import java.util.Locale;

/**
 * Break iterator mirroring {@code android.icu.text.BreakIterator}.
 *
 * <p>{@code android.icu.*} is Android's re-export of ICU4J. Break iterators
 * locate boundaries between text units (characters, words, sentences, lines).
 * This stub wraps a {@code com.ibm.icu.text.BreakIterator} obtained from the
 * ICU4J factory methods and forwards the boundary-navigation API.
 */
public abstract class BreakIterator implements Cloneable {

    private final com.ibm.icu.text.BreakIterator delegate;

    protected BreakIterator(com.ibm.icu.text.BreakIterator delegate) {
        this.delegate = delegate;
    }

    public static BreakIterator getWordInstance() {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getWordInstance()
        );
    }

    public static BreakIterator getWordInstance(Locale where) {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getWordInstance(where)
        );
    }

    public static BreakIterator getCharacterInstance() {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getCharacterInstance()
        );
    }

    public static BreakIterator getCharacterInstance(Locale where) {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getCharacterInstance(where)
        );
    }

    public static BreakIterator getSentenceInstance() {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getSentenceInstance()
        );
    }

    public static BreakIterator getSentenceInstance(Locale where) {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getSentenceInstance(where)
        );
    }

    public static BreakIterator getLineInstance() {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getLineInstance()
        );
    }

    public static BreakIterator getLineInstance(Locale where) {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getLineInstance(where)
        );
    }

    public static BreakIterator getTitleInstance() {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getTitleInstance()
        );
    }

    public static BreakIterator getTitleInstance(Locale where) {
        return new BreakIteratorImpl(
            com.ibm.icu.text.BreakIterator.getTitleInstance(where)
        );
    }

    /** {@return the wrapped ICU4J break iterator, for {@link StringSearch} to use.} */
    com.ibm.icu.text.BreakIterator delegate() {
        return delegate;
    }

    public int first() {
        return delegate.first();
    }

    public int last() {
        return delegate.last();
    }

    public int next() {
        return delegate.next();
    }

    public int previous() {
        return delegate.previous();
    }

    public int following(int offset) {
        return delegate.following(offset);
    }

    public int preceding(int offset) {
        return delegate.preceding(offset);
    }

    public int current() {
        return delegate.current();
    }

    public int getRuleStatus() {
        return delegate.getRuleStatus();
    }

    public int[] getRuleStatusVec() {
        int[] vec = new int[8];
        int n = delegate.getRuleStatusVec(vec);
        int[] result = new int[n];
        System.arraycopy(vec, 0, result, 0, n);
        return result;
    }

    public int next(int n) {
        return delegate.next(n);
    }

    public boolean isBoundary(int offset) {
        return delegate.isBoundary(offset);
    }

    public java.text.CharacterIterator getText() {
        return delegate.getText();
    }

    public void setText(String newText) {
        delegate.setText(newText);
    }

    public void setText(java.text.CharacterIterator newText) {
        delegate.setText(newText);
    }

    @Override
    public Object clone() {
        try {
            return super.clone();
        } catch (CloneNotSupportedException e) {
            throw new InternalError(e);
        }
    }

    /** Concrete break iterator wrapping an ICU4J instance. */
    private static final class BreakIteratorImpl extends BreakIterator {

        BreakIteratorImpl(com.ibm.icu.text.BreakIterator delegate) {
            super(delegate);
        }
    }
}
