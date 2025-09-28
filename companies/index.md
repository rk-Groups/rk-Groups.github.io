---
layout: default
title: Our Companies Network
description: "Discover RK Groups' diverse portfolio of industrial solutions including gases, welding equipment, real estate, and creative services across Uttar Pradesh."
breadcrumbs:
  - name: Home
    url: /
  - name: Companies
    url: /companies/
---

<div class="mui-hero">
  <div class="mui-hero__container">
    <div class="mui-hero__content">
      <h1>RK Groups Network</h1>
      <p>Comprehensive industrial solutions and services across Uttar Pradesh, India</p>
    </div>
  </div>
</div><!-- Enhanced Network Overview -->
<div class="mui-card mui-card--highlight" style="margin: 2rem 0;">
  <div class="mui-container">
    <div class="mui-network-overview">
      <div class="mui-network-stat">
        <div class="mui-stat-icon">
          <span class="material-icons">business</span>
        </div>
        <div class="mui-stat-number">{{ site.data.companies | size }}</div>
        <div class="mui-stat-label">Companies</div>
      </div>
      <div class="mui-network-stat">
        <div class="mui-stat-icon">
          <span class="material-icons">location_city</span>
        </div>
        <div class="mui-stat-number">
          {% assign total_branches = 0 %}
          {% for company_pair in site.data.companies %}
            {% assign company_key = company_pair[0] %}
            {% assign company_data = company_pair[1] %}
            {% for branch_pair in company_data %}
              {% assign branch_key = branch_pair[0] %}
              {% if branch_key != 'main' %}
                {% assign total_branches = total_branches | plus: 1 %}
              {% endif %}
            {% endfor %}
          {% endfor %}
          {{ total_branches }}
        </div>
        <div class="mui-stat-label">Branch Locations</div>
      </div>
      <div class="mui-network-stat">
        <div class="mui-stat-icon">
          <span class="material-icons">trending_up</span>
        </div>
        <div class="mui-stat-number">5+</div>
        <div class="mui-stat-label">Years Experience</div>
      </div>
      <div class="mui-network-stat">
        <div class="mui-stat-icon">
          <span class="material-icons">star</span>
        </div>
        <div class="mui-stat-number">24/7</div>
        <div class="mui-stat-label">Emergency Support</div>
      </div>
    </div>
  </div>
</div>

<!-- Companies Section -->
<div class="mui-companies-section" style="padding: 3rem 0;">
  <div class="mui-container">
    <div class="mui-section-header" style="text-align: center; margin-bottom: 3rem;">
      <h2 class="mui-section-title">Our Companies Portfolio</h2>
      <p class="mui-section-subtitle">Specialized solutions across multiple industries</p>
    </div>
    
    <div class="mui-companies-grid">
      {% for company_pair in site.data.companies %}
        {% assign company_key = company_pair[0] %}
        {% assign company = company_pair[1] %}
        {% assign company_name = company.main.name | default: company_key | replace: '-', ' ' | capitalize %}
        
        <div class="mui-card">
          <h3>{{ company_name }}</h3>
          <p><strong>GSTIN:</strong> {{ company.main.gstin | default: 'N/A' }}</p>
          {% if company.main.contact.email %}
          <p><strong>Email:</strong> {{ company.main.contact.email }}</p>
          {% endif %}
        </div>
      {% endfor %}
    </div>
  </div>
</div>

