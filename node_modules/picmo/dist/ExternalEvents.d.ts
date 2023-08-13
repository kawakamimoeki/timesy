import { Events, EventKey } from './events';
export declare type ExternalEvent = 'emoji:select' | 'data:ready';
export declare type ExternalEventKey = EventKey<ExternalEvent>;
export declare class ExternalEvents extends Events<ExternalEvent> {
}
