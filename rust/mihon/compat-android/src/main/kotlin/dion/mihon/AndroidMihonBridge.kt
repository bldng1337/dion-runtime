package dion.mihon

import android.app.Application
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import dalvik.system.PathClassLoader
import dion.mihon.dto.*
import eu.kanade.tachiyomi.animesource.AnimeCatalogueSource
import eu.kanade.tachiyomi.animesource.AnimeSourceFactory
import eu.kanade.tachiyomi.animesource.model.*
import eu.kanade.tachiyomi.animesource.online.AnimeHttpSource
import eu.kanade.tachiyomi.source.*
import eu.kanade.tachiyomi.source.model.*
import eu.kanade.tachiyomi.network.NetworkHelper
import eu.kanade.tachiyomi.source.online.*
import io.github.oshai.kotlinlogging.KotlinLogging
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import uy.kohesive.injekt.Injekt
import uy.kohesive.injekt.api.addSingleton
import java.io.File

/**
 * Apply filter states from a list of [FilterDto] to a live filter list obtained from a source.
 *
 * Filters are matched by [name] (the stable identifier). The [state] string is parsed
 * back into the concrete type expected by each filter.
 */
private fun applyFilterStates(filters: List<Filter<*>>, filterStates: List<FilterDto>) {
    val stateMap = filterStates.associateBy { it.name }
    for (filter in filters) {
        val dto = stateMap[filter.name] ?: continue
        try {
            when (filter) {
                is Filter.Text -> filter.state = dto.state
                is Filter.CheckBox -> filter.state = dto.state.toBooleanStrictOrNull() ?: false
                is Filter.TriState -> filter.state = dto.state.toIntOrNull() ?: 0
                is Filter.Select<*> -> {
                    val idx = dto.state.toIntOrNull() ?: 0
                    if (idx in 0 until filter.values.size) {
                        filter.state = idx
                    }
                }

                is Filter.Sort -> {
                    val parts = dto.state.split(";")
                    val idx = parts.getOrNull(0)?.toIntOrNull() ?: 0
                    val asc = parts.getOrNull(1)?.toBooleanStrictOrNull() ?: true
                    filter.state = Filter.Sort.Selection(idx, asc)
                }

                is Filter.Header -> Unit
                is Filter.Separator -> Unit
                is Filter.Group<*> -> Unit
            }
        } catch (_: Exception) {
            // Silently skip malformed filter state; the search will proceed with defaults
        }
    }
}

/**
 * Apply filter states from a list of [FilterDto] to a live anime filter list.
 *
 * Anime equivalent of [applyFilterStates]; filters are matched by [name] and
 * their [FilterDto.state] string is parsed back into the concrete type.
 */
fun applyAnimeFilterStates(filters: List<AnimeFilter<*>>, filterStates: List<FilterDto>) {
    val stateMap = filterStates.associateBy { it.name }
    for (filter in filters) {
        val dto = stateMap[filter.name] ?: continue
        try {
            when (filter) {
                is AnimeFilter.Text -> filter.state = dto.state
                is AnimeFilter.CheckBox -> filter.state = dto.state.toBooleanStrictOrNull() ?: false
                is AnimeFilter.TriState -> filter.state = dto.state.toIntOrNull() ?: 0
                is AnimeFilter.Select<*> -> {
                    val idx = dto.state.toIntOrNull() ?: 0
                    if (idx in 0 until filter.values.size) {
                        filter.state = idx
                    }
                }

                is AnimeFilter.Sort -> {
                    val parts = dto.state.split(";")
                    val idx = parts.getOrNull(0)?.toIntOrNull() ?: 0
                    val asc = parts.getOrNull(1)?.toBooleanStrictOrNull() ?: true
                    filter.state = AnimeFilter.Sort.Selection(idx, asc)
                }

                is AnimeFilter.Header -> Unit
                is AnimeFilter.Separator -> Unit
                is AnimeFilter.Group<*> -> Unit
            }
        } catch (_: Exception) {
            // Silently skip malformed filter state; the search will proceed with defaults
        }
    }
}

/**
 * Bridge class providing JNI-callable static methods for Rust.
 * Android implementation using native class loading instead of dex2jar.
 *
 * All methods accept/return JSON strings for simplicity, matching the desktop API exactly.
 */
object AndroidMihonBridge {
    private val logger = KotlinLogging.logger {}

