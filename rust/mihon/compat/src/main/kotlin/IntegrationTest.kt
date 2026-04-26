import dion.mihon.MihonBridge
import kotlinx.serialization.json.Json
import java.io.File

/**
 * Simple integration test for MihonBridge
 */
fun main() {
    val json = Json { ignoreUnknownKeys = true; isLenient = true }
    
    // Create temp directory for testing
    val tempDir = File(System.getProperty("java.io.tmpdir"), "mihon-test-${System.currentTimeMillis()}")
    tempDir.mkdirs()
    println("Using temp directory: $tempDir")
    
    try {
        // 1. Initialize
        println("\n=== Initialize ===")
        val initResult = MihonBridge.initialize(tempDir.absolutePath)
        println("Initialize result: $initResult")
        if (initResult.contains("error")) {
            println("ERROR: Initialize failed!")
            return
        }
        
        // 2. Install extension (convert APK to JAR)
        println("\n=== Install Extension ===")
        val apkPath = "../testdata/test.apk"
        val installResult = MihonBridge.installExtension(apkPath)
        println("Install result: $installResult")
        if (installResult.contains("error")) {
            println("ERROR: Install failed!")
            return
        }
        
        // Parse install result to get class name
        val jarPath = Regex(""""jarPath"\s*:\s*"([^"]+)"""").find(installResult)?.groupValues?.get(1)
        val className = Regex(""""className"\s*:\s*"([^"]+)"""").find(installResult)?.groupValues?.get(1) ?: ""
        println("JAR path: $jarPath")
        println("Class name: $className")
        
        if (jarPath == null) {
            println("ERROR: Could not extract jar path from result")
            return
        }
        
        // 3. Load extension
        println("\n=== Load Extension ===")
        val loadResult = MihonBridge.loadExtension(jarPath, className)
        println("Load result: $loadResult")
        if (loadResult.contains("error")) {
            println("ERROR: Load failed!")
            return
        }
        
        // Extract source ID - fix regex to not use character range incorrectly
        val sourceIdMatch = Regex(""""sourceIds"\s*:\s*\[([0-9,\s]+)\]""").find(loadResult)
        val sourceIds = sourceIdMatch?.groupValues?.get(1)?.split(",")?.mapNotNull { it.trim().toLongOrNull() } ?: emptyList()
        println("Source IDs: $sourceIds")
        
        if (sourceIds.isEmpty()) {
            println("ERROR: No source IDs returned!")
            return
        }
        
        val sourceId = sourceIds.first()
        
        // 4. Get source info
        println("\n=== Get Source Info ===")
        val infoResult = MihonBridge.getSourceInfo(sourceId)
        println("Source info: $infoResult")
        
        // 5. Get source type
        println("\n=== Get Source Type ===")
        val typeResult = MihonBridge.getSourceType(sourceId)
        println("Source type: $typeResult")
        
        // 6. Get popular
        println("\n=== Get Popular (page 1) ===")
        val popularResult = MihonBridge.getPopular(sourceId, 1)
        println("Popular result: ${popularResult.take(500)}...")
        
        // 7. Search
        println("\n=== Search for 'one' ===")
        val searchResult = MihonBridge.search(sourceId, 1, "one", "")
        println("Search result: ${searchResult.take(500)}...")
        
        println("\n=== All tests completed successfully! ===")
        
    } catch (e: Exception) {
        println("ERROR: ${e.message}")
        e.printStackTrace()
    } finally {
        // Cleanup
        println("\nCleaning up temp directory...")
        tempDir.deleteRecursively()
    }
}
