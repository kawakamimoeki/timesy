import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "show", "editButton", "closeButton", "deleteButton", "menu"]

  edit() {
    this.editorTarget.classList.remove("hidden");
    this.showTarget.classList.add("hidden");
    this.editorTarget.focus();
    this.editButtonTarget.classList.add("hidden");
    this.closeButtonTarget.classList.remove("hidden");
    this.deleteButtonTarget.classList.add("hidden");
    this.menuTargets.forEach((menu) => {
      menu.classList.add("hidden");
    });
    this.element.querySelector("#post-form").dispatchEvent(new Event("edit"));
  }

  close() {
    this.editorTarget.classList.add("hidden");
    this.showTarget.classList.remove("hidden");
    this.editButtonTarget.classList.remove("hidden");
    this.closeButtonTarget.classList.add("hidden");
    this.deleteButtonTarget.classList.remove("hidden");
    this.menuTargets.forEach((menu) => {
      menu.classList.remove("hidden");
    });
  }
}
