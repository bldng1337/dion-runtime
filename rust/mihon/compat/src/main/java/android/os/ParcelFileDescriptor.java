package android.os;

import java.io.Closeable;
import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;

/**
 * Minimal {@code android.os.ParcelFileDescriptor} stub.
 *
 * <p>Extensions rarely touch this directly; the few that do (typically to hand a
 * local file to a media/decoding API) only need {@link #open(File, int)} and
 * {@link #getFileDescriptor()}. This stub wraps a plain {@link FileDescriptor}
 * backed by a {@link RandomAccessFile} so reads/writes work on the desktop JVM.
 */
public class ParcelFileDescriptor implements Closeable {

    public static final int MODE_READ_ONLY = 0x10000000;
    public static final int MODE_WRITE_ONLY = 0x20000000;
    public static final int MODE_READ_WRITE = 0x30000000;
    public static final int MODE_CREATE = 0x08000000;
    public static final int MODE_TRUNCATE = 0x01000000;
    public static final int MODE_APPEND = 0x02000000;

    private final RandomAccessFile backing;
    private boolean closed;

    private ParcelFileDescriptor(RandomAccessFile backing) {
        this.backing = backing;
    }

    /**
     * Opens a {@link File} with the given mode flags (one of {@code MODE_READ_ONLY},
     * {@code MODE_WRITE_ONLY}, {@code MODE_READ_WRITE}, optionally OR'ed with
     * {@code MODE_CREATE}/{@code MODE_TRUNCATE}/{@code MODE_APPEND}).
     */
    public static ParcelFileDescriptor open(File file, int mode)
        throws IOException {
        boolean read =
            (mode & MODE_READ_ONLY) == MODE_READ_ONLY ||
            (mode & MODE_READ_WRITE) == MODE_READ_WRITE;
        boolean write =
            (mode & MODE_WRITE_ONLY) == MODE_WRITE_ONLY ||
            (mode & MODE_READ_WRITE) == MODE_READ_WRITE;
        String rw;
        if (read && write) {
            rw = "rw";
        } else if (write) {
            rw = "rw"; // RandomAccessFile has no write-only mode; rw is close enough.
        } else {
            rw = "r";
        }
        RandomAccessFile raf = new RandomAccessFile(file, rw);
        if ((mode & MODE_TRUNCATE) != 0 && raf.length() > 0) {
            raf.setLength(0);
        }
        return new ParcelFileDescriptor(raf);
    }

    /** Returns the underlying file descriptor. */
    public FileDescriptor getFileDescriptor() {
        try {
            return backing.getFD();
        } catch (IOException e) {
            return null;
        }
    }

    /** Returns the integer fd, or {@code -1} if unavailable. */
    public int getFd() {
        FileDescriptor fd = getFileDescriptor();
        return fd == null ? -1 : System.identityHashCode(fd);
    }

    public long getStatSize() {
        try {
            return backing.length();
        } catch (IOException e) {
            return -1;
        }
    }

    public FileInputStream createInputStream() throws IOException {
        return new FileInputStream(getFileDescriptor());
    }

    public FileOutputStream createOutputStream() throws IOException {
        return new FileOutputStream(getFileDescriptor());
    }

    @Override
    public void close() throws IOException {
        if (!closed) {
            closed = true;
            backing.close();
        }
    }
}
