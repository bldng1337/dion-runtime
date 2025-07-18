declare class ExtensionManager {
    path: string;
    manager: any;
    constructor(path: string);
    getExtensions(): Promise<Extension[]>;
}
declare class Extension {
    ext: any;
    constructor(ext: any);
    setEnabled(enabled: boolean): Promise<void>;
    isEnabled(): Promise<boolean>;
    setSetting(id: string, setting: Settingvalues): Promise<void>;
    getSetting(id: string): Promise<ExtensionSetting>;
    browse(page: number, sort: Sort): Promise<Entry[]>;
    fromUrl(url: string): Promise<Entry | undefined>;
    search(page: number, filter: string): Promise<Entry[]>;
    detail(entryid: string, settings?: {
        [key: string]: Setting;
    }): Promise<EntryDetailed>;
    source(epid: string, settings?: {
        [key: string]: Setting;
    }): Promise<Source>;
}
export { ExtensionManager, Extension };
