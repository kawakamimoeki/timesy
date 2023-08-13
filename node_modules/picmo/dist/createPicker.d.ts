import { EmojiPicker } from './views/EmojiPicker';
import { PickerOptions } from './types';
export { LazyLoader } from './LazyLoader';
/**
 * Creates a new emoji picker.
 * @param options The options for the emoji picker.
 * @returns a Promise that resolves to the picker when it is ready.
 */
export declare function createPicker(options: Partial<PickerOptions>): EmojiPicker;
