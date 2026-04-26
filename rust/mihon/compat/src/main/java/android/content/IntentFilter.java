package android.content;

/**
 * Minimal IntentFilter stub.
 */
public class IntentFilter {
    private String mAction;
    private String mDataScheme;
    private String mDataType;
    
    public IntentFilter() {
    }
    
    public IntentFilter(String action) {
        mAction = action;
    }
    
    public void addAction(String action) {
        mAction = action;
    }
    
    public void addDataScheme(String scheme) {
        mDataScheme = scheme;
    }
    
    public void addDataType(String type) {
        mDataType = type;
    }
    
    public boolean hasAction(String action) {
        return action.equals(mAction);
    }
}
