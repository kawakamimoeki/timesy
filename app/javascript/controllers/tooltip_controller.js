import { Controller } from "@hotwired/stimulus"
import tippy from "tippy.js"

export default class extends Controller {
  static values = { text: String }

  connect() {
    let theme;
    if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      theme = 'dark';
    } else {
      theme = 'light';
    }
    tippy(this.element, {
      content: this.textValue,
      theme: theme,
      animateFill: true,
    });
  }
}
