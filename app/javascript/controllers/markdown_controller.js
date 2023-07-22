import { Controller } from "@hotwired/stimulus"
import EasyMDE from "easymde"
import { unified } from 'unified';
import remarkParse from 'remark-parse';
import remarkRehype from 'remark-rehype';
import rehypeHighlight from 'rehype-highlight';
import rehypeStringify from 'rehype-stringify';
import EmojiConvertor from 'emoji-js';

export default class extends Controller {
  static values = { minHeight: String, placeholder: String }
  static targets = ["editor", "preview", "editorContainer", "editorButton", "previewButton"]
 
  connect() {
   this.element.easyMDE = new EasyMDE({
      element: this.editorTarget,
      placeholder: this.placeholderValue,
      toolbar: false,
      status: false,
      tabSize: 2,
      minHeight: this.minHeightValue,
      spellChecker: false,
    });
    this.element.addEventListener("edit", () => {
      this.element.easyMDE.codemirror.refresh();
      this.element.easyMDE.codemirror.focus();
    });
  }

  async preview() {
    this.previewTarget.classList.remove("hidden");
    this.previewButtonTarget.classList.add("hidden");
    this.editorContainerTarget.classList.add("hidden");
    this.editorButtonTarget.classList.remove("hidden");
    const result = await unified()
      .use(remarkParse)
      .use(remarkRehype)
      .use(rehypeHighlight)
      .use(rehypeStringify)
      .process(this.element.easyMDE.value());
    const emoji = new EmojiConvertor();
    this.previewTarget.innerHTML = emoji.replace_colons(result.toString());
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
