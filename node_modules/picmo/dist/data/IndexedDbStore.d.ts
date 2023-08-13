import { GroupMessage, Emoji, Locale } from 'emojibase';
import { PickerOptions, EmojiRecord, Category } from '../types';
import { DataStore } from './DataStore';
export declare function IndexedDbStoreFactory(locale: Locale): DataStore;
export declare namespace IndexedDbStoreFactory {
    var deleteDatabase: (locale: Locale) => Promise<unknown>;
}
export declare class IndexedDbStore extends DataStore {
    private db;
    /**
     * Creates/opens the database.
     *
     * There are three data stores:
     *
     * - category: stores the categories
     * - emoji: stores the emoji data itself
     * - meta: stores metadata such as the ETags
     *
     * @returns a Promise that resolves when the database is ready
     */
    open(): Promise<void>;
    delete(): Promise<void>;
    close(): void;
    getEmojiCount(): Promise<number>;
    /**
     * Gets the ETags stored in the meta datastore.
     * @returns a Promise that resolves to the ETag data
     */
    getEtags(): Promise<Record<string, string | undefined>>;
    /**
     * Stores ETag values for the emoji and message data.
     * @param emojisEtag the ETag for the emoji data
     * @param messagesEtag the ETag for the message data
     */
    setMeta(meta: any): Promise<unknown>;
    getHash(): Promise<any>;
    /**
     * Determines whether or not the database is populated.
     *
     * @returns a Promise that resolves to a boolean indicating the populated state
     */
    isPopulated(): Promise<boolean>;
    /**
     * Removes any current data and re-populates the data stores with the given data.
     *
     * @param groups the group message data
     * @param emojis the emoji data
     * @param emojisEtag the emoji data ETag
     * @param messagesEtag the message data ETag
     * @returns a Promise that resolves when all data has been written
     */
    populate({ groups, emojis, emojisEtag, messagesEtag, hash }: {
        groups: GroupMessage[];
        emojis: Emoji[];
        emojisEtag?: string | null;
        messagesEtag?: string | null;
        hash?: string | null;
    }): Promise<void>;
    /**
     * Gets the emoji categories.
     *
     * If an include list is specified, only those categories will be returned - and will be in the same sort order.
     * Otherwise, all categories (except 'component') are returned.
     *
     * @param include an array of CategoryKeys to include
     * @returns an arrya of all categories, or only the ones specified if include is given
     */
    getCategories(options: PickerOptions): Promise<Category[]>;
    /**
     * Gets all emojis for a particular category and emoji version.
     *
     * @param category the category to get emojis for
     * @param emojiVersion the maximum version for returned emojis
     * @returns a Promise that resolves to an array of the EmojiRecord data
     */
    getEmojis(category: Category, emojiVersion: number): Promise<EmojiRecord[]>;
    /**
     * Searches the database for emojis.
     *
     * @param query the text query
     * @param customEmojis the custom emojis
     * @param emojiVersion the maximum emoji version for search results
     * @param categories the categories to search
     * @returns a Promise that resolves to the matching EmojiRecords
     */
    searchEmojis(query: string, customEmojis: EmojiRecord[], emojiVersion: number, categories: Category[]): Promise<EmojiRecord[]>;
    /**
     * Waits for a request to complete.
     *
     * @param request the request
     * @returns a Promise that resolves when the request succeeds, or rejects if it fails
     */
    waitForRequest(request: IDBRequest): Promise<any>;
    /**
     * Wraps an operation in an IndexedDB transaction.
     *
     * @param storeName the data store(s) to use
     * @param mode the transaction mode
     * @param callback a callback containing the work to do in the transaction
     * @returns a Promise that resolves when the transaction completes, or rejects if it fails
     */
    protected withTransaction(storeName: string | string[], mode: IDBTransactionMode | undefined, callback: (transaction: IDBTransaction) => void): Promise<unknown>;
    /**
     * Removes all entries from one or more stores.
     * @param storeNames the stores to clear
     * @return a Promise that resolves when the clear is complete
     */
    protected removeAllObjects(...storeNames: string[]): Promise<void>;
    /**
     * Adds a collection of objects to a data store.
     *
     * @param storeName the store to populate
     * @param objects the objects to add
     * @returns a Promise that resolves when the add is complete, or rejects if it fails
     */
    protected addObjects(storeName: string, objects: any[]): Promise<unknown>;
}
