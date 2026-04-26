package android.database;

/**
 * Minimal DatabaseErrorHandler stub.
 */
public interface DatabaseErrorHandler {
    void onCorruption(android.database.sqlite.SQLiteDatabase dbObj);
}
