package android.content.pm;

import android.os.Bundle;

/**
 * Minimal PackageInfo stub.
 */
public class PackageInfo {
    public String packageName;
    public int versionCode;
    public String versionName;
    public String[] requestedPermissions;
    public int[] requestedPermissionsFlags;
    public ApplicationInfo applicationInfo;
    public long firstInstallTime;
    public long lastUpdateTime;
    public int baseRevisionCode;
    public String[] splitNames;
    public int[] splitRevisionCodes;
}
