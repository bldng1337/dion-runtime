package eu.kanade.tachiyomi.source

/**
 * A basic interface for creating a source.
 */
interface Source {
    /**
     * Id for the source. Must be unique.
     */
    val id: Long

    /**
     * Name of the source.
     */
    val name: String
    
    /**
     * Language of the source.
     */
    val lang: String
        get() = ""
}
