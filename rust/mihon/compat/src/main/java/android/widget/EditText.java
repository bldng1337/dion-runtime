package android.widget;

import android.content.Context;

/**
 * Minimal EditText stub for Mihon extension compatibility.
 */
public class EditText {
    
    private String text = "";
    private int inputType = 0;
    private boolean selectAllOnFocus = false;
    
    public EditText(Context context) {
    }
    
    public void setText(CharSequence text) {
        this.text = text != null ? text.toString() : "";
    }
    
    public CharSequence getText() {
        return text;
    }
    
    public void setInputType(int type) {
        this.inputType = type;
    }
    
    public int getInputType() {
        return inputType;
    }
    
    public void setSelectAllOnFocus(boolean selectAllOnFocus) {
        this.selectAllOnFocus = selectAllOnFocus;
    }
    
    public void setSelection(int start, int stop) {
        // No-op
    }
    
    public void setSelection(int index) {
        // No-op
    }
}
