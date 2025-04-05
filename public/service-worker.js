// Empty service worker file
// This file is created to prevent 404 errors when browsers try to fetch service-worker.js
// If you need actual service worker functionality, you can implement it here

self.addEventListener('install', function(event) {
  // Skip over the "waiting" lifecycle state
  self.skipWaiting();
});

self.addEventListener('activate', function(event) {
  // Claim any clients immediately
  event.waitUntil(self.clients.claim());
});

// Default fetch handler
self.addEventListener('fetch', function(event) {
  // Let the browser handle the request normally
  event.respondWith(fetch(event.request));
});
