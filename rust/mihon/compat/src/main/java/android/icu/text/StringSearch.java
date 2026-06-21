package android.icu.text;

/**
 * Collation-based substring search, mirroring {@code android.icu.text.StringSearch}.
 *
 * <p>{@code android.icu.*} is Android's re-export of ICU4J, but the bundled
 * {@code com.ibm.icu.text.StringSearch} is {@code final}, so we cannot simply
 * subclass it. Instead this implementation delegates to a wrapped ICU4J
 * {@code com.ibm.icu.text.StringSearch}, which provides identical collation
 * search semantics. Only the constructors and methods that Android extensions
 * actually use are surfaced here.
 */
public final class StringSearch extends SearchIterator {

    private final com.ibm.icu.text.StringSearch delegate;

    /**
     * Creates a search for {@code pattern} within {@code target} using the
     * default collator.
     */
    public StringSearch(String pattern, String target) {
        this.delegate = new com.ibm.icu.text.StringSearch(pattern, target);
    }

    /**
     * Creates a search for {@code pattern} within {@code target} using the given
     * {@link RuleBasedCollator}. The ICU4J collator backing the Android
     * {@code RuleBasedCollator} is unwrapped and passed to ICU4J's own
     * {@code StringSearch}.
     */
    public StringSearch(
        String pattern,
        java.text.CharacterIterator target,
        RuleBasedCollator collator
    ) {
        this.delegate = new com.ibm.icu.text.StringSearch(
            pattern,
            target,
            collator == null ? null : collator.ruleBasedDelegate()
        );
    }

    /** Creates a search for {@code pattern} within {@code target}. */
    public StringSearch(String pattern, java.text.CharacterIterator target) {
        // ICU4J has no bare (String, CharacterIterator) constructor; use the
        // default-collator overload by passing a null collator, which makes
        // ICU4J fall back to the default RuleBasedCollator.
        this.delegate = new com.ibm.icu.text.StringSearch(
            pattern,
            target,
            (com.ibm.icu.text.RuleBasedCollator) null
        );
    }

    @Override
    public int next() {
        return delegate.next();
    }

    @Override
    public int previous() {
        return delegate.previous();
    }

    @Override
    public int first() {
        return delegate.first();
    }

    @Override
    public int last() {
        return delegate.last();
    }

    @Override
    public int following(int offset) {
        return delegate.following(offset);
    }

    @Override
    public int preceding(int offset) {
        return delegate.preceding(offset);
    }

    @Override
    public void setIndex(int position) {
        delegate.setIndex(position);
    }

    /** Toggles overlapping-match mode (delegated to ICU4J). */
    public void setOverlapping(boolean overlapping) {
        delegate.setOverlapping(overlapping);
    }

    /** {@return whether overlapping-match mode is enabled.} */
    public boolean isOverlapping() {
        return delegate.isOverlapping();
    }

    /** {@return the current match index.} */
    public int getIndex() {
        return delegate.getIndex();
    }

    /** Resets the iterator to its initial state. */
    public void reset() {
        delegate.reset();
    }

    /** Changes the text this iterator searches over. */
    public void setTarget(java.text.CharacterIterator target) {
        delegate.setTarget(target);
    }

    /** Changes the pattern being searched for. */
    public void setPattern(String pattern) {
        delegate.setPattern(pattern);
    }

    /** {@return the current search pattern.} */
    public String getPattern() {
        return delegate.getPattern();
    }

    /** {@return the collator in use.} */
    public RuleBasedCollator getCollator() {
        return new RuleBasedCollator(delegate.getCollator());
    }

    /** Changes the collator. */
    public void setCollator(RuleBasedCollator collator) {
        delegate.setCollator(
            collator == null ? null : collator.ruleBasedDelegate()
        );
    }

    /** {@return whether canonical-match mode is enabled.} */
    public boolean isCanonical() {
        return delegate.isCanonical();
    }

    /** Toggles canonical-match mode. */
    public void setCanonical(boolean allowCanonical) {
        delegate.setCanonical(allowCanonical);
    }

    /** {@return the length of the last matched text (0 if no match).} */
    public int getMatchedLength() {
        return delegate.getMatchLength();
    }

    /** The start index of the last match, or {@link #DONE} if there was none. */
    public int getMatchStart() {
        return delegate.getMatchStart();
    }

    /** The text of the last match, or the empty string if there was none. */
    public String getMatchedText() {
        return delegate.getMatchedText();
    }
}
