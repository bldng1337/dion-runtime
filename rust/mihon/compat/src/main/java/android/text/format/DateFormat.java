package android.text.format;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * Minimal {@code android.text.format.DateFormat} stub.
 *
 * <p>Extensions use it to format parsed dates (e.g. upload/parse times). The
 * Android API accepts a template CharSequence where the character literals have
 * Android-specific meanings (e.g. {@code MM} = numeric month). This stub maps
 * the common template characters onto {@link SimpleDateFormat} so the output is
 * reasonable, which is all that's needed for test/parse purposes.
 */
public final class DateFormat {

    private DateFormat() {}

    /**
     * Format string constants mirroring the Android API (used by some extensions
     * as the {@code inFormat} argument).
     */
    public static final char QUOTE = '\'';
    public static final char AM_PM = 'a';
    public static final char CAPITAL_AM_PM = 'A';
    public static final char DATE = 'd';
    public static final char DAY = 'E';
    public static final char HOUR = 'h';
    public static final char HOUR_OF_DAY = 'H';
    public static final char MINUTE = 'm';
    public static final char MONTH = 'M';
    public static final char SECONDS = 's';
    public static final char TIME_ZONE = 'z';
    public static final char YEAR = 'y';

    /**
     * Formats a millisecond timestamp using the given template.
     *
     * @param inFormat the date template (e.g. {@code "yyyy-MM-dd"})
     * @param inTimeInMillis the time to format, in milliseconds since the epoch
     * @return the formatted date string
     */
    public static CharSequence format(
        CharSequence inFormat,
        long inTimeInMillis
    ) {
        return format(inFormat, new Date(inTimeInMillis));
    }

    /**
     * Formats a {@link Date} using the given template.
     *
     * @param inFormat the date template (e.g. {@code "yyyy-MM-dd"})
     * @param inDate the time to format
     * @return the formatted date string
     */
    public static CharSequence format(CharSequence inFormat, Date inDate) {
        return new SimpleDateFormat(
            inFormat.toString(),
            Locale.getDefault()
        ).format(inDate);
    }

    /**
     * Formats a {@link Calendar} using the given template.
     *
     * @param inFormat the date template (e.g. {@code "yyyy-MM-dd"})
     * @param inDate the time to format
     * @return the formatted date string
     */
    public static CharSequence format(CharSequence inFormat, Calendar inDate) {
        return format(inFormat, inDate.getTime());
    }
}
