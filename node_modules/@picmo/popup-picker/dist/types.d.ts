import { Placement } from '@floating-ui/dom';
export declare type FixedPosition = {
    top?: string;
    bottom?: string;
    left?: string;
    right?: string;
};
export declare type RelativePosition = Placement | 'auto';
export declare type Position = FixedPosition | RelativePosition;
export declare type PositionLostStrategy = 'close' | 'destroy' | 'hold' | 'none';
export declare type PopupOptions = {
    hideOnClickOutside: boolean;
    hideOnEmojiSelect: boolean;
    hideOnEscape: boolean;
    position: Position;
    referenceElement?: HTMLElement;
    triggerElement?: HTMLElement;
    showCloseButton?: boolean;
    className?: string;
    onPositionLost?: PositionLostStrategy;
};
