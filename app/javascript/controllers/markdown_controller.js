import { Controller } from "@hotwired/stimulus"
import EasyMDE from "easymde"

export default class extends Controller {
  static values = { minHeight: String, placeholder: String }
  static targets = ["editor", "preview", "editorContainer", "editorButton", "previewButton"]
 
  connect() {
    if (this.element.querySelector(".EasyMDEContainer")) {
      return
    }
    this.element.easyMDE = new EasyMDE({
      element: this.editorTarget,
      placeholder: this.placeholderValue,
      toolbar: false,
      status: false,
      tabSize: 2,
      indentWithTabs: false,
      minHeight: this.minHeightValue,
      spellChecker: false,
    });
    this.element.addEventListener("edit", () => {
      this.element.easyMDE.codemirror.refresh();
      this.element.easyMDE.codemirror.focus();
    });
    this.submit = this.element.querySelector("input[type='submit']")
    this.element.addEventListener("keydown", (event) => {
      if (event.key === "Enter" && (event.ctrlKey || event.metaKey)) {
        event.preventDefault();
        this.submit.click();
      }
    })
    this.updateSubmitState();
    this.element.easyMDE.codemirror.on("change", () => {
      this.updateSubmitState();
    });
  }

  updateSubmitState() {
    if (this.element.easyMDE.value() === "") {
      this.submit.disabled = true;
    } else {
      this.submit.disabled = false;
    }
  }

  async preview() {
    this.previewTarget.classList.remove("hidden");
    this.previewButtonTarget.classList.add("hidden");
    this.editorContainerTarget.classList.add("hidden");
    this.editorButtonTarget.classList.remove("hidden");
    const res = await fetch("/api/v1/posts/preview", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content"),
      },
      body: JSON.stringify({
        post: {
          body: this.element.easyMDE.value()
        }
      }),
    });
    const data = await res.json();
    this.previewTarget.innerHTML = data.body;
  }

  async edit() {
    this.previewTarget.classList.add("hidden");
    this.previewButtonTarget.classList.remove("hidden");
    this.editorContainerTarget.classList.remove("hidden");
    this.editorButtonTarget.classList.add("hidden");
  }

  clear() {
    this.element.easyMDE.value('');
    this.previewTarget.innerHTML = '';
  }
}
