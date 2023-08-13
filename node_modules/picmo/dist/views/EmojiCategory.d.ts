import { BaseEmojiCategory } from './BaseEmojiCategory';
import { LazyLoader } from '../LazyLoader';
import { Category } from '../types';
declare type EmojiCategoryOptions = {
    category: Category;
    showVariants: boolean;
    lazyLoader?: LazyLoader;
    emojiVersion: number;
};
export declare class EmojiCategory extends BaseEmojiCategory {
    private emojiVersion;
    constructor({ category, showVariants, lazyLoader, emojiVersion }: EmojiCategoryOptions);
    initialize(): void;
    render(): Promise<HTMLElement>;
}
export {};
