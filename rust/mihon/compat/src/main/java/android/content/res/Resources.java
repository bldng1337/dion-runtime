package android.content.res;

import android.graphics.drawable.Drawable;

/**
 * Minimal Resources stub.
 */
public class Resources {
    
    public static class NotFoundException extends RuntimeException {
        public NotFoundException() {
            super();
        }
        
        public NotFoundException(String name) {
            super(name);
        }
        
        public NotFoundException(String name, Exception cause) {
            super(name, cause);
        }
    }
    
    public static class Theme {
        public TypedArray obtainStyledAttributes(int[] attrs) {
            return new TypedArray();
        }
        
        public TypedArray obtainStyledAttributes(int resid, int[] attrs) {
            return new TypedArray();
        }
        
        public TypedArray obtainStyledAttributes(android.util.AttributeSet set, int[] attrs, int defStyleAttr, int defStyleRes) {
            return new TypedArray();
        }
    }
    
    private Configuration mConfiguration;
    private Theme mTheme;
    
    public Resources() {
        mConfiguration = new Configuration();
        mTheme = new Theme();
    }
    
    public CharSequence getText(int id) {
        return "";
    }
    
    public String getString(int id) {
        return "";
    }
    
    public String getString(int id, Object... formatArgs) {
        return String.format(getString(id), formatArgs);
    }
    
    public int getColor(int id, Theme theme) {
        return 0;
    }
    
    public Drawable getDrawable(int id, Theme theme) {
        return null;
    }
    
    public ColorStateList getColorStateList(int id, Theme theme) {
        return null;
    }
    
    public Configuration getConfiguration() {
        return mConfiguration;
    }
    
    public Theme getTheme() {
        return mTheme;
    }
    
    public Theme newTheme() {
        return new Theme();
    }
}
