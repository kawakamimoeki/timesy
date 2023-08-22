import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "backdrop"]

  connect() {
    this.element.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => {
        if (this.dropdownTarget.classList.contains("hidden")) {
          this.dropdownTarget.classList.remove("hidden")
        } else {
          this.dropdownTarget.classList.add("hidden")
        }

        if (this.backdrop.classList.contains("hidden")) {
          this.backdrop.classList.remove("hidden")
        } else {
          this.backdrop.classList.add("hidden")
        }
      })
    })
    this.dropdownTarget.classList.add("hidden")
    this.backdrop.classList.add("hidden")
  }
}
