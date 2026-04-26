package android.content;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Minimal ContentValues stub.
 */
public final class ContentValues {
    private final HashMap<String, Object> mValues;
    
    public ContentValues() {
        mValues = new HashMap<>();
    }
    
    public ContentValues(int size) {
        mValues = new HashMap<>(size);
    }
    
    public ContentValues(ContentValues from) {
        mValues = new HashMap<>(from.mValues);
    }
    
    public void put(String key, String value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Byte value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Short value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Integer value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Long value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Float value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Double value) {
        mValues.put(key, value);
    }
    
    public void put(String key, Boolean value) {
        mValues.put(key, value);
    }
    
    public void put(String key, byte[] value) {
        mValues.put(key, value);
    }
    
    public void putNull(String key) {
        mValues.put(key, null);
    }
    
    public int size() {
        return mValues.size();
    }
    
    public void remove(String key) {
        mValues.remove(key);
    }
    
    public void clear() {
        mValues.clear();
    }
    
    public boolean containsKey(String key) {
        return mValues.containsKey(key);
    }
    
    public Object get(String key) {
        return mValues.get(key);
    }
    
    public String getAsString(String key) {
        Object value = mValues.get(key);
        return value != null ? value.toString() : null;
    }
    
    public Long getAsLong(String key) {
        Object value = mValues.get(key);
        if (value instanceof Long) return (Long) value;
        if (value instanceof Number) return ((Number) value).longValue();
        if (value instanceof String) {
            try { return Long.parseLong((String) value); } catch (NumberFormatException e) {}
        }
        return null;
    }
    
    public Integer getAsInteger(String key) {
        Object value = mValues.get(key);
        if (value instanceof Integer) return (Integer) value;
        if (value instanceof Number) return ((Number) value).intValue();
        if (value instanceof String) {
            try { return Integer.parseInt((String) value); } catch (NumberFormatException e) {}
        }
        return null;
    }
    
    public Boolean getAsBoolean(String key) {
        Object value = mValues.get(key);
        if (value instanceof Boolean) return (Boolean) value;
        return null;
    }
    
    public Set<Map.Entry<String, Object>> valueSet() {
        return mValues.entrySet();
    }
    
    public Set<String> keySet() {
        return mValues.keySet();
    }
}
