// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

document.addEventListener('turbo:load', function() {
  const form = document.getElementById('post-form');
  if (!form) return;

  const nameInput = form.querySelector('input[name="post[name]"]');
  const categorySelect = form.querySelector('select[name="post[category]"]');
  const bodyTextarea = form.querySelector('textarea[name="post[body]"]');
  const submitButton = document.getElementById('submit-button');

  function validateForm() {
    const nameValid = nameInput.value.trim().length > 0;
    const categoryValid = categorySelect.value !== '';
    const bodyValid = bodyTextarea.value.trim().length > 0;

    submitButton.disabled = !(nameValid && categoryValid && bodyValid);
  }

  [nameInput, categorySelect, bodyTextarea].forEach(element => {
    element.addEventListener('input', validateForm);
    element.addEventListener('change', validateForm);
  });

  // 初期状態のバリデーション
  validateForm();
});