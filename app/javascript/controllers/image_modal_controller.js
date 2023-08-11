import { Controller } from "@hotwired/stimulus"
import MicroModal from 'micromodal'

export default class extends Controller {
  connect() {
    this.setup();
  }

  setup() { 
    this.element.querySelectorAll('p > img').forEach((img) => {
      img.addEventListener('click', (e) => {
        this.openModal(e);
      })
    })
  }

  openModal(e) {
    MicroModal.init();
    MicroModal.show('image-modal');
    document.querySelector('#image-modal-image').src = e.target.src;
  }
}
