import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    document.documentElement.addEventListener("turbo:before-stream-render", (e) => {
      if (e.detail.newStream.getAttribute("target") === "form") {
        this.scroll()
      }
    })
  }

  async sleep (ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
  }

  async scroll () {
    await this.sleep(500)
    window.scrollTo({
      top: document.body.scrollHeight,
      behavior: "smooth"
    })
  }
}
