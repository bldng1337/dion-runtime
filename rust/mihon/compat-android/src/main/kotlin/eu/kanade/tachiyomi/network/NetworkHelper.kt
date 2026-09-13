package eu.kanade.tachiyomi.network

import android.content.Context
import eu.kanade.tachiyomi.network.interceptor.CloudflareInterceptor
import eu.kanade.tachiyomi.network.interceptor.UncaughtExceptionInterceptor
import eu.kanade.tachiyomi.network.interceptor.UserAgentInterceptor
import okhttp3.Cookie
import okhttp3.CookieJar
import okhttp3.HttpUrl
import okhttp3.OkHttpClient
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.TimeUnit

/**
 * A simple in-memory CookieJar implementation.
 */
class SimpleCookieJar : CookieJar {
    private val cookies = ConcurrentHashMap<String, MutableList<Cookie>>()
    
    override fun saveFromResponse(url: HttpUrl, cookies: List<Cookie>) {
        val key = url.host
        this.cookies.getOrPut(key) { mutableListOf() }.apply {
            // Remove old cookies with same name
            cookies.forEach { cookie ->
                removeAll { it.name == cookie.name }
            }
            addAll(cookies)
        }
    }
    
    override fun loadForRequest(url: HttpUrl): List<Cookie> {
        val host = url.host
        val hostCookies = cookies[host] ?: return emptyList()
        val now = System.currentTimeMillis()
        // Filter expired cookies
        return hostCookies.filter { cookie ->
            cookie.expiresAt > now
        }
    }
    
    fun clear() {
        cookies.clear()
    }
}

/**
 * NetworkHelper provides HTTP clients for extensions.
 * 
 * Extensions access this via dependency injection and use the `client` property
 * to make HTTP requests.
 */
class NetworkHelper(
    @Suppress("unused") private val context: Context
) {
    
    val cookieJar = SimpleCookieJar()
    
    private val baseClientBuilder: OkHttpClient.Builder
        get() = OkHttpClient.Builder()
            .cookieJar(cookieJar)
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(30, TimeUnit.SECONDS)
            .writeTimeout(30, TimeUnit.SECONDS)
            .callTimeout(2, TimeUnit.MINUTES)
            // Mirrors the desktop compat layer's default client. The
            // interceptor stack (by class simple name) is part of the contract
            // newer keiyoushi extensions check before building their source
            // client; a missing interceptor fails with IllegalStateException
            // ("UncaughtExceptionInterceptor must be present in default client").
            .addInterceptor(UncaughtExceptionInterceptor())
            .addInterceptor(UserAgentInterceptor { DEFAULT_USER_AGENT })
            .addInterceptor(CloudflareInterceptor())
    
    /**
     * The main HTTP client for extensions.
     */
    val client: OkHttpClient by lazy {
        baseClientBuilder.build()
    }
    
    /**
     * Legacy cloudflare client - same as regular client.
     * @deprecated Since extension-lib 1.5
     */
    @Deprecated("The regular client handles Cloudflare by default")
    @Suppress("UNUSED")
    val cloudflareClient: OkHttpClient by lazy { client }
    
    companion object {
        const val DEFAULT_USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }
}
