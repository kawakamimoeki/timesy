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
    const tweets = document.querySelectorAll(".twitter-tweet")
    if (localStorage.theme === 'dark') {
      document.querySelector("body").classList.add('dark')
      if (tweets) {
        tweets.forEach((tweet) => {
          tweet.dataset.theme = 'dark'
        })
      }
      this.darkTarget.classList.add('hidden')
      this.lightTarget.classList.remove('hidden')
    } else {
      document.querySelector("body").classList.remove('dark')
      if (tweets) {
        tweets.forEach((tweet) => {
          tweet.dataset.theme = ''
        })
      }
      this.lightTarget.classList.add('hidden')
      this.darkTarget.classList.remove('hidden')
    }
  }
}
