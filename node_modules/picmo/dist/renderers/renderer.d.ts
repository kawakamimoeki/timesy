import { LazyLoader } from '../LazyLoader';
import { CustomEmoji, EmojiRecord, EmojiSelection } from '../types';
import { View } from '../views/view';
export declare type RenderTask = {
    content: View | Element;
    resolver?: () => Element;
};
export declare abstract class Renderer {
    abstract render(emoji: EmojiRecord, classNames?: string): RenderTask;
    abstract emit(emoji: EmojiRecord): EmojiSelection | Promise<EmojiSelection>;
    renderElement(content: Element): RenderTask;
    renderImage(classNames: string | undefined, urlResolver: () => string | Promise<string>): RenderTask;
    doRender(emoji: EmojiRecord, lazyLoader?: LazyLoader, classNames?: string): Element;
    doEmit(emoji: EmojiRecord): EmojiSelection | Promise<EmojiSelection>;
    emitCustom({ url, label, emoji, data }: CustomEmoji): EmojiSelection;
    renderCustom(emoji: CustomEmoji, lazyLoader?: LazyLoader, additionalClasses?: string): Element;
}
