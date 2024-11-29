// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeModal() {
    this.element.classList.remove('modal-open');
  }
}

document.addEventListener('turbo:load', () => {
  const controller = document.querySelector('[data-controller="form"]')?.__stimulusController;
  if (controller && document.querySelector('.alert-error')) {
    controller.closeModal();
  }
});