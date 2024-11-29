import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.form = document.getElementById('post-form');
    this.modal = document.getElementById('loading-modal');
    this.setupFormSubmission();
  }

  setupFormSubmission() {
    this.form.addEventListener('submit', (e) => {
      // モーダルを表示
      this.modal.classList.add('modal-open');
    });
  }
}