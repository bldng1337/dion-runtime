package android.app;

import android.content.Context;

/**
 * Minimal Application stub for Mihon extensions
 */
public class Application extends Context {
    
    // ========== Context Abstract Methods Implementation ==========
    
    @Override
    public android.content.res.AssetManager getAssets() {
        return null;
    }
    
    @Override
    public android.content.res.Resources getResources() {
        return null;
    }
    
    @Override
    public android.content.pm.PackageManager getPackageManager() {
        return null;
    }
    
    @Override
    public android.content.ContentResolver getContentResolver() {
        return null;
    }
    
    @Override
    public android.os.Looper getMainLooper() {
        return android.os.Looper.getMainLooper();
    }
    
    @Override
    public Context getApplicationContext() {
        return this;
    }
    
    @Override
    public void setTheme(int resid) {}
    
    @Override
    public android.content.res.Resources.Theme getTheme() {
        return null;
    }
    
    @Override
    public ClassLoader getClassLoader() {
        return getClass().getClassLoader();
    }
    
    @Override
    public String getPackageName() {
        return "";
    }
    
    @Override
    public String getBasePackageName() {
        return "";
    }
    
    @Override
    public String getOpPackageName() {
        return "";
    }
    
    @Override
    public android.content.pm.ApplicationInfo getApplicationInfo() {
        return new android.content.pm.ApplicationInfo();
    }
    
    @Override
    public String getPackageResourcePath() {
        return "";
    }
    
    @Override
    public String getPackageCodePath() {
        return "";
    }
    
    @Override
    public android.content.SharedPreferences getSharedPreferences(String name, int mode) {
        return null;
    }
    
    @Override
    public android.content.SharedPreferences getSharedPreferences(java.io.File file, int mode) {
        return null;
    }
    
    @Override
    public boolean moveSharedPreferencesFrom(Context sourceContext, String name) {
        return false;
    }
    
    @Override
    public boolean deleteSharedPreferences(String name) {
        return false;
    }
    
    @Override
    public java.io.FileInputStream openFileInput(String name) throws java.io.FileNotFoundException {
        throw new java.io.FileNotFoundException();
    }
    
    @Override
    public java.io.FileOutputStream openFileOutput(String name, int mode) throws java.io.FileNotFoundException {
        throw new java.io.FileNotFoundException();
    }
    
    @Override
    public boolean deleteFile(String name) {
        return false;
    }
    
    @Override
    public java.io.File getFileStreamPath(String name) {
        return null;
    }
    
    @Override
    public java.io.File getSharedPreferencesPath(String name) {
        return null;
    }
    
    @Override
    public java.io.File getDataDir() {
        return null;
    }
    
    @Override
    public java.io.File getFilesDir() {
        return null;
    }
    
    @Override
    public java.io.File getNoBackupFilesDir() {
        return null;
    }
    
    @Override
    public java.io.File getExternalFilesDir(String type) {
        return null;
    }
    
    @Override
    public java.io.File[] getExternalFilesDirs(String type) {
        return new java.io.File[0];
    }
    
    @Override
    public java.io.File getObbDir() {
        return null;
    }
    
    @Override
    public java.io.File[] getObbDirs() {
        return new java.io.File[0];
    }
    
    @Override
    public java.io.File getCacheDir() {
        return null;
    }
    
    @Override
    public java.io.File getCodeCacheDir() {
        return null;
    }
    
    @Override
    public java.io.File getExternalCacheDir() {
        return null;
    }
    
    @Override
    public java.io.File[] getExternalCacheDirs() {
        return new java.io.File[0];
    }
    
    @Override
    public java.io.File[] getExternalMediaDirs() {
        return new java.io.File[0];
    }
    
    @Override
    public java.io.File getDir(String name, int mode) {
        return null;
    }
    
    @Override
    public String[] fileList() {
        return new String[0];
    }
    
    @Override
    public java.io.File getDatabasePath(String name) {
        return null;
    }
    
    @Override
    public android.database.sqlite.SQLiteDatabase openOrCreateDatabase(String name, int mode, android.database.sqlite.SQLiteDatabase.CursorFactory factory) {
        return null;
    }
    
    @Override
    public android.database.sqlite.SQLiteDatabase openOrCreateDatabase(String name, int mode, android.database.sqlite.SQLiteDatabase.CursorFactory factory, android.database.DatabaseErrorHandler errorHandler) {
        return null;
    }
    
    @Override
    public boolean moveDatabaseFrom(Context sourceContext, String name) {
        return false;
    }
    
    @Override
    public boolean deleteDatabase(String name) {
        return false;
    }
    
    @Override
    public String[] databaseList() {
        return new String[0];
    }
    
    @Override
    public Object getSystemService(String name) {
        return null;
    }
    
    @Override
    public String getSystemServiceName(Class<?> serviceClass) {
        return null;
    }
    
    @Override
    public int checkPermission(String permission, int pid, int uid) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public int checkCallingPermission(String permission) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public int checkCallingOrSelfPermission(String permission) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public int checkSelfPermission(String permission) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public void enforcePermission(String permission, int pid, int uid, String message) {}
    
    @Override
    public void enforceCallingPermission(String permission, String message) {}
    
    @Override
    public void enforceCallingOrSelfPermission(String permission, String message) {}
    
    @Override
    public void grantUriPermission(String toPackage, android.net.Uri uri, int modeFlags) {}
    
    @Override
    public void revokeUriPermission(android.net.Uri uri, int modeFlags) {}
    
    @Override
    public void revokeUriPermission(String toPackage, android.net.Uri uri, int modeFlags) {}
    
