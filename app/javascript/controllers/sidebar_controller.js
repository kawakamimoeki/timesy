import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    this.element.addEventListener('click', this.open.bind(this))
    document.querySelector('#sidebar-close').addEventListener('click', this.close.bind(this))
  }

  open () {
    document.querySelector('#sidebar').classList.remove('hidden')
  }

  close () {
    document.querySelector('#sidebar').classList.add('hidden')
  }
}
