package android.graphics;

import java.io.InputStream;
import java.io.OutputStream;

/**
 * Minimal Bitmap stub.
 */
public final class Bitmap {
    
    public enum Config {
        ALPHA_8,
        RGB_565,
        ARGB_4444,
        ARGB_8888,
        RGBA_F16,
        HARDWARE
    }
    
    public enum CompressFormat {
        JPEG,
        PNG,
        WEBP,
        WEBP_LOSSY,
        WEBP_LOSSLESS
    }
    
    private int mWidth;
    private int mHeight;
    private Config mConfig;
    
    private Bitmap(int width, int height, Config config) {
        mWidth = width;
        mHeight = height;
        mConfig = config;
    }
    
    public static Bitmap createBitmap(int width, int height, Config config) {
        return new Bitmap(width, height, config);
    }
    
    public static Bitmap createBitmap(Bitmap source, int x, int y, int width, int height) {
        return new Bitmap(width, height, source.mConfig);
    }
    
    public int getWidth() {
        return mWidth;
    }
    
    public int getHeight() {
        return mHeight;
    }
    
    public Config getConfig() {
        return mConfig;
    }
    
    public int getPixel(int x, int y) {
        return 0;
    }
    
    public void setPixel(int x, int y, int color) {
    }
    
    public boolean compress(CompressFormat format, int quality, OutputStream stream) {
        return false;
    }
    
    public void recycle() {
    }
    
    public boolean isRecycled() {
        return false;
    }
}
