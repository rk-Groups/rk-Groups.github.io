// report-issue.js
// Enhanced Report Issue functionality with page context

class ReportIssue {
  constructor() {
    this.githubRepo = 'rk-Groups/rk-Groups.github.io';
    this.githubIssuesUrl = `https://github.com/${this.githubRepo}/issues/new`;
  }

  // Collect comprehensive page context data
  collectPageData() {
    const data = {
      timestamp: new Date().toISOString(),
      url: window.location.href,
      title: document.title,
      userAgent: navigator.userAgent,
      language: navigator.language,
      platform: navigator.platform,
      screenResolution: `${screen.width}x${screen.height}`,
      viewport: `${window.innerWidth}x${window.innerHeight}`,
      referrer: document.referrer || 'Direct',
      cookiesEnabled: navigator.cookieEnabled,
      onlineStatus: navigator.onLine ? 'Online' : 'Offline',
      timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
      pageLoadTime: this.getPageLoadTime(),

      // Enhanced data collection
      devicePixelRatio: window.devicePixelRatio || 1,
      hardwareConcurrency: navigator.hardwareConcurrency || 'Unknown',
      maxTouchPoints: navigator.maxTouchPoints || 0,
      scrollPosition: `${window.scrollX}, ${window.scrollY}`,
      sessionHistoryLength: history.length,
      localStorageAvailable: this.checkStorageAvailability('localStorage'),
      sessionStorageAvailable: this.checkStorageAvailability('sessionStorage'),
      webGLSupported: this.checkWebGLSupport(),
      serviceWorkerStatus: this.getServiceWorkerStatus(),
      cacheStatus: this.getCacheStatus(),
      memoryInfo: this.getMemoryInfo(),
      batteryStatus: null, // Will be populated asynchronously
      networkInfo: this.getNetworkInfo(),
      geolocationAvailable: 'geolocation' in navigator,
      webAPIs: this.getWebAPISupport(),
      themeInfo: this.getThemeInfo(),
      recentConsoleMessages: this.getRecentConsoleMessages(),
      formData: this.getFormData(),
      performanceMetrics: this.getPerformanceMetrics()
    };

    // Add page content summary
    data.pageSummary = this.getPageSummary();

    // Add company context if available
    data.companyContext = this.getCompanyContext();

    // Get battery status asynchronously
    if ('getBattery' in navigator) {
      navigator.getBattery().then(battery => {
        data.batteryStatus = {
          level: Math.round(battery.level * 100) + '%',
          charging: battery.charging,
          chargingTime: battery.chargingTime,
          dischargingTime: battery.dischargingTime
        };
      }).catch(() => {
        data.batteryStatus = 'Unavailable';
      });
    } else {
      data.batteryStatus = 'Not Supported';
    }

    return data;
  }

  // Get page load performance timing
  getPageLoadTime() {
    if (window.performance && window.performance.timing) {
      const timing = window.performance.timing;
      return timing.loadEventEnd - timing.navigationStart + 'ms';
    }
    return 'Unknown';
  }

  // Check storage availability
  checkStorageAvailability(type) {
    try {
      const storage = window[type];
      const testKey = '__storage_test__';
      storage.setItem(testKey, 'test');
      storage.removeItem(testKey);
      return 'Available';
    } catch (e) {
      return 'Unavailable';
    }
  }

  // Check WebGL support
  checkWebGLSupport() {
    try {
      const canvas = document.createElement('canvas');
      return !!(window.WebGLRenderingContext && canvas.getContext('webgl'));
    } catch (e) {
      return false;
    }
  }

  // Get service worker status
  getServiceWorkerStatus() {
    if ('serviceWorker' in navigator) {
      return navigator.serviceWorker.controller ? 'Active' : 'Registered but not active';
    }
    return 'Not supported';
  }

  // Get cache status
  getCacheStatus() {
    if ('caches' in window) {
      return 'Available';
    }
    return 'Not supported';
  }

  // Get memory information
  getMemoryInfo() {
    if (performance.memory) {
      return {
        usedJSHeapSize: Math.round(performance.memory.usedJSHeapSize / 1024 / 1024) + ' MB',
        totalJSHeapSize: Math.round(performance.memory.totalJSHeapSize / 1024 / 1024) + ' MB',
        jsHeapSizeLimit: Math.round(performance.memory.jsHeapSizeLimit / 1024 / 1024) + ' MB'
      };
    }
    return 'Not available';
  }

