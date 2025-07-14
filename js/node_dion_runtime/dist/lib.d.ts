declare const lib: any;
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
    getEnabled(): Promise<boolean>;
    setSetting(id: string, setting: any): Promise<void>;
    getSetting(id: string): Promise<any>;
    browse(page: number, sort: any): Promise<any>;
    search(page: number, filter: any): Promise<any>;
    detail(entryid: string, settings?: any): Promise<any>;
    source(epid: string, settings?: any): Promise<any>;
}
