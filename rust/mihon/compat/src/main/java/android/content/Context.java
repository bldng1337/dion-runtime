package android.content;

import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.UserHandle;
import android.net.Uri;
import android.view.Display;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

/**
 * Minimal Android Context stub for Mihon extensions.
 */
public abstract class Context {
    
    public static final int MODE_PRIVATE = 0x0000;
    public static final int MODE_WORLD_READABLE = 0x0001;
    public static final int MODE_WORLD_WRITEABLE = 0x0002;
    public static final int MODE_APPEND = 0x8000;
    public static final int MODE_MULTI_PROCESS = 0x0004;
    public static final int MODE_ENABLE_WRITE_AHEAD_LOGGING = 0x0008;
    public static final int MODE_NO_LOCALIZED_COLLATORS = 0x0010;
    
    public static final int BIND_AUTO_CREATE = 0x0001;
    public static final int BIND_DEBUG_UNBIND = 0x0002;
    public static final int BIND_NOT_FOREGROUND = 0x0004;
    public static final int BIND_ABOVE_CLIENT = 0x0008;
    public static final int BIND_ALLOW_OOM_MANAGEMENT = 0x0010;
    public static final int BIND_WAIVE_PRIORITY = 0x0020;
    public static final int BIND_IMPORTANT = 0x0040;
    public static final int BIND_ADJUST_WITH_ACTIVITY = 0x0080;
    
    // Core abstract methods that extensions need
    public abstract AssetManager getAssets();
    public abstract Resources getResources();
    public abstract PackageManager getPackageManager();
    public abstract ContentResolver getContentResolver();
    public abstract Looper getMainLooper();
    public abstract Context getApplicationContext();
    public abstract void setTheme(int resid);
    public abstract Resources.Theme getTheme();
    public abstract ClassLoader getClassLoader();
    public abstract String getPackageName();
    public abstract String getBasePackageName();
    public abstract String getOpPackageName();
    public abstract ApplicationInfo getApplicationInfo();
    public abstract String getPackageResourcePath();
    public abstract String getPackageCodePath();
    public abstract SharedPreferences getSharedPreferences(String name, int mode);
    public abstract SharedPreferences getSharedPreferences(File file, int mode);
    public abstract boolean moveSharedPreferencesFrom(Context sourceContext, String name);
    public abstract boolean deleteSharedPreferences(String name);
    public abstract FileInputStream openFileInput(String name) throws FileNotFoundException;
    public abstract FileOutputStream openFileOutput(String name, int mode) throws FileNotFoundException;
    public abstract boolean deleteFile(String name);
    public abstract File getFileStreamPath(String name);
    public abstract File getSharedPreferencesPath(String name);
    public abstract File getDataDir();
    public abstract File getFilesDir();
    public abstract File getNoBackupFilesDir();
    public abstract File getExternalFilesDir(String type);
    public abstract File[] getExternalFilesDirs(String type);
    public abstract File getObbDir();
    public abstract File[] getObbDirs();
    public abstract File getCacheDir();
    public abstract File getCodeCacheDir();
    public abstract File getExternalCacheDir();
    public abstract File[] getExternalCacheDirs();
    public abstract File[] getExternalMediaDirs();
    public abstract File getDir(String name, int mode);
    public abstract String[] fileList();
    public abstract File getDatabasePath(String name);
    public abstract SQLiteDatabase openOrCreateDatabase(String name, int mode, SQLiteDatabase.CursorFactory factory);
    public abstract SQLiteDatabase openOrCreateDatabase(String name, int mode, SQLiteDatabase.CursorFactory factory, android.database.DatabaseErrorHandler errorHandler);
    public abstract boolean moveDatabaseFrom(Context sourceContext, String name);
    public abstract boolean deleteDatabase(String name);
    public abstract String[] databaseList();
    public abstract Object getSystemService(String name);
    public abstract String getSystemServiceName(Class<?> serviceClass);
    public abstract int checkPermission(String permission, int pid, int uid);
    public abstract int checkCallingPermission(String permission);
    public abstract int checkCallingOrSelfPermission(String permission);
    public abstract int checkSelfPermission(String permission);
    public abstract void enforcePermission(String permission, int pid, int uid, String message);
    public abstract void enforceCallingPermission(String permission, String message);
    public abstract void enforceCallingOrSelfPermission(String permission, String message);
    public abstract void grantUriPermission(String toPackage, Uri uri, int modeFlags);
    public abstract void revokeUriPermission(Uri uri, int modeFlags);
    public abstract void revokeUriPermission(String toPackage, Uri uri, int modeFlags);
    public abstract int checkUriPermission(Uri uri, int pid, int uid, int modeFlags);
    public abstract int checkCallingUriPermission(Uri uri, int modeFlags);
    public abstract int checkCallingOrSelfUriPermission(Uri uri, int modeFlags);
    public abstract int checkUriPermission(Uri uri, String readPermission, String writePermission, int pid, int uid, int modeFlags);
    public abstract void enforceUriPermission(Uri uri, int pid, int uid, int modeFlags, String message);
    public abstract void enforceCallingUriPermission(Uri uri, int modeFlags, String message);
    public abstract void enforceCallingOrSelfUriPermission(Uri uri, int modeFlags, String message);
    public abstract void enforceUriPermission(Uri uri, String readPermission, String writePermission, int pid, int uid, int modeFlags, String message);
    public abstract Context createPackageContext(String packageName, int flags) throws PackageManager.NameNotFoundException;
    public abstract Context createConfigurationContext(Configuration overrideConfiguration);
    public abstract Context createDisplayContext(Display display);
    public abstract Context createDeviceProtectedStorageContext();
    public abstract boolean isDeviceProtectedStorage();
    
