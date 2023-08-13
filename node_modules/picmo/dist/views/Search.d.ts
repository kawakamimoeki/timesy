import { View } from './view';
import { Category } from '../types';
declare type SearchOptions = {
    categories: Category[];
    emojiVersion: number;
};
export declare class Search extends View {
    private categories;
    private emojiVersion;
    private searchIcon;
    private clearSearchButton;
    private resultsContainer;
    private notFoundMessage;
    private errorMessage;
    searchField: HTMLInputElement;
    constructor({ categories, emojiVersion }: SearchOptions);
    initialize(): void;
    render(): Promise<HTMLElement>;
    private showSearchIcon;
    private showClearSearchButton;
    private showSearchAccessory;
    clear(): void;
    focus(): void;
    onClearSearch(event: Event): void;
    handleResultsKeydown(event: KeyboardEvent): void;
    onKeyDown(event: KeyboardEvent): void;
    onSearchInput(event: Event): void;
    search(): Promise<void>;
}
export {};
