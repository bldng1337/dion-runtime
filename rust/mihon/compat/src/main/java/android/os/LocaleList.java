package android.os;

import java.util.Locale;

/**
 * Minimal {@code android.os.LocaleList} stub.
 *
 * <p>Some extensions (e.g. yellownote) read the device's locale list at source
 * creation time (typically to localise requests). We expose a single-element
 * list wrapping {@link Locale#getDefault()}, which is enough for those
 * extensions to load and pick a locale.
 */
public final class LocaleList {

    private final Locale[] mList;

    public LocaleList(Locale... locales) {
        this.mList = locales != null && locales.length > 0 ? locales.clone() : new Locale[]{Locale.getDefault()};
    }

    public Locale get(int index) {
        return mList[index];
    }

    public int size() {
        return mList.length;
    }

    public boolean isEmpty() {
        return mList.length == 0;
    }

    /** Returns the first match for the given languages, or the first locale. */
    public Locale getFirstMatch(String[] supportedLocales) {
        if (supportedLocales != null) {
            for (String supported : supportedLocales) {
                if (supported != null) {
                    for (Locale locale : mList) {
                        if (supported.equals(locale.getLanguage()) || supported.equals(locale.toString())) {
                            return locale;
                        }
                    }
                }
            }
        }
        return mList.length > 0 ? mList[0] : Locale.getDefault();
    }

    /** Returns the default locale list (single default locale on the JVM runtime). */
    public static LocaleList getDefault() {
        return new LocaleList(Locale.getDefault());
    }

    public static LocaleList getEmptyLocaleList() {
        return new LocaleList();
    }

    /** Returns the user's primary locale. */
    public static Locale getDefaultLocale() {
        return Locale.getDefault();
    }
}
