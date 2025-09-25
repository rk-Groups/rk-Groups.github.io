---
layout: default
title: Privacy Policy
description: Privacy Policy for RK Groups. Learn how we collect, use, and protect your personal information and data privacy rights.
---

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">privacy_tip</span>
    </div>
    <h1 class="mui-hero-title">Privacy Policy</h1>
    <p class="mui-hero-subtitle">How we collect, use, and protect your personal information</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <h2>Information We Collect</h2>
    <p>We collect information you provide directly to us, such as when you:</p>
    <ul>
      <li>Contact us through our website forms or email</li>
      <li>Request quotes or place orders for our products and services</li>
      <li>Subscribe to our newsletters or updates</li>
      <li>Participate in surveys or feedback forms</li>
    </ul>

    <p>The types of information we may collect include:</p>
    <ul>
      <li>Name, email address, and phone number</li>
      <li>Company name and business information</li>
      <li>Product and service preferences</li>
      <li>Communication history and correspondence</li>
    </ul>
  </div>

  <div class="mui-card">
    <h2>How We Use Your Information</h2>
    <p>We use the information we collect to:</p>
    <ul>
      <li>Process and fulfill your orders and requests</li>
      <li>Provide customer service and technical support</li>
      <li>Send you important updates about your orders or services</li>
      <li>Improve our products and services</li>
      <li>Communicate with you about our offerings</li>
      <li>Comply with legal obligations</li>
    </ul>

    <div class="highlight-box">
      <p><strong>Data Protection:</strong> We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.</p>
    </div>
  </div>

  <div class="mui-card">
    <h2>Information Sharing and Disclosure</h2>
    <p>We do not sell, trade, or otherwise transfer your personal information to third parties except in the following circumstances:</p>
    <ul>
      <li>With your explicit consent</li>
      <li>To comply with legal obligations or court orders</li>
      <li>To protect our rights, property, or safety, or that of our customers</li>
      <li>With trusted service providers who assist us in operating our business (under strict confidentiality agreements)</li>
    </ul>
  </div>

  <div class="mui-card">
    <h2>Data Security</h2>
    <p>We take the security of your personal information seriously and implement appropriate measures to protect it:</p>
    <ul>
      <li>Secure data transmission using SSL/TLS encryption</li>
      <li>Regular security audits and updates</li>
      <li>Limited access to personal information on a need-to-know basis</li>
      <li>Secure storage and disposal of information</li>
    </ul>
  </div>

  <div class="mui-card">
    <h2>Your Rights and Choices</h2>
    <p>You have the following rights regarding your personal information:</p>
    <ul>
      <li><strong>Access:</strong> Request a copy of the personal information we hold about you</li>
      <li><strong>Correction:</strong> Request correction of inaccurate or incomplete information</li>
      <li><strong>Deletion:</strong> Request deletion of your personal information (subject to legal requirements)</li>
      <li><strong>Portability:</strong> Request transfer of your data in a structured format</li>
      <li><strong>Opt-out:</strong> Unsubscribe from marketing communications at any time</li>
    </ul>

    <p>To exercise these rights, please contact us using the information provided below.</p>
  </div>

  <div class="mui-card">
    <h2>Cookies and Tracking</h2>
    <p>Our website may use cookies and similar technologies to enhance your browsing experience:</p>
    <ul>
      <li><strong>Essential Cookies:</strong> Required for website functionality</li>
      <li><strong>Analytics Cookies:</strong> Help us understand how visitors use our site</li>
      <li><strong>Preference Cookies:</strong> Remember your settings and preferences</li>
    </ul>

    <p>You can control cookie settings through your browser preferences. However, disabling certain cookies may affect website functionality.</p>
  </div>

  <div class="mui-card">
    <h2>Third-Party Links</h2>
    <p>Our website may contain links to third-party websites. We are not responsible for the privacy practices or content of these external sites. We encourage you to review the privacy policies of any third-party websites you visit.</p>
  </div>

  <div class="mui-card">
    <h2>Children's Privacy</h2>
    <p>Our services are not intended for children under 13 years of age. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.</p>
  </div>

  <div class="mui-card">
    <h2>Changes to This Privacy Policy</h2>
    <p>We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the new Privacy Policy on this page and updating the "Last updated" date below.</p>

    <p>We encourage you to review this Privacy Policy periodically to stay informed about how we protect your information.</p>
  </div>

  <div class="contact-info">
    <h3>Contact Us About Privacy</h3>
    <p>If you have any questions about this Privacy Policy or our privacy practices, please contact us:</p>
    <ul>
      <li><strong>Email:</strong> <a href="mailto:gkp.rkoxygen@gmail.com">gkp.rkoxygen@gmail.com</a></li>
      <li><strong>Phone:</strong> <a href="tel:+917355755506">+91-7355755506</a></li>
      <li><strong>Address:</strong> 85, RK Palace, Gangaprasad Road, Rakabganj, Lucknow – 226018, Uttar Pradesh</li>
    </ul>
  </div>

  <div class="last-updated">
    Last updated: September 12, 2025
  </div>
</div>

<script>
  // Simple analytics tracking (sessionStorage only)
  window.RKAnalytics = {
    trackPageView: function(page) {
      const data = {
        page: page || location.pathname,
        timestamp: new Date().toISOString(),
        referrer: document.referrer ? new URL(document.referrer).hostname : 'direct'
      };
      console.log('Page View:', data);
      this.storeEvent('pageview', data);
    },
    storeEvent: function(type, data) {
      try {
        const events = JSON.parse(sessionStorage.getItem('rk_analytics') || '[]');
        events.push({type: type, data});
        if (events.length > 50) events.shift();
        sessionStorage.setItem('rk_analytics', JSON.stringify(events));
      } catch (e) {
        console.warn('Analytics storage failed:', e);
      }
    }
  };

  // Track page view
  RKAnalytics.trackPageView();
</script>