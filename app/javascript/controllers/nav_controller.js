import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.itemTargets.forEach((i) => {
      if (location.pathname === i.dataset.current) {
        i.classList.add("border-sky-600")
        i.classList.add("dark:border-sky-600")
        i.classList.remove("opacity-30")
        i.addEventListener("click", this.scroll)
      } else {
        i.classList.remove("border-sky-600")
        i.classList.remove("dark:border-sky-600")
        i.classList.add("opacity-30")
        i.removeEventListener("click", this.scroll)
      }
    })
  }

  scroll(e) {
    window.scrollTo({ top: 0, behavior: "smooth" })
    e.preventDefault()
  }
}
