import { Controller } from "@hotwired/stimulus"
import Toastify from 'toastify-js'

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.element.addEventListener("click", this.copy.bind(this))
  }

  copy() {
    navigator.clipboard.writeText(this.urlValue)
    Toastify({
      text: "リンクをコピーしました",
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
