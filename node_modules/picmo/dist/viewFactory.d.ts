import { AppEvent } from './AppEvents';
import { DataStore } from './data/DataStore';
import { Events } from './events';
import { Bundle } from './i18n/bundle';
import { Renderer } from './renderers/renderer';
import { PickerOptions, EmojiRecord } from './types';
import { View } from './views/view';
declare type ViewFactoryOptions = {
    data?: boolean;
};
declare type DependencyMapping = {
    events: Events<AppEvent>;
    i18n: Bundle;
    renderer: Renderer;
    emojiData: Promise<DataStore>;
    options: PickerOptions;
    customEmojis: EmojiRecord[];
    pickerId: string;
};
export declare type ViewConstructor<T extends View> = new (...args: any[]) => T;
export declare type ViewConstructorParameters<T extends View> = ConstructorParameters<ViewConstructor<T>>;
export declare class ViewFactory {
    private events;
    private i18n;
    private renderer;
    private emojiData;
    private options;
    private customEmojis;
    private pickerId;
    constructor({ events, i18n, renderer, emojiData, options, customEmojis, pickerId }: DependencyMapping);
    setEmojiData(emojiData: DataStore): void;
    createWithOptions<T extends View>(options: ViewFactoryOptions | undefined, constructor: ViewConstructor<T>, ...args: ViewConstructorParameters<T>): T;
    create<T extends View>(constructor: ViewConstructor<T>, ...args: ViewConstructorParameters<T>): T;
}
export {};
