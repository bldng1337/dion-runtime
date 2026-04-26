package androidx.preference;

import android.content.Context;

/**
 * DialogPreference stub - base class for dialog-based preferences
 */
public abstract class DialogPreference extends Preference {
    
    private CharSequence dialogTitle;
    private CharSequence dialogMessage;
    private CharSequence positiveButtonText;
    private CharSequence negativeButtonText;
    
    public DialogPreference(Context context) {
        super(context);
    }
    
    public CharSequence getDialogTitle() {
        return dialogTitle;
    }
    
    public void setDialogTitle(CharSequence dialogTitle) {
        this.dialogTitle = dialogTitle;
    }
    
    public void setDialogTitle(int dialogTitleResId) {
        // Resource IDs not supported
        this.dialogTitle = "";
    }
    
    public CharSequence getDialogMessage() {
        return dialogMessage;
    }
    
    public void setDialogMessage(CharSequence dialogMessage) {
        this.dialogMessage = dialogMessage;
    }
    
    public void setDialogMessage(int dialogMessageResId) {
        // Resource IDs not supported
        this.dialogMessage = "";
    }
    
    public CharSequence getPositiveButtonText() {
        return positiveButtonText;
    }
    
    public void setPositiveButtonText(CharSequence positiveButtonText) {
        this.positiveButtonText = positiveButtonText;
    }
    
    public void setPositiveButtonText(int positiveButtonTextResId) {
        // Resource IDs not supported
        this.positiveButtonText = "";
    }
    
    public CharSequence getNegativeButtonText() {
        return negativeButtonText;
    }
    
    public void setNegativeButtonText(CharSequence negativeButtonText) {
        this.negativeButtonText = negativeButtonText;
    }
    
    public void setNegativeButtonText(int negativeButtonTextResId) {
        // Resource IDs not supported
        this.negativeButtonText = "";
    }
}
