// Web Push Notification Manager
// Handles requesting notification permissions and managing subscriptions

async function requestNotificationPermission() {
  if (!("Notification" in window)) {
    console.warn("This browser does not support notifications");
    return false;
  }

  if (!("serviceWorker" in navigator)) {
    console.warn("This browser does not support service workers");
    return false;
  }

  if (Notification.permission === "granted") {
    console.log("Notification permission already granted");
    await subscribeToNotifications();
    return true;
  }

  if (Notification.permission !== "denied") {
    try {
      const permission = await Notification.requestPermission();
      if (permission === "granted") {
        console.log("Notification permission granted");
        await subscribeToNotifications();
        return true;
      } else {
        console.log("Notification permission denied");
        return false;
      }
    } catch (error) {
      console.error("Error requesting notification permission:", error);
      return false;
    }
  }

  return false;
}

async function subscribeToNotifications() {
  try {
    const registration = await navigator.serviceWorker.ready;

    // Get VAPID public key from meta tag
    const vapidPublicKeyElement = document.querySelector(
      'meta[name="push-notification-key"]',
    );
    const vapidPublicKey = vapidPublicKeyElement?.getAttribute("content");

    if (!vapidPublicKey) {
      console.warn("VAPID public key not found in page metadata");
      return false;
    }

    // Convert VAPID key from base64 to Uint8Array
    const vapidPublicKeyUint8 = urlBase64ToUint8Array(vapidPublicKey);

    const subscription = await registration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: vapidPublicKeyUint8,
    });

    // Send subscription to backend
    const response = await fetch("/push_notifications/subscribe", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        subscription: {
          endpoint: subscription.endpoint,
          auth: arrayBufferToBase64Url(subscription.getKey("auth")),
          p256dh: arrayBufferToBase64Url(subscription.getKey("p256dh")),
        },
      }),
    });

    if (!response.ok) {
      throw new Error(`Server responded with ${response.status}`);
    }

    const data = await response.json();
    console.log("Successfully subscribed to push notifications", data);

    // Store subscription id in localStorage for later unsubscribe
    localStorage.setItem("pushNotificationSubscriptionId", data.id);

    return true;
  } catch (error) {
    console.error("Error subscribing to push notifications:", error);
    return false;
  }
}

async function unsubscribeFromNotifications() {
  try {
    const registration = await navigator.serviceWorker.ready;
    const subscription = await registration.pushManager.getSubscription();

    if (!subscription) {
      console.log("No push subscription found");
      return true;
    }

    // Unsubscribe from push manager
    await subscription.unsubscribe();

    // Notify backend to delete subscription
    const subscriptionId = localStorage.getItem(
      "pushNotificationSubscriptionId",
    );
    if (subscriptionId) {
      await fetch(`/push_notifications/${subscriptionId}`, {
        method: "DELETE",
      });
      localStorage.removeItem("pushNotificationSubscriptionId");
    }

    console.log("Successfully unsubscribed from push notifications");
    return true;
  } catch (error) {
    console.error("Error unsubscribing from push notifications:", error);
    return false;
  }
}

// Convert ArrayBuffer to URL-safe base64 (required by webpush protocol)
function arrayBufferToBase64Url(buffer) {
  return btoa(String.fromCharCode(...new Uint8Array(buffer)))
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=/g, "");
}

// Convert VAPID public key from base64 to Uint8Array
function urlBase64ToUint8Array(base64String) {
  const padding = "=".repeat((4 - (base64String.length % 4)) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, "+")
    .replace(/_/g, "/");

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }

  return outputArray;
}

// Export functions for global access
window.NotificationManager = {
  requestNotificationPermission,
  subscribeToNotifications,
  unsubscribeFromNotifications,
};

export {
  requestNotificationPermission,
  subscribeToNotifications,
  unsubscribeFromNotifications,
};
