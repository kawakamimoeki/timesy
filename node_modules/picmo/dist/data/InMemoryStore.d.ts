import { Locale } from 'emojibase';
import { Meta, PopulateOptions, DataStore } from './DataStore';
import { PickerOptions, EmojiRecord, Category } from '../types';
export declare function InMemoryStoreFactory(locale: Locale): DataStore;
export declare namespace InMemoryStoreFactory {
    var deleteDatabase: (locale: Locale) => void;
}
export declare class InMemoryStore extends DataStore {
    private categories;
    private emojis;
    private meta;
    open(): Promise<void>;
    delete(): Promise<void>;
    close(): void;
    isPopulated(): Promise<boolean>;
    getEmojiCount(): Promise<number>;
    getEtags(): Promise<Record<string, string | undefined>>;
    getHash(): Promise<string>;
    populate(options: PopulateOptions): Promise<void>;
    getCategories(options: PickerOptions): Promise<Category[]>;
    getEmojis(category: Category, emojiVersion: number): Promise<EmojiRecord[]>;
    searchEmojis(query: string, customEmojis: EmojiRecord[], emojiVersion: number, categories: Category[]): Promise<EmojiRecord[]>;
    setMeta(meta: Meta): void;
}
