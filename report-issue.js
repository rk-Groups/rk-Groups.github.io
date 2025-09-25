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
      pageLoadTime: this.getPageLoadTime()
    };

    // Add page content summary
    data.pageSummary = this.getPageSummary();

    // Add company context if available
    data.companyContext = this.getCompanyContext();

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

### Technical Details
- **User Agent:** ${data.userAgent}
- **Browser Language:** ${data.language}
- **Platform:** ${data.platform}
- **Screen Resolution:** ${data.screenResolution}
- **Viewport:** ${data.viewport}
- **Referrer:** ${data.referrer}
- **Cookies Enabled:** ${data.cookiesEnabled}
- **Online Status:** ${data.onlineStatus}
- **Timezone:** ${data.timezone}
- **Page Load Time:** ${data.pageLoadTime}

### Page Summary
${summary.h1.length > 0 ? `**H1 Headings:** ${summary.h1.join(', ')}\n` : ''}${summary.h2.length > 0 ? `**H2 Headings:** ${summary.h2.slice(0, 3).join(', ')}\n` : ''}${summary.metaDescription ? `**Meta Description:** ${summary.metaDescription}\n` : ''}

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

### Additional Context
<!-- Add any other context about the problem here -->

---
*This issue was automatically generated from the RK Groups website.*`;

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
  reportIssue() {
    const data = this.collectPageData();
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
        this.reportIssue();
      }
    });
  }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  const reportIssue = new ReportIssue();
  reportIssue.init();
});