  // Get network information
  getNetworkInfo() {
    if ('connection' in navigator) {
      const conn = navigator.connection;
      return {
        effectiveType: conn.effectiveType || 'Unknown',
        downlink: conn.downlink ? conn.downlink + ' Mbps' : 'Unknown',
        rtt: conn.rtt ? conn.rtt + ' ms' : 'Unknown',
        saveData: conn.saveData || false
      };
    }
    return 'Not available';
  }

  // Get Web APIs support
  getWebAPISupport() {
    const apis = [
      'fetch', 'Promise', 'async/await', 'WebGL', 'WebRTC', 'WebAssembly',
      'IntersectionObserver', 'ResizeObserver', 'MutationObserver',
      'IndexedDB', 'WebSockets', 'Notifications', 'Push API',
      'Service Workers', 'Background Sync', 'Payment Request API'
    ];

    const support = {};
    apis.forEach(api => {
      switch (api) {
        case 'fetch':
          support[api] = 'fetch' in window;
          break;
        case 'Promise':
          support[api] = 'Promise' in window;
          break;
        case 'async/await':
          support[api] = true; // Supported in modern browsers
          break;
        case 'WebGL':
          support[api] = this.checkWebGLSupport();
          break;
        case 'WebRTC':
          support[api] = 'RTCPeerConnection' in window;
          break;
        case 'WebAssembly':
          support[api] = 'WebAssembly' in window;
          break;
        case 'IntersectionObserver':
          support[api] = 'IntersectionObserver' in window;
          break;
        case 'ResizeObserver':
          support[api] = 'ResizeObserver' in window;
          break;
        case 'MutationObserver':
          support[api] = 'MutationObserver' in window;
          break;
        case 'IndexedDB':
          support[api] = 'indexedDB' in window;
          break;
        case 'WebSockets':
          support[api] = 'WebSocket' in window;
          break;
        case 'Notifications':
          support[api] = 'Notification' in window;
          break;
        case 'Push API':
          support[api] = 'PushManager' in window;
          break;
        case 'Service Workers':
          support[api] = 'serviceWorker' in navigator;
          break;
        case 'Background Sync':
          support[api] = 'serviceWorker' in navigator && 'sync' in window.ServiceWorkerRegistration.prototype;
          break;
        case 'Payment Request API':
          support[api] = 'PaymentRequest' in window;
          break;
      }
    });

    return support;
  }

  // Get theme information
  getThemeInfo() {
    return {
      colorScheme: window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'Dark' : 'Light',
      reducedMotion: window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches,
      highContrast: window.matchMedia && window.matchMedia('(prefers-contrast: high)').matches,
      currentTheme: document.body.classList.contains('dark-mode') ? 'Dark Mode' : 'Light Mode'
    };
  }

  // Get recent console messages (limited implementation)
  getRecentConsoleMessages() {
    // Note: This is a simplified implementation
    // In a real scenario, you might want to override console methods to capture messages
    return {
      note: 'Console messages are not captured in real-time. Check browser developer tools for detailed logs.',
      lastError: null,
      lastWarning: null
    };
  }

  // Get form data from the page
  getFormData() {
    const forms = document.querySelectorAll('form');
    const formInfo = [];

    forms.forEach((form, index) => {
      const formData = {
        id: form.id || `form-${index}`,
        action: form.action || '',
        method: form.method || 'get',
        inputs: form.querySelectorAll('input, select, textarea').length,
        hasValidation: form.querySelectorAll('[required], [pattern], [min], [max]').length > 0
      };
      formInfo.push(formData);
    });

    return {
      count: forms.length,
      forms: formInfo.slice(0, 5) // Limit to first 5 forms
    };
  }

  // Get detailed performance metrics
  getPerformanceMetrics() {
    if (!window.performance || !window.performance.timing) {
      return 'Not available';
    }

    const timing = window.performance.timing;
    const navigation = window.performance.navigation || {};

    return {
      navigationStart: timing.navigationStart,
      unloadEventStart: timing.unloadEventStart,
      unloadEventEnd: timing.unloadEventEnd,
      redirectStart: timing.redirectStart,
      redirectEnd: timing.redirectEnd,
      fetchStart: timing.fetchStart,
      domainLookupStart: timing.domainLookupStart,
      domainLookupEnd: timing.domainLookupEnd,
      connectStart: timing.connectStart,
      connectEnd: timing.connectEnd,
      secureConnectionStart: timing.secureConnectionStart,
      requestStart: timing.requestStart,
      responseStart: timing.responseStart,
      responseEnd: timing.responseEnd,
      domLoading: timing.domLoading,
      domInteractive: timing.domInteractive,
      domContentLoadedEventStart: timing.domContentLoadedEventStart,
      domContentLoadedEventEnd: timing.domContentLoadedEventEnd,
      domComplete: timing.domComplete,
      loadEventStart: timing.loadEventStart,
      loadEventEnd: timing.loadEventEnd,
      navigationType: navigation.type === 0 ? 'Navigate' : navigation.type === 1 ? 'Reload' : 'Back/Forward',
      redirectCount: navigation.redirectCount || 0
    };
  }

