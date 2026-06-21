package eu.kanade.tachiyomi.network

import android.content.Context
import okhttp3.Cookie
import okhttp3.CookieJar
import okhttp3.HttpUrl
import okhttp3.OkHttpClient
import java.security.KeyStore
import java.security.cert.X509Certificate
import java.util.concurrent.ConcurrentHashMap
import java.util.concurrent.TimeUnit
import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManagerFactory
import javax.net.ssl.X509TrustManager

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

    /**
     * TrustManager that trusts certificates from both the JDK's default trust
     * store and the operating system's root certificate store.
     *
     * The JDK's bundled `cacerts` can be outdated, which causes SSL handshake
     * failures (PKIX path building failed) for sites whose CA was added after
     * the JDK was released. The OS root store is kept up-to-date by the OS
     * (Windows Update, macOS software updates), so combining both stores gives
     * extensions access to the same set of trusted CAs they would have on
     * Android (which uses the system trust store).
     */
    private val trustManager: X509TrustManager by lazy { createSystemTrustManager() }

    private val sslSocketFactory by lazy {
        SSLContext.getInstance("TLS").apply {
            init(null, arrayOf(trustManager), null)
        }.socketFactory
    }

    private val baseClientBuilder: OkHttpClient.Builder
        get() = OkHttpClient.Builder()
            .cookieJar(cookieJar)
            .sslSocketFactory(sslSocketFactory, trustManager)
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(30, TimeUnit.SECONDS)
            .writeTimeout(30, TimeUnit.SECONDS)
            .callTimeout(2, TimeUnit.MINUTES)
            .addInterceptor { chain ->
                val originalRequest = chain.request()
                val newRequest = originalRequest.newBuilder()
                    .header("User-Agent", DEFAULT_USER_AGENT)
                    .build()
                chain.proceed(newRequest)
            }

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

    /**
     * Builds a [X509TrustManager] that trusts any certificate trusted by the
     * JDK default trust manager OR the OS root certificate store.
     */
    private fun createSystemTrustManager(): X509TrustManager {
        val managers = mutableListOf<X509TrustManager>()

        // 1. JDK default trust manager (uses the bundled `cacerts`).
        runCatching {
            val tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm())
            tmf.init(null as KeyStore?)
            managers += tmf.trustManagers.filterIsInstance<X509TrustManager>()
        }.onFailure { e ->
            println("[NetworkHelper] Failed to init JDK trust manager: ${e.message}")
        }

        // 2. OS root certificate store. The JDK's `cacerts` is often
        //    outdated; the OS store is updated regularly by the OS itself.
        val osName = System.getProperty("os.name")?.lowercase().orEmpty()
        val osKeyStoreType = when {
            "win" in osName -> "Windows-ROOT"
            "mac" in osName -> "KeychainStore"
            else -> null
        }
        osKeyStoreType?.let { type ->
            runCatching {
                val osKeyStore = KeyStore.getInstance(type)
                osKeyStore.load(null, null)
                val tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm())
                tmf.init(osKeyStore)
                managers += tmf.trustManagers.filterIsInstance<X509TrustManager>()
            }.onFailure { e ->
                println("[NetworkHelper] Failed to load OS trust store '$type': ${e.message}")
            }
        }

        return if (managers.isNotEmpty()) {
            CompositeX509TrustManager(managers)
        } else {
            // Last-resort fallback so extensions still work if neither trust
            // store could be loaded.
            TrustAllManager
        }
    }

    companion object {
        const val DEFAULT_USER_AGENT =
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    }
}

/**
 * A [X509TrustManager] that delegates to multiple underlying managers.
 *
 * A certificate is accepted if **any** underlying manager trusts it, which
 * lets us combine the JDK trust store with the OS root certificate store.
 */
private class CompositeX509TrustManager(
    private val managers: List<X509TrustManager>,
) : X509TrustManager {

    override fun checkClientTrusted(chain: Array<X509Certificate>, authType: String) {
        val errors = managers.mapNotNull { tm ->
            runCatching { tm.checkClientTrusted(chain, authType) }.exceptionOrNull()
        }
        if (errors.size == managers.size) throw errors.first()
    }

    override fun checkServerTrusted(chain: Array<X509Certificate>, authType: String) {
        val errors = managers.mapNotNull { tm ->
            runCatching { tm.checkServerTrusted(chain, authType) }.exceptionOrNull()
        }
        if (errors.size == managers.size) throw errors.first()
    }

    override fun getAcceptedIssuers(): Array<X509Certificate> =
        managers.flatMap { it.acceptedIssuers.asList() }.toTypedArray()
}

/**
 * Permissive trust manager used only as a last-resort fallback when neither
 * the JDK nor the OS trust store could be loaded.
 */
private object TrustAllManager : X509TrustManager {
    override fun checkClientTrusted(chain: Array<X509Certificate>?, authType: String?) {}
    override fun checkServerTrusted(chain: Array<X509Certificate>?, authType: String?) {}
    override fun getAcceptedIssuers(): Array<X509Certificate> = emptyArray()
}
