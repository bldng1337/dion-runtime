package android.graphics;

/**
 * Minimal Paint stub.
 */
public class Paint {
    public Paint() {
    }
    
    public Paint(int flags) {
    }
    
    public void setColor(int color) {
    }
    
    public int getColor() {
        return 0;
    }
    
    public void setAlpha(int alpha) {
    }
    
    public int getAlpha() {
        return 255;
    }
    
    public void setTextSize(float textSize) {
    }
    
    public float getTextSize() {
        return 12f;
    }
    
    public void setAntiAlias(boolean aa) {
    }
    
    public boolean isAntiAlias() {
        return false;
    }
    
    public float measureText(String text) {
        return text.length() * 10f; // Rough estimate
    }
}
