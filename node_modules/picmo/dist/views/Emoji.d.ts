import { LazyLoader } from '../LazyLoader';
import { View } from './view';
import { CategoryKey, EmojiRecord } from '../types';
declare type EmojiOptions = {
    emoji: EmojiRecord;
    lazyLoader?: LazyLoader;
    category?: CategoryKey;
};
export declare class Emoji extends View {
    private emoji;
    private lazyLoader?;
    private category?;
    constructor({ emoji, lazyLoader, category }: EmojiOptions);
    initialize(): void;
    private handleFocus;
    activateFocus(performFocus?: boolean): void;
    deactivateFocus(): void;
    renderSync(): HTMLElement;
}
export {};
