import { Renderer } from './renderer';
import { EmojiRecord, EmojiSelection } from '../types';
export declare class NativeRenderer extends Renderer {
    render(emoji: EmojiRecord): import("./renderer").RenderTask;
    emit({ emoji, hexcode, label }: EmojiRecord): EmojiSelection;
}
