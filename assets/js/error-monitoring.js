// Error monitoring and user feedback system
class RKErrorMonitor {
  constructor() {
    this.errors = [];
    this.maxErrors = 50; // Limit stored errors
    this.init();
  }

  init() {
    // Global error handler
    window.addEventListener('error', (event) => {
      this.captureError({
        type: 'javascript_error',
        message: event.message,
        filename: event.filename,
        lineno: event.lineno,
        colno: event.colno,
        stack: event.error?.stack,
        timestamp: Date.now(),
        url: window.location.href,
        userAgent: navigator.userAgent
      });
    });

    // Unhandled promise rejection handler
    window.addEventListener('unhandledrejection', (event) => {
      this.captureError({
        type: 'promise_rejection',
        message: event.reason?.message || event.reason,
        stack: event.reason?.stack,
        timestamp: Date.now(),
        url: window.location.href,
        userAgent: navigator.userAgent
      });
    });

    // Resource loading errors
    window.addEventListener('error', (event) => {
      if (event.target !== window) {
        this.captureError({
          type: 'resource_error',
          message: `Failed to load resource: ${event.target.src || event.target.href}`,
          resource: event.target.src || event.target.href,
          timestamp: Date.now(),
          url: window.location.href
        });
      }
    }, true);

    // Service worker errors
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.addEventListener('message', (event) => {
        if (event.data && event.data.type === 'error') {
          this.captureError({
            type: 'service_worker_error',
            message: event.data.message,
            stack: event.data.stack,
            timestamp: Date.now(),
            url: window.location.href
          });
        }
      });
    }

    // Performance issues
    if ('PerformanceObserver' in window) {
      // Long tasks
      const longTaskObserver = new PerformanceObserver((list) => {
        for (const entry of list.getEntries()) {
          if (entry.duration > 50) { // Tasks longer than 50ms
            this.captureError({
              type: 'long_task',
              duration: entry.duration,
              startTime: entry.startTime,
              timestamp: Date.now(),
              url: window.location.href
            });
          }
        }
      });
      longTaskObserver.observe({ type: 'longtask', buffered: true });

      // Layout shifts
      const layoutShiftObserver = new PerformanceObserver((list) => {
        let clsValue = 0;
        for (const entry of list.getEntries()) {
          if (!entry.hadRecentInput) {
            clsValue += entry.value;
          }
        }
        if (clsValue > 0.1) { // Significant layout shift
          this.captureError({
            type: 'layout_shift',
            value: clsValue,
            timestamp: Date.now(),
            url: window.location.href
          });
        }
      });
      layoutShiftObserver.observe({ type: 'layout-shift', buffered: true });
    }

