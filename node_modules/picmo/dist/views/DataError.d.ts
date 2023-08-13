import { ErrorMessage } from './ErrorMessage';
declare type DataErrorOptions = {
    message: string;
};
export declare class DataError extends ErrorMessage {
    constructor({ message }: DataErrorOptions);
    initialize(): void;
    private onRetry;
}
export {};
