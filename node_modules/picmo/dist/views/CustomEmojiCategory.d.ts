import { BaseEmojiCategory } from './BaseEmojiCategory';
import { LazyLoader } from '../LazyLoader';
import { Category } from '../types';
declare type CustomEmojiCategoryOptions = {
    category: Category;
    lazyLoader?: LazyLoader;
};
export declare class CustomEmojiCategory extends BaseEmojiCategory {
    constructor({ category, lazyLoader }: CustomEmojiCategoryOptions);
    initialize(): void;
    render(): Promise<HTMLElement>;
}
export {};
