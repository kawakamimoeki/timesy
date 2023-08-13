export declare type AsyncEventCallback = (...args: any[]) => Promise<void>;
export declare type EventCallback = (...args: any[]) => void;
export declare type EventArgs = any[];
export declare type EventKey<T> = Extract<T, string>;
export declare type EventBinding = {
    context?: any;
    handler: EventCallback;
    once?: boolean;
};
export declare type EventHandlerRecord<T> = {
    event: EventKey<T>;
    handler: EventCallback;
};
export declare class Events<T> {
    #private;
    on(event: EventKey<T>, handler: EventCallback, context?: any): void;
    once(event: EventKey<T>, handler: EventCallback, context?: any): void;
    off(event: EventKey<T>, handler: EventCallback): void;
    emit(event: EventKey<T>, ...args: EventArgs): void;
    removeAll(): void;
}
