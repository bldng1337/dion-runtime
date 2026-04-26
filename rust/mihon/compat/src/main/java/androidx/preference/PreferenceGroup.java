package androidx.preference;

import android.content.Context;
import android.util.AttributeSet;
import java.util.ArrayList;
import java.util.List;

/**
 * PreferenceGroup stub - base class for preference containers
 */
public abstract class PreferenceGroup extends Preference {
    
    private List<Preference> preferences = new ArrayList<>();
    
    public PreferenceGroup(Context context, AttributeSet attrs) {
        super(context);
    }
    
    public void addPreference(Preference preference) {
        preferences.add(preference);
    }
    
    public boolean removePreference(Preference preference) {
        return preferences.remove(preference);
    }
    
    public void removeAll() {
        preferences.clear();
    }
    
    public int getPreferenceCount() {
        return preferences.size();
    }
    
    public Preference getPreference(int index) {
        return preferences.get(index);
    }
    
    public Preference findPreference(CharSequence key) {
        for (Preference pref : preferences) {
            if (key != null && key.equals(pref.getKey())) {
                return pref;
            }
        }
        return null;
    }
}
