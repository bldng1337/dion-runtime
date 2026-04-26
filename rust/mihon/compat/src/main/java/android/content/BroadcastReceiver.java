package android.content;

/**
 * Minimal BroadcastReceiver stub.
 */
public abstract class BroadcastReceiver {
    
    public abstract void onReceive(Context context, Intent intent);
    
    public final void abortBroadcast() {
    }
    
    public final void clearAbortBroadcast() {
    }
    
    public final boolean getAbortBroadcast() {
        return false;
    }
    
    public final boolean isOrderedBroadcast() {
        return false;
    }
    
    public final void setResultCode(int code) {
    }
    
    public final int getResultCode() {
        return 0;
    }
    
    public final void setResultData(String data) {
    }
    
    public final String getResultData() {
        return null;
    }
    
    public final void setResultExtras(android.os.Bundle extras) {
    }
    
    public final android.os.Bundle getResultExtras(boolean makeMap) {
        return null;
    }
}