    private val json = Json {
        ignoreUnknownKeys = true
        encodeDefaults = true
        isLenient = true
    }

    private var context: Context? = null
    private var initialized = false

    @Volatile
    private var globalUncaughtHandlerInstalled = false
    private val sourceManager = SourceManager()
    private val classLoaders = mutableMapOf<String, ClassLoader>()
    private val jarToSourceIds = mutableMapOf<String, List<Long>>()

    /** Extensions data directory (the Rust adapter's `jars` dir). Used to
     *  persist extracted extension icons across restarts. */
    private var extensionsDir: File? = null

    /**
     * Run a blocking coroutine on a worker thread with a large stack.
     *
     * Extension call chains nest deeply on the calling thread: OkHttp's
     * interceptor chain, RxJava Observable operators, Kotlin coroutine
     * suspend machinery and the extension's own (sometimes recursive)
     * parsing all stack on top of each other. The FFI worker threads that
     * drive these calls use the platform default stack (~1-2 MB), which some
     * extensions overflow — producing a native `SIGSEGV` (stack overflow)
     * that kills the whole app process.
     *
     * This mirrors the Rust integration test, which runs the workflow on a
     * large-stack thread for exactly this reason. Running each source call on
     * its own 64 MB-stack thread gives the legitimately-deep — but finite —
     * recursion room to complete instead of crashing the process.
     */
    private fun <T> runBlockingLargeStack(block: suspend () -> T): T {
        // Holder for the result / error communicated back from the worker.
        @Suppress("UNCHECKED_CAST")
        val result = arrayOfNulls<Any>(1)
        val worker = Thread(
            null,
            {
                try {
                    result[0] = runBlocking { block() }
                } catch (e: Throwable) {
                    // Wrap so join() can rethrow on the caller thread, where the
                    // bridge method's catch (e: Throwable) returns an ErrorResult.
                    result[0] = LargeStackFailure(e)
                }
            },
            "mihon-large-stack",
            64L * 1024 * 1024, // 64 MB stack — some extensions' OkHttp HTTP/2 +
            // recursive-parse chains overflow 16 MB on Android.
        )
        worker.start()
        worker.join()
        val outcome = result[0]
        if (outcome is LargeStackFailure) throw outcome.cause
        return outcome as T
    }

    /** Marker wrapper used by [runBlockingLargeStack] to ferry a thrown
     *  exception from the worker thread back to the caller. */
    private class LargeStackFailure(val cause: Throwable)

    const val METADATA_SOURCE_CLASS = "tachiyomi.extension.class"
    const val METADATA_NSFW = "tachiyomi.extension.nsfw"
    const val METADATA_LIB_VERSION = "tachiyomi.extension.lib.version"

    // Anime extensions (Aniyomi) use a parallel set of meta-data keys under
    // the `tachiyomi.animeextension` namespace. Must match desktop
    // ExtensionLoader so aniyomi APKs install on both platforms.
    const val METADATA_ANIME_SOURCE_CLASS = "tachiyomi.animeextension.class"
    const val METADATA_ANIME_NSFW = "tachiyomi.animeextension.nsfw"
    const val METADATA_ANIME_LIB_VERSION = "tachiyomi.animeextension.lib.version"

    // Supported extension lib versions (must match desktop ExtensionLoader).
    // 1.0 allows legacy extensions that predate the
    // tachiyomi.extension.lib.version metadata.
    const val LIB_VERSION_MIN = 1.0
    const val LIB_VERSION_MAX = 1.5

    /**
     * Set the Android context. Must be called before [initialize].
     * @param androidContext The application context
     */
    @JvmStatic
    fun setContext(androidContext: Context) {
        this.context = androidContext.applicationContext
    }

    private fun getContext(): Context {
        return context
            ?: throw IllegalStateException("Context not set. Call setContext() first.")
    }

