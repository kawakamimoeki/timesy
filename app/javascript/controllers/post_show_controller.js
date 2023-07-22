import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "show", "editButton", "closeButton"]

  edit() {
    this.editorTarget.classList.remove("hidden");
    this.showTarget.classList.add("hidden");
    this.editorTarget.focus();
    this.editButtonTarget.classList.add("hidden");
    this.closeButtonTarget.classList.remove("hidden");
  }

  close() {
    this.editorTarget.classList.add("hidden");
    this.showTarget.classList.remove("hidden");
    this.editButtonTarget.classList.remove("hidden");
    this.closeButtonTarget.classList.add("hidden");
  }
}
