import { Locale, MessagesDataset, Emoji } from 'emojibase';
import { DataStoreFactory, DataStore } from './DataStore';
/**
 * Public API for initializing a database.
 *
 * @param locale the locale
 * @param staticMessages local messages dataset, if any
 * @param staticEmojis local emoji dataset, if any
 * @param existingDb any existing database to repopulate
 * @returns a Promise that resolves to the database instance
 */
export declare function initDatabase(locale: Locale, factory: DataStoreFactory, staticMessages?: MessagesDataset, staticEmojis?: Emoji[], existingDb?: DataStore): Promise<DataStore>;
/**
 * Deletes a database instance for a locale.
 * @param locale the locale to delete
 */
export declare function deleteDatabase(factory: DataStoreFactory, locale: Locale): void;
