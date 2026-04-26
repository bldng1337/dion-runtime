package android.content.pm;

import java.io.File;

/**
 * Minimal ApplicationInfo stub.
 */
public class ApplicationInfo extends PackageItemInfo {
    public String sourceDir;
    public String publicSourceDir;
    public String[] splitSourceDirs;
    public String[] splitPublicSourceDirs;
    public String[] resourceDirs;
    public String[] sharedLibraryFiles;
    public String dataDir;
    public String deviceProtectedDataDir;
    public String credentialProtectedDataDir;
    public String nativeLibraryDir;
    public String secondaryNativeLibraryDir;
    public int uid;
    public int minSdkVersion;
    public int targetSdkVersion;
    public int versionCode;
    public boolean enabled = true;
    public int flags;
    public String processName;
    public String className;
    public String taskAffinity;
    public String permission;
    public int theme;
    public int descriptionRes;
    public int labelRes;
    public int iconRes;
    public int logo;
    public int banner;
    public String backupAgentName;
    public int fullBackupContent;
    public int networkSecurityConfigRes;
    public int category = -1;
    
    // Flags
    public static final int FLAG_SYSTEM = 1<<0;
    public static final int FLAG_DEBUGGABLE = 1<<1;
    public static final int FLAG_HAS_CODE = 1<<2;
    public static final int FLAG_PERSISTENT = 1<<3;
    public static final int FLAG_FACTORY_TEST = 1<<4;
    public static final int FLAG_ALLOW_TASK_REPARENTING = 1<<5;
    public static final int FLAG_ALLOW_CLEAR_USER_DATA = 1<<6;
    public static final int FLAG_UPDATED_SYSTEM_APP = 1<<7;
    public static final int FLAG_TEST_ONLY = 1<<8;
    public static final int FLAG_SUPPORTS_SMALL_SCREENS = 1<<9;
    public static final int FLAG_SUPPORTS_NORMAL_SCREENS = 1<<10;
    public static final int FLAG_SUPPORTS_LARGE_SCREENS = 1<<11;
    public static final int FLAG_RESIZEABLE_FOR_SCREENS = 1<<12;
    public static final int FLAG_SUPPORTS_SCREEN_DENSITIES = 1<<13;
    public static final int FLAG_VM_SAFE_MODE = 1<<14;
    public static final int FLAG_ALLOW_BACKUP = 1<<15;
    public static final int FLAG_KILL_AFTER_RESTORE = 1<<16;
    public static final int FLAG_RESTORE_ANY_VERSION = 1<<17;
    public static final int FLAG_EXTERNAL_STORAGE = 1<<18;
    public static final int FLAG_SUPPORTS_XLARGE_SCREENS = 1<<19;
    public static final int FLAG_LARGE_HEAP = 1<<20;
    public static final int FLAG_STOPPED = 1<<21;
    public static final int FLAG_SUPPORTS_RTL = 1<<22;
    public static final int FLAG_INSTALLED = 1<<23;
    public static final int FLAG_IS_DATA_ONLY = 1<<24;
    public static final int FLAG_IS_GAME = 1<<25;
    public static final int FLAG_FULL_BACKUP_ONLY = 1<<26;
    public static final int FLAG_USES_CLEARTEXT_TRAFFIC = 1<<27;
    public static final int FLAG_EXTRACT_NATIVE_LIBS = 1<<28;
    public static final int FLAG_HARDWARE_ACCELERATED = 1<<29;
    public static final int FLAG_SUSPENDED = 1<<30;
    public static final int FLAG_MULTIARCH = 1<<31;
    
    public ApplicationInfo() {
    }
    
    public ApplicationInfo(ApplicationInfo orig) {
        super(orig);
        sourceDir = orig.sourceDir;
        publicSourceDir = orig.publicSourceDir;
        dataDir = orig.dataDir;
        nativeLibraryDir = orig.nativeLibraryDir;
        uid = orig.uid;
        minSdkVersion = orig.minSdkVersion;
        targetSdkVersion = orig.targetSdkVersion;
        enabled = orig.enabled;
        flags = orig.flags;
        processName = orig.processName;
        className = orig.className;
    }
    
    public File getDataDirFile() {
        return dataDir != null ? new File(dataDir) : null;
    }
}
