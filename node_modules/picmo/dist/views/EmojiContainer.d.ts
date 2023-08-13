import { Emoji } from './Emoji';
import { LazyLoader } from '../LazyLoader';
import { View } from './view';
import { CategoryKey, EmojiFocusTarget, EmojiRecord } from '../types';
declare type EmojiContainerOptions = {
    emojis: EmojiRecord[];
    showVariants: boolean;
    preview: boolean;
    lazyLoader?: LazyLoader;
    category?: CategoryKey;
    fullHeight?: boolean;
};
/**
 * An EmojiContainer contains all the emojis in a given category.
 *
 * It manages keybaord focus for all emojis in the category.
 */
export declare class EmojiContainer extends View {
    protected emojis: EmojiRecord[];
    protected showVariants: boolean;
    protected preview: boolean;
    protected lazyLoader?: LazyLoader;
    private category?;
    private grid;
    emojiViews: Emoji[];
    emojiElements: HTMLElement[];
    fullHeight: boolean;
    constructor({ emojis, showVariants, preview, lazyLoader, category, fullHeight }: EmojiContainerOptions);
    initialize(): void;
    /**
     * Marks the specified cell in the emoji grid as focused.
     *
     * @param focusTarget The target emoji to make focusable.
     * @param performFocus Whether or not to actually focus the new target.
     */
    private setFocusedView;
    /**
     * Sets the active state of this category's emojis. If a category is active, its emojis
     * are focusable.
     *
     * @param active the desired active state
     * @param focusTarget the target emoji to make focusable if active is true
     * @param performFocus whether or not to actually focus the new target if active is true
     */
    setActive(active: boolean, focusTarget?: EmojiFocusTarget, performFocus?: boolean): void;
    renderSync(): HTMLElement;
    destroy(): void;
    /**
     * Causes the previous category to become active/focusable due to a focus:underflow event.
     * @param column the currently focused column
     */
    private triggerPreviousCategory;
    /**
     * Causes the next category to become active/focusable due to a focus:overflow event.
     * @param column the currently focused column
     */
    private triggerNextCategory;
    /**
     * Reacts to a focus:change event from the grid.
     *
     * The current emoji is deactivated, and the new emoji is activated.
     * An event is then emitted which will pause the scroll listener in the main emoji area,
     * otherwise the active category tab can get out of sync.
     *
     * @param event The focus:change event.
     */
    private setFocus;
    private selectEmoji;
    private showPreview;
    private hidePreview;
    get emojiCount(): number;
}
export {};
