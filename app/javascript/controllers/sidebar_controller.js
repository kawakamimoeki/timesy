import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect () {
    this.element.addEventListener('click', this.open.bind(this))
    const mo = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === "childList") {
          document.querySelector('#sidebar-close')?.addEventListener('click', this.close.bind(this))
        }
      })
    })
    mo.observe(document, { childList: true })
    document.documentElement.addEventListener("turbo:frame-render", () => {
      document.querySelector('#sidebar-close')?.addEventListener('click', this.close.bind(this))
    })
  }

  open () {
    document.querySelector('#sidebar-container').classList.remove('hidden')
    document.querySelector('#main').classList.add('w-1/2')
  }

  close () {
    document.querySelector('#sidebar-container').classList.add('hidden')
    document.querySelector('#main').classList.remove('w-1/2')
  }
}
