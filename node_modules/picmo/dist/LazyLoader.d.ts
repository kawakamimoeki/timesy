declare type Callback = () => void;
export declare class LazyLoader {
    private elements;
    lazyLoad(placeholder: HTMLElement, callback: Callback): HTMLElement;
    observe(root: HTMLElement): void;
}
export {};
