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

    /**
     * Returns the advance width of each character in {@code text}.
     *
     * Real Android computes this from the loaded typeface; we only have a
     * rough uniform estimate, which is enough for extensions that just need
     * the method to exist (e.g. the Webtoons title decoder).
     *
     * @return the number of characters written into {@code widths}
     */
    public int getTextWidths(String text, float[] widths) {
        int count = Math.min(text.length(), widths.length);
        for (int i = 0; i < count; i++) {
            widths[i] = 10f;
        }
        return count;
    }
}
