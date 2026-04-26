package android.os;

/**
 * Minimal Looper stub.
 */
public final class Looper {
    private static final ThreadLocal<Looper> sThreadLocal = new ThreadLocal<>();
    private static Looper sMainLooper;
    
    private Thread mThread;
    
    private Looper() {
        mThread = Thread.currentThread();
    }
    
    public static void prepare() {
        if (sThreadLocal.get() != null) {
            throw new RuntimeException("Only one Looper may be created per thread");
        }
        sThreadLocal.set(new Looper());
    }
    
    public static void prepareMainLooper() {
        prepare();
        synchronized (Looper.class) {
            if (sMainLooper != null) {
                throw new IllegalStateException("The main Looper has already been prepared.");
            }
            sMainLooper = myLooper();
        }
    }
    
    public static Looper getMainLooper() {
        synchronized (Looper.class) {
            if (sMainLooper == null) {
                // Auto-create main looper if not exists
                sMainLooper = new Looper();
            }
            return sMainLooper;
        }
    }
    
    public static Looper myLooper() {
        return sThreadLocal.get();
    }
    
    public Thread getThread() {
        return mThread;
    }
    
    public boolean isCurrentThread() {
        return Thread.currentThread() == mThread;
    }
    
    public void quit() {
    }
    
    public void quitSafely() {
    }
    
    public static void loop() {
        // Stub - no actual message loop
    }
}
