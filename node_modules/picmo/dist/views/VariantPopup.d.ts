import { View } from './view';
import { EmojiRecord } from '../types';
declare type VariantPopupOptions = {
    emoji: EmojiRecord;
    parent: HTMLElement;
};
export declare class VariantPopup extends View {
    private focusedEmojiIndex;
    private emoji;
    private renderedEmojis;
    private emojiContainer;
    private focusTrap;
    constructor({ emoji, parent }: VariantPopupOptions);
    initialize(): void;
    animateShow: () => Promise<[void | Animation, void | Animation]>;
    animateHide(): Promise<[void | Animation, void | Animation]>;
    private hide;
    private handleKeydown;
    private handleClick;
    getEmoji(index: number): Element;
    setFocusedEmoji(newIndex: number): void;
    destroy(): void;
    renderSync(): HTMLElement;
    activate(): void;
}
export {};
