package app.cash.quickjs;

import java.io.Closeable;
import org.mozilla.javascript.Context;
import org.mozilla.javascript.ScriptableObject;
import org.mozilla.javascript.Undefined;

/**
 * Rhino-backed implementation of the {@code app.cash.quickjs.QuickJs} surface.
 *
 * <p>Several Tachiyomi extensions instantiate {@code QuickJs} to evaluate
 * JavaScript — typically to decrypt obfuscated image/video URLs or to solve
 * simple challenges. The real {@code quickjs-jvm} library wraps the QuickJS C
 * engine via JNI and ships no Windows native binary, so it cannot be used on the
 * desktop test/runtime host. This implementation provides the same minimal API
 * (creation, {@link #evaluate(String)}, {@link #evaluate(String, String)},
 * {@link #close()}) backed by Mozilla Rhino, a pure-Java JavaScript engine, so
 * the common decrypt-a-string use cases work without a native dependency.
 *
 * <p>Only the subset of the QuickJs API that extensions exercise is
 * implemented. Anything Rhino cannot handle propagates as a
 * {@link QuickJsException} so the caller sees a clear, typed failure.
 */
public class QuickJs implements Closeable {

    private final Context context;
    private final ScriptableObject scope;
    private boolean closed;

    private QuickJs() {
        this.context = Context.enter();
        // Optimize for interpreted execution; no bytecode generation needed.
        this.context.setOptimizationLevel(-1);
        this.scope = context.initSafeStandardObjects();
    }

    /**
     * Creates a new QuickJs instance backed by a fresh Rhino context.
     *
     * @return a new {@link QuickJs}
     */
    public static QuickJs create() {
        return new QuickJs();
    }

    /**
     * Evaluates {@code sourceCode} as JavaScript and returns the result as a
     * Java {@link Object} (matching QuickJs' {@code Object}-returning
     * {@code evaluate}). Strings come back as {@link String}, numbers as
     * {@link Double}/{@link Integer}, and everything else is coerced to its
     * nearest Java representation by Rhino.
     *
     * @param sourceCode the JavaScript to evaluate
     * @return the result, as a Java object
     * @throws QuickJsException if evaluation throws
     */
    public Object evaluate(String sourceCode) {
        return evaluate(sourceCode, "?");
    }

    /**
     * Evaluates {@code sourceCode} (reported as {@code fileName} in errors) and
     * returns the result as a Java {@link Object}.
     *
     * @param sourceCode the JavaScript to evaluate
     * @param fileName   the source file name used in error reporting
     * @return the result, as a Java object
     * @throws QuickJsException if evaluation throws
     */
    public Object evaluate(String sourceCode, String fileName) {
        ensureOpen();
        try {
            return jsToJava(
                context.evaluateString(scope, sourceCode, fileName, 1, null)
            );
        } catch (QuickJsException e) {
            throw e;
        } catch (Throwable t) {
            throw new QuickJsException(
                "Failed to evaluate JavaScript: " + t.getMessage(),
                t
            );
        }
    }

    /**
     * Evaluates {@code sourceCode} and coerces the result to {@code returnType}.
     * Only {@link String}, {@link Integer}, {@link Double}, and {@link Boolean}
     * are supported (covering the cases extensions use).
     *
     * @param sourceCode the JavaScript to evaluate
     * @param fileName   the source file name used in error reporting
     * @param returnType the desired Java result type
     * @return the coerced result
     * @throws QuickJsException if the result cannot be coerced or evaluation fails
     */
    public <T> T evaluate(
        String sourceCode,
        String fileName,
        Class<T> returnType
    ) {
        ensureOpen();
        try {
            Object result = context.evaluateString(
                scope,
                sourceCode,
                fileName,
                1,
                null
            );
            return coerce(result, returnType);
        } catch (QuickJsException e) {
            throw e;
        } catch (Throwable t) {
            throw new QuickJsException(
                "Failed to evaluate JavaScript: " + t.getMessage(),
                t
            );
        }
    }

    /**
     * Converts a Rhino JS value into a plain Java object suitable for returning
     * across the QuickJs API. Strings stay strings, numbers become {@link Double}
     * (with integer-valued doubles normalized to {@link Integer} for convenience),
     * booleans become {@link Boolean}, and {@code undefined}/{@code null} become
     * {@code null}.
     */
    private Object jsToJava(Object result) {
        if (result == null || result instanceof Undefined) {
            return null;
        }
        if (result instanceof String) {
            return result;
        }
        if (result instanceof Boolean) {
            return result;
        }
        if (result instanceof Number) {
            double d = ((Number) result).doubleValue();
            if (
                !Double.isNaN(d) &&
                !Double.isInfinite(d) &&
                d == Math.rint(d) &&
                d >= Integer.MIN_VALUE &&
                d <= Integer.MAX_VALUE
            ) {
                return (Integer) (int) d;
            }
            return (Double) d;
        }
        // Fall back to a string representation for objects/arrays.
        return Context.toString(result);
    }

    private String coerceToString(Object result) {
        if (result == null || result instanceof Undefined) {
            return "undefined";
        }
        return Context.toString(result);
    }

    @SuppressWarnings("unchecked")
    private <T> T coerce(Object result, Class<T> returnType) {
        if (returnType == Object.class) {
            return (T) jsToJava(result);
        }
        if (returnType == String.class) {
            return (T) coerceToString(result);
        }
        if (result == null || result instanceof Undefined) {
            return null;
        }
        if (returnType == Integer.class || returnType == int.class) {
            return (T) (Integer) Integer.valueOf(
                (int) Context.toNumber(result)
            );
        }
        if (returnType == Double.class || returnType == double.class) {
            return (T) (Double) Context.toNumber(result);
        }
        if (returnType == Boolean.class || returnType == boolean.class) {
            return (T) (Boolean) Context.toBoolean(result);
        }
        throw new QuickJsException(
            "Unsupported return type: " + returnType.getName()
        );
    }

    /**
     * Defines a global integer constant, mirroring QuickJs' typed global setters.
     * Only the value types extensions commonly use are supported.
     */
    public void set(String name, int value) {
        ensureOpen();
        ScriptableObject.putProperty(scope, name, value);
    }

    /** Defines a global string constant. */
    public void set(String name, String value) {
        ensureOpen();
        ScriptableObject.putProperty(scope, name, value);
    }

    /** Defines a global boolean constant. */
    public void set(String name, boolean value) {
        ensureOpen();
        ScriptableObject.putProperty(scope, name, value);
    }

    private void ensureOpen() {
        if (closed) {
            throw new QuickJsException("QuickJs instance is closed");
        }
    }

    @Override
    public void close() {
        if (!closed) {
            closed = true;
            Context.exit();
        }
    }
}
