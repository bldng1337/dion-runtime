package dion.mihon.android.replace.java.text

import com.ibm.icu.text.DateFormat
import com.ibm.icu.util.Calendar
import com.ibm.icu.util.TimeZone as IcuTimeZone
import java.text.AttributedCharacterIterator
import java.text.FieldPosition
import java.text.ParseException
import java.text.ParsePosition
import java.util.Date
import java.util.Locale
import java.util.TimeZone as JavaTimeZone

/**
 * A SimpleDateFormat replacement that uses ICU4J for Android-compatible date parsing.
 * 
 * Android's SimpleDateFormat is based on ICU (International Components for Unicode),
 * which handles certain date patterns differently than the standard JDK implementation.
 * This class provides a drop-in replacement that uses ICU4J to match Android behavior.
 * 
 * The BytecodeEditor rewrites all references to java.text.SimpleDateFormat in extension
 * code to use this class instead.
 */
class SimpleDateFormat : java.text.DateFormat {
    
    private val icuFormat: com.ibm.icu.text.SimpleDateFormat
    private var pattern: String
    
    /**
     * Constructs a SimpleDateFormat using the default pattern and date format symbols
     * for the default locale.
     */
    constructor() {
        this.pattern = ""
        this.icuFormat = com.ibm.icu.text.SimpleDateFormat()
        syncTimeZone()
    }
    
    /**
     * Constructs a SimpleDateFormat using the given pattern and the default date
     * format symbols for the default locale.
     */
    constructor(pattern: String) {
        this.pattern = pattern
        this.icuFormat = com.ibm.icu.text.SimpleDateFormat(pattern)
        syncTimeZone()
    }
    
    /**
     * Constructs a SimpleDateFormat using the given pattern and locale.
     */
    constructor(pattern: String, locale: Locale) {
        this.pattern = pattern
        this.icuFormat = com.ibm.icu.text.SimpleDateFormat(pattern, locale)
        syncTimeZone()
    }
    
    /**
     * Constructs a SimpleDateFormat using the given pattern and date format symbols.
     */
    constructor(pattern: String, formatSymbols: java.text.DateFormatSymbols) {
        this.pattern = pattern
        // Convert Java DateFormatSymbols to ICU DateFormatSymbols
        val icuSymbols = com.ibm.icu.text.DateFormatSymbols(Locale.getDefault())
        icuSymbols.shortMonths = formatSymbols.shortMonths
        icuSymbols.months = formatSymbols.months
        icuSymbols.shortWeekdays = formatSymbols.shortWeekdays
        icuSymbols.weekdays = formatSymbols.weekdays
        icuSymbols.amPmStrings = formatSymbols.amPmStrings
        icuSymbols.eras = formatSymbols.eras
        this.icuFormat = com.ibm.icu.text.SimpleDateFormat(pattern, icuSymbols)
        syncTimeZone()
    }
    
    private fun syncTimeZone() {
        val javaZone = JavaTimeZone.getDefault()
        icuFormat.timeZone = IcuTimeZone.getTimeZone(javaZone.id)
    }
    
    override fun format(date: Date, toAppendTo: StringBuffer, fieldPosition: FieldPosition): StringBuffer {
        return icuFormat.format(date, toAppendTo, fieldPosition)
    }
    
    override fun parse(source: String, pos: ParsePosition): Date? {
        return icuFormat.parse(source, pos)
    }
    
    override fun parse(source: String): Date {
        val pos = ParsePosition(0)
        val result = icuFormat.parse(source, pos)
        if (pos.index == 0 || pos.errorIndex >= 0) {
            throw ParseException("Unparseable date: \"$source\"", pos.errorIndex.coerceAtLeast(0))
        }
        return result
    }
    
    override fun formatToCharacterIterator(obj: Any): AttributedCharacterIterator {
        return icuFormat.formatToCharacterIterator(obj)
    }
    
    override fun setTimeZone(zone: JavaTimeZone) {
        super.setTimeZone(zone)
        icuFormat.timeZone = IcuTimeZone.getTimeZone(zone.id)
    }
    
