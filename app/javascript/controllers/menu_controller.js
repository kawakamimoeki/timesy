import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "backdrop"]

  connect() {
    this.element.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => {
        this.toggle()
      })
    })
    this.dropdownTarget.classList.add("hidden")
    this.backdrop.classList.add("hidden")
  }

  toggle() {
    this.dropdownTarget.classList.toggle("hidden")
    this.backdropTarget.classList.toggle("hidden")
  }
}
