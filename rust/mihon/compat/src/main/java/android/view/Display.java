package android.view;

/**
 * Minimal Display stub.
 */
public final class Display {
    public static final int DEFAULT_DISPLAY = 0;
    
    private final int mDisplayId;
    
    public Display(int displayId) {
        mDisplayId = displayId;
    }
    
    public int getDisplayId() {
        return mDisplayId;
    }
    
    public int getWidth() {
        return 1920;
    }
    
    public int getHeight() {
        return 1080;
    }
    
    public void getSize(android.graphics.Point outSize) {
        outSize.x = getWidth();
        outSize.y = getHeight();
    }
    
    public int getRotation() {
        return 0;
    }
}
