import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select", "summary", "list"];

  connect() {
    this.update();
  }

  update() {
    const orgId = this.selectTarget.value;

    fetch(`/tools/org_summary?organization_id=${orgId}`)
      .then((r) => r.json())
      .then((data) => {
        this.listTarget.innerHTML = "";

        data.summary.forEach((item) => {
          const li = document.createElement("li");
          if (item.count === 0) {
            li.textContent = `${item.type}: None currently checked out`;
          } else {
            li.textContent = `${item.type}: ${item.count} checked out (barcodes: ${item.barcodes.join(", ")})`;
          }
          this.listTarget.appendChild(li);
        });

        this.summaryTarget.style.display = "block";
      });
  }
}
