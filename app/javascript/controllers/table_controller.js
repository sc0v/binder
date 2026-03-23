import { Controller } from "@hotwired/stimulus";
import { DateTime } from "luxon";
window.DateTime = DateTime;
import { TabulatorFull as Tabulator } from "tabulator-tables";

/** @param {import("tabulator-tables").TabulatorFull} table */
function clearCountdownIntervalsFromTable(table) {
  table?.getRows?.()?.forEach((row) => {
    row.getCells().forEach((cell) => {
      const el = cell.getElement();
      if (el?._binderCountdownInterval) {
        clearInterval(el._binderCountdownInterval);
        el._binderCountdownInterval = null;
      }
    });
  });
}

export default class extends Controller {
  connect() {
    const e = document.createElement("div");
    const config = JSON.parse(this.element.dataset.config);

    config.columns?.forEach((col) => {
      if (col.field === "due_at_countdown") {
        col.formatter = (cell) => {
          const el = cell.getElement();
          if (el?._binderCountdownInterval) {
            clearInterval(el._binderCountdownInterval);
            el._binderCountdownInterval = null;
          }

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
              if (intervalId) clearInterval(intervalId);
              if (el) el._binderCountdownInterval = null;
              return;
            }
            const totalSec = Math.floor(ms / 1000);
            const h = Math.floor(totalSec / 3600);
            const m = Math.floor((totalSec % 3600) / 60);
            span.textContent = `${String(h).padStart(2, "0")}:${String(m).padStart(2, "0")}`;
          };
          tick();
          if (span.textContent !== "Overdue") {
            intervalId = setInterval(tick, 1000);
            if (el) el._binderCountdownInterval = intervalId;
          }
          return span;
        };
      }
    });

    const table = new Tabulator(e, config);
    this._table = table;

    table.on("dataLoading", () => {
      clearCountdownIntervalsFromTable(table);
    });

    table.on("rowUpdated", (row) => {
      row.reformat();
    });

    this.element.replaceChildren(e);
  }

  disconnect() {
    clearCountdownIntervalsFromTable(this._table);
    this._table?.destroy();
    this._table = null;
  }
}