    /**
     * Initialize the bridge with extensions directory.
     * On Android, this initializes Injekt with the real Application context.
     *
     * @param extensionsDir Directory for storing extension data (used to persist extracted icons)
     */
    @JvmStatic
    fun initialize(extensionsDir: String): String {
        return try {
            logger.info { "Initializing AndroidMihonBridge with extensions dir: $extensionsDir" }
            this.extensionsDir = File(extensionsDir)

            val appContext = getContext()

            // Install a global uncaught-exception handler so that an `Error`
            // thrown on an extension's own background thread (e.g. a fire-and-
            // forget `launch {}` coroutine on Dispatchers.IO, or an OkHttp/
            // RxJava worker) does NOT tear down the whole app process.
            //
            // The per-call `catch (e: Throwable)` in each bridge method only
            // covers the synchronous path through `runBlocking`; exceptions on
            // standalone coroutines escape to their thread's handler. Here we
            // log them and swallow, which lets the awaiting call surface a
            // result (CancellationException is caught by the bridge) or hit the
            // Dart-side operation timeout — either way the 1000+ extension test
            // suite keeps making progress instead of dying on one bad source.
            if (!globalUncaughtHandlerInstalled) {
                globalUncaughtHandlerInstalled = true
                Thread.setDefaultUncaughtExceptionHandler { thread, throwable ->
                    logger.error(throwable) {
                        "Uncaught exception on ${thread.name} (swallowed to keep process alive)"
                    }
                    // Intentionally do NOT forward to the previous handler: the
                    // default Android handler calls Process.killProcess(), which
                    // is exactly the process death we are preventing here.
                }
            }

            // Initialize Injekt with the real Android Application
            initializeInjekt(appContext)

            initialized = true
            logger.info { "AndroidMihonBridge initialized successfully" }
            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to initialize AndroidMihonBridge" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Initialize Injekt dependency injection with required singletons.
     *
     * Mihon extensions use Injekt.get<Application>() to access SharedPreferences
     * and Injekt.get<NetworkHelper>() for HTTP clients.
     */
    private fun initializeInjekt(appContext: Context) {
        logger.debug { "Initializing Injekt with Android Application context" }

        // Register the real Application context
        val app = (appContext as? Application) ?: (appContext.applicationContext as Application)
        Injekt.addSingleton<Application>(app)

        // Create and register NetworkHelper (provides OkHttpClient + cookie jar)
        // Extensions access it via HttpSource's `network: NetworkHelper by injectLazy()`
        val networkHelper = NetworkHelper(appContext)
        Injekt.addSingleton(networkHelper)

        // Register Json instance for extensions that use Injekt.get<Json>()
        // Configuration matches the expected defaults from extensions-lib 16+
        val extensionJson = Json {
            ignoreUnknownKeys = true
            explicitNulls = false
        }
        Injekt.addSingleton(extensionJson)

        logger.info { "Injekt initialized with Application, NetworkHelper, and Json" }
    }

    private fun requireInitialized() {
        check(initialized) { "AndroidMihonBridge not initialized. Call initialize() first." }
    }

    /**
     * Extract the extension's launcher icon and save it as a PNG file.
     *
     * Mihon/Tachiyomi extension APKs are built with Android Gradle Plugin
     * resource obfuscation, which renames every resource file to a short,
     * meaningless name (e.g. `res/9w.png`). The logical `ic_launcher` name
     * then only exists *inside* `resources.arsc`, so a raw zip-entry scan for
     * `ic_launcher` finds nothing.
     *
     * Instead we let the platform resolve the icon via
     * `ApplicationInfo.loadIcon(pm)`, which reads `resources.arsc` and renders
     * even adaptive/vector icons to a raster `Drawable`. We then draw that
     * drawable onto a `Bitmap` and persist it as PNG so the host image loader
     * can render it through a `file://` URL.
     *
     * @return the absolute path to the saved PNG file, or null if the icon
     *   could not be resolved or rendered.
     */
    private fun extractIcon(appInfo: android.content.pm.ApplicationInfo, packageName: String): String? {
        val dir = extensionsDir ?: return null
        val iconsDir = File(dir, "icons").apply { mkdirs() }

        val pm = getContext().packageManager
        val drawable = try {
            appInfo.loadIcon(pm)
        } catch (e: Throwable) {
            logger.warn(e) { "loadIcon failed for $packageName" }
            return null
        }

        val width = drawable.intrinsicWidth.takeIf { it > 0 } ?: 192
        val height = drawable.intrinsicHeight.takeIf { it > 0 } ?: 192

        val bitmap = android.graphics.Bitmap.createBitmap(width, height, android.graphics.Bitmap.Config.ARGB_8888)
        val canvas = android.graphics.Canvas(bitmap)
        drawable.setBounds(0, 0, width, height)
        drawable.draw(canvas)

        val iconFile = File(iconsDir, "$packageName.png")
        try {
            iconFile.outputStream().use { out ->
                bitmap.compress(android.graphics.Bitmap.CompressFormat.PNG, 100, out)
            }
            logger.debug { "Extracted icon for $packageName -> ${iconFile.absolutePath}" }
            iconFile.absolutePath
        } catch (e: Throwable) {
            logger.warn(e) { "Failed to write icon for $packageName" }
            null
        } finally {
            bitmap.recycle()
        }
    }

    // ========== Extension Lifecycle ==========

    /**
     * Install extension: Parse APK metadata using Android PackageManager.
     * On Android, we don't need to convert DEX to JAR - the APK path is used directly.
     *
     * @param apkPath Path to the APK file
     * @return JSON: InstallResult { jarPath, className, metadata }
     */
    @JvmStatic
    fun installExtension(apkPath: String): String {
        return try {
            requireInitialized()
            logger.info { "Installing extension from: $apkPath" }

            val apkFile = File(apkPath)
            require(apkFile.exists()) { "APK file not found: $apkPath" }

            // Android 14+ requires DEX files to be read-only (W^X enforcement).
            // If the file is writable, make it read-only before loading.
            if (apkFile.canWrite()) {
                apkFile.setReadOnly()
            }

            val pm = getContext().packageManager

            // Parse APK metadata using PackageManager
            val packageInfo = pm.getPackageArchiveInfo(
                apkPath,
                PackageManager.GET_META_DATA or PackageManager.GET_ACTIVITIES
            )
                ?: throw IllegalArgumentException("Failed to parse APK: $apkPath")

            // Fix sourceDir so that loadLabel() and asset loading work correctly
            // for APKs parsed via getPackageArchiveInfo (not installed packages)
            packageInfo.applicationInfo?.sourceDir = apkPath
            packageInfo.applicationInfo?.nativeLibraryDir = null

            val packageName = packageInfo.packageName
            logger.debug { "Package name: $packageName" }

            // Extract metadata from AndroidManifest.xml.
            // Anime extensions (Aniyomi) use the `tachiyomi.animeextension.*`
            // meta-data keys instead of the manga `tachiyomi.extension.*` keys,
            // so we fall back to the anime keys when the manga keys are absent
            // (same logic as the desktop ExtensionLoader).
            val metaData: Bundle? = packageInfo.applicationInfo?.metaData
            val isAnime = metaData?.getString(METADATA_ANIME_SOURCE_CLASS) != null
            val classKey = if (isAnime) METADATA_ANIME_SOURCE_CLASS else METADATA_SOURCE_CLASS
            val classNames = metaData?.getString(classKey)
                ?: throw IllegalArgumentException("Missing $classKey meta-data in APK")

            // Handle semicolon-separated class names (multi-source extensions)
            // e.g. ".Source1;.Source2" -> ["com.pkg.Source1", "com.pkg.Source2"]
            val fullClassNames = classNames.split(";")
                .filter { it.isNotBlank() }
                .joinToString(";") { cls ->
                    val trimmed = cls.trim()
                    if (trimmed.startsWith(".")) {
                        packageName + trimmed
                    } else {
                        trimmed
                    }
                }
            logger.debug { "Extension main class(es): $fullClassNames" }

            val nsfwKey = if (isAnime) METADATA_ANIME_NSFW else METADATA_NSFW
            val libVersionKey = if (isAnime) METADATA_ANIME_LIB_VERSION else METADATA_LIB_VERSION
            val nsfw = metaData.getInt(nsfwKey, 0) == 1
            val libVersion = metaData.getString(libVersionKey) ?: "1.0"

            // Validate lib version for compatibility (security parity with desktop)
            val libVersionNum = libVersion.substringBeforeLast('.').toDoubleOrNull()
            if (libVersionNum == null || libVersionNum < LIB_VERSION_MIN || libVersionNum > LIB_VERSION_MAX) {
                throw IllegalArgumentException(
                    "Lib version is $libVersionNum, while only versions " +
                            "$LIB_VERSION_MIN to $LIB_VERSION_MAX are allowed"
                )
            }

            val versionName = packageInfo.versionName ?: "1.0"

            @Suppress("DEPRECATION")
            val versionCode = packageInfo.versionCode ?: 1
            val label = packageInfo.applicationInfo?.loadLabel(pm)?.toString() ?: packageName

            // Extract the extension's launcher icon. loadIcon() resolves it
            // through resources.arsc, so obfuscated APKs work correctly.
            val iconPath = try {
                packageInfo.applicationInfo?.let { extractIcon(it, packageName) }
            } catch (e: Throwable) {
                logger.warn(e) { "Failed to extract icon for $packageName" }
                null
            }

            // On Android, the jarPath is the APK path itself (no conversion needed)
            val result = InstallResult(
                jarPath = apkPath,
                className = fullClassNames,
                metadata = ExtensionMetadata(
                    packageName = packageName,
                    versionName = versionName,
                    versionCode = versionCode,
                    label = label,
                    nsfw = nsfw,
                    libVersion = libVersion
                ),
                iconPath = iconPath
            )

            logger.info { "Extension installed successfully: $packageName -> $apkPath" }
            json.encodeToString(result)
        } catch (e: Throwable) {
            logger.error(e) { "Failed to install extension: $apkPath" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Discover extensions that are already installed on the device (shared extensions).
     * These are APKs installed system-wide via package installer.
     *
     * @return JSON: List<InstallResult> with jarPath pointing to the installed APK
     */
    @JvmStatic
    fun getInstalledExtensions(): String {
        return try {
            requireInitialized()
            logger.info { "Scanning for installed extensions" }

            val pm = getContext().packageManager

            @Suppress("DEPRECATION")
            val flags = PackageManager.GET_META_DATA or
                    PackageManager.GET_CONFIGURATIONS or
                    PackageManager.GET_SIGNATURES or
                    (if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P)
                        PackageManager.GET_SIGNING_CERTIFICATES else 0)

            val installedPkgs = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
                pm.getInstalledPackages(PackageManager.PackageInfoFlags.of(flags.toLong()))
            } else {
                @Suppress("DEPRECATION")
                pm.getInstalledPackages(flags)
            }

            val results = installedPkgs
                .filter { pkgInfo ->
                    // Primary detection: extensions declare a <uses-feature>.
                    // Manga extensions declare `tachiyomi.extension`;
                    // anime (Aniyomi) extensions declare
                    // `tachiyomi.animeextension`.
                    val hasFeature = pkgInfo.reqFeatures?.any {
                        it.name == "tachiyomi.extension" ||
                                it.name == "tachiyomi.animeextension"
                    } == true
                    if (hasFeature) return@filter true
                    // Fallback: some extensions omit <uses-feature> but still
                    // declare the tachiyomi meta-data class keys. metaData is
                    // already populated because GET_META_DATA is part of `flags`.
                    val md = pkgInfo.applicationInfo?.metaData
                    md?.getString(METADATA_SOURCE_CLASS) != null ||
                            md?.getString(METADATA_ANIME_SOURCE_CLASS) != null
                }
                .mapNotNull { pkgInfo ->
                    try {
                        val appInfo = pkgInfo.applicationInfo ?: return@mapNotNull null
                        val apkPath = appInfo.sourceDir ?: return@mapNotNull null
                        val packageName = pkgInfo.packageName

                        val metaData = appInfo.metaData
                        // Anime extensions use the animeextension.* keys;
                        // fall back like installExtension does.
                        val isAnime = metaData?.getString(METADATA_ANIME_SOURCE_CLASS) != null
                        val classKey = if (isAnime) METADATA_ANIME_SOURCE_CLASS else METADATA_SOURCE_CLASS
                        val classNames = metaData?.getString(classKey)
                            ?: return@mapNotNull null

                        val fullClassNames = classNames.split(";")
                            .filter { it.isNotBlank() }
                            .joinToString(";") { cls ->
                                val trimmed = cls.trim()
                                if (trimmed.startsWith(".")) {
                                    packageName + trimmed
                                } else {
                                    trimmed
                                }
                            }

                        val nsfwKey = if (isAnime) METADATA_ANIME_NSFW else METADATA_NSFW
                        val libVersionKey = if (isAnime) METADATA_ANIME_LIB_VERSION else METADATA_LIB_VERSION
                        val nsfw = metaData.getInt(nsfwKey, 0) == 1
                        val libVersion = metaData.getString(libVersionKey) ?: "1.0"
                        val versionName = pkgInfo.versionName ?: "1.0"

                        @Suppress("DEPRECATION")
                        val versionCode = pkgInfo.versionCode ?: 1
                        val label = appInfo.loadLabel(pm)?.toString() ?: packageName

                        val iconPath = try {
                            extractIcon(appInfo, packageName)
                        } catch (e: Throwable) {
                            logger.warn(e) { "Failed to extract icon for $packageName" }
                            null
                        }

                        InstallResult(
                            jarPath = apkPath,
                            className = fullClassNames,
                            metadata = ExtensionMetadata(
                                packageName = packageName,
                                versionName = versionName,
                                versionCode = versionCode,
                                label = label,
                                nsfw = nsfw,
                                libVersion = libVersion
                            ),
                            iconPath = iconPath
                        )
                    } catch (e: Throwable) {
                        logger.warn(e) { "Failed to parse installed extension: ${pkgInfo.packageName}" }
                        null
                    }
                }

            logger.info { "Found ${results.size} installed extension(s)" }
            json.encodeToString(results)
        } catch (e: Throwable) {
            logger.error(e) { "Failed to scan for installed extensions" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Load extension from APK file using Android's PathClassLoader.
     * On Android, jarPath is actually the APK path.
     *
     * @param jarPath Path to the APK file (passed through from installExtension)
     * @param className Entry point class name
     * @return JSON: SourceIdsResult { sourceIds: List<Long> }
     */
    @JvmStatic
    fun loadExtension(jarPath: String, className: String): String {
        return try {
            requireInitialized()
            logger.info { "Loading extension: $jarPath (class: $className)" }

            val apkFile = File(jarPath)
            require(apkFile.exists()) { "APK file not found: $jarPath" }

            // Android 14+ requires DEX files to be read-only (W^X enforcement).
            // If the file is writable, make it read-only before loading.
            if (apkFile.canWrite()) {
                apkFile.setReadOnly()
            }

            // Create a parent-last class loader for the APK
            val classLoader = classLoaders.getOrPut(jarPath) {
                try {
                    // Try ChildFirstPathClassLoader first (preferred for extensions)
                    ChildFirstPathClassLoader(jarPath, null, getContext().classLoader)
                } catch (e: LinkageError) {
                    logger.warn(e) { "ChildFirstPathClassLoader failed, falling back to PathClassLoader" }
                    // Fallback to standard PathClassLoader
                    PathClassLoader(jarPath, getContext().classLoader)
                }
            }

            // Handle semicolon-separated class names (multi-source extensions)
            // e.g. "com.pkg.Source1;com.pkg.Source2"
            val sources = className.split(";")
                .filter { it.isNotBlank() }
                .flatMap { cls ->
                    val trimmed = cls.trim()
                    try {
                        val mainClass = Class.forName(trimmed, false, classLoader)
                        val instance = mainClass.getDeclaredConstructor().newInstance()

                        // Handle Source, SourceFactory, or AnimeSourceFactory.
                        // Anime extensions expose an AnimeSourceFactory (Aniyomi
                        // API); since AnimeSource extends Source, its sources are
                        // valid Sources.
                        when (instance) {
                            is AnimeSourceFactory -> instance.createSources()
                            is SourceFactory -> instance.createSources()
                            is Source -> listOf(instance)
                            else -> throw IllegalArgumentException(
                                "Extension class is not a Source, SourceFactory, or AnimeSourceFactory: ${instance.javaClass}"
                            )
                        }
                    } catch (e: LinkageError) {
                        // Fallback to standard PathClassLoader for this class
                        logger.warn(e) { "ChildFirstPathClassLoader failed for $trimmed, trying PathClassLoader fallback" }
                        val fallBackClassLoader = PathClassLoader(jarPath, getContext().classLoader)
                        val mainClass = Class.forName(trimmed, false, fallBackClassLoader)
                        val instance = mainClass.getDeclaredConstructor().newInstance()

                        when (instance) {
                            is AnimeSourceFactory -> instance.createSources()
                            is SourceFactory -> instance.createSources()
                            is Source -> listOf(instance)
                            else -> throw IllegalArgumentException(
                                "Extension class is not a Source, SourceFactory, or AnimeSourceFactory: ${instance.javaClass}"
                            )
                        }
                    }
                }

            // Register sources and track which source IDs belong to this jarPath
            sources.forEach { sourceManager.register(it) }
            val sourceIds = sources.map { it.id }
            jarToSourceIds[jarPath] = sourceIds
            logger.info { "Loaded ${sources.size} source(s) with IDs: $sourceIds" }
            json.encodeToString(SourceIdsResult(sourceIds))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to load extension: $jarPath" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Unload extension APK and remove all its sources.
     * @param jarPath Path to the APK file
     */
    @JvmStatic
    fun unloadExtension(jarPath: String): String {
        return try {
            logger.info { "Unloading extension: $jarPath" }
            // Unregister all sources that were loaded from this jarPath
            jarToSourceIds.remove(jarPath)?.forEach { sourceId ->
                sourceManager.unregister(sourceId)
            }
            // Remove class loader reference
            classLoaders.remove(jarPath)
            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to unload extension: $jarPath" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Unload a specific source.
     * @param sourceId Source ID to unload
     */
    @JvmStatic
    fun unloadSource(sourceId: Long): String {
        return try {
            logger.debug { "Unloading source: $sourceId" }
            sourceManager.unregister(sourceId)
            json.encodeToString(SuccessResult(true))
        } catch (e: Throwable) {
            logger.error(e) { "Failed to unload source: $sourceId" }
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    // ========== Source Info ==========

    /**
     * Get source metadata.
     * @return JSON: SourceInfo { id, name, lang, baseUrl, supportsLatest, isConfigurable }
     */
    @JvmStatic
    fun getSourceInfo(sourceId: Long): String {
        return try {
            val source = sourceManager.get(sourceId)
                ?: return json.encodeToString(ErrorResult("Source not found: $sourceId"))
            json.encodeToString(SourceInfo.from(source))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get source type (manga or anime).
     * @return JSON: SourceTypeResult { type: "manga" | "anime" | "unknown" }
     */
    @JvmStatic
    fun getSourceType(sourceId: Long): String {
        return try {
            val source = sourceManager.get(sourceId)
                ?: return json.encodeToString(ErrorResult("Source not found: $sourceId"))
            val type = when (source) {
                is AnimeCatalogueSource -> "anime"
                is CatalogueSource -> "manga"
                else -> "unknown"
            }
            json.encodeToString(SourceTypeResult(type))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get filter list for source.
     * @return JSON: List<FilterDto>
     */
    @JvmStatic
    fun getFilterList(sourceId: Long): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val filters = source.getFilterList()
            json.encodeToString(filters.map { it.toDto() })
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    // ========== Manga Source Methods ==========

    /**
     * Get popular manga list.
     * @return JSON: MangasPageDto { mangas, hasNextPage }
     */
    @JvmStatic
    fun getPopular(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val result = runBlockingLargeStack {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getPopularManga(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get latest manga updates.
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun getLatest(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            if (!source.supportsLatest) {
                return json.encodeToString(ErrorResult("Source does not support latest"))
            }
            val result = runBlockingLargeStack {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getLatestUpdates(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Search manga.
     * @param filtersJson JSON-encoded filter state (empty string for defaults)
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun search(sourceId: Long, page: Int, query: String, filtersJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val filters = source.getFilterList()
            if (filtersJson.isNotEmpty()) {
                try {
                    val filterStates = json.decodeFromString<List<FilterDto>>(filtersJson)
                    applyFilterStates(filters, filterStates)
                } catch (e: Throwable) {
                    logger.warn(e) { "Failed to parse filtersJson, using default filters" }
                }
            }
            val result = runBlockingLargeStack {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getSearchManga(page, query, filters).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get manga details.
     * @param mangaJson JSON: MangaDto (must have url field)
     * @return JSON: MangaDto (with all fields populated)
     */
    @JvmStatic
    fun getDetails(sourceId: Long, mangaJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val mangaDto = json.decodeFromString<MangaDto>(mangaJson)
            val manga = mangaDto.toSManga()
            val result = runBlockingLargeStack {
                if (source is HttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getMangaDetails(manga).toDto(thumbnailHeaders)
                } else {
                    mangaDto
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get chapter list for manga.
     * @param mangaJson JSON: MangaDto
     * @return JSON: ChapterListResult { chapters: List<ChapterDto> }
     */
    @JvmStatic
    fun getChapterList(sourceId: Long, mangaJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val mangaDto = json.decodeFromString<MangaDto>(mangaJson)
            val manga = mangaDto.toSManga()
            val result = runBlockingLargeStack {
                if (source is HttpSource) {
                    source.getChapterList(manga).map { it.toDto() }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(ChapterListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get page list for chapter.
     * @param chapterJson JSON: ChapterDto
     * @return JSON: PageListResult { pages: List<PageDto> }
     */
    @JvmStatic
    fun getPageList(sourceId: Long, chapterJson: String): String {
        return try {
            val source = sourceManager.getCatalogue(sourceId)
            val chapterDto = json.decodeFromString<ChapterDto>(chapterJson)
            val chapter = chapterDto.toSChapter()
            val result = runBlockingLargeStack {
                if (source is HttpSource) {
                    source.getPageList(chapter).map { page ->
                        page.toDto(headers = source.imageRequestHeaders(page))
                    }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(PageListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    // ========== Anime Source Methods ==========

    /**
     * Get popular anime list.
     * @return JSON: MangasPageDto { mangas, hasNextPage }
     */
    @JvmStatic
    fun getPopularAnime(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val result = runBlockingLargeStack {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getPopularAnime(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get latest anime updates.
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun getLatestAnime(sourceId: Long, page: Int): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            if (!source.supportsLatest) {
                return json.encodeToString(ErrorResult("Source does not support latest"))
            }
            val result = runBlockingLargeStack {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getLatestUpdates(page).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Search anime.
     * @param filtersJson JSON-encoded filter state (empty string for defaults)
     * @return JSON: MangasPageDto
     */
    @JvmStatic
    fun searchAnime(sourceId: Long, page: Int, query: String, filtersJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val filters = source.getFilterList()
            if (filtersJson.isNotEmpty()) {
                try {
                    val filterStates = json.decodeFromString<List<FilterDto>>(filtersJson)
                    applyAnimeFilterStates(filters, filterStates)
                } catch (e: Throwable) {
                    logger.warn(e) { "Failed to parse filtersJson, using default filters" }
                }
            }
            val result = runBlockingLargeStack {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getSearchAnime(page, query, filters).toDto(thumbnailHeaders)
                } else {
                    MangasPageDto(emptyList(), false)
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get anime details.
     * @param animeJson JSON: MangaDto (must have url field)
     * @return JSON: MangaDto (with all fields populated)
     */
    @JvmStatic
    fun getAnimeDetails(sourceId: Long, animeJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val animeDto = json.decodeFromString<MangaDto>(animeJson)
            val anime = animeDto.toSAnime()
            val result = runBlockingLargeStack {
                if (source is AnimeHttpSource) {
                    val thumbnailHeaders =
                        source.headers.toMultimap().mapValues { (_, values) -> values.lastOrNull().orEmpty() }
                    source.getAnimeDetails(anime).toDto(thumbnailHeaders)
                } else {
                    animeDto
                }
            }
            json.encodeToString(result)
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get episode list for anime.
     * @param animeJson JSON: MangaDto
     * @return JSON: EpisodeListResult { episodes: [...] }
     */
    @JvmStatic
    fun getEpisodeList(sourceId: Long, animeJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val animeDto = json.decodeFromString<MangaDto>(animeJson)
            val anime = animeDto.toSAnime()
            val result = runBlockingLargeStack {
                if (source is AnimeHttpSource) {
                    source.getEpisodeList(anime).map { it.toDto() }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(EpisodeListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }

    /**
     * Get video list for episode.
     * @param episodeJson JSON: EpisodeDto
     * @return JSON: VideoListResult { videos: [...] }
     */
    @JvmStatic
    fun getVideoList(sourceId: Long, episodeJson: String): String {
        return try {
            val source = sourceManager.getAnimeCatalogue(sourceId)
            val episodeDto = json.decodeFromString<EpisodeDto>(episodeJson)
            val episode = episodeDto.toSEpisode()
            val result = runBlockingLargeStack {
                if (source is AnimeHttpSource) {
                    source.getVideoList(episode).map { it.toDto() }
                } else {
                    emptyList()
                }
            }
            json.encodeToString(VideoListResult(result))
        } catch (e: Throwable) {
            json.encodeToString(ErrorResult(e.message ?: "Unknown error", e.stackTraceToString()))
        }
    }


}
