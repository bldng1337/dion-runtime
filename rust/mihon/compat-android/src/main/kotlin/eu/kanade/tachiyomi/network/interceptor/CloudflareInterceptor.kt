package eu.kanade.tachiyomi.network.interceptor

import okhttp3.Interceptor
import okhttp3.Response

/**
 * Pass-through stand-in for the app's WebView-backed CloudflareInterceptor.
 *
 * The keiyoushi extension template builds its client from the host's default
 * client and validates the interceptor stack by class *simple name*: a client
 * without a "CloudflareInterceptor" is rejected with `IllegalStateException`
 * ("CloudflareInterceptor must be present in default client"). Extensions run
 * inside Dion's own process where no challenge-solving WebView is wired up —
 * same as the desktop runtime — so this interceptor is a pass-through that
 * only keeps the client contract intact. Cloudflare-protected sources simply
 * surface their HTTP error responses, which callers treat as network errors.
 */
class CloudflareInterceptor : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response = chain.proceed(chain.request())
}
