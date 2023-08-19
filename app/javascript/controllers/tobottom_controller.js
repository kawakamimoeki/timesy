import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("click", this.scroll.bind(this))
    window.addEventListener("scroll", this.toggleVisibility.bind(this))
  }

  scroll() {
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: "smooth"
    })
  }

  toggleVisibility() {
    if (window.scrollY > document.body.scrollHeight - window.innerHeight - 50) {
      this.element.classList.add("hidden")
    } else {
      this.element.classList.remove("hidden")
    }
  }
}
