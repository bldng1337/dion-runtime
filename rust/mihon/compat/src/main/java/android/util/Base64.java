package android.util;

import java.nio.charset.StandardCharsets;

/**
 * Minimal {@code android.util.Base64} stub.
 *
 * <p>Provides the subset of Android's Base64 API used by extensions (encode/decode
 * with the {@link #DEFAULT}, {@link #NO_WRAP} and {@link #URL_SAFE} flags). The
 * implementation delegates to {@link java.util.Base64}.
 */
public final class Base64 {

    public static final int NO_PADDING = 1;
    public static final int NO_WRAP = 2;
    public static final int CRLF = 4;
    public static final int URL_SAFE = 8;
    public static final int DEFAULT = 0;

    private Base64() {}

    public static byte[] encode(byte[] input, int flags) {
        java.util.Base64.Encoder encoder = encoder(flags);
        return encoder.encode(input);
    }

    public static byte[] encode(byte[] input, int offset, int len, int flags) {
        java.util.Base64.Encoder encoder = encoder(flags);
        return encoder.encode(java.util.Arrays.copyOfRange(input, offset, offset + len));
    }

    public static String encodeToString(byte[] input, int flags) {
        return new String(encode(input, flags), StandardCharsets.UTF_8);
    }

    public static String encodeToString(byte[] input, int offset, int len, int flags) {
        return new String(encode(input, offset, len, flags), StandardCharsets.UTF_8);
    }

    public static byte[] decode(byte[] input, int flags) {
        return decoder(flags).decode(input);
    }

    public static byte[] decode(String str, int flags) {
        return decoder(flags).decode(str.getBytes(StandardCharsets.UTF_8));
    }

    private static java.util.Base64.Encoder encoder(int flags) {
        if ((flags & URL_SAFE) != 0) {
            java.util.Base64.Encoder e = java.util.Base64.getUrlEncoder();
            return (flags & NO_PADDING) != 0 ? e.withoutPadding() : e;
        }
        java.util.Base64.Encoder e = java.util.Base64.getEncoder();
        return (flags & NO_PADDING) != 0 ? e.withoutPadding() : e;
    }

    private static java.util.Base64.Decoder decoder(int flags) {
        return (flags & URL_SAFE) != 0
                ? java.util.Base64.getUrlDecoder()
                : java.util.Base64.getMimeDecoder();
    }
}