    // Network issues
    this.monitorNetworkStatus();
  }

  captureError(error) {
    // Add to errors array
    this.errors.unshift(error);

    // Limit array size
    if (this.errors.length > this.maxErrors) {
      this.errors = this.errors.slice(0, this.maxErrors);
    }

    // Send to analytics if available
    if (window.RKAnalytics) {
      window.RKAnalytics.trackError(error);
    }

    // Log to console in development
    if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
      console.error('Error captured:', error);
    }

    // Show user-friendly error for critical issues
    if (this.isCriticalError(error)) {
      this.showUserError(error);
    }
  }

  isCriticalError(error) {
    return error.type === 'javascript_error' &&
           (error.message.includes('ReferenceError') ||
            error.message.includes('TypeError') ||
            error.message.includes('SyntaxError'));
  }

  showUserError(error) {
    // Create error notification
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-notification';
    errorDiv.setAttribute('role', 'alert');
    errorDiv.innerHTML = `
      <div class="error-content">
        <span class="material-icons">error</span>
        <div class="error-text">
          <strong>Something went wrong</strong>
          <p>We encountered an issue. Please try refreshing the page.</p>
        </div>
        <button class="error-dismiss" aria-label="Dismiss error">
          <span class="material-icons">close</span>
        </button>
      </div>
    `;

    // Add to page
    document.body.appendChild(errorDiv);

    // Auto-dismiss after 10 seconds
    setTimeout(() => {
      if (errorDiv.parentNode) {
        errorDiv.parentNode.removeChild(errorDiv);
      }
    }, 10000);

    // Manual dismiss
    errorDiv.querySelector('.error-dismiss').addEventListener('click', () => {
      errorDiv.parentNode.removeChild(errorDiv);
    });
  }

  monitorNetworkStatus() {
    // Network status changes
    if ('onLine' in navigator) {
      window.addEventListener('online', () => {
        if (window.RKAnalytics) {
          window.RKAnalytics.trackEvent('network', 'status_change', 'online');
        }
      });

      window.addEventListener('offline', () => {
        this.captureError({
          type: 'network_offline',
          message: 'User went offline',
          timestamp: Date.now(),
          url: window.location.href
        });
      });
    }

    // Slow network detection
    if ('connection' in navigator) {
      navigator.connection.addEventListener('change', () => {
        const connection = navigator.connection;
        if (connection.effectiveType === 'slow-2g' || connection.effectiveType === '2g') {
          this.captureError({
            type: 'slow_connection',
            effectiveType: connection.effectiveType,
            downlink: connection.downlink,
            rtt: connection.rtt,
            timestamp: Date.now(),
            url: window.location.href
          });
        }
      });
    }
  }

  // Get error report for debugging
  getErrorReport() {
    return {
      errors: this.errors,
      totalErrors: this.errors.length,
      userAgent: navigator.userAgent,
      url: window.location.href,
      timestamp: Date.now(),
      performance: this.getPerformanceMetrics()
    };
  }

  getPerformanceMetrics() {
    if (!window.performance || !window.performance.timing) {
      return null;
    }

    const timing = window.performance.timing;
    return {
      domContentLoaded: timing.domContentLoadedEventEnd - timing.navigationStart,
      loadComplete: timing.loadEventEnd - timing.navigationStart,
      firstPaint: this.getFirstPaint(),
      memory: window.performance.memory ? {
        used: window.performance.memory.usedJSHeapSize,
        total: window.performance.memory.totalJSHeapSize,
        limit: window.performance.memory.jsHeapSizeLimit
      } : null
    };
  }

  getFirstPaint() {
    if (!window.performance || !window.performance.getEntriesByType) {
      return null;
    }

    const paintEntries = window.performance.getEntriesByType('paint');
    const firstPaint = paintEntries.find(entry => entry.name === 'first-paint');
    return firstPaint ? firstPaint.startTime : null;
  }
}

// User feedback system
class RKFeedback {
  constructor() {
    this.feedbackButton = null;
    this.feedbackModal = null;
    this.init();
  }

  init() {
    // Create feedback button
    this.createFeedbackButton();

    // Create feedback modal
    this.createFeedbackModal();

    // Add event listeners
    this.feedbackButton.addEventListener('click', () => this.showModal());
  }

  createFeedbackButton() {
    this.feedbackButton = document.createElement('button');
    this.feedbackButton.className = 'feedback-button';
    this.feedbackButton.setAttribute('aria-label', 'Send feedback');
    this.feedbackButton.innerHTML = `
      <span class="material-icons">feedback</span>
      <span class="feedback-label">Feedback</span>
    `;

    document.body.appendChild(this.feedbackButton);
  }