    @Override
    public int checkUriPermission(android.net.Uri uri, int pid, int uid, int modeFlags) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public int checkCallingUriPermission(android.net.Uri uri, int modeFlags) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public int checkCallingOrSelfUriPermission(android.net.Uri uri, int modeFlags) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public int checkUriPermission(android.net.Uri uri, String readPermission, String writePermission, int pid, int uid, int modeFlags) {
        return android.content.pm.PackageManager.PERMISSION_GRANTED;
    }
    
    @Override
    public void enforceUriPermission(android.net.Uri uri, int pid, int uid, int modeFlags, String message) {}
    
    @Override
    public void enforceCallingUriPermission(android.net.Uri uri, int modeFlags, String message) {}
    
    @Override
    public void enforceCallingOrSelfUriPermission(android.net.Uri uri, int modeFlags, String message) {}
    
    @Override
    public void enforceUriPermission(android.net.Uri uri, String readPermission, String writePermission, int pid, int uid, int modeFlags, String message) {}
    
    @Override
    public Context createPackageContext(String packageName, int flags) {
        return this;
    }
    
    @Override
    public Context createConfigurationContext(android.content.res.Configuration overrideConfiguration) {
        return this;
    }
    
    @Override
    public Context createDisplayContext(android.view.Display display) {
        return this;
    }
    
    @Override
    public Context createDeviceProtectedStorageContext() {
        return this;
    }
    
    @Override
    public boolean isDeviceProtectedStorage() {
        return false;
    }
    
    @Override
    public void startActivity(android.content.Intent intent) {}
    
    @Override
    public void startActivity(android.content.Intent intent, android.os.Bundle options) {}
    
    @Override
    public void startActivities(android.content.Intent[] intents) {}
    
    @Override
    public void startActivities(android.content.Intent[] intents, android.os.Bundle options) {}
    
    @Override
    public void startIntentSender(android.content.IntentSender intent, android.content.Intent fillInIntent, int flagsMask, int flagsValues, int extraFlags) {}
    
    @Override
    public void startIntentSender(android.content.IntentSender intent, android.content.Intent fillInIntent, int flagsMask, int flagsValues, int extraFlags, android.os.Bundle options) {}
    
    @Override
    public void sendBroadcast(android.content.Intent intent) {}
    
    @Override
    public void sendBroadcast(android.content.Intent intent, String receiverPermission) {}
    
    @Override
    public void sendBroadcast(android.content.Intent intent, String receiverPermission, int appOp) {}
    
    @Override
    public void sendOrderedBroadcast(android.content.Intent intent, String receiverPermission) {}
    
    @Override
    public void sendOrderedBroadcast(android.content.Intent intent, String receiverPermission, android.content.BroadcastReceiver resultReceiver, android.os.Handler scheduler, int initialCode, String initialData, android.os.Bundle initialExtras) {}
    
    @Override
    public void sendOrderedBroadcast(android.content.Intent intent, String receiverPermission, int appOp, android.content.BroadcastReceiver resultReceiver, android.os.Handler scheduler, int initialCode, String initialData, android.os.Bundle initialExtras) {}
    
    @Override
    public void sendBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user) {}
    
    @Override
    public void sendBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user, String receiverPermission) {}
    
    @Override
    public void sendBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user, String receiverPermission, android.os.Bundle options) {}
    
    @Override
    public void sendOrderedBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user, String receiverPermission, android.content.BroadcastReceiver resultReceiver, android.os.Handler scheduler, int initialCode, String initialData, android.os.Bundle initialExtras) {}
    
    @Override
    public void sendStickyBroadcast(android.content.Intent intent) {}
    
    @Override
    public void sendStickyOrderedBroadcast(android.content.Intent intent, android.content.BroadcastReceiver resultReceiver, android.os.Handler scheduler, int initialCode, String initialData, android.os.Bundle initialExtras) {}
    
    @Override
    public void removeStickyBroadcast(android.content.Intent intent) {}
    
    @Override
    public void sendStickyBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user) {}
    
    @Override
    public void sendStickyOrderedBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user, android.content.BroadcastReceiver resultReceiver, android.os.Handler scheduler, int initialCode, String initialData, android.os.Bundle initialExtras) {}
    
    @Override
    public void removeStickyBroadcastAsUser(android.content.Intent intent, android.os.UserHandle user) {}
    
    @Override
    public android.content.Intent registerReceiver(android.content.BroadcastReceiver receiver, android.content.IntentFilter filter) {
        return null;
    }
    
    @Override
    public android.content.Intent registerReceiver(android.content.BroadcastReceiver receiver, android.content.IntentFilter filter, int flags) {
        return null;
    }
    
    @Override
    public android.content.Intent registerReceiver(android.content.BroadcastReceiver receiver, android.content.IntentFilter filter, String broadcastPermission, android.os.Handler scheduler) {
        return null;
    }
    
    @Override
    public android.content.Intent registerReceiver(android.content.BroadcastReceiver receiver, android.content.IntentFilter filter, String broadcastPermission, android.os.Handler scheduler, int flags) {
        return null;
    }
    
    @Override
    public void unregisterReceiver(android.content.BroadcastReceiver receiver) {}
    
    @Override
    public android.content.ComponentName startService(android.content.Intent service) {
        return null;
    }
    
    @Override
    public android.content.ComponentName startForegroundService(android.content.Intent service) {
        return null;
    }
    
    @Override
    public boolean stopService(android.content.Intent service) {
        return false;
    }
    
    @Override
    public boolean bindService(android.content.Intent service, android.content.ServiceConnection conn, int flags) {
        return false;
    }
    
    @Override
    public void unbindService(android.content.ServiceConnection conn) {}
    
    @Override
    public boolean startInstrumentation(android.content.ComponentName className, String profileFile, android.os.Bundle arguments) {
        return false;
    }
}
