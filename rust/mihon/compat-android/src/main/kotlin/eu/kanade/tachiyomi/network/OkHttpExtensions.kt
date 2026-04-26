package eu.kanade.tachiyomi.network

import okhttp3.Call
import okhttp3.Response
import rx.Observable
import rx.Producer
import rx.Subscription
import java.util.concurrent.atomic.AtomicBoolean

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
