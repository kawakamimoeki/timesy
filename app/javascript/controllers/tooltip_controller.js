import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: String }

  connect() {
    tippy(this.element, {
      content: this.textValue,
      theme: 'light',
      animateFill: true,
    });
  }
}
