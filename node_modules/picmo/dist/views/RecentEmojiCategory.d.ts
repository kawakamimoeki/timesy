import { BaseEmojiCategory } from './BaseEmojiCategory';
import { RecentEmojiContainer } from './RecentEmojiContainer';
import { Category, EmojiRecord } from '../types';
import { LazyLoader } from '../LazyLoader';
import { RecentsProvider } from '../recents/RecentsProvider';
declare type RecentEmojiCategoryOptions = {
    category: Category;
    provider: RecentsProvider;
    lazyLoader?: LazyLoader;
};
export declare class RecentEmojiCategory extends BaseEmojiCategory {
    emojiContainer: RecentEmojiContainer;
    private provider;
    constructor({ category, lazyLoader, provider }: RecentEmojiCategoryOptions);
    initialize(): void;
    addRecent(recent: EmojiRecord): Promise<void>;
    render(): Promise<HTMLElement>;
}
export {};
