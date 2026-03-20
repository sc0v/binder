import { Controller } from "@hotwired/stimulus";
import { DateTime } from "luxon";
window.DateTime = DateTime;
import { TabulatorFull as Tabulator } from "tabulator-tables";

export default class extends Controller {
  connect() {
    this._countdownIntervals = [];
    const e = document.createElement("div");
    const config = JSON.parse(this.element.dataset.config);
    const controller = this;

    config.columns?.forEach((col) => {
      if (col.field === "due_at_countdown") {
        col.formatter = (cell) => {
          const value = cell.getValue();
          const span = document.createElement("span");
          if (!value) {
            span.textContent = "—";
            return span;
          }
          let intervalId;
          const tick = () => {
            const endMs = new Date(value).getTime();
            const ms = endMs - Date.now();
            if (ms <= 0) {
              span.textContent = "Overdue";
              clearInterval(intervalId);
              return;
            }
            const totalSec = Math.floor(ms / 1000);
            const h = Math.floor(totalSec / 3600);
            const m = Math.floor((totalSec % 3600) / 60);
            const s = totalSec % 60;
            span.textContent = `${String(h).padStart(2, "0")}:${String(m).padStart(2, "0")}:${String(s).padStart(2, "0")}`;
          };
          tick();
          intervalId = setInterval(tick, 1000);
          controller._countdownIntervals.push(intervalId);
          return span;
        };
      }
    });

    const table = new Tabulator(e, config);
    this._table = table;
    this.element.replaceChildren(e);
  }

  disconnect() {
    this._countdownIntervals?.forEach(clearInterval);
    this._countdownIntervals = [];
    this._table?.destroy();
    this._table = null;
  }
}
