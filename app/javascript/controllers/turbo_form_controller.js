import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clear() {
    this.element.reset()
    if (this.element.easyMDE) {
      this.element.easyMDE.value('');
    }
  }
}
