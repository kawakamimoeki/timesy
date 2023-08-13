import { View } from './view';
import { Template } from '../Template';
declare type ErrorMessageOptions = {
    message: string;
    icon?: string;
    template?: Template;
    className?: string;
};
export declare class ErrorMessage extends View {
    private message;
    private icon;
    private className?;
    constructor({ message, icon, template, className }: ErrorMessageOptions);
    renderSync(): HTMLElement;
}
export {};
