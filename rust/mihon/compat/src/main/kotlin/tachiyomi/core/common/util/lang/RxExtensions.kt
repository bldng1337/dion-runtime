package tachiyomi.core.common.util.lang

import rx.Observable
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

/**
 * Awaits the single value from an Observable in a suspending manner.
 * This bridges RxJava 1.x Observables to Kotlin coroutines.
 */
suspend fun <T> Observable<T>.awaitSingle(): T {
    return suspendCancellableCoroutine { continuation ->
        val subscription = this
            .single()
            .subscribe(
                { value ->
                    continuation.resume(value)
                },
                { error ->
                    continuation.resumeWithException(error)
                }
            )
        
        continuation.invokeOnCancellation {
            subscription.unsubscribe()
        }
    }
}
