import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "preview", "fallback"]
  static values = { fallback: String }

  connect() {
    this.fieldTarget.addEventListener("change", this.preview.bind(this))
  }

  click() {
    this.fieldTarget.click()
  }

  preview() {
    this.element.querySelector(".preview").src = URL.createObjectURL(this.fieldTarget.files[0])
  }

  remove() {
    this.fieldTarget.value = ""
    this.element.querySelector(".preview").src = this.fallbackValue
    this.fallbackTarget.value = "true"
  }
}
