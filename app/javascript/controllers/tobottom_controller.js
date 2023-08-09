import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("click", this.scroll.bind(this))
    window.addEventListener("scroll", () => {
      const bottom = document.body.scrollHeight - window.scrollY - window.innerHeight
      if (bottom < 100) {
        this.element.classList.add("hidden")
      } else {
        this.element.classList.remove("hidden")
      }
    })
  }

  scroll() {
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: "smooth"
    })
  }
}
