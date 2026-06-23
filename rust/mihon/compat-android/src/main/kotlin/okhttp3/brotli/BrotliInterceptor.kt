package okhttp3.brotli

import okhttp3.Interceptor
import okhttp3.Response

/**
 * Minimal stub for `okhttp3.brotli.BrotliInterceptor`.
 *
 * The real class (from `com.squareup.okhttp3:okhttp-brotli-interceptor`) is a
 * Kotlin `object` implementing [Interceptor] that advertises `Accept-Encoding: br`
 * and decompresses Brotli responses. Several Keiyoushi extensions
 * (e.g. `keiyoushi.lib.randomua`) reference it — typically only to locate it
 * among the client's interceptors via an `instanceof` check — so the class must
 * exist on the classpath. This stub implements [Interceptor] as a no-op chain
 * call; Brotli decompression is not needed to run the extensions.
 *
 * Ported from the desktop `compat` layer (`okhttp3/brotli/BrotliInterceptor.kt`).
 */
object BrotliInterceptor : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response = chain.proceed(chain.request())
}
