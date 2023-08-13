import { EmojiPicker, EventCallback, PickerOptions } from 'picmo';
import { PopupEvent } from './PopupEvents';
import { PopupOptions } from './types';
declare type OpenOptions = {
    referenceElement?: HTMLElement;
    triggerElement?: HTMLElement;
};
export declare class PopupPickerController {
    picker: EmojiPicker;
    isOpen: boolean;
    referenceElement?: HTMLElement;
    triggerElement?: HTMLElement;
    options: PickerOptions & PopupOptions;
    private popupEl;
    private focusTrap;
    private positionCleanup;
    private closeButton;
    private externalEvents;
    constructor(pickerOptions: Partial<PickerOptions>, popupOptions: Partial<PopupOptions>);
    /**
     * Listens for a picker event.
     *
     * @param event The event to listen for
     * @param callback The callback to call when the event is triggered
     */
    addEventListener(event: PopupEvent, callback: EventCallback): void;
    removeEventListener(event: PopupEvent, callback: EventCallback): void;
    private handleKeydown;
    /**
     * Destroys the picker when it is no longer needed.
     * After calling this method, the picker will no longer be usable.
     *
     * If this is called while the picker is open, it will be closed first.
     *
     * @returns a Promise that resolves when the close/destroy is complete.
     */
    destroy(): Promise<void>;
    /**
     * Toggles the visible state of the picker
     * If the picker is currently open, it will be closed, and if it si currently closed, it will be opened.
     *
     * @returns a Promise that resolves when the visibility state change is complete
     */
    toggle(options?: OpenOptions): Promise<void>;
    /**
     * Opens the picker.
     *
     * @returns a Promise that resolves when the picker is finished opening
     */
    open({ triggerElement, referenceElement }?: OpenOptions): Promise<void>;
    /**
     * Closes the picker.
     *
     * @returns a Promise that resolves when the picker is finished closing
     */
    close(): Promise<void>;
    /**
     * Finds any pending (running) animations on the picker element.
     *
     * @returns an array of Animation objects that are in the 'running' state.
     */
    private getRunningAnimations;
    /**
     * Sets up the picker positioning.
     */
    private setPosition;
    /**
     * Waits for all pending animations on the picker element to finish.
     *
     * @returns a Promise that resolves when all animations have finished
     */
    private awaitPendingAnimations;
    /**
     * Handles a click on the document, so that the picker is closed
     * if the mouse is clicked outside of it.
     *
     * The picker will only be closed if:
     * - The picker is currently open
     * - The click target is not the trigger element or any of its children
     * - The click target is not the picker or any of its children
     *
     * @param event The MouseEvent that was dispatched.
     */
    private onDocumentClick;
    private animatePopup;
    private animateCloseButton;
    /**
     * Prepares for an animation either for opening or closing the picker.
     * If other animations are still running (this will happen when toggled rapidly), this will wait for them to finish.
     *
     * It will mark the new open state immediately then wait for pending animations to finish.
     *
     * @param openState The desired open state
     */
    private initiateOpenStateChange;
}
export {};
