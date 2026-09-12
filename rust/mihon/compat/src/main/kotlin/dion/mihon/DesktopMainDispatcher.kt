package dion.mihon

import kotlinx.coroutines.ExecutorCoroutineDispatcher
import kotlinx.coroutines.MainCoroutineDispatcher
import kotlinx.coroutines.asCoroutineDispatcher
import kotlinx.coroutines.internal.MainDispatcherFactory
import java.util.concurrent.Executors

/**
 * Provides `Dispatchers.Main` for extensions running on the desktop runtime.
 *
 * Extensions occasionally hop to `withContext(Dispatchers.Main)` (for
 * UI-adjacent work); on Android the app supplies the Android Main dispatcher,
 * and the official desktop stand-in (`kotlinx-coroutines-swing`) requires AWT
 * natives that are not loadable inside the embedded JVM. This factory supplies
 * a Main dispatcher backed by one dedicated daemon thread instead — there is
 * no UI thread to synchronize with, so any single-threaded executor preserves
 * the serialization guarantees extension code expects from Main.
 *
 * Registered through
 * `META-INF/services/kotlinx.coroutines.internal.MainDispatcherFactory` with a
 * load priority above the built-in fallbacks.
 */
@OptIn(kotlinx.coroutines.InternalCoroutinesApi::class)
internal class DesktopMainDispatcherFactory : MainDispatcherFactory {
    override fun createDispatcher(allFactories: List<MainDispatcherFactory>): MainCoroutineDispatcher =
        DesktopMainDispatcher

    override fun hintOnError(): String = "DionDesktopMain"

    override val loadPriority: Int
        get() = 10_000
}

private object DesktopMainDispatcher : MainCoroutineDispatcher() {
    private val delegate: ExecutorCoroutineDispatcher =
        Executors
            .newSingleThreadExecutor { runnable ->
                Thread(runnable, "dion-main-dispatcher").apply { isDaemon = true }
            }.asCoroutineDispatcher()

    override val immediate: MainCoroutineDispatcher
        get() = this

    override fun isDispatchNeeded(context: kotlin.coroutines.CoroutineContext): Boolean = delegate.isDispatchNeeded(context)

    override fun dispatch(context: kotlin.coroutines.CoroutineContext, value: Runnable) = delegate.dispatch(context, value)

    override fun toString(): String = "Dion desktop Main dispatcher"
}
