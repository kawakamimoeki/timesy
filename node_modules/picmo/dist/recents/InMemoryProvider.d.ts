import { EmojiRecord } from '../types';
import { RecentsProvider } from './RecentsProvider';
export declare class InMemoryProvider extends RecentsProvider {
    recents: EmojiRecord[];
    clear(): void;
    getRecents(maxCount: number): Array<EmojiRecord>;
    addOrUpdateRecent(emoji: EmojiRecord, maxCount: number): void;
}