    override fun getTimeZone(): JavaTimeZone {
        return JavaTimeZone.getTimeZone(icuFormat.timeZone.id)
    }
    
    override fun setLenient(lenient: Boolean) {
        super.setLenient(lenient)
        icuFormat.isLenient = lenient
    }
    
    override fun isLenient(): Boolean {
        return icuFormat.isLenient
    }
    
    override fun setCalendar(newCalendar: java.util.Calendar) {
        super.setCalendar(newCalendar)
        val icuCalendar = Calendar.getInstance(
            IcuTimeZone.getTimeZone(newCalendar.timeZone.id),
            Locale.getDefault()
        )
        icuCalendar.time = newCalendar.time
        icuFormat.calendar = icuCalendar
    }
    
    override fun getCalendar(): java.util.Calendar {
        val icuCalendar = icuFormat.calendar
        val javaCalendar = java.util.Calendar.getInstance(
            JavaTimeZone.getTimeZone(icuCalendar.timeZone.id),
            Locale.getDefault()
        )
        javaCalendar.time = icuCalendar.time
        return javaCalendar
    }
    
    /**
     * Returns the pattern string describing this date format.
     */
    fun toPattern(): String = icuFormat.toPattern()
    
    /**
     * Returns a localized pattern string describing this date format.
     */
    fun toLocalizedPattern(): String = icuFormat.toLocalizedPattern()
    
    /**
     * Applies the given pattern string to this date format.
     */
    fun applyPattern(pattern: String) {
        this.pattern = pattern
        icuFormat.applyPattern(pattern)
    }
    
    /**
     * Applies the given localized pattern string to this date format.
     */
    fun applyLocalizedPattern(pattern: String) {
        this.pattern = pattern
        icuFormat.applyLocalizedPattern(pattern)
    }
    
    /**
     * Gets a copy of the date and time format symbols of this date format.
     */
    fun getDateFormatSymbols(): java.text.DateFormatSymbols {
        val icuSymbols = icuFormat.dateFormatSymbols
        val javaSymbols = java.text.DateFormatSymbols()
        javaSymbols.shortMonths = icuSymbols.shortMonths
        javaSymbols.months = icuSymbols.months
        javaSymbols.shortWeekdays = icuSymbols.shortWeekdays
        javaSymbols.weekdays = icuSymbols.weekdays
        javaSymbols.amPmStrings = icuSymbols.amPmStrings
        javaSymbols.eras = icuSymbols.eras
        return javaSymbols
    }
    
    /**
     * Sets the date and time format symbols of this date format.
     */
    fun setDateFormatSymbols(newFormatSymbols: java.text.DateFormatSymbols) {
        val icuSymbols = icuFormat.dateFormatSymbols
        icuSymbols.shortMonths = newFormatSymbols.shortMonths
        icuSymbols.months = newFormatSymbols.months
        icuSymbols.shortWeekdays = newFormatSymbols.shortWeekdays
        icuSymbols.weekdays = newFormatSymbols.weekdays
        icuSymbols.amPmStrings = newFormatSymbols.amPmStrings
        icuSymbols.eras = newFormatSymbols.eras
        icuFormat.dateFormatSymbols = icuSymbols
    }
    
    /**
     * Sets the 100-year period 2-digit years will be interpreted as being in
     * to begin on the date the user specifies.
     */
    fun set2DigitYearStart(startDate: Date) {
        icuFormat.set2DigitYearStart(startDate)
    }
    
    /**
     * Returns the beginning date of the 100-year period 2-digit years are
     * interpreted as being within.
     */
    fun get2DigitYearStart(): Date {
        return icuFormat.get2DigitYearStart()
    }
    
    override fun clone(): Any {
        val clone = super.clone() as SimpleDateFormat
        return clone
    }
    
    override fun hashCode(): Int {
        return icuFormat.hashCode()
    }
    
    override fun equals(other: Any?): Boolean {
        if (other !is SimpleDateFormat) return false
        return icuFormat == other.icuFormat
    }
}
