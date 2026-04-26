package android.content.pm;

import android.os.Bundle;

/**
 * Minimal PackageItemInfo stub.
 */
public class PackageItemInfo {
    public String name;
    public String packageName;
    public int labelRes;
    public CharSequence nonLocalizedLabel;
    public int icon;
    public int banner;
    public int logo;
    public Bundle metaData;
    
    public PackageItemInfo() {
    }
    
    public PackageItemInfo(PackageItemInfo orig) {
        name = orig.name;
        packageName = orig.packageName;
        labelRes = orig.labelRes;
        nonLocalizedLabel = orig.nonLocalizedLabel;
        icon = orig.icon;
        banner = orig.banner;
        logo = orig.logo;
        metaData = orig.metaData;
    }
    
    public CharSequence loadLabel(PackageManager pm) {
        if (nonLocalizedLabel != null) {
            return nonLocalizedLabel;
        }
        if (labelRes != 0) {
            // In stub, just return name
            return name;
        }
        return name;
    }
}
