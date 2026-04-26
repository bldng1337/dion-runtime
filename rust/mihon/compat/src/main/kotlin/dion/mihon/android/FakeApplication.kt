package dion.mihon.android

import android.app.Application
import android.content.Context
import android.content.SharedPreferences
import android.content.pm.ApplicationInfo
import android.os.Looper
import io.github.oshai.kotlinlogging.KotlinLogging
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream

/**
 * A fake Application that wraps CustomContext to provide Application functionality
 * for Mihon extensions that use Injekt.get<Application>().
 * 
 * This class is registered with Injekt during initialization.
 */
class FakeApplication(
    private val context: CustomContext
) : Application() {
    
    companion object {
        private val logger = KotlinLogging.logger {}
    }
    
    init {
        logger.debug { "FakeApplication created wrapping context for package: ${context.packageName}" }
    }
    
    // ============ Delegate to CustomContext ============
    
    override fun getSharedPreferences(name: String, mode: Int): SharedPreferences {
        return context.getSharedPreferences(name, mode)
    }
    
    override fun getSharedPreferences(file: File, mode: Int): SharedPreferences {
        return context.getSharedPreferences(file, mode)
    }
    
    override fun getSharedPreferencesPath(name: String): File {
        return context.getSharedPreferencesPath(name)
    }
    
    override fun deleteSharedPreferences(name: String): Boolean {
        return context.deleteSharedPreferences(name)
    }
    
    override fun moveSharedPreferencesFrom(sourceContext: Context, name: String): Boolean {
        return context.moveSharedPreferencesFrom(sourceContext, name)
    }
    
    override fun getFilesDir(): File {
        return context.filesDir
    }
    
    override fun getCacheDir(): File {
        return context.cacheDir
    }
    
    override fun getDataDir(): File {
        return context.dataDir
    }
    
    override fun getCodeCacheDir(): File {
        return context.codeCacheDir
    }
    
    override fun getNoBackupFilesDir(): File {
        return context.noBackupFilesDir
    }
    
    override fun getExternalFilesDir(type: String?): File? {
        return context.getExternalFilesDir(type)
    }
    
    override fun getExternalFilesDirs(type: String): Array<File> {
        return context.getExternalFilesDirs(type)
    }
    
    override fun getObbDir(): File {
        return context.obbDir
    }
    
    override fun getObbDirs(): Array<File> {
        return context.obbDirs
    }
    
    override fun getExternalCacheDir(): File {
        return context.externalCacheDir
    }
    
    override fun getExternalCacheDirs(): Array<File> {
        return context.externalCacheDirs
    }
    
    override fun getExternalMediaDirs(): Array<File> {
        return context.externalMediaDirs
    }
    
    override fun getFileStreamPath(name: String): File {
        return context.getFileStreamPath(name)
    }
    
    override fun getDir(name: String, mode: Int): File {
        return context.getDir(name, mode)
    }
    
    override fun openFileInput(name: String): FileInputStream {
        return context.openFileInput(name)
    }
    
    override fun openFileOutput(name: String, mode: Int): FileOutputStream {
        return context.openFileOutput(name, mode)
    }
    
    override fun deleteFile(name: String): Boolean {
        return context.deleteFile(name)
    }
    
    override fun fileList(): Array<String> {
        return context.fileList()
    }
    
    override fun getPackageName(): String {
        return context.packageName
    }
    
    override fun getBasePackageName(): String {
        return context.basePackageName
    }
    
    override fun getOpPackageName(): String {
        return context.opPackageName
    }
    
    override fun getApplicationInfo(): ApplicationInfo {
        return context.applicationInfo
    }
    
    override fun getPackageResourcePath(): String {
        return context.packageResourcePath
    }
    
    override fun getPackageCodePath(): String {
        return context.packageCodePath
    }
    
    override fun getApplicationContext(): Context {
        return this
    }
    
    override fun getMainLooper(): Looper {
        return context.mainLooper
    }
    
    override fun getClassLoader(): ClassLoader {
        return context.classLoader
    }
    
    override fun getDatabasePath(name: String): File {
        return context.getDatabasePath(name)
    }
    
    override fun deleteDatabase(name: String): Boolean {
        return context.deleteDatabase(name)
    }
    
    override fun databaseList(): Array<String> {
        return context.databaseList()
    }
    
    override fun getSystemService(name: String): Any? {
        return context.getSystemService(name)
    }
    
    override fun getSystemServiceName(serviceClass: Class<*>): String? {
        return context.getSystemServiceName(serviceClass)
    }
    
    override fun checkPermission(permission: String, pid: Int, uid: Int): Int {
        return context.checkPermission(permission, pid, uid)
    }
    
    override fun checkCallingPermission(permission: String): Int {
        return context.checkCallingPermission(permission)
    }
    
    override fun checkCallingOrSelfPermission(permission: String): Int {
        return context.checkCallingOrSelfPermission(permission)
    }
    
    override fun checkSelfPermission(permission: String): Int {
        return context.checkSelfPermission(permission)
    }
    
    override fun createPackageContext(packageName: String, flags: Int): Context {
        return context.createPackageContext(packageName, flags)
    }
    
    override fun createConfigurationContext(overrideConfiguration: android.content.res.Configuration): Context {
        return context.createConfigurationContext(overrideConfiguration)
    }
    
    override fun createDisplayContext(display: android.view.Display): Context {
        return context.createDisplayContext(display)
    }
    
    override fun createDeviceProtectedStorageContext(): Context {
        return context.createDeviceProtectedStorageContext()
    }
    
    override fun isDeviceProtectedStorage(): Boolean {
        return context.isDeviceProtectedStorage
    }
}
