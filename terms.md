---
layout: default
title: Terms of Service
description: Terms of Service for RK Groups. Legal terms and conditions for using our services and website.
---

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">gavel</span>
    </div>
    <h1 class="mui-hero-title">Terms of Service</h1>
    <p class="mui-hero-subtitle">Legal terms and conditions for using our services</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <h2>Acceptance of Terms</h2>
    <p>By accessing and using the services provided by RK Groups ("we," "us," or "our"), including our website, products, and services, you accept and agree to be bound by the terms and provision of this agreement.</p>

    <p>These Terms of Service apply to all visitors, users, and others who access or use our services. If you disagree with any part of these terms, then you may not access our services.</p>
  </div>

  <div class="mui-card">
    <h2>Products and Services</h2>
    <p>RK Groups provides industrial gases, welding equipment, and related services through our various company branches. Our services include but are not limited to:</p>
    <ul>
      <li>Supply of industrial gases (oxygen, nitrogen, carbon dioxide, etc.)</li>
      <li>Welding equipment and consumables</li>
      <li>Technical consultation and support</li>
      <li>Delivery and installation services</li>
      <li>Maintenance and repair services</li>
    </ul>
  </div>

  <div class="mui-card">
    <h2>Orders and Payment</h2>
    <h3>Order Acceptance</h3>
    <p>All orders are subject to acceptance and availability. We reserve the right to refuse or cancel any order for any reason, including but not limited to product availability, errors in product information, or payment issues.</p>

    <h3>Pricing and Payment</h3>
    <p>All prices are subject to change without notice. Payment terms are specified on invoices and must be adhered to. Late payments may incur additional charges.</p>

    <h3>Delivery</h3>
    <p>Delivery schedules are estimates only. We are not liable for delays in delivery due to circumstances beyond our control.</p>
  </div>

  <div class="mui-card">
    <h2>Safety and Usage</h2>
    <div class="highlight-box">
      <p><strong>Important Safety Notice:</strong> Our products, particularly industrial gases, can be hazardous if not handled properly. Users must follow all safety guidelines, Material Safety Data Sheets (MSDS), and local regulations.</p>
    </div>

    <p>By purchasing our products, you acknowledge that:</p>
    <ul>
      <li>You are responsible for proper storage and handling of products</li>
      <li>You will comply with all applicable safety regulations and standards</li>
      <li>You will ensure proper training for personnel handling our products</li>
      <li>You will maintain appropriate insurance coverage</li>
    </ul>
  </div>

  <div class="mui-card">
    <h2>Limited Warranty</h2>
    <p>Our products are provided with limited warranties as specified in product documentation. Warranties are void if products are misused, modified, or subjected to abnormal conditions.</p>

    <p>Our liability for any claim related to product defects is limited to the purchase price of the product. We are not liable for consequential or incidental damages.</p>
  </div>

  <div class="mui-card">
    <h2>Website Usage</h2>
    <h3>Content and Accuracy</h3>
    <p>While we strive to provide accurate information on our website, we make no warranties about the completeness, reliability, or accuracy of this information. Product specifications and availability may change without notice.</p>

    <h3>User Conduct</h3>
    <p>You agree not to use our website for any unlawful purpose or to solicit others to perform unlawful acts. You must not attempt to gain unauthorized access to our systems.</p>

    <h3>Intellectual Property</h3>
    <p>All content on our website, including text, graphics, logos, and software, is the property of RK Groups or our licensors and is protected by copyright and trademark laws.</p>
  </div>

  <div class="mui-card">
    <h2>Limitation of Liability</h2>
    <p>In no event shall RK Groups be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.</p>

    <p>Our total liability for any claim arising out of or relating to these terms or our services shall not exceed the amount paid by you for the specific service or product giving rise to the claim.</p>
  </div>

  <div class="mui-card">
    <h2>Indemnification</h2>
    <p>You agree to defend, indemnify, and hold harmless RK Groups and our officers, directors, employees, and agents from and against any claims, actions, or demands arising out of your use of our services or violation of these terms.</p>
  </div>

  <div class="mui-card">
    <h2>Governing Law</h2>
    <p>These Terms of Service shall be governed by and construed in accordance with the laws of Uttar Pradesh, India, without regard to its conflict of law provisions.</p>

    <p>Any disputes arising from these terms shall be resolved through the courts of Lucknow, Uttar Pradesh.</p>
  </div>

  <div class="mui-card">
    <h2>Changes to Terms</h2>
    <p>We reserve the right to modify these Terms of Service at any time. Changes will be effective immediately upon posting on our website. Your continued use of our services after changes are posted constitutes acceptance of the modified terms.</p>
  </div>

  <div class="mui-card">
    <h2>Contact Information</h2>
    <p>If you have any questions about these Terms of Service, please contact us:</p>
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