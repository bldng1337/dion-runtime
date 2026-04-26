package android.os;

/**
 * Minimal SystemClock stub.
 */
public final class SystemClock {
    private SystemClock() {
    }
    
    public static long uptimeMillis() {
        return System.nanoTime() / 1_000_000L;
    }
    
    public static long elapsedRealtime() {
        return System.nanoTime() / 1_000_000L;
    }
    
    public static long elapsedRealtimeNanos() {
        return System.nanoTime();
    }
    
    public static long currentThreadTimeMillis() {
        return System.currentTimeMillis();
    }
    
    public static boolean setCurrentTimeMillis(long millis) {
        return false;
    }
    
    public static void sleep(long ms) {
        try {
            Thread.sleep(ms);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
