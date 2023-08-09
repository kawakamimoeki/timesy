import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    mo.observe(this.element, { childList: true })
    document.documentElement.addEventListener("turbo:before-stream-render", (e) => {
      if (e.detail.newStream.getAttribute("target") === "form") {
        this.scroll()
      }
    })
  }

  scroll () {
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: "smooth"
    })
  }
}
