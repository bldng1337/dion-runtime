package android.content;

/**
 * Minimal ComponentName stub.
 */
public final class ComponentName {
    private final String mPackage;
    private final String mClass;
    
    public ComponentName(String pkg, String cls) {
        mPackage = pkg;
        mClass = cls;
    }
    
    public ComponentName(Context context, String cls) {
        mPackage = context.getPackageName();
        mClass = cls;
    }
    
    public ComponentName(Context context, Class<?> cls) {
        mPackage = context.getPackageName();
        mClass = cls.getName();
    }
    
    public String getPackageName() {
        return mPackage;
    }
    
    public String getClassName() {
        return mClass;
    }
    
    public String getShortClassName() {
        if (mClass.startsWith(mPackage)) {
            int pn = mPackage.length();
            int cn = mClass.length();
            if (cn > pn && mClass.charAt(pn) == '.') {
                return mClass.substring(pn);
            }
        }
        return mClass;
    }
    
    public String flattenToString() {
        return mPackage + "/" + mClass;
    }
    
    public String flattenToShortString() {
        return mPackage + "/" + getShortClassName();
    }
    
    public static ComponentName unflattenFromString(String str) {
        int sep = str.indexOf('/');
        if (sep < 0 || sep + 1 >= str.length()) {
            return null;
        }
        String pkg = str.substring(0, sep);
        String cls = str.substring(sep + 1);
        if (!cls.isEmpty() && cls.charAt(0) == '.') {
            cls = pkg + cls;
        }
        return new ComponentName(pkg, cls);
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof ComponentName) {
            ComponentName other = (ComponentName) obj;
            return mPackage.equals(other.mPackage) && mClass.equals(other.mClass);
        }
        return false;
    }
    
    @Override
    public int hashCode() {
        return mPackage.hashCode() + mClass.hashCode();
    }
    
    @Override
    public String toString() {
        return "ComponentInfo{" + mPackage + "/" + mClass + "}";
    }
}
