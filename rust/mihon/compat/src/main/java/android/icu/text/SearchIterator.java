package android.icu.text;

/**
 * Abstract base for ICU text search iterators.
 *
 * <p>Mirrors {@code android.icu.text.SearchIterator}. {@code android.icu.*} is a
 * thin re-export of ICU4J, but since {@code com.ibm.icu.text.StringSearch} is
 * {@code final} we provide parallel {@code android.icu.text.*} types that
 * delegate to the ICU4J implementation under the hood. Concrete iterators (e.g.
 * {@link StringSearch}) implement {@link #next()} and {@link #previous()}.
 */
public abstract class SearchIterator {

    /** Returned by {@link #next()} / {@link #previous()} when there is no match. */
    public static final int DONE = -1;

    /**
     * Returns the index of the next match, or {@link #DONE} if there isn't one.
     */
    public abstract int next();

    /**
     * Returns the index of the previous match, or {@link #DONE} if there isn't one.
     */
    public abstract int previous();

    /**
     * Resets to the start of the target and returns the index of the first match,
     * or {@link #DONE}.
     */
    public int first() {
        setIndex(0);
        return next();
    }

    /**
     * Moves past the end of the target and returns the index of the last match,
     * or {@link #DONE}.
     */
    public int last() {
        setIndex(Integer.MAX_VALUE);
        return previous();
    }

    /**
     * Returns the index of the first match at or after {@code offset}, or
     * {@link #DONE}. Default implementation sets the position then calls
     * {@link #next()}.
     */
    public int following(int offset) {
        setIndex(offset);
        return next();
    }

    /**
     * Returns the index of the first match at or before {@code offset}, or
     * {@link #DONE}. Default implementation sets the position then calls
     * {@link #previous()}.
     */
    public int preceding(int offset) {
        setIndex(offset);
        return previous();
    }

    /**
     * Sets the current search position. The base implementation is a no-op;
     * subclasses that track a cursor override this.
     *
     * @param position the new position to search from
     */
    public void setIndex(int position) {
        // No-op by default.
    }
}
