// PWA Service Worker Registration and Notification Manager Import
import {
  requestNotificationPermission,
  subscribeToNotifications,
  unsubscribeFromNotifications,
} from "notification_manager";

if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("/service-worker", { scope: "/" })
    .then((registration) => {
      console.log("Service Worker registered successfully:", registration);
      window.serviceWorkerRegistration = registration;
      requestNotificationPermission();
    })
    .catch((error) => {
      console.error("Service Worker registration failed:", error);
    });
}

// Expose notification manager functions to window for easier access
window.requestNotificationPermission = requestNotificationPermission;
window.subscribeToNotifications = subscribeToNotifications;
window.unsubscribeFromNotifications = unsubscribeFromNotifications;
