package dion.mihon

import com.googlecode.d2j.dex.Dex2jar
import com.googlecode.d2j.reader.MultiDexFileReader
import com.googlecode.dex2jar.tools.BaksmaliBaseDexExceptionHandler
import dion.mihon.dto.*
import eu.kanade.tachiyomi.animesource.AnimeSourceFactory
import eu.kanade.tachiyomi.source.*
import io.github.oshai.kotlinlogging.KotlinLogging
import net.dongliu.apk.parser.ApkFile
import java.io.File
import java.io.FileOutputStream
import java.net.URLClassLoader
import java.nio.file.Files
import java.util.zip.ZipEntry
import java.util.zip.ZipFile
import java.util.zip.ZipInputStream
import java.util.zip.ZipOutputStream
import javax.xml.parsers.DocumentBuilderFactory

/**
 * Handles APK -> JAR conversion and class loading for Mihon/Tachiyomi extensions.
 *
 * This class converts Android DEX files to Java JAR files using dex2jar,
 * then loads the extension classes via URLClassLoader.
 */
class ExtensionLoader(
    /** Directory to store converted JAR files */
    private val extensionsDir: File
) {
    private val logger = KotlinLogging.logger {}
    private val classLoaders = mutableMapOf<String, URLClassLoader>()

    init {
        extensionsDir.mkdirs()
    }

    /**
     * Install extension by converting APK to JAR
     *
     * @param apkPath Path to the APK file
     * @return Installation result with JAR path and metadata
     */
    fun install(apkPath: String): InstallResult {
        val apkFile = File(apkPath)
        require(apkFile.exists()) { "APK file not found: $apkPath" }

        logger.info { "Installing extension from: $apkPath" }

        // Parse APK metadata
        val apk = ApkFile(apkFile)
        val manifest = apk.apkMeta
        val packageName = manifest.packageName

        logger.debug { "Package name: $packageName" }

        // Parse manifest XML to get meta-data elements
        val manifestXml = apk.manifestXml
        val metaDataMap = parseMetaDataFromManifest(manifestXml)

        // Extract extension class name from manifest.
        // Anime extensions use the `tachiyomi.animeextension.*` meta-data keys
        // instead of the manga `tachiyomi.extension.*` keys, so we fall back
        // to the anime keys when the manga keys are absent.
        val isAnime = metaDataMap[METADATA_ANIME_SOURCE_CLASS] != null
        val classKey = if (isAnime) METADATA_ANIME_SOURCE_CLASS else METADATA_SOURCE_CLASS
        val className = metaDataMap[classKey]
            ?: throw IllegalArgumentException("Missing $classKey meta-data in APK")

        val fullClassName = if (className.startsWith(".")) {
            packageName + className
        } else {
            className
        }

        logger.debug { "Extension main class: $fullClassName" }

        // File paths - use packageName as base to avoid collisions when
        // multiple extensions are installed from temp APK files (e.g. temp.apk)
        val fileNameBase = packageName
        val jarFile = File(extensionsDir, "$fileNameBase.jar")
        val dexFile = File(extensionsDir, "$fileNameBase.dex")
        val errorFile = File(extensionsDir, "$fileNameBase-error.txt")

        try {
            // Close any existing ClassLoader for this JAR to release the
            // file lock. On Windows, URLClassLoader keeps the JAR file
            // open, which would prevent dex2jar from overwriting it on
            // reinstall (FileSystemException: being used by another process).
            unload(jarFile.absolutePath)

            // Best-effort delete of any pre-existing JAR with retries.
            // Even after ClassLoader.close(), Windows may briefly retain
            // the handle until GC runs, so we retry a few times.
            deleteFileWithRetries(jarFile)

            // Step 1: Convert DEX to JAR using dex2jar
            dex2jar(apkPath, jarFile.absolutePath, dexFile.absolutePath, errorFile)

            // Step 2: Extract assets from APK and add to JAR
            extractAssetsFromApk(apkFile, jarFile)

            logger.info { "Extension installed successfully: $packageName -> ${jarFile.absolutePath}" }
        } catch (e: Exception) {
            logger.error(e) { "Failed to install extension: $packageName" }
            throw e
        } finally {
            // Clean up temp files
            dexFile.delete()
            apk.close()
        }

        // Extract metadata. Anime extensions use the `tachiyomi.animeextension.*`
        // keys; manga extensions use `tachiyomi.extension.*`.
        val nsfwKey = if (isAnime) METADATA_ANIME_NSFW else METADATA_NSFW
        val libVersionKey = if (isAnime) METADATA_ANIME_LIB_VERSION else METADATA_LIB_VERSION
        val nsfw = metaDataMap[nsfwKey]?.let { it == "1" || it.equals("true", ignoreCase = true) } ?: false
        val libVersion = metaDataMap[libVersionKey] ?: "1.0"

        // Validate lib version for compatibility
        val libVersionNum = libVersion.substringBeforeLast('.').toDoubleOrNull()
        if (libVersionNum == null || libVersionNum < LIB_VERSION_MIN || libVersionNum > LIB_VERSION_MAX) {
            throw IllegalArgumentException(
                "Lib version is $libVersionNum, while only versions " +
                        "$LIB_VERSION_MIN to $LIB_VERSION_MAX are allowed"
            )
        }

        // Extract the extension's launcher icon from the APK. The host image
        // loader cannot resolve the legacy `mihon://icon/{id}` placeholder, so
        // we extract a raster icon to a file and return its path instead.
        val iconPath = try {
            extractIcon(apkFile, packageName)
        } catch (e: Exception) {
            logger.warn(e) { "Failed to extract icon for $packageName" }
            null
        }

        return InstallResult(
            jarPath = jarFile.absolutePath,
            className = fullClassName,
            metadata = ExtensionMetadata(
                packageName = packageName,
                versionName = manifest.versionName ?: "1.0",
                versionCode = manifest.versionCode?.toInt() ?: 1,
                label = manifest.label ?: packageName,
                nsfw = nsfw,
                libVersion = libVersion
            ),
            iconPath = iconPath
        )
    }

    /**
     * Parse meta-data elements from AndroidManifest.xml
     */
    private fun parseMetaDataFromManifest(manifestXml: String): Map<String, String> {
        val result = mutableMapOf<String, String>()

        try {
            val factory = DocumentBuilderFactory.newInstance()
            factory.isNamespaceAware = true
            val builder = factory.newDocumentBuilder()
            val doc = builder.parse(manifestXml.byteInputStream())

            // Find all meta-data elements
            val metaDataNodes = doc.getElementsByTagName("meta-data")
            for (i in 0 until metaDataNodes.length) {
                val node = metaDataNodes.item(i)
                val attrs = node.attributes

                // Get android:name and android:value
                val nameAttr = attrs.getNamedItemNS("http://schemas.android.com/apk/res/android", "name")
                    ?: attrs.getNamedItem("android:name")
                val valueAttr = attrs.getNamedItemNS("http://schemas.android.com/apk/res/android", "value")
                    ?: attrs.getNamedItem("android:value")

                if (nameAttr != null && valueAttr != null) {
                    result[nameAttr.nodeValue] = valueAttr.nodeValue
                }
            }
        } catch (e: Exception) {
            logger.warn(e) { "Failed to parse manifest XML" }
        }

        return result
    }

    /**
     * Convert DEX file(s) from APK to JAR using dex2jar
     */
    private fun dex2jar(apkPath: String, jarPath: String, dexPath: String, errorFile: File) {
        logger.debug { "Converting DEX to JAR: $apkPath -> $jarPath" }

        val jarFilePath = File(jarPath).toPath()

        // Read DEX from APK (handles multi-dex)
        val apkBytes = Files.readAllBytes(File(apkPath).toPath())
        val reader = MultiDexFileReader.open(apkBytes)

        val handler = BaksmaliBaseDexExceptionHandler()

        Dex2jar
            .from(reader)
            .withExceptionHandler(handler)
            .reUseReg(false)
            .topoLogicalSort()
            .skipDebug(true)
            .optimizeSynchronized(false)
            .printIR(false)
            .noCode(false)
            .skipExceptions(false)
            .dontSanitizeNames(true)
            .to(jarFilePath)

        if (handler.hasException()) {
            logger.warn {
                """
                DEX to JAR conversion had errors. Details written to: ${errorFile.absolutePath}
                The extension may still work, but some features might be broken.
                """.trimIndent()
            }
            handler.dump(errorFile.toPath(), emptyArray())
        } else {
            // Apply bytecode fixes for Android->JVM compatibility
            BytecodeEditor.fixAndroidClasses(jarFilePath)
        }
    }

    /**
     * Extract assets from APK and add them to the JAR file.
     * Many extensions store data files (like filters, configs) in assets.
     */
    private fun extractAssetsFromApk(apkFile: File, jarFile: File) {
        // Create temp directory for assets
        val assetsDir = File(jarFile.parentFile, "${jarFile.nameWithoutExtension}_assets")
        assetsDir.mkdirs()

        try {
            // Extract assets from APK
            ZipInputStream(apkFile.inputStream()).use { zipIn ->
                var entry = zipIn.nextEntry
                while (entry != null) {
                    if (entry.name.startsWith("assets/") && !entry.isDirectory) {
                        val assetFile = File(assetsDir, entry.name)
                        assetFile.parentFile?.mkdirs()
                        FileOutputStream(assetFile).use { out ->
                            zipIn.copyTo(out)
                        }
                    }
                    entry = zipIn.nextEntry
                }
            }

            // Add assets to JAR (removing META-INF to avoid signature issues)
            if (assetsDir.exists() && assetsDir.listFiles()?.isNotEmpty() == true) {
                val tempJar = File(jarFile.parentFile, "${jarFile.nameWithoutExtension}_temp.jar")

                ZipInputStream(jarFile.inputStream()).use { jarIn ->
                    ZipOutputStream(FileOutputStream(tempJar)).use { jarOut ->
                        // Copy existing JAR entries (except META-INF)
                        var entry = jarIn.nextEntry
                        while (entry != null) {
                            if (!entry.name.startsWith("META-INF/")) {
                                jarOut.putNextEntry(ZipEntry(entry.name))
                                jarIn.copyTo(jarOut)
                                jarOut.closeEntry()
                            }
                            entry = jarIn.nextEntry
                        }

                        // Add assets
                        assetsDir.walkTopDown().forEach { file ->
                            if (file.isFile) {
                                val relativePath = file.relativeTo(assetsDir).path.replace("\\", "/")
                                jarOut.putNextEntry(ZipEntry(relativePath))
                                file.inputStream().use { it.copyTo(jarOut) }
                                jarOut.closeEntry()
                            }
                        }
                    }
                }

                // Replace original JAR with new one. Use retries for the
                // delete (Windows file locking) and fall back to copy+delete
                // if the atomic rename fails.
                deleteFileWithRetries(jarFile)
                if (!tempJar.renameTo(jarFile)) {
                    tempJar.copyTo(jarFile, overwrite = true)
                    deleteFileWithRetries(tempJar)
                }
            }
        } finally {
            // Clean up assets directory
            assetsDir.deleteRecursively()
        }
    }

    /**
     * Extract the extension's launcher icon from the APK and save it as a file.
     *
     * Scans the APK's `res/mipmap-*` and `res/drawable-*` entries for a raster
     * `ic_launcher` image (PNG/WebP), preferring the highest available density.
     * Adaptive-icon XMLs are skipped since the host image loader cannot render
     * Android vector drawables.
     *
     * @return the absolute path to the saved icon file, or null if the APK
     *   contained no extractable raster launcher icon.
     */
    private fun extractIcon(apkFile: File, packageName: String): String? {
        val iconsDir = File(extensionsDir, "icons").apply { mkdirs() }

        return ZipFile(apkFile).use { zip ->
            var bestEntry: ZipEntry? = null
            var bestRank = -1
            var bestExt = "png"

            val entries = zip.entries()
            while (entries.hasMoreElements()) {
                val entry = entries.nextElement()
                if (entry.isDirectory) continue
                val name = entry.name.lowercase()
                if (!name.endsWith(".png") && !name.endsWith(".webp")) continue
                if (!name.contains("ic_launcher")) continue
                if (!name.startsWith("res/mipmap") && !name.startsWith("res/drawable")) continue

                val density = ICON_DENSITY_RANK.keys.firstOrNull { name.contains("-$it") }
                val rank = ICON_DENSITY_RANK[density] ?: 1
                if (rank > bestRank) {
                    bestRank = rank
                    bestEntry = entry
                    bestExt = if (name.endsWith(".webp")) "webp" else "png"
                }
            }

            val entry = bestEntry ?: return@use null
            val iconFile = File(iconsDir, "$packageName.$bestExt")
            zip.getInputStream(entry).use { input ->
                iconFile.outputStream().use { output -> input.copyTo(output) }
            }
            logger.debug { "Extracted icon for $packageName -> ${iconFile.absolutePath}" }
            iconFile.absolutePath
        }
    }

    /**
     * Load extension classes from JAR file
     *
     * @param jarPath Path to the JAR file
     * @param className Full qualified class name of the extension entry point
     * @return List of Source instances provided by the extension
     */
    fun load(jarPath: String, className: String): List<Source> {
        val jarFile = File(jarPath)
        require(jarFile.exists()) { "JAR file not found: $jarPath" }

        logger.debug { "Loading extension: $jarPath (class: $className)" }

        // Create/reuse class loader with parent loader set to this class's loader
        // This ensures Android compat classes are available
        val classLoader = classLoaders.getOrPut(jarPath) {
            URLClassLoader(
                arrayOf(jarFile.toURI().toURL()),
                this.javaClass.classLoader
            )
        }

        return try {
            // Load main class
            val mainClass = Class.forName(className, false, classLoader)
            val instance = mainClass.getDeclaredConstructor().newInstance()

            // Handle Source, SourceFactory, or AnimeSourceFactory.
            // Anime extensions expose an AnimeSourceFactory (Aniyomi API);
            // since AnimeSource extends Source, its sources are valid Sources.
            val sources = when (instance) {
                is AnimeSourceFactory -> instance.createSources()
                is SourceFactory -> instance.createSources()
                is Source -> listOf(instance)
                else -> throw IllegalArgumentException(
                    "Extension class is not a Source, SourceFactory, or AnimeSourceFactory: ${instance.javaClass}"
                )
            }

            logger.info { "Loaded ${sources.size} source(s) from extension" }
            sources
        } catch (e: Exception) {
            logger.error(e) { "Failed to load extension class: $className" }
            throw e
        }
    }

    /**
     * Unload extension and close its class loader
     */
    fun unload(jarPath: String) {
        logger.debug { "Unloading extension: $jarPath" }
        classLoaders.remove(jarPath)?.close()
    }

    /**
     * Delete a file with retries to work around Windows file locking.
     *
     * URLClassLoader and the OS may briefly retain file handles even
     * after close(); this is especially common on Windows. We retry a
     * few times with a short delay and trigger GC to encourage pending
     * finalizers (e.g. JarFile) to release the handle.
     *
     * This is best-effort: if the file still cannot be deleted after
     * all attempts, the error is logged but not re-thrown, so the
     * caller can proceed and surface a clearer upstream error if the
     * file turns out to be genuinely stuck.
     */
    private fun deleteFileWithRetries(
        file: File,
        maxAttempts: Int = 5,
        delayMs: Long = 100L
    ) {
        if (!file.exists()) return
        repeat(maxAttempts) { attempt ->
            try {
                Files.deleteIfExists(file.toPath())
                return
            } catch (e: java.nio.file.FileSystemException) {
                if (attempt == maxAttempts - 1) {
                    logger.warn(e) {
                        "Could not delete ${file.absolutePath} after $maxAttempts attempts"
                    }
                    return
                }
                System.gc()
                Thread.sleep(delayMs)
            }
        }
    }

    companion object {
        const val METADATA_SOURCE_CLASS = "tachiyomi.extension.class"
        const val METADATA_NSFW = "tachiyomi.extension.nsfw"
        const val METADATA_LIB_VERSION = "tachiyomi.extension.lib.version"

        // Anime extensions (Aniyomi) use a parallel set of meta-data keys under
        // the `tachiyomi.animeextension` namespace.
        const val METADATA_ANIME_SOURCE_CLASS = "tachiyomi.animeextension.class"
        const val METADATA_ANIME_NSFW = "tachiyomi.animeextension.nsfw"
        const val METADATA_ANIME_LIB_VERSION = "tachiyomi.animeextension.lib.version"

        // Supported extension lib versions (1.0 allows legacy
        // extensions that predate the tachiyomi.extension.lib.version metadata)
        const val LIB_VERSION_MIN = 1.0
        const val LIB_VERSION_MAX = 1.5

        // Density ranking for Android resource qualifiers (higher = preferred).
        // Used by [extractIcon] to pick the highest-resolution raster launcher
        // icon available in the APK. `anydpi`/`nodpi` rank lowest because they
        // frequently hold adaptive-icon XMLs rather than raster images.
        private val ICON_DENSITY_RANK = mapOf(
            "xxxhdpi" to 6,
            "xxhdpi" to 5,
            "xhdpi" to 4,
            "hdpi" to 3,
            "mdpi" to 2,
            "ldpi" to 1,
            "nodpi" to 0,
            "anydpi" to 0
        )
    }
}
