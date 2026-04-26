package androidx.preference;

import android.content.Context;

/**
 * TwoStatePreference stub - base class for boolean preferences
 */
public abstract class TwoStatePreference extends Preference {
    
    protected boolean checked;
    protected CharSequence summaryOn;
    protected CharSequence summaryOff;
    
    public TwoStatePreference(Context context) {
        super(context);
    }
    
    public boolean isChecked() {
        return checked;
    }
    
    public void setChecked(boolean checked) {
        this.checked = checked;
    }
    
    public CharSequence getSummaryOn() {
        return summaryOn;
    }
    
    public void setSummaryOn(CharSequence summary) {
        this.summaryOn = summary;
    }
    
    public CharSequence getSummaryOff() {
        return summaryOff;
    }
    
    public void setSummaryOff(CharSequence summary) {
        this.summaryOff = summary;
    }
}
