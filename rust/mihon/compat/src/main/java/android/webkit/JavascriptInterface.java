package android.webkit;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Minimal {@code JavascriptInterface} annotation stub.
 *
 * <p>On Android this marks methods exposed to a {@link WebView}'s JavaScript
 * engine. Extensions annotate helper methods with it; we only need the
 * annotation type to be present at runtime for class loading.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface JavascriptInterface {
}
