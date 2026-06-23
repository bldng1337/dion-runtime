package app.cash.quickjs;

/**
 * Mirrors {@code app.cash.quickjs.QuickJsException}.
 *
 * <p>Thrown by {@link QuickJs} when JavaScript evaluation fails or when a result
 * cannot be coerced to the requested type. Extends {@link RuntimeException} so it
 * is unchecked, matching the upstream QuickJs API.
 */
public class QuickJsException extends RuntimeException {

    public QuickJsException(String message) {
        super(message);
    }

    public QuickJsException(String message, Throwable cause) {
        super(message, cause);
    }
}