  // Extract page summary (headings, key content)
  getPageSummary() {
    const summary = {
      h1: [],
      h2: [],
      h3: [],
      metaDescription: '',
      canonicalUrl: ''
    };

    // Get headings
    ['h1', 'h2', 'h3'].forEach(tag => {
      document.querySelectorAll(tag).forEach(el => {
        const text = el.textContent.trim();
        if (text && text.length > 0) {
          summary[tag].push(text.substring(0, 100)); // Limit length
        }
      });
    });

    // Get meta description
    const metaDesc = document.querySelector('meta[name="description"]');
    if (metaDesc) {
      summary.metaDescription = metaDesc.getAttribute('content') || '';
    }

    // Get canonical URL
    const canonical = document.querySelector('link[rel="canonical"]');
    if (canonical) {
      summary.canonicalUrl = canonical.getAttribute('href') || '';
    }

    return summary;
  }

  // Get company-specific context
  getCompanyContext() {
    const context = {
      company: null,
      branch: null,
      pageType: null
    };

    const path = window.location.pathname;

    // Extract company from URL
    if (path.includes('/companies/')) {
      const companyMatch = path.match(/\/companies\/([^\/]+)/);
      if (companyMatch) {
        context.company = companyMatch[1];

        // Check for branch
        const branchMatch = path.match(/\/companies\/[^\/]+\/([^\/]+)/);
        if (branchMatch && branchMatch[1] !== 'terms' && branchMatch[1] !== 'refund-policy') {
          context.branch = branchMatch[1];
        }

        // Determine page type
        if (path.includes('/terms')) context.pageType = 'Terms';
        else if (path.includes('/refund-policy')) context.pageType = 'Refund Policy';
        else if (path.includes('/privacy')) context.pageType = 'Privacy Policy';
        else if (path.includes('/contact')) context.pageType = 'Contact';
        else if (path.includes('/shipping')) context.pageType = 'Shipping';
        else context.pageType = 'Company Page';
      }
    } else if (path.includes('/Calc/')) {
      context.pageType = 'Calculator';
      if (path.includes('/GST/')) context.calculatorType = 'GST';
      else if (path.includes('/EMI/')) context.calculatorType = 'EMI';
      else if (path.includes('/LIQ/')) context.calculatorType = 'Liquid';
      else if (path.includes('/CI/')) context.calculatorType = 'Compound Interest';
    }

    return context;
  }

