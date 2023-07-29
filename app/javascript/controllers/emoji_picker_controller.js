import { Controller } from "@hotwired/stimulus"
import { createPopup } from '@picmo/popup-picker';

export default class extends Controller {
  static targets = ["picker", "button", "input"]

  connect() {
    this.element.picker = createPopup({
    }, {
      triggerElement: this.buttonTarget,
      referenceElement: this.buttonTarget,
    });
    this.element.picker.addEventListener('emoji:select', selection => {
      this.element.picker.close();
      this.inputTarget.value = selection.emoji;
      this.element.requestSubmit();
    });
  }

  open() {
    this.element.picker.open();
  }
}
