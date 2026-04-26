package androidx.preference;

import android.content.Context;
import java.util.HashSet;
import java.util.Set;

/**
 * MultiSelectListPreference stub
 */
public class MultiSelectListPreference extends DialogPreference {
    
    private CharSequence[] entries;
    private CharSequence[] entryValues;
    private Set<String> values = new HashSet<>();
    
    public MultiSelectListPreference(Context context) {
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
    
    public Set<String> getValues() {
        return values;
    }
    
    public void setValues(Set<String> values) {
        this.values = values;
    }
    
    public void setDefaultValue(Object defaultValue) {
        if (defaultValue instanceof Set) {
            @SuppressWarnings("unchecked")
            Set<String> set = (Set<String>) defaultValue;
            this.values = new HashSet<>(set);
        }
    }
}
