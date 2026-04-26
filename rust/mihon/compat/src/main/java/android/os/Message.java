package android.os;

/**
 * Minimal Message stub.
 */
public final class Message {
    public int what;
    public int arg1;
    public int arg2;
    public Object obj;
    public Bundle data;
    Handler target;
    Runnable callback;
    
    public Message() {
    }
    
    public static Message obtain() {
        return new Message();
    }
    
    public static Message obtain(Handler h) {
        Message m = obtain();
        m.target = h;
        return m;
    }
    
    public static Message obtain(Handler h, int what) {
        Message m = obtain(h);
        m.what = what;
        return m;
    }
    
    public static Message obtain(Handler h, int what, Object obj) {
        Message m = obtain(h, what);
        m.obj = obj;
        return m;
    }
    
    public static Message obtain(Handler h, int what, int arg1, int arg2) {
        Message m = obtain(h, what);
        m.arg1 = arg1;
        m.arg2 = arg2;
        return m;
    }
    
    public static Message obtain(Handler h, int what, int arg1, int arg2, Object obj) {
        Message m = obtain(h, what, arg1, arg2);
        m.obj = obj;
        return m;
    }
    
    public static Message obtain(Handler h, Runnable callback) {
        Message m = obtain(h);
        m.callback = callback;
        return m;
    }
    
    public static Message obtain(Message orig) {
        Message m = obtain();
        m.what = orig.what;
        m.arg1 = orig.arg1;
        m.arg2 = orig.arg2;
        m.obj = orig.obj;
        m.target = orig.target;
        m.callback = orig.callback;
        if (orig.data != null) {
            m.data = new Bundle(orig.data);
        }
        return m;
    }
    
    public void setTarget(Handler target) {
        this.target = target;
    }
    
    public Handler getTarget() {
        return target;
    }
    
    public Runnable getCallback() {
        return callback;
    }
    
    public Bundle getData() {
        if (data == null) {
            data = new Bundle();
        }
        return data;
    }
    
    public Bundle peekData() {
        return data;
    }
    
    public void setData(Bundle data) {
        this.data = data;
    }
    
    public void sendToTarget() {
        if (target != null) {
            target.sendMessage(this);
        }
    }
    
    public void recycle() {
        // No-op in stub
    }
}
