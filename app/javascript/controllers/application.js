import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

closeModal() {
  this.modal.classList.remove('modal-open');
}

// エラー時にモーダルを閉じるメソッドを呼び出す
document.addEventListener('turbo:load', () => {
  const controller = document.querySelector('[data-controller="form"]')?.__stimulusController;
  if (controller && document.querySelector('.alert-error')) {
    controller.closeModal();
  }
});

