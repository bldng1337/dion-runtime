package android.content.pm;

import android.content.ComponentName;
import android.content.Intent;
import android.graphics.drawable.Drawable;

import java.util.List;

/**
 * Minimal PackageManager stub.
 */
public abstract class PackageManager {
    public static final int PERMISSION_GRANTED = 0;
    public static final int PERMISSION_DENIED = -1;
    
    public static final int GET_ACTIVITIES = 0x00000001;
    public static final int GET_RECEIVERS = 0x00000002;
    public static final int GET_SERVICES = 0x00000004;
    public static final int GET_PROVIDERS = 0x00000008;
    public static final int GET_INSTRUMENTATION = 0x00000010;
    public static final int GET_INTENT_FILTERS = 0x00000020;
    public static final int GET_SIGNATURES = 0x00000040;
    public static final int GET_META_DATA = 0x00000080;
    public static final int GET_GIDS = 0x00000100;
    public static final int GET_DISABLED_COMPONENTS = 0x00000200;
    public static final int GET_SHARED_LIBRARY_FILES = 0x00000400;
    public static final int GET_URI_PERMISSION_PATTERNS = 0x00000800;
    public static final int GET_PERMISSIONS = 0x00001000;
    public static final int GET_UNINSTALLED_PACKAGES = 0x00002000;
    public static final int GET_CONFIGURATIONS = 0x00004000;
    public static final int GET_DISABLED_UNTIL_USED_COMPONENTS = 0x00008000;
    
    public static class NameNotFoundException extends Exception {
        public NameNotFoundException() {
            super();
        }
        
        public NameNotFoundException(String name) {
            super(name);
        }
    }
    
    public abstract PackageInfo getPackageInfo(String packageName, int flags) throws NameNotFoundException;
    public abstract ApplicationInfo getApplicationInfo(String packageName, int flags) throws NameNotFoundException;
    public abstract CharSequence getApplicationLabel(ApplicationInfo info);
    public abstract Drawable getApplicationIcon(ApplicationInfo info);
    public abstract Drawable getApplicationIcon(String packageName) throws NameNotFoundException;
    public abstract List<PackageInfo> getInstalledPackages(int flags);
    public abstract List<ApplicationInfo> getInstalledApplications(int flags);
    public abstract Intent getLaunchIntentForPackage(String packageName);
    public abstract int checkPermission(String permName, String pkgName);
}
