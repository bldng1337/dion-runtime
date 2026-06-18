package eu.kanade.tachiyomi.network

import kotlinx.coroutines.suspendCancellableCoroutine
import okhttp3.Call
import okhttp3.Callback
import okhttp3.Response
import rx.Observable
import rx.Producer
import rx.Subscription
import java.io.IOException
import java.util.concurrent.atomic.AtomicBoolean
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

/**
 * Converts an OkHttp Call to an RxJava Observable.
 */
fun Call.asObservable(): Observable<Response> {
    return Observable.unsafeCreate { subscriber ->
        // Since Call is a one-shot type, clone it for each new subscriber.
        val call = clone()

        // Wrap the call in a helper which handles both unsubscription and backpressure.
        val requestArbiter = object : Producer, Subscription {
            val started = AtomicBoolean(false)

            override fun request(n: Long) {
                if (n == 0L || !started.compareAndSet(false, true)) return

                try {
                    val response = call.execute()
                    if (!subscriber.isUnsubscribed) {
                        subscriber.onNext(response)
                        subscriber.onCompleted()
                    }
                } catch (e: Exception) {
                    if (!subscriber.isUnsubscribed) {
                        subscriber.onError(e)
                    }
                }
            }

            override fun unsubscribe() {
                call.cancel()
            }

            override fun isUnsubscribed(): Boolean {
                return call.isCanceled()
            }
        }

        subscriber.add(requestArbiter)
        subscriber.setProducer(requestArbiter)
    }
}

/**
 * Converts an OkHttp Call to an RxJava Observable that throws on non-successful responses.
 */
fun Call.asObservableSuccess(): Observable<Response> {
    return asObservable().doOnNext { response ->
        if (!response.isSuccessful) {
            response.close()
            throw HttpException(response.code)
        }
    }
}

/**
 * Exception that represents an HTTP error response.
 */
class HttpException(val code: Int) : Exception("HTTP error $code")

/**
 * Suspends until the [Call] completes and returns its [Response].
 *
 * Mirrors `eu.kanade.tachiyomi.network.OkHttpExtensionsKt.await` from the
 * Tachiyomi app — several extensions (e.g. Keiyoushi `randomua`) call this to
 * perform an HTTP request from a coroutine. The call is executed asynchronously
 * and the coroutine is cancelled (which cancels the call) on cancellation.
 */
suspend fun Call.await(): Response = suspendCancellableCoroutine { cont ->
    enqueue(object : Callback {
        override fun onResponse(call: Call, response: Response) {
            cont.resume(response)
        }

        override fun onFailure(call: Call, e: IOException) {
            cont.resumeWithException(e)
        }
    })
    cont.invokeOnCancellation { runCatching { cancel() } }
}

/**
 * Awaits the [Call] and throws [HttpException] if the response is not successful.
 *
 * Mirrors `eu.kanade.tachiyomi.network.OkHttpExtensionsKt.awaitSuccess` from the
 * Tachiyomi app. Several extensions use this to perform an HTTP request from a
 * coroutine and fail fast on error status codes.
 */
suspend fun Call.awaitSuccess(): Response {
    val response = await()
    if (!response.isSuccessful) {
        response.close()
        throw HttpException(response.code)
    }
    return response
}
