import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "backdrop"]

  connect() {
    this.element.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => {
        this.toggle()
      })
    })
  }

  toggle() {
    this.dropdownTarget.classList.toggle("hidden")
    this.backdropTarget.classList.toggle("hidden")
  }
}
