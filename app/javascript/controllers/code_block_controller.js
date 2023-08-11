import { Controller } from "@hotwired/stimulus"
import Toastify from 'toastify-js'

export default class extends Controller {

  copy() {
    const code = this.element.querySelector("code").innerText
    navigator.clipboard.writeText(code)
    Toastify({
      text: "クリップボードにコピーしました",
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
