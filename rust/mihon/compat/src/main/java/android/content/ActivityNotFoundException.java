package android.content;

/**
 * Minimal {@code android.content.ActivityNotFoundException} stub.
 *
 * <p>Thrown by Android when {@code startActivity} finds no matching activity.
 * Some extensions catch this type when launching URL/deep-link activities; the
 * class must be a loadable {@link RuntimeException} subtype for that to work.
 */
public class ActivityNotFoundException extends RuntimeException {

    public ActivityNotFoundException() {
        super();
    }

    public ActivityNotFoundException(String name) {
        super(name);
    }
}
