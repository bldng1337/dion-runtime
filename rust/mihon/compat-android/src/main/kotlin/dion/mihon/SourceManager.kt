package dion.mihon

import dion.mihon.dto.SourceInfo
import eu.kanade.tachiyomi.source.*
import eu.kanade.tachiyomi.source.online.HttpSource
import java.util.concurrent.ConcurrentHashMap

/**
 * Manages loaded Source instances
 */
class SourceManager {
    private val sources = ConcurrentHashMap<Long, Source>()
    
    fun register(source: Source) {
        sources[source.id] = source
    }
    
    fun unregister(sourceId: Long) {
        sources.remove(sourceId)
    }
    
    fun get(sourceId: Long): Source? = sources[sourceId]
    
    fun getCatalogue(sourceId: Long): CatalogueSource {
        val source = get(sourceId) 
            ?: throw IllegalArgumentException("Source not found: $sourceId")
        return source as? CatalogueSource 
            ?: throw IllegalArgumentException("Source is not a CatalogueSource: $sourceId")
    }
    
    fun getAll(): List<Source> = sources.values.toList()
}
