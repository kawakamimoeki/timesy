import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown", "backdrop"];

  connect() {
    this.dropdownTarget.classList.add("hidden");
    this.backdropTarget.classList.add("hidden");
  }

  close() {
    this.dropdownTarget.classList.add("hidden");
    this.backdropTarget.classList.add("hidden");
  }

  open() {
    this.dropdownTarget.classList.remove("hidden");
    this.backdropTarget.classList.remove("hidden");
  }
}