<!-- Featured Services Section -->
<div class="mui-features-section" style="background: var(--bg-primary); padding: 4rem 0; margin: 3rem 0;">
  <div class="mui-container">
    <div class="mui-section-header" style="text-align: center; margin-bottom: 3rem;">
      <h2 class="mui-section-title">Why Choose RK Groups?</h2>
      <p class="mui-section-subtitle">Comprehensive solutions with industry expertise</p>
    </div>
    
    <div class="mui-features-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem;">
      <div class="mui-feature-card" style="text-align: center; padding: 2rem; background: var(--bg-elevated); border-radius: var(--mui-radius); box-shadow: var(--shadow-sm); border: 1px solid var(--border-primary);">
        <div class="mui-feature-icon" style="background: linear-gradient(135deg, #2196F3, #1976D2); color: white; width: 4rem; height: 4rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
          <span class="material-icons" style="font-size: 2rem;">verified</span>
        </div>
        <h3 style="margin: 0 0 1rem 0; color: var(--text-primary);">Quality Assured</h3>
        <p style="margin: 0; color: var(--text-secondary); line-height: 1.6;">All products meet industry standards with proper certifications and quality checks.</p>
      </div>
      
      <div class="mui-feature-card" style="text-align: center; padding: 2rem; background: var(--bg-elevated); border-radius: var(--mui-radius); box-shadow: var(--shadow-sm); border: 1px solid var(--border-primary);">
        <div class="mui-feature-icon" style="background: linear-gradient(135deg, #4CAF50, #388E3C); color: white; width: 4rem; height: 4rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
          <span class="material-icons" style="font-size: 2rem;">support_agent</span>
        </div>
        <h3 style="margin: 0 0 1rem 0; color: var(--text-primary);">24/7 Support</h3>
        <p style="margin: 0; color: var(--text-secondary); line-height: 1.6;">Emergency support available for critical industrial operations and safety concerns.</p>
      </div>
      
      <div class="mui-feature-card" style="text-align: center; padding: 2rem; background: var(--bg-elevated); border-radius: var(--mui-radius); box-shadow: var(--shadow-sm); border: 1px solid var(--border-primary);">
        <div class="mui-feature-icon" style="background: linear-gradient(135deg, #FF9800, #F57C00); color: white; width: 4rem; height: 4rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
          <span class="material-icons" style="font-size: 2rem;">local_shipping</span>
        </div>
        <h3 style="margin: 0 0 1rem 0; color: var(--text-primary);">Fast Delivery</h3>
        <p style="margin: 0; color: var(--text-secondary); line-height: 1.6;">Quick and safe delivery across multiple locations in Uttar Pradesh.</p>
      </div>
      
      <div class="mui-feature-card" style="text-align: center; padding: 2rem; background: var(--bg-elevated); border-radius: var(--mui-radius); box-shadow: var(--shadow-sm); border: 1px solid var(--border-primary);">
        <div class="mui-feature-icon" style="background: linear-gradient(135deg, #9C27B0, #7B1FA2); color: white; width: 4rem; height: 4rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
          <span class="material-icons" style="font-size: 2rem;">handshake</span>
        </div>
        <h3 style="margin: 0 0 1rem 0; color: var(--text-primary);">Trusted Partner</h3>
        <p style="margin: 0; color: var(--text-secondary); line-height: 1.6;">Reliable business relationships built on trust and professional service delivery.</p>
      </div>
    </div>
  </div>
</div>

<!-- Enhanced Contact CTA -->
<div class="mui-cta-section" style="background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary)); padding: 4rem 0; color: white; text-align: center;">
  <div class="mui-container">
    <h2 style="margin: 0 0 1rem 0; font-size: 2.5rem;">Ready to Get Started?</h2>
    <p style="margin: 0 0 2rem 0; font-size: 1.2rem; opacity: 0.9;">Contact any of our companies for industrial gases, welding solutions, real estate, or creative services</p>
    <div class="mui-cta-actions" style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
      <a href="/Calc/" class="mui-btn mui-btn--outline mui-btn--large" style="background: rgba(255,255,255,0.1); border-color: rgba(255,255,255,0.3); color: white; text-decoration: none; display: flex; align-items: center; padding: 1rem 2rem; border-radius: 8px; backdrop-filter: blur(10px);">
        <span class="material-icons" style="margin-right: 0.5rem;">calculate</span>
        Use Our Calculators
      </a>
      <a href="/companies/rk-oxygen/gorakhpur/contact/" class="mui-btn mui-btn--primary mui-btn--large" style="background: rgba(255,255,255,0.2); color: white; text-decoration: none; display: flex; align-items: center; padding: 1rem 2rem; border-radius: 8px; backdrop-filter: blur(10px); border: none;">
        <span class="material-icons" style="margin-right: 0.5rem;">email</span>
        Contact Us Today
      </a>
    </div>
    
    <!-- Quick Contact Info -->
    <div class="mui-quick-contact" style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid rgba(255,255,255,0.2);">
      <div style="display: flex; justify-content: center; gap: 2rem; flex-wrap: wrap; font-size: 0.9rem;">
        <div style="display: flex; align-items: center; opacity: 0.9;">
          <span class="material-icons" style="margin-right: 0.5rem;">phone</span>
          +91-7355755506
        </div>
        <div style="display: flex; align-items: center; opacity: 0.9;">
          <span class="material-icons" style="margin-right: 0.5rem;">email</span>
          oxygen.rkgroup@gmail.com
        </div>
        <div style="display: flex; align-items: center; opacity: 0.9;">
          <span class="material-icons" style="margin-right: 0.5rem;">location_on</span>
          Lucknow, UP
        </div>
      </div>
    </div>
  </div>
</div>
