package dion.mihon.android

import android.content.Context
import android.content.SharedPreferences
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.content.res.AssetManager
import android.content.res.Resources
import android.os.Looper
import io.github.oshai.kotlinlogging.KotlinLogging
import java.io.File
import java.io.FileInputStream
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.util.concurrent.ConcurrentHashMap

/**
 * A minimal Context implementation for running Mihon extensions on desktop.
 * Provides the essential services that extensions need:
 * - SharedPreferences
 * - Basic file operations
 * - Package information
 */
class CustomContext(
    private val packageName: String,
    private val dataDir: File,
) : Context() {
    
    companion object {
        private val logger = KotlinLogging.logger {}
        
        // Global registry of contexts by package name
        private val contexts = ConcurrentHashMap<String, CustomContext>()
        
        /**
         * Get or create a context for a package
         */
        fun getOrCreate(packageName: String, dataDir: File): CustomContext {
            return contexts.getOrPut(packageName) {
                CustomContext(packageName, dataDir)
            }
        }
        
        /**
         * Get an existing context for a package
         */
        fun get(packageName: String): CustomContext? = contexts[packageName]
    }
    
    private val settingsDir = File(dataDir, "settings").also { it.mkdirs() }
    private val filesDir = File(dataDir, "files").also { it.mkdirs() }
    private val cacheDir = File(dataDir, "cache").also { it.mkdirs() }
    
    private val sharedPreferences = ConcurrentHashMap<String, SharedPreferencesImpl>()
    
    private val applicationInfo = ApplicationInfo().apply {
        this.packageName = this@CustomContext.packageName
        this.dataDir = this@CustomContext.dataDir.absolutePath
    }
    
    init {
        logger.debug { "Created CustomContext for package: $packageName, dataDir: $dataDir" }
    }
    
    // ============ SharedPreferences ============
    
    override fun getSharedPreferences(name: String, mode: Int): SharedPreferences {
        return sharedPreferences.getOrPut(name) {
            SharedPreferencesImpl(settingsDir, name)
        }
    }
    
    override fun getSharedPreferences(file: File, mode: Int): SharedPreferences {
        return getSharedPreferences(file.nameWithoutExtension, mode)
    }
    
    override fun getSharedPreferencesPath(name: String): File {
        return File(settingsDir, "${SafePath.buildValidFilename(name)}.xml")
    }
    
    override fun deleteSharedPreferences(name: String): Boolean {
        sharedPreferences.remove(name)
        return getSharedPreferencesPath(name).delete()
    }
    
    override fun moveSharedPreferencesFrom(sourceContext: Context, name: String): Boolean {
        // Not implemented - just return true
        return true
    }
    
    // ============ File Operations ============
    
    override fun getFilesDir(): File = filesDir
    
    override fun getCacheDir(): File = cacheDir
    
    override fun getDataDir(): File = dataDir
    
    override fun getCodeCacheDir(): File = File(cacheDir, "code_cache").also { it.mkdirs() }
    
    override fun getNoBackupFilesDir(): File = File(filesDir, "no_backup").also { it.mkdirs() }
    
    override fun getExternalFilesDir(type: String?): File? {
        val dir = if (type != null) File(filesDir, type) else filesDir
        dir.mkdirs()
        return dir
    }
    
    override fun getExternalFilesDirs(type: String): Array<File> {
        return arrayOf(getExternalFilesDir(type) ?: filesDir)
    }
    
    override fun getObbDir(): File = File(dataDir, "obb").also { it.mkdirs() }
    
    override fun getObbDirs(): Array<File> = arrayOf(getObbDir())
    
    override fun getExternalCacheDir(): File = File(cacheDir, "external").also { it.mkdirs() }
    
    override fun getExternalCacheDirs(): Array<File> = arrayOf(getExternalCacheDir())
    
    override fun getExternalMediaDirs(): Array<File> = arrayOf(File(dataDir, "media").also { it.mkdirs() })
    
    override fun getFileStreamPath(name: String): File = File(filesDir, name)
    
    override fun getDir(name: String, mode: Int): File {
        return File(dataDir, "app_$name").also { it.mkdirs() }
    }
    
    override fun openFileInput(name: String): FileInputStream {
        val file = File(filesDir, name)
        if (!file.exists()) {
            throw FileNotFoundException("File not found: $name")
        }
        return FileInputStream(file)
    }
    
    override fun openFileOutput(name: String, mode: Int): FileOutputStream {
        val file = File(filesDir, name)
        file.parentFile?.mkdirs()
        val append = (mode and MODE_APPEND) != 0
        return FileOutputStream(file, append)
    }
    
    override fun deleteFile(name: String): Boolean {
        return File(filesDir, name).delete()
    }
    
    override fun fileList(): Array<String> {
        return filesDir.list() ?: emptyArray()
    }
    
    // ============ Package Information ============
    
    override fun getPackageName(): String = packageName
    
    override fun getBasePackageName(): String = packageName
    
    override fun getOpPackageName(): String = packageName
    
    override fun getApplicationInfo(): ApplicationInfo = applicationInfo
    
    override fun getPackageResourcePath(): String = dataDir.absolutePath
    
    override fun getPackageCodePath(): String = dataDir.absolutePath
    
    override fun getApplicationContext(): Context = this
    
    // ============ Stubs for unsupported operations ============
    
    override fun getAssets(): AssetManager {
        throw UnsupportedOperationException("AssetManager is not supported in CustomContext")
    }
    
    override fun getResources(): Resources {
        throw UnsupportedOperationException("Resources is not supported in CustomContext")
    }
    
    override fun getPackageManager(): PackageManager {
        throw UnsupportedOperationException("PackageManager is not supported in CustomContext")
    }
    
    override fun getContentResolver(): android.content.ContentResolver {
        throw UnsupportedOperationException("ContentResolver is not supported in CustomContext")
    }
    
    override fun getMainLooper(): Looper {
        return Looper.getMainLooper()
    }
    
    override fun setTheme(resid: Int) {
        // No-op
    }
    
    override fun getTheme(): Resources.Theme {
        throw UnsupportedOperationException("Theme is not supported in CustomContext")
    }
    
    override fun getClassLoader(): ClassLoader {
        return this.javaClass.classLoader ?: ClassLoader.getSystemClassLoader()
    }
    
    override fun getDatabasePath(name: String): File {
        return File(dataDir, "databases/$name")
    }
    
    override fun openOrCreateDatabase(
        name: String,
        mode: Int,
        factory: android.database.sqlite.SQLiteDatabase.CursorFactory?
    ): android.database.sqlite.SQLiteDatabase {
        throw UnsupportedOperationException("SQLite databases are not supported in CustomContext")
    }
    
    override fun openOrCreateDatabase(
        name: String,
        mode: Int,
        factory: android.database.sqlite.SQLiteDatabase.CursorFactory?,
        errorHandler: android.database.DatabaseErrorHandler?
    ): android.database.sqlite.SQLiteDatabase {
        throw UnsupportedOperationException("SQLite databases are not supported in CustomContext")
    }
    
    override fun moveDatabaseFrom(sourceContext: Context, name: String): Boolean = false
    
    override fun deleteDatabase(name: String): Boolean {
        return getDatabasePath(name).delete()
    }
    
    override fun databaseList(): Array<String> {
        val dbDir = File(dataDir, "databases")
        return dbDir.list() ?: emptyArray()
    }
    
    @Deprecated("Deprecated in Java")
    override fun getWallpaper(): android.graphics.drawable.Drawable {
        throw UnsupportedOperationException("Wallpaper is not supported")
    }
    
    @Deprecated("Deprecated in Java")
    override fun peekWallpaper(): android.graphics.drawable.Drawable {
        throw UnsupportedOperationException("Wallpaper is not supported")
    }
    
    @Deprecated("Deprecated in Java")
    override fun getWallpaperDesiredMinimumWidth(): Int = 0
    
    @Deprecated("Deprecated in Java")
    override fun getWallpaperDesiredMinimumHeight(): Int = 0
    
    @Deprecated("Deprecated in Java")
    override fun setWallpaper(bitmap: android.graphics.Bitmap) {
        throw UnsupportedOperationException("Wallpaper is not supported")
    }
    
    @Deprecated("Deprecated in Java")
    override fun setWallpaper(data: java.io.InputStream) {
        throw UnsupportedOperationException("Wallpaper is not supported")
    }
    
    @Deprecated("Deprecated in Java")
    override fun clearWallpaper() {
        throw UnsupportedOperationException("Wallpaper is not supported")
    }
    
    override fun startActivity(intent: android.content.Intent) {
        throw UnsupportedOperationException("Starting activities is not supported")
    }
    
    override fun startActivity(intent: android.content.Intent, options: android.os.Bundle?) {
        throw UnsupportedOperationException("Starting activities is not supported")
    }
    
    override fun startActivities(intents: Array<android.content.Intent>) {
        throw UnsupportedOperationException("Starting activities is not supported")
    }
    
    override fun startActivities(intents: Array<android.content.Intent>, options: android.os.Bundle?) {
        throw UnsupportedOperationException("Starting activities is not supported")
    }
    
    override fun startIntentSender(
        intent: android.content.IntentSender,
        fillInIntent: android.content.Intent?,
        flagsMask: Int,
        flagsValues: Int,
        extraFlags: Int
    ) {
        throw UnsupportedOperationException("IntentSender is not supported")
    }
    
    override fun startIntentSender(
        intent: android.content.IntentSender,
        fillInIntent: android.content.Intent?,
        flagsMask: Int,
        flagsValues: Int,
        extraFlags: Int,
        options: android.os.Bundle?
    ) {
        throw UnsupportedOperationException("IntentSender is not supported")
    }
    
    override fun sendBroadcast(intent: android.content.Intent) {
        logger.debug { "sendBroadcast (no-op): $intent" }
    }
    
    override fun sendBroadcast(intent: android.content.Intent, receiverPermission: String?) {
        logger.debug { "sendBroadcast (no-op): $intent" }
    }
    
    override fun sendBroadcast(intent: android.content.Intent, receiverPermission: String?, appOp: Int) {
        logger.debug { "sendBroadcast (no-op): $intent" }
    }
    
    override fun sendOrderedBroadcast(intent: android.content.Intent, receiverPermission: String?) {
        logger.debug { "sendOrderedBroadcast (no-op): $intent" }
    }
    
    override fun sendOrderedBroadcast(
        intent: android.content.Intent,
        receiverPermission: String?,
        resultReceiver: android.content.BroadcastReceiver?,
        scheduler: android.os.Handler?,
        initialCode: Int,
        initialData: String?,
        initialExtras: android.os.Bundle?
    ) {
        logger.debug { "sendOrderedBroadcast (no-op): $intent" }
    }
    
    override fun sendOrderedBroadcast(
        intent: android.content.Intent,
        receiverPermission: String?,
        appOp: Int,
        resultReceiver: android.content.BroadcastReceiver?,
        scheduler: android.os.Handler?,
        initialCode: Int,
        initialData: String?,
        initialExtras: android.os.Bundle?
    ) {
        logger.debug { "sendOrderedBroadcast (no-op): $intent" }
    }
    
    override fun sendBroadcastAsUser(intent: android.content.Intent, user: android.os.UserHandle) {
        logger.debug { "sendBroadcastAsUser (no-op): $intent" }
    }
    
    override fun sendBroadcastAsUser(
        intent: android.content.Intent,
        user: android.os.UserHandle,
        receiverPermission: String?
    ) {
        logger.debug { "sendBroadcastAsUser (no-op): $intent" }
    }
    
    override fun sendBroadcastAsUser(
        intent: android.content.Intent,
        user: android.os.UserHandle,
        receiverPermission: String?,
        options: android.os.Bundle?
    ) {
        logger.debug { "sendBroadcastAsUser (no-op): $intent" }
    }
    
    override fun sendOrderedBroadcastAsUser(
        intent: android.content.Intent,
        user: android.os.UserHandle,
        receiverPermission: String?,
        resultReceiver: android.content.BroadcastReceiver?,
        scheduler: android.os.Handler?,
        initialCode: Int,
        initialData: String?,
        initialExtras: android.os.Bundle?
    ) {
        logger.debug { "sendOrderedBroadcastAsUser (no-op): $intent" }
    }
    
    @Deprecated("Deprecated in Java")
    override fun sendStickyBroadcast(intent: android.content.Intent) {
        logger.debug { "sendStickyBroadcast (no-op): $intent" }
    }
    
    @Deprecated("Deprecated in Java")
    override fun sendStickyOrderedBroadcast(
        intent: android.content.Intent,
        resultReceiver: android.content.BroadcastReceiver?,
        scheduler: android.os.Handler?,
        initialCode: Int,
        initialData: String?,
        initialExtras: android.os.Bundle?
    ) {
        logger.debug { "sendStickyOrderedBroadcast (no-op): $intent" }
    }
    
    @Deprecated("Deprecated in Java")
    override fun removeStickyBroadcast(intent: android.content.Intent) {
        logger.debug { "removeStickyBroadcast (no-op): $intent" }
    }
    
    @Deprecated("Deprecated in Java")
    override fun sendStickyBroadcastAsUser(intent: android.content.Intent, user: android.os.UserHandle) {
        logger.debug { "sendStickyBroadcastAsUser (no-op): $intent" }
    }
    
    @Deprecated("Deprecated in Java")
    override fun sendStickyOrderedBroadcastAsUser(
        intent: android.content.Intent,
        user: android.os.UserHandle,
        resultReceiver: android.content.BroadcastReceiver?,
        scheduler: android.os.Handler?,
        initialCode: Int,
        initialData: String?,
        initialExtras: android.os.Bundle?
    ) {
        logger.debug { "sendStickyOrderedBroadcastAsUser (no-op): $intent" }
    }
    
    @Deprecated("Deprecated in Java")
    override fun removeStickyBroadcastAsUser(intent: android.content.Intent, user: android.os.UserHandle) {
        logger.debug { "removeStickyBroadcastAsUser (no-op): $intent" }
    }
    
    override fun registerReceiver(
        receiver: android.content.BroadcastReceiver?,
        filter: android.content.IntentFilter
    ): android.content.Intent? {
        logger.debug { "registerReceiver (no-op): $filter" }
        return null
    }
    
    override fun registerReceiver(
        receiver: android.content.BroadcastReceiver?,
        filter: android.content.IntentFilter,
        flags: Int
    ): android.content.Intent? {
        logger.debug { "registerReceiver (no-op): $filter" }
        return null
    }
    
    override fun registerReceiver(
        receiver: android.content.BroadcastReceiver?,
        filter: android.content.IntentFilter,
        broadcastPermission: String?,
        scheduler: android.os.Handler?
    ): android.content.Intent? {
        logger.debug { "registerReceiver (no-op): $filter" }
        return null
    }
    
    override fun registerReceiver(
        receiver: android.content.BroadcastReceiver?,
        filter: android.content.IntentFilter,
        broadcastPermission: String?,
        scheduler: android.os.Handler?,
        flags: Int
    ): android.content.Intent? {
        logger.debug { "registerReceiver (no-op): $filter" }
        return null
    }
    
    override fun unregisterReceiver(receiver: android.content.BroadcastReceiver) {
        logger.debug { "unregisterReceiver (no-op)" }
    }
    
    override fun startService(service: android.content.Intent): android.content.ComponentName? {
        logger.debug { "startService (no-op): $service" }
        return null
    }
    
    override fun startForegroundService(service: android.content.Intent): android.content.ComponentName? {
        logger.debug { "startForegroundService (no-op): $service" }
        return null
    }
    
    override fun stopService(service: android.content.Intent): Boolean {
        logger.debug { "stopService (no-op): $service" }
        return false
    }
    
    override fun bindService(
        service: android.content.Intent,
        conn: android.content.ServiceConnection,
        flags: Int
    ): Boolean {
        logger.debug { "bindService (no-op): $service" }
        return false
    }
    
    override fun unbindService(conn: android.content.ServiceConnection) {
        logger.debug { "unbindService (no-op)" }
    }
    
    override fun startInstrumentation(
        className: android.content.ComponentName,
        profileFile: String?,
        arguments: android.os.Bundle?
    ): Boolean {
        return false
    }
    
    override fun getSystemService(name: String): Any? {
        logger.debug { "getSystemService: $name (returning null)" }
        return null
    }
    
    override fun getSystemServiceName(serviceClass: Class<*>): String? {
        return null
    }
    
    override fun checkPermission(permission: String, pid: Int, uid: Int): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun checkCallingPermission(permission: String): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun checkCallingOrSelfPermission(permission: String): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun checkSelfPermission(permission: String): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun enforcePermission(permission: String, pid: Int, uid: Int, message: String?) {
        // Always granted
    }
    
    override fun enforceCallingPermission(permission: String, message: String?) {
        // Always granted
    }
    
    override fun enforceCallingOrSelfPermission(permission: String, message: String?) {
        // Always granted
    }
    
    override fun grantUriPermission(toPackage: String, uri: android.net.Uri, modeFlags: Int) {
        // No-op
    }
    
    override fun revokeUriPermission(uri: android.net.Uri, modeFlags: Int) {
        // No-op
    }
    
    override fun revokeUriPermission(toPackage: String, uri: android.net.Uri, modeFlags: Int) {
        // No-op
    }
    
    override fun checkUriPermission(uri: android.net.Uri, pid: Int, uid: Int, modeFlags: Int): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun checkCallingUriPermission(uri: android.net.Uri, modeFlags: Int): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun checkCallingOrSelfUriPermission(uri: android.net.Uri, modeFlags: Int): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun checkUriPermission(
        uri: android.net.Uri?,
        readPermission: String?,
        writePermission: String?,
        pid: Int,
        uid: Int,
        modeFlags: Int
    ): Int {
        return PackageManager.PERMISSION_GRANTED
    }
    
    override fun enforceUriPermission(
        uri: android.net.Uri,
        pid: Int,
        uid: Int,
        modeFlags: Int,
        message: String?
    ) {
        // Always granted
    }
    
    override fun enforceCallingUriPermission(uri: android.net.Uri, modeFlags: Int, message: String?) {
        // Always granted
    }
    
    override fun enforceCallingOrSelfUriPermission(uri: android.net.Uri, modeFlags: Int, message: String?) {
        // Always granted
    }
    
    override fun enforceUriPermission(
        uri: android.net.Uri?,
        readPermission: String?,
        writePermission: String?,
        pid: Int,
        uid: Int,
        modeFlags: Int,
        message: String?
    ) {
        // Always granted
    }
    
    override fun createPackageContext(packageName: String, flags: Int): Context {
        return this
    }
    
    override fun createConfigurationContext(overrideConfiguration: android.content.res.Configuration): Context {
        return this
    }
    
    override fun createDisplayContext(display: android.view.Display): Context {
        return this
    }
    
    override fun createDeviceProtectedStorageContext(): Context {
        return this
    }
    
    override fun isDeviceProtectedStorage(): Boolean = false
}
