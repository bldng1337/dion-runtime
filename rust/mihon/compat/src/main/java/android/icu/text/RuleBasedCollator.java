package android.icu.text;

/**
 * Rule-based collator mirroring {@code android.icu.text.RuleBasedCollator}.
 *
 * <p>This is a concrete subclass of {@link Collator} wrapping the ICU4J
 * {@code com.ibm.icu.text.RuleBasedCollator} returned by
 * {@code com.ibm.icu.text.Collator.getInstance()}. Extensions obtain one via
 * {@link Collator#getInstance()} (which always returns a rule-based collator)
 * and may pass it to {@link StringSearch}.
 */
public class RuleBasedCollator extends Collator {

    public RuleBasedCollator(String rules) {
        super(toIcuRules(rules));
    }

    RuleBasedCollator(com.ibm.icu.text.RuleBasedCollator delegate) {
        super(delegate);
    }

    private static com.ibm.icu.text.RuleBasedCollator toIcuRules(String rules) {
        try {
            return new com.ibm.icu.text.RuleBasedCollator(rules);
        } catch (Exception e) {
            // Fall back to the default collator if the custom rules are invalid.
            return (com.ibm.icu.text.RuleBasedCollator) com.ibm.icu.text.Collator.getInstance();
        }
    }
}
