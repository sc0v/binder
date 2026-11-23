// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";

// CMU's template scripts load at the end of <body> (layouts/_template_scripts);
// the kit's script handles Turbo visits itself.
import "cmu-web-kilt";
import "custom/csv-upload";
import "controllers";

// A countdown's timer would keep running after Turbo replaces its page
document.addEventListener("turbo:before-render", () => {
  document.querySelectorAll("[data-cmu-countdown]").forEach((countdown) => {
    clearInterval(countdown.cmuCountdown);
  });
});

import "pwa";
