---
layout: default
title: Contact Us - RK Oxygen Gorakhpur
description: Contact RK Oxygen Gorakhpur for industrial gases and welding supplies. Get in touch for inquiries, orders, and support.
company: rk-oxygen
branch: gorakhpur
---

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">contact_phone</span>
    </div>
    <h1 class="mui-hero-title">Contact Us</h1>
    <p class="mui-hero-subtitle">RK Oxygen Gorakhpur - Your trusted partner for industrial gases</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <h2>
      <span class="material-icons">location_on</span>
      Get In Touch
    </h2>

    <div class="contact-grid">
      <!-- Contact Information -->
      <div class="contact-info">
        <div class="info-item">
          <span class="material-icons">business</span>
          <div class="info-content">
            <h4>Address</h4>
            <p>85, RK Palace<br>Gangaprasad Road, Rakabganj<br>Lucknow – 226018<br>Uttar Pradesh, India</p>
          </div>
        </div>

        <div class="info-item">
          <span class="material-icons">phone</span>
          <div class="info-content">
            <h4>Phone</h4>
            <p><a href="tel:+917355755506">+91-7355755506</a></p>
          </div>
        </div>

        <div class="info-item">
          <span class="material-icons">email</span>
          <div class="info-content">
            <h4>Email</h4>
            <p><a href="mailto:gkp.rkoxygen@gmail.com">gkp.rkoxygen@gmail.com</a></p>
          </div>
        </div>

        <div class="info-item">
          <span class="material-icons">schedule</span>
          <div class="info-content">
            <h4>GST Number</h4>
            <p>09AAHFRK2019P1Z8</p>
          </div>
        </div>
      </div>

      <!-- Business Hours -->
      <div class="business-hours">
        <h4>
          <span class="material-icons">access_time</span>
          Business Hours
        </h4>
        <div class="hours-grid">
          <div class="hours-item">
            <span class="hours-day">Monday - Friday</span>
            <span class="hours-time open">9:00 AM - 6:00 PM</span>
          </div>
          <div class="hours-item">
            <span class="hours-day">Saturday</span>
            <span class="hours-time open">9:00 AM - 2:00 PM</span>
          </div>
          <div class="hours-item">
            <span class="hours-day">Sunday</span>
            <span class="hours-time">Closed</span>
          </div>
          <div class="hours-item">
            <span class="hours-day">Public Holidays</span>
            <span class="hours-time">Closed</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
      <a href="tel:+917355755506" class="action-btn">
        <span class="material-icons">call</span>
        Call Now
      </a>
      <a href="mailto:gkp.rkoxygen@gmail.com" class="action-btn">
        <span class="material-icons">email</span>
        Send Email
      </a>
      <a href="https://wa.me/917355755506" class="action-btn">
        <span class="material-icons">chat</span>
        WhatsApp
      </a>
      <a href="/contact/" class="action-btn">
        <span class="material-icons">contact_mail</span>
        Contact Form
      </a>
    </div>
  </div>

  <!-- Emergency Contact -->
  <div class="emergency-contact">
    <h4>
      <span class="material-icons">warning</span>
      Emergency Contact
    </h4>
    <p>For urgent gas supply requirements or safety emergencies, please call our 24/7 emergency line immediately. We prioritize safety and will respond to all emergency situations.</p>
    <p><strong>Emergency Phone:</strong> <a href="tel:+917355755506" style="color: var(--accent-danger); font-weight: 500;">+91-7355755506</a></p>
  </div>

  <!-- Map Section -->
  <div class="mui-card map-section">
    <h2>
      <span class="material-icons">map</span>
      Location Map
    </h2>
    <div class="map-placeholder">
      <span class="material-icons" style="font-size: 3rem; color: var(--text-secondary); margin-bottom: 1rem;">location_on</span>
      <h3 style="margin: 0 0 1rem 0; color: var(--text);">RK Palace, Lucknow</h3>
      <p>Located in the heart of Lucknow's business district, easily accessible from all major roads and transportation hubs.</p>
      <p style="margin: 1rem 0 0 0; font-size: 0.9rem;">
        <strong>Landmarks:</strong> Near Rakabganj, close to major hospitals, educational institutions, and commercial areas.
      </p>
    </div>
  </div>

  <!-- Additional Information -->
  <div class="mui-card">
    <h2>
      <span class="material-icons">info</span>
      Additional Information
    </h2>
    <div style="display: grid; gap: 1rem;">
      <div>
        <h3>Service Areas</h3>
        <p>We serve customers across Uttar Pradesh, with particular focus on Gorakhpur, Lucknow, and surrounding districts. We provide reliable delivery services to ensure timely supply of industrial gases.</p>
      </div>

      <div>
        <h3>Technical Support</h3>
        <p>Our experienced team provides technical consultation for gas selection, equipment setup, and safety procedures. Contact us for expert advice on your industrial gas requirements.</p>
      </div>

      <div>
        <h3>Quality Assurance</h3>
        <p>All our gases meet industry standards and undergo rigorous quality testing. We maintain certifications and follow best practices to ensure product safety and reliability.</p>
      </div>
    </div>
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
