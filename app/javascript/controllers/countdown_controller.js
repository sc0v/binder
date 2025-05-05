/* Original:
 * https://codepen.io/shshaw/pen/vKzoLL
 * Simplified & updated to use classes.*/

import { Controller } from "@hotwired/stimulus";

const Unit = Object.freeze({
  DAY: "Days",
  HOUR: "Hours",
  MINUTE: "Minutes",
  SECOND: "Seconds",
  MILLISECOND: "Milliseconds",
});

class ClockModule {
  element;
  format;
  label;
  currentValue = "";

  constructor(
    label = "",
    format = (t) => {
      return t;
    }
  ) {
    this.element = document.createElement("div");
    this.element.innerHTML =
      '<b class="split-flap__card">' +
      '<b class="card__top"></b><b class="card__bottom"></b>' +
      '<b class="card__back"><b class="card__bottom"></b></b>' +
      `</b><div class="split-flap__label">${label}</div>`;
    this.format = format;
    this.label = label;
  }

  update(value) {
    value = this.format(value).toString().padStart(2, "0");

    const e = this.element;
    const top = e.querySelector(".card__top"),
      bottom = e.querySelector(".card__bottom"),
      back = e.querySelector(".card__back"),
      backBottom = e.querySelector(".card__back .card__bottom");

    if (value !== this.currentValue) {
      if (this.currentValue !== "") {
        // The width of each part of the clock is dependent on its data-value,
        // so if we're switching from 100 -> 99 set the back to 00 so it has the
        // same "size" as 99.
        const oldValue = this.currentValue === "100" ? "00" : this.currentValue;
        back.setAttribute("data-value", oldValue);
        bottom.setAttribute("data-value", oldValue);
      }
      this.currentValue = value;
      top.innerText = value;
      backBottom.setAttribute("data-value", this.currentValue);
      this.element.classList.remove("flip");
      void this.element.offsetWidth;
      this.element.classList.add("flip");
    }
  }
}

class Clock {
  element;
  endAt;
  #interval;
  #modules;

  constructor(endAt = null) {
    this.element = document.createElement("div");
    this.element.className = "split-flap";

    this.modules = [
      new ClockModule(Unit.DAY, (t) => {
        return Math.floor(t / (1000 * 60 * 60 * 24));
      }),
      new ClockModule(Unit.HOUR, function (t) {
        return Math.floor((t / (1000 * 60 * 60)) % 24);
      }),
      new ClockModule(Unit.MINUTE, function (t) {
        return Math.floor((t / 1000 / 60) % 60);
      }),
      new ClockModule(Unit.SECOND, function (t) {
        return Math.floor((t / 1000) % 60);
      }),
      // new ClockModule(Unit.MILLISECOND, function (t) {
      //   return Math.floor(t % 1000);
      // }),
    ];
    for (const m of this.modules) this.element.appendChild(m.element);

    this.endAt = new Date(endAt);
    this.update();
    this.interval = setInterval(this.update.bind(this), 1000);
  }

  update() {
    const t = Math.max(new Date(this.endAt - new Date()), 0);
    if (t == 0) clearInterval(this.interval);
    for (const m of this.modules) m.update(t);
  }
}

export default class extends Controller {
  static values = {
    endAt: {
      type: String,
      default: new Date(Date.now() + 5 * 1000).toISOString(),
    },
  };

  connect() {
    const clock = new Clock(this.endAtValue);
    this.element.replaceChildren(clock.element);
  }
}
