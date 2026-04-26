package androidx.preference;

import android.content.Context;

/**
 * ListPreference stub
 */
public class ListPreference extends DialogPreference {
    
    private CharSequence[] entries;
    private CharSequence[] entryValues;
    private String value;
    
    public ListPreference(Context context) {
        super(context);
    }
    
    public CharSequence[] getEntries() {
        return entries;
    }
    
    public void setEntries(CharSequence[] entries) {
        this.entries = entries;
    }
    
    public void setEntries(int entriesResId) {
        // Resource IDs not supported
        this.entries = new CharSequence[0];
    }
    
    public CharSequence[] getEntryValues() {
        return entryValues;
    }
    
    public void setEntryValues(CharSequence[] entryValues) {
        this.entryValues = entryValues;
    }
    
    public void setEntryValues(int entryValuesResId) {
        // Resource IDs not supported
        this.entryValues = new CharSequence[0];
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public void setDefaultValue(Object defaultValue) {
        if (defaultValue instanceof String) {
            this.value = (String) defaultValue;
        }
    }
    
    public int findIndexOfValue(String value) {
        if (entryValues != null && value != null) {
            for (int i = entryValues.length - 1; i >= 0; i--) {
                if (value.contentEquals(entryValues[i])) {
                    return i;
                }
            }
        }
        return -1;
    }
}
