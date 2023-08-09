import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown", "backdrop", "read", "unread", "indicator"]

  connect() {
    const mo = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === "childList") {
          this.toggleIndicator()
        }
      })
    })
    mo.observe(this.dropdownTarget, { childList: true })
    document.documentElement.addEventListener("turbo:frame-render", () => {
      this.toggleIndicator()
    })
  }

  toggle() {
    this.dropdownTarget.classList.toggle("hidden")
    this.backdropTarget.classList.toggle("hidden")
  }

  async read() {
    const unread = this.element.querySelectorAll(".unread")
    const ids = []
    unread.forEach((notification) => {
      notification.classList.remove("unread")
      notification.classList.add("read")
      ids.push(notification.dataset.id)
    })
    this.toggleIndicator()
    await fetch("/api/v1/notifications/read", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content"),
      }
    })
  }

  toggleIndicator() {
    const unreaded = this.element.querySelectorAll(".unread")
    if (unreaded.length > 0) {
      this.indicatorTarget.classList.remove("hidden")
      const title = document.title
      document.title = `(${unreaded.length}) ${title}`
    } else {
      this.indicatorTarget.classList.add("hidden")
      document.title = document.title.replace(/^\(\d+\)\s/, "")
    }
  }
}
