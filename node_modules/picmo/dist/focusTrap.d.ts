export declare class FocusTrap {
    private rootElement;
    constructor();
    activate(rootElement: HTMLElement): void;
    deactivate(): void;
    get focusableElements(): NodeListOf<HTMLElement>;
    get lastFocusableElement(): HTMLElement;
    get firstFocusableElement(): HTMLElement;
    checkFocus(event: KeyboardEvent, referenceElement: HTMLElement, targetElement: HTMLElement): void;
    handleKeyDown(event: KeyboardEvent): void;
}
