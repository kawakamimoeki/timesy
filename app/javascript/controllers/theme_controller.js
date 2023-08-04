import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dark", "light"]

  connect() {
    this.switch()
  }

  toggle() {
    if (localStorage.theme === 'dark') {
      localStorage.removeItem('theme')
    } else {
      localStorage.theme = 'dark'
    }
    this.switch()
  }

  switch() {
    if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      document.querySelector("body").classList.add('dark')
      this.darkTarget.classList.add('hidden')
      this.lightTarget.classList.remove('hidden')
    } else {
      document.querySelector("body").classList.remove('dark')
      this.lightTarget.classList.add('hidden')
      this.darkTarget.classList.remove('hidden')
    }
  }
}
