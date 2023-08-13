import { EmojiRecord } from '../types';
import { RecentsProvider } from './RecentsProvider';
export declare abstract class WebStorageProvider extends RecentsProvider {
    storage: Storage;
    constructor(storage: Storage);
    clear(): void;
    getRecents(maxCount: number): Array<EmojiRecord>;
    addOrUpdateRecent(emoji: EmojiRecord, maxCount: number): void;
}
