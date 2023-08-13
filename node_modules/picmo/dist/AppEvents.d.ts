import { Events, EventKey } from './events';
export declare type AppEvent = 'data:ready' | 'error' | 'reinitialize' | 'emoji:select' | 'content:show' | 'preview:show' | 'preview:hide' | 'variantPopup:hide' | 'category:select' | 'category:next' | 'category:previous' | 'recent:add' | 'focus:change';
export declare type AppEventKey = EventKey<AppEvent>;
export declare class AppEvents extends Events<AppEvent> {
}
