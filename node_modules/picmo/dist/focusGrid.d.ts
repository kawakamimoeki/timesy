declare type FocusGridEvent = 'focus:change' | 'focus:underflow' | 'focus:overflow';
export declare type FocusChangeEvent = {
    from: number;
    to: number;
    performFocus: boolean;
};
declare type Cell = {
    row: number;
    column: number;
};
/**
 * Represents an array of emojis as a grid with rows and columns as they appear in the UI.
 * This makes focus traversal calculations less complex in the EmojiContainer.
 *
 * The grid is given a flat array of emojis for the current category and the number of columns. It will create
 * a virtual grid structure mapping those emojis to rows of the desired length.
 *
 * The focus can be traversed left, right, up, and down, or to a specific row and column coordinate. Later, the currently
 * selected grid cell can be translated back to the index in the original emoji array.
 *
 * The grid emits three events:
 * - focus:change - when the focused cell changes
 *                  Event properties: from (the previous index), to (the new index), and performFocus (whether to focus the new cell)
 *
 * - focus:underflow - when the focus tries to move below the first emoji in the category
 *                     Event properties: index (the current index within the grid)
 *
 * - focus:overflow - when the focus tries to move beyond the last emoji in the category
 *                     Event properties: index (the current index within the grid)
 */
export declare class FocusGrid {
    private focusedRow;
    private focusedColumn;
    private rowCount;
    private columnCount;
    private emojiCount;
    private wrap;
    private events;
    /** Maps focus traversal keys to their associated handlers. */
    private keyHandlers;
    /**
     * Creates a FocusGrid.
     *
     * @param columnCount The number of columns in the emoji picker.
     * @param emojiCount The total number of emojis in this category.
     * @param initialRow The initial focused row.
     * @param initialColumn The initial focused column.
     */
    constructor(columnCount: number, emojiCount: number, initialRow?: number, initialColumn?: number, wrap?: boolean);
    /**
     * Removes all bound event listeners.
     */
    destroy(): void;
    /**
     * Public API for listening for focus events.
     */
    on(event: FocusGridEvent, handler: (...args: any[]) => void): void;
    /**
     * Handles keydown events that are forwarded from the EmojiContainer and executes
     * the appropriate focus function.
     * @param event the KeyboardEvent that occurred
     */
    handleKeyDown(event: KeyboardEvent): void;
    /**
     * Sets the focused cell to a specific row and, optionally, column. If no column is specified,
     * the focused column remains unchanged.
     *
     * The `performFocus` flag determines whether the focus should be moved to the new cell. If it
     * is false, the focused element will be changed but the actual focus() call will not be triggered yet.
     *
     * @param row The new focused row
     * @param column The new focused column, if specified
     * @param performFocus Whether or not to perform the actual focus operation.
     */
    setCell(row: number, column?: number, performFocus?: boolean): void;
    setFocusedIndex(index: number, performFocus?: boolean): void;
    /**
     * Moves the focus to the next cell in the current row.
     * Emits `focus:overflow` if there is no next cell.
     */
    focusNext(): void;
    /**
     * Moves the focus to the previous cell in the current row.
     * Emits `focus:underflow` if there is no previous cell.
     */
    focusPrevious(): void;
    /**
     * Moves the focus to the cell directly above the current one.
     * Emits `focus:underflow` if the current cell is in the first row.
     */
    focusUp(): void;
    /**
     * Moves the focus to the cell directly below the current one.
     * Emits `focus:overflow` if the current cell is in the last row.
     */
    focusDown(): void;
    /**
     * Moves the focus to a specific emoji in the category.
     * @param index the index of the emoji to focus on
     */
    focusToIndex(index: number): void;
    /**
     * Gets the index in the emoji array of the currently focused cell.
     * @returns the currently focused cell's index
     */
    getIndex(): number;
    /**
     * Gets the row and column of the currently focused cell.
     * @returns the row and column data
     */
    getCell(): Cell;
    /**
     * Gets the total number of rows in the grid
     * @returns the number of rows in the grid
     */
    getRowCount(): number;
}
export {};
