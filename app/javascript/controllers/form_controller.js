import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.form = document.getElementById('post-form')
    this.modal = document.getElementById('loading-modal')
    if (this.form && this.modal) {
      this.setupFormSubmission()
    }
  }

  setupFormSubmission() {
    this.form.addEventListener('submit', () => {
      if (typeof this.modal.showModal === 'function') {
        this.modal.showModal()
      } else {
        this.modal.classList.add('modal-open')
      }
    })
  }

  closeModal() {
    if (typeof this.modal.close === 'function') {
      this.modal.close()
    } else {
      this.modal.classList.remove('modal-open')
    }
  }
}