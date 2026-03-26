// NFC scanning support for NFC-enabled devices.
// Shows a FAB button to request permissions, then auto-submits scanned tag
// serial numbers into the focused input — behaves like a barcode scanner.

let ndefActive = false;

const convertSerialNumber = (serialNumber) => {
  // NFC serial numbers are colon-separated hex bytes in LSB-first order;
  // reverse the bytes and parse as a single hex integer.
  const reversedHex = serialNumber.split(":").reverse().join("");
  return parseInt(reversedHex, 16);
};

const handleNfcRead = (event) => {
  const value = convertSerialNumber(event.serialNumber);
  const focused = document.activeElement;

  if (
    focused &&
    (focused.tagName === "INPUT" || focused.tagName === "TEXTAREA") &&
    focused.type !== "submit" &&
    focused.type !== "button"
  ) {
    focused.value = value;
    focused.dispatchEvent(new Event("input", { bubbles: true }));
    focused.dispatchEvent(new Event("change", { bubbles: true }));

    const form = focused.closest("form");
    if (form) form.requestSubmit();
  }
};

document.addEventListener("turbo:load", () => {
  if (!("NDEFReader" in window)) return;

  // FAB is re-added after each Turbo navigation since <body> is replaced.
  if (document.getElementById("nfc-fab")) return;

  const fab = document.createElement("button");
  fab.id = "nfc-fab";
  fab.setAttribute("type", "button");
  fab.setAttribute("title", "Enable NFC scanning");
  fab.setAttribute("aria-label", "Enable NFC scanning");
  fab.innerHTML =
    '<i class="fa-solid fa-wifi" style="transform: rotate(90deg)"></i>';

  // If permissions were already granted this session, hide immediately.
  if (ndefActive) fab.classList.add("nfc-hidden");

  document.body.appendChild(fab);

  let previousFocus = null;

  fab.addEventListener("mousedown", (e) => {
    previousFocus = document.activeElement;
    e.preventDefault(); // prevent the button from stealing focus
  });

  fab.addEventListener("click", async () => {
    try {
      const ndef = new NDEFReader();
      await ndef.scan();

      ndefActive = true;
      fab.classList.add("nfc-hidden");
      previousFocus?.focus();

      ndef.onreading = handleNfcRead;
      ndef.onreadingerror = (err) => console.error("NFC read error:", err);
    } catch (err) {
      console.error("NFC permission denied or unavailable:", err);
    }
  });
});
