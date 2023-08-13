import { View } from './view';
import { CategoryTabs } from './CategoryTabs';
import { EmojiCategory } from './EmojiCategory';
import { Category } from '../types';
declare type EmojiAreaOptions = {
    categoryTabs?: CategoryTabs;
    categories: Category[];
    emojiVersion: number;
};
/**
 * The EmojiArea is the main view of the picker, it contains all the categories and their emojis inside
 * a main scrollable area.
 */
export declare class EmojiArea extends View {
    private selectedCategory;
    private categoryTabs?;
    private categories;
    private emojiVersion;
    private observer;
    private scrollListenerState;
    private lazyLoader;
    emojiCategories: EmojiCategory[];
    constructor({ categoryTabs, categories, emojiVersion }: EmojiAreaOptions);
    initialize(): void;
    get focusableEmoji(): HTMLElement;
    render(): Promise<HTMLElement>;
    destroy(): void;
    private handleCategorySelect;
    private createCategory;
    private determineInitialCategory;
    private determineFocusTarget;
    reset(performFocus?: boolean): void;
    /**
     * Given a category key, returns the index of the category in the categories array.
     * @param key
     * @returns
     */
    private getCategoryIndex;
    private focusPreviousCategory;
    private focusNextCategory;
    /**
     * Changes the focused category.
     *
     * @param category the index of the category
     * @param focusTarget the desired focus target in the new category
     */
    private focusCategory;
    /**
     * Changes the current category, optionally animating, scrolling, and changing the focus.
     *
     * Supported options are:
     * - focus: The target element that should become focusable
     * - performFocus: Whether or not to actually focus the new focusable element
     * - scroll: Whether the scrolling should be immediate (jump), animated (animate), or none (undefined).
     * - animate: Whether or not to animate active indicator under the button.
     *
     * @param category The key or index of the category to select.
     * @param options The options for the category selection.
     */
    private selectCategory;
    /**
     * Updates the category tabs to reflect the currently focused category.
     * @param category the key of the currently focused category
     */
    private updateFocusedCategory;
    /**
     * On scroll, checks the new scroll position and highlights a new category if necessary.
     */
    handleScroll(): void;
}
export {};
