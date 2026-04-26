package android.content.res;

/**
 * Minimal AssetManager stub.
 */
public class AssetManager {
    public AssetManager() {
    }
    
    public String[] list(String path) throws java.io.IOException {
        return new String[0];
    }
    
    public java.io.InputStream open(String fileName) throws java.io.IOException {
        throw new java.io.FileNotFoundException(fileName);
    }
    
    public java.io.InputStream open(String fileName, int accessMode) throws java.io.IOException {
        return open(fileName);
    }
    
    public void close() {
    }
}
