package android.icu.text;

import java.util.Locale;

/**
 * Collator mirroring {@code android.icu.text.Collator}.
 *
 * <p>{@code android.icu.*} is Android's re-export of ICU4J. {@code Collator} is
 * abstract on both platforms; this stub provides a concrete implementation that
 * delegates to a {@code com.ibm.icu.text.Collator} obtained from
 * {@code com.ibm.icu.text.Collator.getInstance()}. The common operations
 * extensions use — {@link #getInstance()}, {@link #compare(Object, Object)} and
 * {@link #setStrength(int)} — are supported.
 */
public abstract class Collator
    implements java.util.Comparator<Object>, Cloneable
{

    /** Primary collation strength (differences in base letters). */
    public static final int PRIMARY = 0;
    /** Secondary collation strength (accents). */
    public static final int SECONDARY = 1;
    /** Tertiary collation strength (case). */
    public static final int TERTIARY = 2;
    /** Quaternary collation strength. */
    public static final int QUATERNARY = 3;
    /** Identical collation strength. */
    public static final int IDENTICAL = 15;

    /** No decomposition (collation). */
    public static final int NO_DECOMPOSITION = 16;
    /** Canonical decomposition (collation). */
    public static final int CANONICAL_DECOMPOSITION = 17;
    /** Full decomposition (collation). */
    public static final int FULL_DECOMPOSITION = 18;

    private final com.ibm.icu.text.Collator delegate;

    protected Collator(com.ibm.icu.text.Collator delegate) {
        this.delegate = delegate;
    }

    /**
     * Returns a {@code Collator} for the default locale. The concrete runtime
     * type is always {@link RuleBasedCollator}, matching Android's behaviour
     * (and what {@link StringSearch} expects).
     */
    public static Collator getInstance() {
        return new RuleBasedCollator(
            (com.ibm.icu.text.RuleBasedCollator) com.ibm.icu.text.Collator.getInstance()
        );
    }

    /**
     * Returns a {@code Collator} for the given locale.
     */
    public static Collator getInstance(Locale locale) {
        return new RuleBasedCollator(
            (com.ibm.icu.text.RuleBasedCollator) com.ibm.icu.text.Collator.getInstance(
                locale
            )
        );
    }

    /** {@return the wrapped ICU4J collator, for {@link StringSearch} to use.} */
    com.ibm.icu.text.Collator delegate() {
        return delegate;
    }

    /** {@return the wrapped ICU4J collator as a rule-based collator.} */
    com.ibm.icu.text.RuleBasedCollator ruleBasedDelegate() {
        return (com.ibm.icu.text.RuleBasedCollator) delegate;
    }

    /** Compares two strings using this collator's ordering rules. */
    public int compare(String source, String target) {
        return delegate.compare(source, target);
    }

    @Override
    public int compare(Object source, Object target) {
        return delegate.compare(source, target);
    }

    /** Sets the comparison strength. */
    public void setStrength(int strength) {
        delegate.setStrength(strength);
    }

    /** {@return the comparison strength.} */
    public int getStrength() {
        return delegate.getStrength();
    }

    /** Sets the decomposition mode (delegated to ICU4J). */
    public void setDecomposition(int decomposition) {
        delegate.setDecomposition(decomposition);
    }

    /** {@return the decomposition mode.} */
    public int getDecomposition() {
        return delegate.getDecomposition();
    }

    /** Enables/disables case-level comparison (delegated to ICU4J). */
    public void setCaseLevel(boolean flag) {
        ((com.ibm.icu.text.RuleBasedCollator) delegate).setCaseLevel(flag);
    }

    /** {@return whether case-level comparison is enabled.} */
    public boolean isCaseLevel() {
        return ((com.ibm.icu.text.RuleBasedCollator) delegate).isCaseLevel();
    }

    /** Sets numeric collation (delegated to ICU4J). */
    public void setNumericCollation(boolean flag) {
        ((com.ibm.icu.text.RuleBasedCollator) delegate).setNumericCollation(
            flag
        );
    }

    /** {@return whether numeric collation is enabled.} */
    public boolean getNumericCollation() {
        return (
            (com.ibm.icu.text.RuleBasedCollator) delegate
        ).getNumericCollation();
    }

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    /** Concrete collator wrapping an ICU4J collator instance. */
    private static final class CollatorImpl extends Collator {

        CollatorImpl(com.ibm.icu.text.Collator delegate) {
            super(delegate);
        }
    }
}
