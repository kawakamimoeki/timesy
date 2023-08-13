import { Emoji, GroupMessage, Locale } from 'emojibase';
import { PickerOptions, EmojiRecord, Category } from '../types';
export declare type PopulateOptions = {
    groups: GroupMessage[];
    emojis: Emoji[];
    emojisEtag?: string | null;
    messagesEtag?: string | null;
    hash?: string | null;
};
declare type SearchableEmoji = {
    label: string;
    tags?: string[];
};
export declare type Meta = {
    emojisEtag?: string;
    messagesEtag?: string;
    hash?: string;
};
export declare type DataStoreFactory = {
    (locale: Locale): DataStore;
    deleteDatabase(locale: Locale): void;
};
/**
 * Transforms an Emoji from emojibase into an EmojiRecord.
 *
 * @param emoji the Emoji from the database
 * @returns the equivalent EmojiRecord
 */
export declare function getEmojiRecord(emoji: Emoji): EmojiRecord;
/**
 * Given an emoji, determine if the query matches.
 *
 * The emoji matches if the text query matches the name or one of its tags, and if it is in the array of
 * categories (if given).
 *
 * @param emoji The emoji to check
 * @param query The text query
 * @param categories The categories to check
 * @returns a boolean indicating whether or not the emoji matches the query
 */
export declare function queryMatches(emoji: SearchableEmoji, query: string, categories?: Category[]): boolean | undefined;
export declare abstract class DataStore {
    locale: Locale;
    constructor(locale?: Locale);
    abstract open(): Promise<void>;
    abstract delete(): Promise<void>;
    abstract close(): void;
    abstract getEmojiCount(): Promise<number>;
    abstract getEtags(): Promise<Record<string, string | undefined>>;
    abstract setMeta(meta: any): void;
    abstract getHash(): Promise<string>;
    abstract isPopulated(): Promise<boolean>;
    abstract populate(options: PopulateOptions): Promise<void>;
    abstract getCategories(options: PickerOptions): Promise<Category[]>;
    abstract getEmojis(category: Category, emojiVersion: number): Promise<EmojiRecord[]>;
    abstract searchEmojis(query: string, customEmojis: EmojiRecord[], emojiVersion: number, categories: Category[]): Promise<EmojiRecord[]>;
}
export {};
