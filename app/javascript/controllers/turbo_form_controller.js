import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clear() {
    this.element.reset()
    if (window.easyMDE) {
      window.easyMDE.value('');
    }
  }
}
