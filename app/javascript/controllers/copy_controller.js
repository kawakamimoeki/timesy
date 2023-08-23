import { Controller } from "@hotwired/stimulus"
import Toastify from 'toastify-js'

export default class extends Controller {
  static values = { content: String, copiedText: String }

  connect() {
    this.element.addEventListener("click", this.copy.bind(this))
  }

  copy() {
    navigator.clipboard.writeText(this.contentValue)
    Toastify({
      text: this.copiedTextValue,
      gravity: "bottom",
      duration: 3000,
      position: "right",
      backgroundColor: "#444",
      style: {
        "font-weight": "bold",
        "font-size": "14px",
      },
    }).showToast();
  }
}
