import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body", "emoji"]

  emoji(event) {
    event.preventDefault()
    const emoji = event.target.innerText
    const value = window.easyMDE.value()
    window.easyMDE.value(value + emoji) 
  }
}
