export declare type Dictionary = Record<string, string>;
export declare class Bundle {
    #private;
    constructor(dictionary?: Dictionary);
    get(key: string, fallback?: string): string;
}
