import { View } from './view';
import { Template } from '../Template';
import { EmojiContainer } from './EmojiContainer';
import { Category, EmojiFocusTarget } from '../types';
import { LazyLoader } from '../LazyLoader';
declare type BaseEmojiCategoryOptions = {
    category: Category;
    showVariants: boolean;
    lazyLoader?: LazyLoader;
    template: Template;
};
export declare const classes: any;
export declare abstract class BaseEmojiCategory extends View {
    category: Category;
    protected showVariants: boolean;
    protected lazyLoader?: LazyLoader;
    protected emojiContainer: EmojiContainer;
    protected baseUIElements: {
        categoryName: string;
    };
    setActive(active: boolean, focusTarget?: EmojiFocusTarget, performFocus?: boolean): void;
    constructor({ template, category, showVariants, lazyLoader }: BaseEmojiCategoryOptions);
}
export {};
