package eu.kanade.tachiyomi.network.interceptor

import okhttp3.Interceptor
import okhttp3.Response

/**
 * Desktop stand-in for the app's WebView-backed CloudflareInterceptor.
 *
 * The keiyoushi extension template builds its client from the host's default
 * client and validates the interceptor stack by class *simple name*: a client
 * without a "CloudflareInterceptor" is rejected with `IllegalStateException`
 * ("CloudflareInterceptor must be present in default client"). The real
 * interceptor solves Cloudflare challenges inside an Android WebView, which
 * does not exist on the desktop runtime — so this one is a pass-through that
 * only keeps the client contract intact. Cloudflare-protected sources simply
 * surface their HTTP error responses, which callers treat as network errors.
 */
class CloudflareInterceptor : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response = chain.proceed(chain.request())
}
