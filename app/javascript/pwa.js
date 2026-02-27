// PWA Service Worker Registration
if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("/service-worker", { scope: "/" })
    .catch((error) => {
      console.error("Service Worker registration failed:", error);
    });
}
