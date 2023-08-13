import { View } from './view';
import { CategoryTab, SetActiveOptions } from './CategoryTab';
import { Category } from '../types';
declare type CategoryTabsOptions = {
    categories: Category[];
};
export declare class CategoryTabs extends View {
    private categories;
    private tabViews;
    private activeCategoryIndex;
    constructor({ categories }: CategoryTabsOptions);
    initialize(): void;
    checkOverflow(): void;
    renderSync(): HTMLElement;
    get currentCategory(): Category;
    get currentTabView(): CategoryTab;
    setActiveTab(index: number, options?: SetActiveOptions): void;
    private getTargetCategory;
    private stepSelectedTab;
}
export {};
