package android.os;

/**
 * Minimal IBinder stub.
 */
public interface IBinder {
    String getInterfaceDescriptor();
    boolean pingBinder();
    boolean isBinderAlive();
    IInterface queryLocalInterface(String descriptor);
    void linkToDeath(DeathRecipient recipient, int flags);
    boolean unlinkToDeath(DeathRecipient recipient, int flags);
    
    interface DeathRecipient {
        void binderDied();
    }
}
