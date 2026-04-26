package android.os;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Minimal Bundle stub for storing key-value pairs.
 */
public class Bundle {
    private final Map<String, Object> mMap;
    
    public Bundle() {
        mMap = new HashMap<>();
    }
    
    public Bundle(int capacity) {
        mMap = new HashMap<>(capacity);
    }
    
    public Bundle(Bundle b) {
        if (b != null) {
            mMap = new HashMap<>(b.mMap);
        } else {
            mMap = new HashMap<>();
        }
    }
    
    public void putString(String key, String value) {
        mMap.put(key, value);
    }
    
    public String getString(String key) {
        Object o = mMap.get(key);
        return o instanceof String ? (String) o : null;
    }
    
    public String getString(String key, String defaultValue) {
        String s = getString(key);
        return s != null ? s : defaultValue;
    }
    
    public void putInt(String key, int value) {
        mMap.put(key, value);
    }
    
    public int getInt(String key) {
        return getInt(key, 0);
    }
    
    public int getInt(String key, int defaultValue) {
        Object o = mMap.get(key);
        if (o instanceof Integer) {
            return (Integer) o;
        }
        return defaultValue;
    }
    
    public void putLong(String key, long value) {
        mMap.put(key, value);
    }
    
    public long getLong(String key) {
        return getLong(key, 0L);
    }
    
    public long getLong(String key, long defaultValue) {
        Object o = mMap.get(key);
        if (o instanceof Long) {
            return (Long) o;
        }
        return defaultValue;
    }
    
    public void putBoolean(String key, boolean value) {
        mMap.put(key, value);
    }
    
    public boolean getBoolean(String key) {
        return getBoolean(key, false);
    }
    
    public boolean getBoolean(String key, boolean defaultValue) {
        Object o = mMap.get(key);
        if (o instanceof Boolean) {
            return (Boolean) o;
        }
        return defaultValue;
    }
    
    public void putFloat(String key, float value) {
        mMap.put(key, value);
    }
    
    public float getFloat(String key) {
        return getFloat(key, 0f);
    }
    
    public float getFloat(String key, float defaultValue) {
        Object o = mMap.get(key);
        if (o instanceof Float) {
            return (Float) o;
        }
        return defaultValue;
    }
    
    public void putDouble(String key, double value) {
        mMap.put(key, value);
    }
    
    public double getDouble(String key) {
        return getDouble(key, 0.0);
    }
    
    public double getDouble(String key, double defaultValue) {
        Object o = mMap.get(key);
        if (o instanceof Double) {
            return (Double) o;
        }
        return defaultValue;
    }
    
    public void putBundle(String key, Bundle value) {
        mMap.put(key, value);
    }
    
    public Bundle getBundle(String key) {
        Object o = mMap.get(key);
        return o instanceof Bundle ? (Bundle) o : null;
    }
    
    public boolean containsKey(String key) {
        return mMap.containsKey(key);
    }
    
    public Object get(String key) {
        return mMap.get(key);
    }
    
    public void remove(String key) {
        mMap.remove(key);
    }
    
    public void clear() {
        mMap.clear();
    }
    
    public boolean isEmpty() {
        return mMap.isEmpty();
    }
    
    public int size() {
        return mMap.size();
    }
    
    public Set<String> keySet() {
        return mMap.keySet();
    }
    
    public void putAll(Bundle bundle) {
        if (bundle != null) {
            mMap.putAll(bundle.mMap);
        }
    }
    
    public static final Bundle EMPTY = new Bundle() {
        @Override
        public void putString(String key, String value) {
            throw new UnsupportedOperationException("Cannot modify EMPTY bundle");
        }
    };
}
