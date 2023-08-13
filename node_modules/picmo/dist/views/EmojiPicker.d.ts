import { ExternalEvent } from '../ExternalEvents';
import { View } from './view';
import { EventCallback } from '../events';
import { UpdatableOptions } from '../types';
/**
 * The main emoji picker view. Contains the full picker UI and an event emitter to react to
 * emoji selection events.
 */
export declare class EmojiPicker extends View {
    pickerReady: boolean;
    private categories;
    private categoryTabs;
    private search;
    private emojiArea;
    private preview;
    private variantPopup;
    private emojiVersion;
    private currentView;
    private externalEvents;
    constructor();
    initialize(): void;
    /**
     * Destroys the picker when it is no longer needed.
     * After calling this method, the picker will no longer be usable.
     *
     * @returns a Promise that resolves when the destroy is complete.
     */
    destroy(): void;
    /**
     * Convenience method to clear the recents using the configured recents provider.
     */
    clearRecents(): void;
    /**
     * Listens for a picker event.
     *
     * @param event The event to listen for
     * @param callback The callback to call when the event is triggered
     */
    addEventListener(event: ExternalEvent, callback: EventCallback): void;
    /**
     * Removes a recent emoji from the picker.
     *
     * @param event The event to stop listening for
     * @param callback The previously bound event listener
     */
    removeEventListener(event: ExternalEvent, callback: EventCallback): void;
    /**
     * Finishes setting up the picker view once the data is ready.
     * This will only be called if the emoji data is available and all
     * emoji picker views have been rendered.
     *
     * This is the last thing to happen before the emoji picker UI becomes visible.
     */
    initializePickerView(): void;
    private handleKeyDown;
    /**
     * Builds the three sections of the picker:
     *
     * - preview area (if enabled in options)
     * - search area (if enabled in options)
     * - emoji area (always shown)
     *
     * @returns an array containing the three child views. The preview and search
     *          views are optional, and will be undefined if they are not enabled.
     */
    private buildChildViews;
    /**
     * Sets any CSS variables corresponding to options that were set.
     */
    private setStyleProperties;
    private updateStyleProperty;
    private reinitialize;
    private onError;
    /**
     * Called when the emoji database is ready to be used.
     *
     * This will replace the loader placeholder with the full picker UI.
     */
    private onDataReady;
    /**
     * Renders the picker.
     *
     * @returns the root element of the picker
     */
    renderSync(): HTMLElement;
    /**
     * Determines what element, if any, should be automatically focused when the picker is rendered.
     *
     * @returns the focus target, or `null` if nothing should be focused
     */
    private getInitialFocusTarget;
    /**
     * Sets the initial autofocus, depending on options.
     */
    setInitialFocus(): void;
    /**
     * Resets the picker to its default, "inactive" state.
     */
    reset(performFocus?: boolean): void;
    /**
     * Shows content in the main picker content area.
     * If no View is specified, the built-in emoji area will be shown.
     *
     * The currently shown view will be removed from the DOM and destroyed.
     *
     * @param content The View to show
     */
    private showContent;
    /**
     * Closes and destroys the variant popup.
     */
    private hideVariantPopup;
    /**
     * Given a mouse event, determines if the event occurred on the picker or one of its components.
     *
     * @param event The mouse event
     * @returns true if the click should be treated as on the picker, false otherwise
     */
    isPickerClick(event: MouseEvent): boolean | undefined;
    /**
     * Handles a click on an emoji.
     * @param emoji The emoji that was clicked
     * @returns a Promise that resolves when either the variant popup is shown or the emoji is rendered and emitted
     */
    private selectEmoji;
    private get isVariantPopupOpen();
    /**
     * Shows the variant popup for an emoji.
     *
     * @param emoji The emoji whose variants are to be shown.
     * @returns a Promise that resolves when the popup is shown
     */
    private showVariantPopup;
    /**
     * Renders an emoji, and emits a public emoji:select event with the rendered result.
     * @param emoji the emoji that was selected.
     */
    private emitEmoji;
    private updaters;
    updateOptions(options: UpdatableOptions): void;
}
