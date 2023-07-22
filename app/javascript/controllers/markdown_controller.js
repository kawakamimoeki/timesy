import { Controller } from "@hotwired/stimulus"
import EasyMDE from "easymde"
import * as marked from "marked"

export default class extends Controller {
  static values = { minHeight: String, placeholder: String }
  static targets = ["editor", "preview", "editorContainer", "editorButton", "previewButton"]
 
  connect() {
   window.easyMDE = new EasyMDE({
      element: this.editorTarget,
      placeholder: this.placeholderValue,
      toolbar: false,
      status: false,
      tabSize: 2,
      minHeight: this.minHeightValue,
      spellChecker: false,
    });
  }

  preview() {
    this.previewTarget.classList.remove("hidden");
    this.previewButtonTarget.classList.add("hidden");
    this.editorContainerTarget.classList.add("hidden");
    this.editorButtonTarget.classList.remove("hidden");
    this.previewTarget.innerHTML = marked.parse(window.easyMDE.value());
  }

  edit() {
    this.previewTarget.classList.add("hidden");
    this.previewButtonTarget.classList.remove("hidden");
    this.editorContainerTarget.classList.remove("hidden");
    this.editorButtonTarget.classList.add("hidden");
  }
}
