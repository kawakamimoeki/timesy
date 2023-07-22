import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body", "emoji"]

  emoji(event) {
    event.preventDefault()
    const emoji = event.target.innerText
    const value = this.element.easyMDE.value()
    this.element.easyMDE.value(value + emoji) 
  }
}
