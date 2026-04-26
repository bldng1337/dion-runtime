package android.os;

/**
 * Minimal Handler stub.
 */
public class Handler {
    private Looper mLooper;
    private Callback mCallback;
    
    public interface Callback {
        boolean handleMessage(Message msg);
    }
    
    public Handler() {
        mLooper = Looper.myLooper();
        if (mLooper == null) {
            mLooper = Looper.getMainLooper();
        }
    }
    
    public Handler(Looper looper) {
        mLooper = looper;
    }
    
    public Handler(Callback callback) {
        this();
        mCallback = callback;
    }
    
    public Handler(Looper looper, Callback callback) {
        mLooper = looper;
        mCallback = callback;
    }
    
    public final Looper getLooper() {
        return mLooper;
    }
    
    public void handleMessage(Message msg) {
    }
    
    public final boolean post(Runnable r) {
        // In stub, just run immediately on current thread
        r.run();
        return true;
    }
    
    public final boolean postAtTime(Runnable r, long uptimeMillis) {
        return post(r);
    }
    
    public final boolean postAtTime(Runnable r, Object token, long uptimeMillis) {
        return post(r);
    }
    
    public final boolean postDelayed(Runnable r, long delayMillis) {
        // In stub, just run immediately
        r.run();
        return true;
    }
    
    public final boolean postDelayed(Runnable r, Object token, long delayMillis) {
        return postDelayed(r, delayMillis);
    }
    
    public final boolean postAtFrontOfQueue(Runnable r) {
        return post(r);
    }
    
    public final void removeCallbacks(Runnable r) {
    }
    
    public final void removeCallbacks(Runnable r, Object token) {
    }
    
    public final boolean sendMessage(Message msg) {
        return sendMessageDelayed(msg, 0);
    }
    
    public final boolean sendEmptyMessage(int what) {
        return sendEmptyMessageDelayed(what, 0);
    }
    
    public final boolean sendEmptyMessageDelayed(int what, long delayMillis) {
        Message msg = Message.obtain();
        msg.what = what;
        return sendMessageDelayed(msg, delayMillis);
    }
    
    public final boolean sendEmptyMessageAtTime(int what, long uptimeMillis) {
        Message msg = Message.obtain();
        msg.what = what;
        return sendMessageAtTime(msg, uptimeMillis);
    }
    
    public final boolean sendMessageDelayed(Message msg, long delayMillis) {
        return sendMessageAtTime(msg, SystemClock.uptimeMillis() + delayMillis);
    }
    
    public boolean sendMessageAtTime(Message msg, long uptimeMillis) {
        // In stub, dispatch immediately
        dispatchMessage(msg);
        return true;
    }
    
    public final boolean sendMessageAtFrontOfQueue(Message msg) {
        dispatchMessage(msg);
        return true;
    }
    
    public void dispatchMessage(Message msg) {
        if (msg.callback != null) {
            msg.callback.run();
        } else {
            if (mCallback != null) {
                if (mCallback.handleMessage(msg)) {
                    return;
                }
            }
            handleMessage(msg);
        }
    }
    
    public final void removeMessages(int what) {
    }
    
    public final void removeMessages(int what, Object object) {
    }
    
    public final void removeCallbacksAndMessages(Object token) {
    }
    
    public final boolean hasMessages(int what) {
        return false;
    }
    
    public final boolean hasMessages(int what, Object object) {
        return false;
    }
    
    public final boolean hasCallbacks(Runnable r) {
        return false;
    }
    
    public final Message obtainMessage() {
        return Message.obtain(this);
    }
    
    public final Message obtainMessage(int what) {
        return Message.obtain(this, what);
    }
    
    public final Message obtainMessage(int what, Object obj) {
        return Message.obtain(this, what, obj);
    }
    
    public final Message obtainMessage(int what, int arg1, int arg2) {
        return Message.obtain(this, what, arg1, arg2);
    }
    
    public final Message obtainMessage(int what, int arg1, int arg2, Object obj) {
        return Message.obtain(this, what, arg1, arg2, obj);
    }
}
