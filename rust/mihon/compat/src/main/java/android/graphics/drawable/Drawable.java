package android.graphics.drawable;

import android.content.res.ColorStateList;

/**
 * Minimal Drawable stub.
 */
public abstract class Drawable {
    public abstract void draw(android.graphics.Canvas canvas);
    public abstract void setAlpha(int alpha);
    public abstract void setColorFilter(android.graphics.ColorFilter colorFilter);
    public abstract int getOpacity();
    
    public void setBounds(int left, int top, int right, int bottom) {
    }
    
    public int getIntrinsicWidth() {
        return -1;
    }
    
    public int getIntrinsicHeight() {
        return -1;
    }
    
    public int getMinimumWidth() {
        return 0;
    }
    
    public int getMinimumHeight() {
        return 0;
    }
    
    public boolean isStateful() {
        return false;
    }
    
    public boolean setState(int[] stateSet) {
        return false;
    }
    
    public int[] getState() {
        return new int[0];
    }
    
    public void setTint(int tintColor) {
    }
    
    public void setTintList(ColorStateList tint) {
    }
}
