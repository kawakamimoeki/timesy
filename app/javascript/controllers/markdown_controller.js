import { Controller } from "@hotwired/stimulus"
import EasyMDE from "easymde"
import { DirectUpload } from "@rails/activestorage"
import Toastify from 'toastify-js'

export default class extends Controller {
  static values = { minHeight: String, placeholder: String, directUploadUrl: String }
  static targets = ["editor", "preview", "editorContainer", "editorButton", "previewButton", "file"]
 
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
      imagePathAbsolute: true,
      uploadImage: true,
      imageAccept: ["image/jpeg", "image/png", "image/gif", "image/svg+xml", "image/x-icon", "image/vnd.microsoft.icon", "image/vnd.wap.wbmp", "image/webp"],
      imageUploadFunction: this.uploadFile,
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
      this.previewButtonTarget.disabled = true;
      this.previewButtonTarget.classList.add("opacity-30");
      this.submit.disabled = true;
    } else {
      this.previewButtonTarget.disabled = false;
      this.submit.disabled = false;
      this.previewButtonTarget.classList.remove("opacity-30");
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

  async uploadFile(file, onSuccess, onError) {
    this.element.toast = Toastify({
      text: "画像をアップロードしています...",
      gravity: "bottom",
      position: "right",
      backgroundColor: "#444",
      style: {
        "font-weight": "bold",
        "font-size": "14px",
      },
    })
    this.element.toast.showToast();
    const url = "/rails/active_storage/direct_uploads"
    const upload = new DirectUpload(file, url)
  
    upload.create(async (error, blob) => {
      if (error) {
        onError(error)
        Toastify({
          text: "画像のアップロードに失敗しました",
          gravity: "bottom",
          duration: 3000,
          position: "right",
          backgroundColor: "#ba5649",
          style: {
            "font-weight": "bold",
            "font-size": "14px",
          },
        }).showToast();
      } else {
        const hiddenField = document.createElement('input')
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("value", blob.signed_id)
        hiddenField.name = "post[images][]"
        this.element.appendChild(hiddenField)
        console.log(hiddenField)
        const res = await fetch("/api/v1/blobs/" + blob.signed_id + "/url", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content"),
          },
        });
        const data = await res.json();
        const url = data.url;
        onSuccess(url)
        this.element.toast.hideToast();
      }
    })
  }
}
