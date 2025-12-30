import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submit(event) {
    const form = event.target.closest("form");
    if (!form) return;

    if (form.requestSubmit) {
      form.requestSubmit();
    } else {
      form.submit();
    }
  }
}
