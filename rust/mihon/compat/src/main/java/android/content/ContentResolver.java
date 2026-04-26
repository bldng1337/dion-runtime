package android.content;

/**
 * Minimal ContentResolver stub.
 */
public abstract class ContentResolver {
    public static final String SCHEME_CONTENT = "content";
    public static final String SCHEME_ANDROID_RESOURCE = "android.resource";
    public static final String SCHEME_FILE = "file";
    
    public ContentResolver() {
    }
    
    // Most methods are abstract or throw UnsupportedOperationException
    // We just need this class to exist for compilation
}
