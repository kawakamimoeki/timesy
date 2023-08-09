import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("click", this.scroll.bind(this))
  }

  scroll() {
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: "smooth"
    })
  }
}
