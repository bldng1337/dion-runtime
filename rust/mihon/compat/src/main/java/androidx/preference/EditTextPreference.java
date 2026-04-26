package androidx.preference;

import android.content.Context;
import android.widget.EditText;

/**
 * EditTextPreference stub
 */
public class EditTextPreference extends DialogPreference {
    
    private String text;
    private OnBindEditTextListener onBindEditTextListener;
    
    public EditTextPreference(Context context) {
        super(context);
    }
    
    public String getText() {
        return text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    public void setDefaultValue(Object defaultValue) {
        if (defaultValue instanceof String) {
            this.text = (String) defaultValue;
        }
    }
    
    public void setOnBindEditTextListener(OnBindEditTextListener listener) {
        this.onBindEditTextListener = listener;
    }
    
    public OnBindEditTextListener getOnBindEditTextListener() {
        return onBindEditTextListener;
    }
    
    /**
     * Interface for customizing the EditText widget.
     */
    public interface OnBindEditTextListener {
        void onBindEditText(EditText editText);
    }
}
