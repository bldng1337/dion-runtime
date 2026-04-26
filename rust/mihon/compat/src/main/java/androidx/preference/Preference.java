package androidx.preference;

import android.content.Context;

/**
 * Minimal Preference stub for Mihon extensions
 */
public class Preference {
    
    protected Context context;
    protected String key;
    protected CharSequence title;
    protected CharSequence summary;
    protected boolean enabled = true;
    protected boolean visible = true;
    protected OnPreferenceChangeListener onPreferenceChangeListener;
    protected OnPreferenceClickListener onPreferenceClickListener;
    
    public Preference(Context context) {
        this.context = context;
    }
    
    public Context getContext() {
        return context;
    }
    
    public String getKey() {
        return key;
    }
    
    public void setKey(String key) {
        this.key = key;
    }
    
    public CharSequence getTitle() {
        return title;
    }
    
    public void setTitle(CharSequence title) {
        this.title = title;
    }
    
    public void setTitle(int titleResId) {
        // Resource IDs not supported
        this.title = "";
    }
    
    public CharSequence getSummary() {
        return summary;
    }
    
    public void setSummary(CharSequence summary) {
        this.summary = summary;
    }
    
    public void setSummary(int summaryResId) {
        // Resource IDs not supported
        this.summary = "";
    }
    
    public boolean isEnabled() {
        return enabled;
    }
    
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
    
    public boolean isVisible() {
        return visible;
    }
    
    public void setVisible(boolean visible) {
        this.visible = visible;
    }
    
    public void setOnPreferenceChangeListener(OnPreferenceChangeListener listener) {
        this.onPreferenceChangeListener = listener;
    }
    
    public OnPreferenceChangeListener getOnPreferenceChangeListener() {
        return onPreferenceChangeListener;
    }
    
    public void setOnPreferenceClickListener(OnPreferenceClickListener listener) {
        this.onPreferenceClickListener = listener;
    }
    
    public OnPreferenceClickListener getOnPreferenceClickListener() {
        return onPreferenceClickListener;
    }
    
    /**
     * Interface for preference change callbacks
     */
    public interface OnPreferenceChangeListener {
        boolean onPreferenceChange(Preference preference, Object newValue);
    }
    
    /**
     * Interface for preference click callbacks
     */
    public interface OnPreferenceClickListener {
        boolean onPreferenceClick(Preference preference);
    }
}
