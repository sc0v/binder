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

    // display tool image
    config.columns?.forEach((col) => {
      if (col.formatter === "imageTooltip") {
        col.formatter = (cell) => {
          const data = cell.getRow().getData();
          const a = document.createElement("a");
          a.href = data.link || "#";
          a.textContent = cell.getValue();

          if (data.image_url) {
            const tooltip = document.createElement("div");
            tooltip.style.cssText =
              "position:fixed;z-index:9999;background:#fff;border:1px solid #ccc;" +
              "border-radius:4px;padding:4px;display:none;pointer-events:none;box-shadow:0 2px 8px rgba(0,0,0,.2);";
            const img = document.createElement("img");
            img.src = data.image_url;
            img.style.cssText = "max-width:180px;max-height:180px;display:block;";
            img.onerror = () => { tooltip.style.display = "none"; };
            tooltip.appendChild(img);
            document.body.appendChild(tooltip);
            this._tooltips = this._tooltips || [];
            this._tooltips.push(tooltip);

            a.addEventListener("mouseenter", (ev) => {
              tooltip.style.display = "block";
              tooltip.style.left = ev.clientX + 12 + "px";
              tooltip.style.top = ev.clientY + 12 + "px";
            });
            a.addEventListener("mousemove", (ev) => {
              tooltip.style.left = ev.clientX + 12 + "px";
              tooltip.style.top = ev.clientY + 12 + "px";
            });
            a.addEventListener("mouseleave", () => {
              tooltip.style.display = "none";
            });
          }

          return a;
        };
      }

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
    this._tooltips?.forEach((t) => t.remove());
    this._tooltips = null;
    clearCountdownIntervalsFromTable(this._table);
    this._table?.destroy();
    this._table = null;
  }
}
