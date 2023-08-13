import { PopupPickerController } from './popupPicker';
import { Position } from './types';
export declare type PositionCleanup = () => void;
export declare function setPosition(picker: PopupPickerController, pickerElement: HTMLElement, referenceElement: HTMLElement | undefined, position: Position): Promise<PositionCleanup>;
