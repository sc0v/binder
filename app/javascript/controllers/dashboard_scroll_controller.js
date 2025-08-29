// app/javascript/controllers/scroll_controller.js

let savedScrollPosition = null;
let savedUrl = null;

document.addEventListener("turbo:before-fetch-request", () => {
  savedScrollPosition = window.scrollY;
  savedUrl = window.location.href;
});

function maybeRestoreScroll() {
  if (savedScrollPosition !== null && window.location.href === savedUrl) {
    window.scrollTo(0, savedScrollPosition);
  }
  savedScrollPosition = null;
  savedUrl = null;
}

// Handles full page loads
document.addEventListener("turbo:load", maybeRestoreScroll);

// Also handles Turbo Frame updates (if you're using frames)
document.addEventListener("turbo:frame-render", maybeRestoreScroll);
