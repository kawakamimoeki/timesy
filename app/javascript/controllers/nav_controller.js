import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.itemTargets.forEach((i) => {
      if (location.pathname === i.dataset.current) {
        i.classList.add("border-sky-600")
        i.classList.add("dark:border-sky-600")
        i.classList.remove("opacity-30")
      } else {
        i.classList.remove("border-sky-600")
        i.classList.remove("dark:border-sky-600")
        i.classList.add("opacity-30")
      }
    })
  }
}
