import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "preview"]

  connect() {
    this.fieldTarget.addEventListener("change", this.preview.bind(this))
  }

  click() {
    this.fieldTarget.click()
  }

  preview() {
    document.querySelector(".preview").src = URL.createObjectURL(this.fieldTarget.files[0])
  }
}
