package android.content.res;

/**
 * Minimal TypedArray stub.
 */
public class TypedArray {
    public TypedArray() {
    }
    
    public int length() {
        return 0;
    }
    
    public int getIndexCount() {
        return 0;
    }
    
    public int getIndex(int at) {
        return 0;
    }
    
    public String getString(int index) {
        return null;
    }
    
    public String getNonResourceString(int index) {
        return null;
    }
    
    public boolean getBoolean(int index, boolean defValue) {
        return defValue;
    }
    
    public int getInt(int index, int defValue) {
        return defValue;
    }
    
    public float getFloat(int index, float defValue) {
        return defValue;
    }
    
    public int getColor(int index, int defValue) {
        return defValue;
    }
    
    public float getDimension(int index, float defValue) {
        return defValue;
    }
    
    public int getResourceId(int index, int defValue) {
        return defValue;
    }
    
    public boolean hasValue(int index) {
        return false;
    }
    
    public void recycle() {
    }
}
