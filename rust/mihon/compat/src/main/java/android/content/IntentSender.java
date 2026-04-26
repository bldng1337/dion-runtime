package android.content;

/**
 * Minimal IntentSender stub.
 */
public class IntentSender {
    
    public static class SendIntentException extends Exception {
        public SendIntentException() {
            super();
        }
        
        public SendIntentException(String message) {
            super(message);
        }
        
        public SendIntentException(Exception cause) {
            super(cause);
        }
    }
}