  // Generate formatted issue body
  generateIssueBody(data) {
    const summary = data.pageSummary;
    const context = data.companyContext;

    let body = `## Issue Report

**Reported on:** ${data.timestamp}
**Page URL:** ${data.url}
**Page Title:** ${data.title}

### Context
- **Company:** ${context.company || 'N/A'}
- **Branch:** ${context.branch || 'N/A'}
- **Page Type:** ${context.pageType || 'General'}
${context.calculatorType ? `- **Calculator Type:** ${context.calculatorType}\n` : ''}

### Device & Browser Information
- **User Agent:** ${data.userAgent}
- **Platform:** ${data.platform}
- **Screen Resolution:** ${data.screenResolution} (${data.devicePixelRatio}x pixel ratio)
- **Viewport:** ${data.viewport}
- **Hardware Concurrency:** ${data.hardwareConcurrency} cores
- **Max Touch Points:** ${data.maxTouchPoints}
- **Language:** ${data.language}
- **Timezone:** ${data.timezone}

### Network & Performance
- **Online Status:** ${data.onlineStatus}
- **Network Info:** ${typeof data.networkInfo === 'object' ? `Type: ${data.networkInfo.effectiveType}, Speed: ${data.networkInfo.downlink}, RTT: ${data.networkInfo.rtt}, Save Data: ${data.networkInfo.saveData}` : data.networkInfo}
- **Page Load Time:** ${data.pageLoadTime}
- **Referrer:** ${data.referrer}
- **Session History Length:** ${data.sessionHistoryLength}
- **Scroll Position:** ${data.scrollPosition}

### Browser Features & Storage
- **Cookies Enabled:** ${data.cookiesEnabled}
- **Local Storage:** ${data.localStorageAvailable}
- **Session Storage:** ${data.sessionStorageAvailable}
- **WebGL Support:** ${data.webGLSupported}
- **Service Worker:** ${data.serviceWorkerStatus}
- **Cache API:** ${data.cacheStatus}
- **Geolocation Available:** ${data.geolocationAvailable}

### Memory & Battery
- **Memory Info:** ${typeof data.memoryInfo === 'object' ? `Used: ${data.memoryInfo.usedJSHeapSize}, Total: ${data.memoryInfo.totalJSHeapSize}, Limit: ${data.memoryInfo.jsHeapSizeLimit}` : data.memoryInfo}
- **Battery Status:** ${typeof data.batteryStatus === 'object' ? `Level: ${data.batteryStatus.level}, Charging: ${data.batteryStatus.charging}` : data.batteryStatus}

### Theme & Accessibility
- **Current Theme:** ${data.themeInfo.currentTheme}
- **Preferred Color Scheme:** ${data.themeInfo.colorScheme}
- **Reduced Motion:** ${data.themeInfo.reducedMotion}
- **High Contrast:** ${data.themeInfo.highContrast}

### Web APIs Support
${Object.entries(data.webAPIs).map(([api, supported]) => `- **${api}:** ${supported ? '✅' : '❌'}`).join('\n')}

### Page Content Summary
${summary.h1.length > 0 ? `**H1 Headings:** ${summary.h1.join(', ')}\n` : ''}${summary.h2.length > 0 ? `**H2 Headings:** ${summary.h2.slice(0, 3).join(', ')}\n` : ''}${summary.metaDescription ? `**Meta Description:** ${summary.metaDescription}\n` : ''}${summary.canonicalUrl ? `**Canonical URL:** ${summary.canonicalUrl}\n` : ''}

### Forms on Page
${data.formData.count > 0 ? `Found ${data.formData.count} form(s):\n${data.formData.forms.map(form => `- ${form.id}: ${form.inputs} inputs, method: ${form.method}, validation: ${form.hasValidation}`).join('\n')}` : 'No forms detected'}

### Performance Metrics
${typeof data.performanceMetrics === 'object' ? `Navigation Type: ${data.performanceMetrics.navigationType}, Redirects: ${data.performanceMetrics.redirectCount}, DOM Interactive: ${data.performanceMetrics.domInteractive - data.performanceMetrics.navigationStart}ms` : data.performanceMetrics}

### Issue Description
<!-- Please describe the issue you encountered -->

### Steps to Reproduce
<!-- How can we reproduce this issue? -->

### Expected Behavior
<!-- What should happen? -->

### Actual Behavior
<!-- What actually happened? -->

### Screenshots
<!-- If applicable, add screenshots to help explain your problem -->

### Browser Console Logs
<!-- Please check your browser's developer tools (F12) and paste any relevant error messages here -->

### Additional Context
<!-- Add any other context about the problem here -->

---
*This issue was automatically generated from the RK Groups website with comprehensive diagnostic information.*`;

    return body;
  }

  // Generate issue title
  generateIssueTitle(data) {
    const context = data.companyContext;
    let title = 'Issue Report';

    if (context.company) {
      title += ` - ${context.company}`;
      if (context.branch) {
        title += ` (${context.branch})`;
      }
      if (context.pageType) {
        title += ` - ${context.pageType}`;
      }
    } else if (context.pageType) {
      title += ` - ${context.pageType}`;
    }

    title += ` - ${new Date().toLocaleDateString()}`;

    return title;
  }

  // Open GitHub issue with pre-filled data
  async reportIssue() {
    const data = this.collectPageData();

    // Wait for battery status if it's being fetched
    if ('getBattery' in navigator && typeof data.batteryStatus === 'object' && data.batteryStatus.then) {
      try {
        data.batteryStatus = await navigator.getBattery().then(battery => ({
          level: Math.round(battery.level * 100) + '%',
          charging: battery.charging,
          chargingTime: battery.chargingTime,
          dischargingTime: battery.dischargingTime
        }));
      } catch (e) {
        data.batteryStatus = 'Unavailable';
      }
    }

    const title = encodeURIComponent(this.generateIssueTitle(data));
    const body = encodeURIComponent(this.generateIssueBody(data));

    const issueUrl = `${this.githubIssuesUrl}?title=${title}&body=${body}`;

    // Open in new tab
    window.open(issueUrl, '_blank');
  }

  // Initialize the report issue functionality
  init() {
    // Add click handler to report issue buttons
    document.addEventListener('click', (e) => {
      if (e.target.closest('.mui-bottombar-report')) {
        e.preventDefault();
        this.reportIssue().catch(console.error);
      }
    });
  }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  const reportIssue = new ReportIssue();
  reportIssue.init();
});