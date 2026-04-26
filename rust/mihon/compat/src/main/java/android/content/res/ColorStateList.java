package android.content.res;

/**
 * Minimal ColorStateList stub.
 */
public class ColorStateList {
    private final int mDefaultColor;
    
    public ColorStateList(int[][] states, int[] colors) {
        mDefaultColor = colors.length > 0 ? colors[0] : 0;
    }
    
    public static ColorStateList valueOf(int color) {
        return new ColorStateList(new int[0][], new int[]{ color });
    }
    
    public int getDefaultColor() {
        return mDefaultColor;
    }
    
    public int getColorForState(int[] stateSet, int defaultColor) {
        return defaultColor;
    }
}
