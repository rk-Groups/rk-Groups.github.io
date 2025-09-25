const CACHE_NAME = 'rk-groups-v2.0.0';
const STATIC_CACHE = 'rk-groups-static-v2.0.0';
const DYNAMIC_CACHE = 'rk-groups-dynamic-v2.0.0';

// Static assets that rarely change
const STATIC_ASSETS = [
  '/assets/css/mui.min.css',
  '/sw.min.js',
  '/favicon.ico',
  '/manifest.json',
  '/offline/',
  'https://fonts.googleapis.com/icon?family=Material+Icons&display=swap'
];

// Dynamic content that should be network-first
const DYNAMIC_ROUTES = [
  '/',
  '/companies/',
  '/Calc/',
  '/sitemap/',
  '/terms/',
  '/privacy/',
  '/contact/'
];

// Install event - cache static assets
self.addEventListener('install', function(event) {
  console.log('[SW] Installing service worker');
  event.waitUntil(
    caches.open(STATIC_CACHE)
      .then(function(cache) {
        console.log('[SW] Caching static assets');
        return cache.addAll(STATIC_ASSETS);
      })
      .then(() => self.skipWaiting())
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', function(event) {
  console.log('[SW] Activating service worker');
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.map(function(cacheName) {
          if (cacheName !== STATIC_CACHE && cacheName !== DYNAMIC_CACHE) {
            console.log('[SW] Deleting old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
    .then(() => self.clients.claim())
  );
});

// Advanced caching strategies
self.addEventListener('fetch', function(event) {
  const { request } = event;
  const url = new URL(request.url);

  // Skip non-GET requests
  if (request.method !== 'GET') return;

  // Skip external requests (except Google Fonts)
  if (url.origin !== location.origin && !url.origin.includes('fonts.googleapis.com')) return;

  // Handle different caching strategies based on content type
  if (isStaticAsset(request)) {
    // Static assets: Cache-first with network fallback
    event.respondWith(cacheFirst(request));
  } else if (isDynamicRoute(request)) {
    // HTML pages: Network-first with cache fallback
    event.respondWith(networkFirst(request));
  } else if (isAPIRequest(request)) {
    // API requests: Network-only (for future API endpoints)
    event.respondWith(fetch(request));
  } else {
    // Other resources: Stale-while-revalidate
    event.respondWith(staleWhileRevalidate(request));
  }
});

// Cache-first strategy for static assets
function cacheFirst(request) {
  return caches.match(request)
    .then(function(response) {
      if (response) {
        return response;
      }
      return fetch(request)
        .then(function(response) {
          if (response.status === 200) {
            const responseClone = response.clone();
            caches.open(STATIC_CACHE)
              .then(function(cache) {
                cache.put(request, responseClone);
              });
          }
          return response;
        })
        .catch(function() {
          // Return offline fallback for critical assets
          if (request.url.includes('mui.min.css')) {
            return caches.match('/assets/css/mui.min.css');
          }
        });
    });
}

// Network-first strategy for dynamic content
function networkFirst(request) {
  return fetch(request)
    .then(function(response) {
      if (response.status === 200) {
        const responseClone = response.clone();
        caches.open(DYNAMIC_CACHE)
          .then(function(cache) {
            cache.put(request, responseClone);
          });
      }
      return response;
    })
    .catch(function() {
      // Fallback to cache if network fails
      return caches.match(request)
        .then(function(response) {
          if (response) {
            return response;
          }
          // Return offline page for navigation requests
          if (request.mode === 'navigate') {
            return caches.match('/offline/');
          }
        });
    });
}

// Stale-while-revalidate strategy
function staleWhileRevalidate(request) {
  return caches.match(request)
    .then(function(response) {
      const fetchPromise = fetch(request)
        .then(function(networkResponse) {
          if (networkResponse.status === 200) {
            const responseClone = networkResponse.clone();
            caches.open(DYNAMIC_CACHE)
              .then(function(cache) {
                cache.put(request, responseClone);
              });
          }
          return networkResponse;
        })
        .catch(function() {
          // Network failed, serve from cache if available
          return response;
        });

      // Return cached version immediately, then update in background
      return response || fetchPromise;
    });
}

// Helper functions
function isStaticAsset(request) {
  const url = request.url;
  return url.includes('.css') ||
         url.includes('.js') ||
         url.includes('.ico') ||
         url.includes('fonts.googleapis.com');
}

function isDynamicRoute(request) {
  const url = request.url;
  return url.includes('.html') ||
         url.includes('/') && !url.includes('.');
}

function isAPIRequest(request) {
  return request.url.includes('/api/');
}

// Background sync for offline form submissions (future enhancement)
self.addEventListener('sync', function(event) {
  if (event.tag === 'background-sync') {
    event.waitUntil(doBackgroundSync());
  }
});

function doBackgroundSync() {
  // Placeholder for future offline functionality
  console.log('[SW] Background sync triggered');
}
