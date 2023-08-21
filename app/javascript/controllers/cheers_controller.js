import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["open", "close", "container"]

  connect() {
    this.openTarget.addEventListener("click", this.open.bind(this))
    this.closeTarget.addEventListener("click", this.close.bind(this))
    this.main = document.querySelector("main")
  }

  open() {
    this.containerTarget.classList.remove("hidden")
    this.element.classList.remove("w-[0px]")
    this.main.classList.add("max-w-5xl")
    this.main.classList.remove("max-w-3xl")
    this.element.classList.add("w-[400px]")
    this.element.classList.add("pl-4")
    this.openTarget.classList.add("hidden")
    this.closeTarget.classList.remove("hidden")
    this.closeTarget.classList.add("flex")
  }

  close() {
    this.containerTarget.classList.add("hidden")
    this.element.classList.remove("w-[400px]")
    this.element.classList.add("w-[0px]")
    this.main.classList.remove("max-w-5xl")
    this.main.classList.add("max-w-3xl")
    this.element.classList.remove("pl-4")
    this.openTarget.classList.remove("hidden")
    this.closeTarget.classList.add("hidden")
    this.closeTarget.classList.remove("flex")
  }
}
