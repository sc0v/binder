// The kit supplies the drop zone; Binder submits CSVs to its upload workflows.
document.addEventListener("dragover", (event) => {
  const zone = event.target.closest("[data-csv-upload]");
  if (!zone) return;
  event.preventDefault();
  zone.classList.add("cmu-drop-over");
});

document.addEventListener("dragleave", (event) => {
  const zone = event.target.closest("[data-csv-upload]");
  if (zone && !zone.contains(event.relatedTarget)) {
    zone.classList.remove("cmu-drop-over");
  }
});

document.addEventListener("drop", (event) => {
  const zone = event.target.closest("[data-csv-upload]");
  if (!zone) return;
  event.preventDefault();
  zone.classList.remove("cmu-drop-over");
  if (!event.dataTransfer.files.length) return;
  const input = zone.querySelector('input[type="file"]');
  const transfer = new DataTransfer();
  transfer.items.add(event.dataTransfer.files[0]);
  input.files = transfer.files;
  input.dispatchEvent(new Event("change", { bubbles: true }));
});
