import { Controller } from "@hotwired/stimulus";

// Toggles between the electrical and structural queue panels on the landing page.
export default class extends Controller {
  static targets = ["tab", "panel"];

  connect() {
    this.showQueue(this.tabTargets[0]?.dataset.queue);
  }

  show(event) {
    this.showQueue(event.currentTarget.dataset.queue);
  }

  showQueue(queue) {
    this.panelTargets.forEach((panel) => {
      panel.hidden = panel.dataset.queue !== queue;
    });
    this.tabTargets.forEach((tab) => {
      tab.classList.toggle("is-active", tab.dataset.queue === queue);
    });
  }
}
