package android.content;

import android.os.Bundle;

/**
 * Minimal Intent stub.
 */
public class Intent {
    public static final String ACTION_MAIN = "android.intent.action.MAIN";
    public static final String ACTION_VIEW = "android.intent.action.VIEW";
    public static final String ACTION_SEND = "android.intent.action.SEND";
    public static final String CATEGORY_LAUNCHER = "android.intent.category.LAUNCHER";
    
    public static final int FLAG_ACTIVITY_NEW_TASK = 0x10000000;
    public static final int FLAG_ACTIVITY_CLEAR_TOP = 0x04000000;
    public static final int FLAG_ACTIVITY_SINGLE_TOP = 0x20000000;
    public static final int FLAG_GRANT_READ_URI_PERMISSION = 0x00000001;
    public static final int FLAG_GRANT_WRITE_URI_PERMISSION = 0x00000002;
    
    private String mAction;
    private android.net.Uri mData;
    private String mType;
    private String mPackage;
    private ComponentName mComponent;
    private int mFlags;
    private Bundle mExtras;
    
    public Intent() {
        mExtras = new Bundle();
    }
    
    public Intent(String action) {
        this();
        mAction = action;
    }
    
    public Intent(String action, android.net.Uri uri) {
        this(action);
        mData = uri;
    }
    
    public Intent(Intent other) {
        this();
        mAction = other.mAction;
        mData = other.mData;
        mType = other.mType;
        mPackage = other.mPackage;
        mComponent = other.mComponent;
        mFlags = other.mFlags;
        mExtras = new Bundle(other.mExtras);
    }
    
    public String getAction() {
        return mAction;
    }
    
    public Intent setAction(String action) {
        mAction = action;
        return this;
    }
    
    public android.net.Uri getData() {
        return mData;
    }
    
    public Intent setData(android.net.Uri data) {
        mData = data;
        mType = null;
        return this;
    }
    
    public String getType() {
        return mType;
    }
    
    public Intent setType(String type) {
        mType = type;
        mData = null;
        return this;
    }
    
    public Intent setDataAndType(android.net.Uri data, String type) {
        mData = data;
        mType = type;
        return this;
    }
    
    public String getPackage() {
        return mPackage;
    }
    
    public Intent setPackage(String packageName) {
        mPackage = packageName;
        return this;
    }
    
    public ComponentName getComponent() {
        return mComponent;
    }
    
    public Intent setComponent(ComponentName component) {
        mComponent = component;
        return this;
    }
    
    public int getFlags() {
        return mFlags;
    }
    
    public Intent setFlags(int flags) {
        mFlags = flags;
        return this;
    }
    
    public Intent addFlags(int flags) {
        mFlags |= flags;
        return this;
    }
    
    public Bundle getExtras() {
        return mExtras;
    }
    
    public Intent putExtra(String name, boolean value) {
        mExtras.putBoolean(name, value);
        return this;
    }
    
    public Intent putExtra(String name, int value) {
        mExtras.putInt(name, value);
        return this;
    }
    
    public Intent putExtra(String name, long value) {
        mExtras.putLong(name, value);
        return this;
    }
    
    public Intent putExtra(String name, String value) {
        mExtras.putString(name, value);
        return this;
    }
    
    public boolean getBooleanExtra(String name, boolean defaultValue) {
        return mExtras.getBoolean(name, defaultValue);
    }
    
    public int getIntExtra(String name, int defaultValue) {
        return mExtras.getInt(name, defaultValue);
    }
    
    public long getLongExtra(String name, long defaultValue) {
        return mExtras.getLong(name, defaultValue);
    }
    
    public String getStringExtra(String name) {
        return mExtras.getString(name);
    }
    
    public boolean hasExtra(String name) {
        return mExtras.containsKey(name);
    }
    
    @Override
    public String toString() {
        return "Intent{action=" + mAction + ", data=" + mData + ", component=" + mComponent + "}";
    }
}
