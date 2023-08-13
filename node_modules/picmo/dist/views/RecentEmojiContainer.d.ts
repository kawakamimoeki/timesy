import { EmojiContainer } from './EmojiContainer';
import { EmojiRecord } from '../types';
export declare class RecentEmojiContainer extends EmojiContainer {
    constructor({ category, emojis, preview, lazyLoader }: {
        category: any;
        emojis: any;
        preview?: boolean | undefined;
        lazyLoader: any;
    });
    addOrUpdate(emoji: EmojiRecord): Promise<void>;
}
