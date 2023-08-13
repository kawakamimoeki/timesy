import { View } from './view';
import { Category } from '../types';
declare type CategoryTabOptions = {
    category: Category;
    icon: Element;
};
export declare type SetActiveOptions = {
    changeFocusable?: boolean;
    performFocus?: boolean;
    scroll?: boolean;
};
export declare class CategoryTab extends View {
    category: Category;
    private icon;
    isActive: boolean;
    constructor({ category, icon }: CategoryTabOptions);
    initialize(): void;
    renderSync(): HTMLElement;
    /**
     * Sets the active state of the tab.
     *
     * @param isActive The new active state
     * @param changeFocus Whether or not to change the active focusable element to the tab button
     * @param scroll Whether or not to scroll to the new category
     */
    setActive(active: boolean, options?: SetActiveOptions): void;
    private selectCategory;
}
export {};
