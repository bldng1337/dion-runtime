package android.os;

/**
 * Minimal UserHandle stub.
 */
public final class UserHandle {
    public static final int USER_OWNER = 0;
    public static final int USER_ALL = -1;
    public static final int USER_CURRENT = -2;
    public static final int USER_CURRENT_OR_SELF = -3;
    public static final int USER_NULL = -10000;
    public static final int USER_SYSTEM = 0;
    
    public static final UserHandle ALL = new UserHandle(USER_ALL);
    public static final UserHandle CURRENT = new UserHandle(USER_CURRENT);
    public static final UserHandle CURRENT_OR_SELF = new UserHandle(USER_CURRENT_OR_SELF);
    public static final UserHandle OWNER = new UserHandle(USER_OWNER);
    public static final UserHandle SYSTEM = new UserHandle(USER_SYSTEM);
    
    private final int mHandle;
    
    public UserHandle(int h) {
        mHandle = h;
    }
    
    public int getIdentifier() {
        return mHandle;
    }
    
    public static int myUserId() {
        return USER_SYSTEM;
    }
    
    public static UserHandle of(int userId) {
        return new UserHandle(userId);
    }
    
    public static int getUserId(int uid) {
        return uid / 100000;
    }
    
    public static int getUid(int userId, int appId) {
        return userId * 100000 + appId;
    }
    
    public static int getAppId(int uid) {
        return uid % 100000;
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof UserHandle) {
            return mHandle == ((UserHandle) obj).mHandle;
        }
        return false;
    }
    
    @Override
    public int hashCode() {
        return mHandle;
    }
    
    @Override
    public String toString() {
        return "UserHandle{" + mHandle + "}";
    }
}