  createFeedbackModal() {
    this.feedbackModal = document.createElement('div');
    this.feedbackModal.className = 'feedback-modal';
    this.feedbackModal.setAttribute('role', 'dialog');
    this.feedbackModal.setAttribute('aria-labelledby', 'feedback-title');
    this.feedbackModal.setAttribute('aria-hidden', 'true');
    this.feedbackModal.innerHTML = `
      <div class="feedback-overlay"></div>
      <div class="feedback-content">
        <div class="feedback-header">
          <h2 id="feedback-title">Send Feedback</h2>
          <button class="feedback-close" aria-label="Close feedback form">
            <span class="material-icons">close</span>
          </button>
        </div>
        <form class="feedback-form">
          <div class="form-group">
            <label for="feedback-type">Feedback Type</label>
            <select id="feedback-type" required>
              <option value="">Select type...</option>
              <option value="bug">Bug Report</option>
              <option value="feature">Feature Request</option>
              <option value="improvement">Improvement Suggestion</option>
              <option value="general">General Feedback</option>
            </select>
          </div>
          <div class="form-group">
            <label for="feedback-message">Message</label>
            <textarea id="feedback-message" placeholder="Tell us what you think..." required></textarea>
          </div>
          <div class="form-group">
            <label for="feedback-email">Email (optional)</label>
            <input type="email" id="feedback-email" placeholder="your.email@example.com">
          </div>
          <div class="form-actions">
            <button type="button" class="feedback-cancel mui-btn mui-btn--outline">Cancel</button>
            <button type="submit" class="feedback-submit mui-btn mui-btn--primary">Send Feedback</button>
          </div>
        </form>
      </div>
    `;

    document.body.appendChild(this.feedbackModal);

    // Add event listeners
    this.feedbackModal.querySelector('.feedback-close').addEventListener('click', () => this.hideModal());
    this.feedbackModal.querySelector('.feedback-cancel').addEventListener('click', () => this.hideModal());
    this.feedbackModal.querySelector('.feedback-overlay').addEventListener('click', () => this.hideModal());
    this.feedbackModal.querySelector('.feedback-form').addEventListener('submit', (e) => this.submitFeedback(e));

    // Keyboard navigation
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && !this.feedbackModal.getAttribute('aria-hidden')) {
        this.hideModal();
      }
    });
  }

  showModal() {
    this.feedbackModal.setAttribute('aria-hidden', 'false');
    this.feedbackModal.style.display = 'block';
    document.body.style.overflow = 'hidden';

    // Focus management
    const firstInput = this.feedbackModal.querySelector('#feedback-type');
    if (firstInput) firstInput.focus();
  }

  hideModal() {
    this.feedbackModal.setAttribute('aria-hidden', 'true');
    this.feedbackModal.style.display = 'none';
    document.body.style.overflow = '';

    // Return focus
    this.feedbackButton.focus();
  }

  async submitFeedback(event) {
    event.preventDefault();

    const formData = new FormData(event.target);
    const feedback = {
      type: formData.get('feedback-type'),
      message: formData.get('feedback-message'),
      email: formData.get('feedback-email'),
      url: window.location.href,
      userAgent: navigator.userAgent,
      timestamp: Date.now()
    };

    try {
      // Send to analytics
      if (window.RKAnalytics) {
        window.RKAnalytics.trackFeedback(feedback);
      }

      // Show success message
      this.showSuccessMessage();

      // Reset form
      event.target.reset();
      this.hideModal();

    } catch (error) {
      console.error('Failed to submit feedback:', error);
      this.showErrorMessage();
    }
  }

  showSuccessMessage() {
    const message = document.createElement('div');
    message.className = 'feedback-message success';
    message.innerHTML = `
      <span class="material-icons">check_circle</span>
      <span>Thank you for your feedback!</span>
    `;
    document.body.appendChild(message);

    setTimeout(() => {
      if (message.parentNode) {
        message.parentNode.removeChild(message);
      }
    }, 3000);
  }

  showErrorMessage() {
    const message = document.createElement('div');
    message.className = 'feedback-message error';
    message.innerHTML = `
      <span class="material-icons">error</span>
      <span>Failed to send feedback. Please try again.</span>
    `;
    document.body.appendChild(message);

    setTimeout(() => {
      if (message.parentNode) {
        message.parentNode.removeChild(message);
      }
    }, 5000);
  }
}

// Initialize error monitoring and feedback when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  // Initialize error monitoring
  window.RKErrorMonitor = new RKErrorMonitor();

  // Initialize feedback system
  window.RKFeedback = new RKFeedback();

  // Add error report to window for debugging
  window.getErrorReport = () => window.RKErrorMonitor.getErrorReport();
});