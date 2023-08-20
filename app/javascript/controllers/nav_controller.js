import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  connect() {
    this.itemTargets.forEach((item) => {
      item.addEventListener('click', (e) => {
        if (e.target.classList.contains("border-sky-600")) {
          e.preventDefault()
          window.scrollTo({
            top: 0,
            behavior: "smooth"
          })
          return
        }
        this.itemTargets.forEach((i) => {
          i.classList.remove("border-sky-600")
          i.classList.remove("dark:border-sky-600")
          i.classList.add("opacity-30")
        })
        e.target.classList.remove("opacity-30")
        e.target.classList.add("border-sky-600")
        e.target.classList.add("dark:border-sky-600")
      })
    })
  }
}
