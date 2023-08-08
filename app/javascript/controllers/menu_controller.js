import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "backdrop"]

  toggle() {
    this.dropdownTarget.classList.toggle("hidden")
    this.backdropTarget.classList.toggle("hidden")
  }
}
