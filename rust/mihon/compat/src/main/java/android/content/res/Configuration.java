package android.content.res;

/**
 * Minimal Configuration stub.
 */
public final class Configuration {
    public int orientation;
    public int screenHeightDp;
    public int screenWidthDp;
    public int densityDpi;
    public java.util.Locale locale;
    
    public static final int ORIENTATION_UNDEFINED = 0;
    public static final int ORIENTATION_PORTRAIT = 1;
    public static final int ORIENTATION_LANDSCAPE = 2;
    
    public Configuration() {
        locale = java.util.Locale.getDefault();
    }
    
    public Configuration(Configuration other) {
        orientation = other.orientation;
        screenHeightDp = other.screenHeightDp;
        screenWidthDp = other.screenWidthDp;
        densityDpi = other.densityDpi;
        locale = other.locale;
    }
}
