import { EmojiRecord } from './types';
export declare type EmojiProcessingRule = (emoji: EmojiRecord, version: number) => EmojiRecord | null;
export declare const rules: EmojiProcessingRule[];
export declare function applyRulesToEmoji(emoji: EmojiRecord, emojiVersion: number): EmojiRecord | null;
export declare function applyRules(emojis: EmojiRecord[], emojiVersion: number): EmojiRecord[];
