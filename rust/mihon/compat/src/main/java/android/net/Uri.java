package android.net;

import java.io.File;
import java.util.List;

/**
 * Minimal Uri stub.
 */
public abstract class Uri {
    
    public static final Uri EMPTY = new StringUri("");
    
    public abstract String getScheme();
    public abstract String getSchemeSpecificPart();
    public abstract String getEncodedSchemeSpecificPart();
    public abstract String getAuthority();
    public abstract String getEncodedAuthority();
    public abstract String getUserInfo();
    public abstract String getEncodedUserInfo();
    public abstract String getHost();
    public abstract int getPort();
    public abstract String getPath();
    public abstract String getEncodedPath();
    public abstract String getQuery();
    public abstract String getEncodedQuery();
    public abstract String getFragment();
    public abstract String getEncodedFragment();
    public abstract List<String> getPathSegments();
    public abstract String getLastPathSegment();
    
    public String getQueryParameter(String key) {
        return null;
    }
    
    public static Uri parse(String uriString) {
        return new StringUri(uriString);
    }
    
    public static Uri fromFile(File file) {
        return new StringUri("file://" + file.getAbsolutePath());
    }
    
    public Builder buildUpon() {
        return new Builder();
    }
    
    // Simple string-based Uri implementation
    private static class StringUri extends Uri {
        private final String mUri;
        
        StringUri(String uri) {
            mUri = uri != null ? uri : "";
        }
        
        @Override
        public String getScheme() {
            int sep = mUri.indexOf(':');
            return sep > 0 ? mUri.substring(0, sep) : null;
        }
        
        @Override
        public String getSchemeSpecificPart() {
            int sep = mUri.indexOf(':');
            return sep > 0 ? mUri.substring(sep + 1) : mUri;
        }
        
        @Override
        public String getEncodedSchemeSpecificPart() {
            return getSchemeSpecificPart();
        }
        
        @Override
        public String getAuthority() {
            String ssp = getSchemeSpecificPart();
            if (ssp.startsWith("//")) {
                int end = ssp.indexOf('/', 2);
                return end > 2 ? ssp.substring(2, end) : ssp.substring(2);
            }
            return null;
        }
        
        @Override
        public String getEncodedAuthority() {
            return getAuthority();
        }
        
        @Override
        public String getUserInfo() {
            String auth = getAuthority();
            if (auth != null) {
                int at = auth.indexOf('@');
                return at >= 0 ? auth.substring(0, at) : null;
            }
            return null;
        }
        
        @Override
        public String getEncodedUserInfo() {
            return getUserInfo();
        }
        
        @Override
        public String getHost() {
            String auth = getAuthority();
            if (auth != null) {
                int at = auth.indexOf('@');
                int start = at >= 0 ? at + 1 : 0;
                int colon = auth.indexOf(':', start);
                return colon >= 0 ? auth.substring(start, colon) : auth.substring(start);
            }
            return null;
        }
        
        @Override
        public int getPort() {
            String auth = getAuthority();
            if (auth != null) {
                int colon = auth.lastIndexOf(':');
                if (colon >= 0) {
                    try {
                        return Integer.parseInt(auth.substring(colon + 1));
                    } catch (NumberFormatException e) {
                        // ignore
                    }
                }
            }
            return -1;
        }
        
        @Override
        public String getPath() {
            String ssp = getSchemeSpecificPart();
            if (ssp.startsWith("//")) {
                int start = ssp.indexOf('/', 2);
                if (start >= 0) {
                    int query = ssp.indexOf('?', start);
                    return query >= 0 ? ssp.substring(start, query) : ssp.substring(start);
                }
                return "";
            }
            int query = ssp.indexOf('?');
            return query >= 0 ? ssp.substring(0, query) : ssp;
        }
        
        @Override
        public String getEncodedPath() {
            return getPath();
        }
        
        @Override
        public String getQuery() {
            int query = mUri.indexOf('?');
            if (query >= 0) {
                int frag = mUri.indexOf('#', query);
                return frag >= 0 ? mUri.substring(query + 1, frag) : mUri.substring(query + 1);
            }
            return null;
        }
        
        @Override
        public String getEncodedQuery() {
            return getQuery();
        }
        
        @Override
        public String getFragment() {
            int frag = mUri.indexOf('#');
            return frag >= 0 ? mUri.substring(frag + 1) : null;
        }
        
        @Override
        public String getEncodedFragment() {
            return getFragment();
        }
        
        @Override
        public List<String> getPathSegments() {
            String path = getPath();
            if (path == null || path.isEmpty()) {
                return java.util.Collections.emptyList();
            }
            java.util.ArrayList<String> segments = new java.util.ArrayList<>();
            for (String segment : path.split("/")) {
                if (!segment.isEmpty()) {
                    segments.add(segment);
                }
            }
            return segments;
        }
        
        @Override
        public String getLastPathSegment() {
            List<String> segments = getPathSegments();
            return segments.isEmpty() ? null : segments.get(segments.size() - 1);
        }
        
        @Override
        public String toString() {
            return mUri;
        }
    }
    
    public static class Builder {
        private String scheme;
        private String authority;
        private String path;
        private String query;
        private String fragment;
        
        public Builder scheme(String scheme) {
            this.scheme = scheme;
            return this;
        }
        
        public Builder authority(String authority) {
            this.authority = authority;
            return this;
        }
        
        public Builder path(String path) {
            this.path = path;
            return this;
        }
        
        public Builder appendPath(String newSegment) {
            if (path == null) {
                path = "/" + newSegment;
            } else if (path.endsWith("/")) {
                path = path + newSegment;
            } else {
                path = path + "/" + newSegment;
            }
            return this;
        }
        
        public Builder appendQueryParameter(String key, String value) {
            if (query == null) {
                query = key + "=" + value;
            } else {
                query = query + "&" + key + "=" + value;
            }
            return this;
        }
        
        public Builder query(String query) {
            this.query = query;
            return this;
        }
        
        public Builder fragment(String fragment) {
            this.fragment = fragment;
            return this;
        }
        
        public Uri build() {
            StringBuilder sb = new StringBuilder();
            if (scheme != null) {
                sb.append(scheme).append(":");
            }
            if (authority != null) {
                sb.append("//").append(authority);
            }
            if (path != null) {
                sb.append(path);
            }
            if (query != null) {
                sb.append("?").append(query);
            }
            if (fragment != null) {
                sb.append("#").append(fragment);
            }
            return new StringUri(sb.toString());
        }
    }
}
