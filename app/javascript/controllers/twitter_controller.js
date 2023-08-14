import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (!window.twitter.widgets) {
      return
    }
    window.twttr.widgets.load()
    const tweets = this.element.querySelectorAll(".twitter-tweet")
    if (localStorage.theme === 'dark') {
      if (tweets) {
        tweets.forEach((tweet) => {
          tweet.dataset.theme = 'dark'
        })
      }
    }
  }
}
