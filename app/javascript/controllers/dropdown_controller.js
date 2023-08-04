import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "backdrop"]

  toggle() {
    this.contentTarget.classList.toggle("hidden")
    this.backdropTarget.classList.toggle("hidden")
  }
}
