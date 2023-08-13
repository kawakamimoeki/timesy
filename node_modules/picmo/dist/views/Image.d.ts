import { View } from './view';
declare type ImageOptions = {
    classNames?: string;
};
export declare class Image extends View {
    private classNames?;
    constructor({ classNames }?: ImageOptions);
    load(src: string | Promise<string>): void;
    renderSync(): HTMLElement;
}
export {};