    // Activity/Service/Broadcast methods - most extensions don't use these
    public abstract void startActivity(Intent intent);
    public abstract void startActivity(Intent intent, Bundle options);
    public abstract void startActivities(Intent[] intents);
    public abstract void startActivities(Intent[] intents, Bundle options);
    public abstract void startIntentSender(IntentSender intent, Intent fillInIntent, int flagsMask, int flagsValues, int extraFlags) throws IntentSender.SendIntentException;
    public abstract void startIntentSender(IntentSender intent, Intent fillInIntent, int flagsMask, int flagsValues, int extraFlags, Bundle options) throws IntentSender.SendIntentException;
    public abstract void sendBroadcast(Intent intent);
    public abstract void sendBroadcast(Intent intent, String receiverPermission);
    public abstract void sendBroadcast(Intent intent, String receiverPermission, int appOp);
    public abstract void sendOrderedBroadcast(Intent intent, String receiverPermission);
    public abstract void sendOrderedBroadcast(Intent intent, String receiverPermission, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras);
    public abstract void sendOrderedBroadcast(Intent intent, String receiverPermission, int appOp, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras);
    public abstract void sendBroadcastAsUser(Intent intent, UserHandle user);
    public abstract void sendBroadcastAsUser(Intent intent, UserHandle user, String receiverPermission);
    public abstract void sendBroadcastAsUser(Intent intent, UserHandle user, String receiverPermission, Bundle options);
    public abstract void sendOrderedBroadcastAsUser(Intent intent, UserHandle user, String receiverPermission, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras);
    public abstract void sendStickyBroadcast(Intent intent);
    public abstract void sendStickyOrderedBroadcast(Intent intent, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras);
    public abstract void removeStickyBroadcast(Intent intent);
    public abstract void sendStickyBroadcastAsUser(Intent intent, UserHandle user);
    public abstract void sendStickyOrderedBroadcastAsUser(Intent intent, UserHandle user, BroadcastReceiver resultReceiver, Handler scheduler, int initialCode, String initialData, Bundle initialExtras);
    public abstract void removeStickyBroadcastAsUser(Intent intent, UserHandle user);
    public abstract Intent registerReceiver(BroadcastReceiver receiver, IntentFilter filter);
    public abstract Intent registerReceiver(BroadcastReceiver receiver, IntentFilter filter, int flags);
    public abstract Intent registerReceiver(BroadcastReceiver receiver, IntentFilter filter, String broadcastPermission, Handler scheduler);
    public abstract Intent registerReceiver(BroadcastReceiver receiver, IntentFilter filter, String broadcastPermission, Handler scheduler, int flags);
    public abstract void unregisterReceiver(BroadcastReceiver receiver);
    public abstract ComponentName startService(Intent service);
    public abstract ComponentName startForegroundService(Intent service);
    public abstract boolean stopService(Intent service);
    public abstract boolean bindService(Intent service, ServiceConnection conn, int flags);
    public abstract void unbindService(ServiceConnection conn);
    public abstract boolean startInstrumentation(ComponentName className, String profileFile, Bundle arguments);
    
    // Deprecated wallpaper methods - stubs
    public android.graphics.drawable.Drawable getWallpaper() { return null; }
    public android.graphics.drawable.Drawable peekWallpaper() { return null; }
    public int getWallpaperDesiredMinimumWidth() { return 0; }
    public int getWallpaperDesiredMinimumHeight() { return 0; }
    public void setWallpaper(android.graphics.Bitmap bitmap) throws java.io.IOException {}
    public void setWallpaper(java.io.InputStream data) throws java.io.IOException {}
    public void clearWallpaper() throws java.io.IOException {}
    
    // Convenience methods with default implementations
    public File getSharedPrefsFile(String name) {
        return getSharedPreferencesPath(name);
    }
    
    public void registerComponentCallbacks(ComponentCallbacks callback) {
        getApplicationContext().registerComponentCallbacks(callback);
    }
    
    public void unregisterComponentCallbacks(ComponentCallbacks callback) {
        getApplicationContext().unregisterComponentCallbacks(callback);
    }
    
    public int getThemeResId() {
        return 0;
    }
}
