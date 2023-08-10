import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.element.style.backgroundImage = `url(${this.urlValue})`
  }
}
