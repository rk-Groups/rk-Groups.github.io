// Core Web Vitals monitoring with privacy focus
import {onCLS, onFID, onFCP, onLCP, onTTFB} from 'web-vitals';

// Privacy-respecting metrics collection
function sendToAnalytics({name, delta, value, id}) {
  // Use your existing analytics system
  if (window.RKAnalytics) {
    window.RKAnalytics.trackMetric({
      metric: name,
      value: delta,
      id: id,
      timestamp: Date.now(),
      page: location.pathname
    });
  }

  // Optional: Send to Google Analytics 4 if configured
  if (window.gtag && typeof window.gtag === 'function') {
    window.gtag('event', name, {
      event_category: 'Web Vitals',
      event_label: id,
      value: Math.round(delta),
      custom_map: {
        metric_value: value
      },
      non_interaction: true
    });
  }
}

// Monitor Core Web Vitals
onCLS(sendToAnalytics);
onFID(sendToAnalytics);
onFCP(sendToAnalytics);
onLCP(sendToAnalytics);
onTTFB(sendToAnalytics);

// Additional performance metrics
window.addEventListener('load', function() {
  // Time to Interactive approximation
  setTimeout(function() {
    if (window.RKAnalytics) {
      const loadTime = performance.now();
      window.RKAnalytics.trackMetric({
        metric: 'TTI',
        value: loadTime,
        timestamp: Date.now(),
        page: location.pathname
      });
    }
  }, 0);

  // Monitor for layout shifts after load
  let clsValue = 0;
  new PerformanceObserver(function(list) {
    for (const entry of list.getEntries()) {
      if (!entry.hadRecentInput) {
        clsValue += entry.value;
      }
    }
  }).observe({type: 'layout-shift', buffered: true});
});

// Resource loading performance
window.addEventListener('load', function() {
  // Monitor largest contentful paint
  new PerformanceObserver(function(list) {
    const entries = list.getEntries();
    const lastEntry = entries[entries.length - 1];

    if (window.RKAnalytics) {
      window.RKAnalytics.trackMetric({
        metric: 'LCP_Resource',
        value: lastEntry.startTime,
        element: lastEntry.element?.tagName,
        url: lastEntry.url,
        timestamp: Date.now(),
        page: location.pathname
      });
    }
  }).observe({type: 'largest-contentful-paint', buffered: true});

  // Monitor first input delay
  new PerformanceObserver(function(list) {
    for (const entry of list.getEntries()) {
      if (window.RKAnalytics) {
        window.RKAnalytics.trackMetric({
          metric: 'FID_Detailed',
          value: entry.processingStart - entry.startTime,
          timestamp: Date.now(),
          page: location.pathname
        });
      }
    }
  }).observe({type: 'first-input', buffered: true});
});

// Network information
if ('connection' in navigator) {
  navigator.connection.addEventListener('change', function() {
    if (window.RKAnalytics) {
      window.RKAnalytics.trackNetworkInfo({
        effectiveType: navigator.connection.effectiveType,
        downlink: navigator.connection.downlink,
        rtt: navigator.connection.rtt,
        timestamp: Date.now(),
        page: location.pathname
      });
    }
  });
}

// Memory usage monitoring (if available)
if ('memory' in performance) {
  window.addEventListener('load', function() {
    setTimeout(function() {
      if (window.RKAnalytics) {
        window.RKAnalytics.trackMemoryUsage({
          used: performance.memory.usedJSHeapSize,
          total: performance.memory.totalJSHeapSize,
          limit: performance.memory.jsHeapSizeLimit,
          timestamp: Date.now(),
          page: location.pathname
        });
      }
    }, 1000);
  });
}