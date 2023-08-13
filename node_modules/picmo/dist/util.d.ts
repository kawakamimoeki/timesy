import { EmojiRecord, PickerOptions } from './types';
export declare function getEmojiForEvent(event: Event, emojis: EmojiRecord[]): EmojiRecord | null;
export declare function shouldAnimate(options: PickerOptions): boolean | undefined;
export declare function caseInsensitiveIncludes(str: string, search: string): boolean;
/**
 * Creates a throttled version of a function.
 *
 * @param fn The function to throttle
 * @param wait The wait time in milliseconds
 * @returns a throttled version of fn
 */
export declare function throttle(fn: () => void, wait: number): () => void;
/**
 * Creates a debounced version of a function.
 *
 * @param fn the function to debounce
 * @param wait the wait time in milliseconds
 * @returns a debounced version of fn
 */
export declare function debounce(fn: (...args: any[]) => any, wait: number): (...args: any[]) => any;
export declare function animate(element: HTMLElement, keyframes: Keyframe[] | PropertyIndexedKeyframes, options: KeyframeAnimationOptions, pickerOptions: PickerOptions): Promise<Animation | void>;
/**
 * Takes a rendered HTML string and renders a DOM node from it.
 *
 * @param html the HTML text
 * @returns the generated HTMLElement
 */
export declare function toElement<E extends Element = HTMLElement>(html: string): E;
export declare function computeHash(obj: any): Promise<string>;
export declare function getPrefixedClasses(...classNames: any[]): any;
export declare function prefixClassName(className: any): string;
export declare function empty(element: Element): Element;
export declare function replaceChildren(parent: Element, ...children: Element[]): void;
export declare function isSessionStorageAvailable(): boolean;
export declare function isLocalStorageAvailable(): boolean;
