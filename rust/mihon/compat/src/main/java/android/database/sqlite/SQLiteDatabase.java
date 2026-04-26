package android.database.sqlite;

import android.database.DatabaseErrorHandler;

/**
 * Minimal SQLiteDatabase stub.
 */
public class SQLiteDatabase {
    
    public interface CursorFactory {
        // Cursor interface not needed for stubs
    }
    
    public void close() {
    }
    
    public boolean isOpen() {
        return false;
    }
    
    public void execSQL(String sql) {
        throw new UnsupportedOperationException("SQLiteDatabase not supported");
    }
    
    public long insert(String table, String nullColumnHack, android.content.ContentValues values) {
        throw new UnsupportedOperationException("SQLiteDatabase not supported");
    }
    
    public int update(String table, android.content.ContentValues values, String whereClause, String[] whereArgs) {
        throw new UnsupportedOperationException("SQLiteDatabase not supported");
    }
    
    public int delete(String table, String whereClause, String[] whereArgs) {
        throw new UnsupportedOperationException("SQLiteDatabase not supported");
    }
    
    public void beginTransaction() {
    }
    
    public void setTransactionSuccessful() {
    }
    
    public void endTransaction() {
    }
}
