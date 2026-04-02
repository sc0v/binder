import { application } from "controllers/application";
import { Controller } from "@hotwired/stimulus";

// Persists across Turbo navigations since the module is loaded once.
let ndefActive = false;

class NfcController extends Controller {
  connect() {
    if (!("NDEFReader" in window)) {
      this.element.hidden = true;
      return;
    }
    if (ndefActive) this.element.classList.add("nfc-hidden");
  }

  retainFocus(event) {
    this._previousFocus = document.activeElement;
    event.preventDefault(); // prevent button from stealing focus
  }

  async enable() {
    if (ndefActive) return;
    try {
      const ndef = new NDEFReader();
      await ndef.scan();

      ndefActive = true;
      this.element.classList.add("nfc-hidden");
      this._previousFocus?.focus();

      ndef.onreading = this.#handleRead;
      ndef.onreadingerror = (err) => console.error("NFC read error:", err);
    } catch (err) {
      console.error("NFC permission denied or unavailable:", err);
    }
  }

  #handleRead(event) {
    // Assumes LSB-first byte order (MIFARE convention) — may not hold for all tag types.
    const reversedHex = event.serialNumber.split(":").reverse().join("");
    const value = parseInt(reversedHex, 16);
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
  }
}

application.register("nfc", NfcController);
