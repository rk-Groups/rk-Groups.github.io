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

<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">corporate_fare</span>
    </div>
    <h1 class="mui-hero-title">RK Groups Network</h1>
    <p class="mui-hero-subtitle">Comprehensive industrial solutions and services across Uttar Pradesh, India</p>
    <div class="mui-hero-badges">
      <span class="mui-badge">
        <span class="material-icons">verified</span>
        Established 2020
      </span>
      <span class="mui-badge">
        <span class="material-icons">location_on</span>
        Multi-Location
      </span>
      <span class="mui-badge">
        <span class="material-icons">handshake</span>
        Trusted Partners
      </span>
    </div>
  </div>
</div>

<!-- Enhanced Network Overview -->
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
    
    <div class="mui-companies-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 2rem;">
      {% for company_pair in site.data.companies %}
        {% assign company_key = company_pair[0] %}
        {% assign company = company_pair[1] %}
        {% assign company_name = company.main.name | default: company_key | replace: '-', ' ' | capitalize %}

        <div class="mui-company-card" style="background: var(--bg-elevated); border-radius: var(--mui-radius); padding: 2rem; box-shadow: var(--shadow-md); transition: all 0.3s ease; border: 1px solid var(--border-primary);">
          <div class="mui-company-header" style="display: flex; align-items: flex-start; margin-bottom: 1.5rem;">
            {% if company_key == 'rk-oxygen' %}
              <div class="mui-company-icon" style="background: linear-gradient(135deg, #2196F3, #1976D2); color: white; padding: 1rem; border-radius: 12px; margin-right: 1rem; box-shadow: 0 4px 12px rgba(33, 150, 243, 0.3);">
                <span class="material-icons" style="font-size: 2rem;">local_gas_station</span>
              </div>
            {% elsif company_key == 'rk-electrodes' %}
              <div class="mui-company-icon" style="background: linear-gradient(135deg, #FF9800, #F57C00); color: white; padding: 1rem; border-radius: 12px; margin-right: 1rem; box-shadow: 0 4px 12px rgba(255, 152, 0, 0.3);">
                <span class="material-icons" style="font-size: 2rem;">build_circle</span>
              </div>
            {% elsif company_key == 'rk-palace' %}
              <div class="mui-company-icon" style="background: linear-gradient(135deg, #4CAF50, #388E3C); color: white; padding: 1rem; border-radius: 12px; margin-right: 1rem; box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);">
                <span class="material-icons" style="font-size: 2rem;">apartment</span>
              </div>
            {% elsif company_key == 'sand-creations' %}
              <div class="mui-company-icon" style="background: linear-gradient(135deg, #9C27B0, #7B1FA2); color: white; padding: 1rem; border-radius: 12px; margin-right: 1rem; box-shadow: 0 4px 12px rgba(156, 39, 176, 0.3);">
                <span class="material-icons" style="font-size: 2rem;">palette</span>
              </div>
            {% else %}
              <div class="mui-company-icon" style="background: linear-gradient(135deg, #607D8B, #455A64); color: white; padding: 1rem; border-radius: 12px; margin-right: 1rem; box-shadow: 0 4px 12px rgba(96, 125, 139, 0.3);">
                <span class="material-icons" style="font-size: 2rem;">business</span>
              </div>
            {% endif %}
            
            <div class="mui-company-title" style="flex: 1;">
              <h3 style="margin: 0 0 0.5rem 0; font-size: 1.5rem; color: var(--text-primary);">{{ company_name }}</h3>
              {% if company_key == 'rk-oxygen' %}
                <p class="mui-company-tagline" style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">Industrial & Medical Gases Supply</p>
                <div class="mui-company-specialties" style="display: flex; gap: 0.5rem; margin-top: 0.5rem;">
                  <span class="mui-tag" style="background: rgba(33, 150, 243, 0.1); color: #2196F3; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Oxygen</span>
                  <span class="mui-tag" style="background: rgba(33, 150, 243, 0.1); color: #2196F3; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Nitrogen</span>
                  <span class="mui-tag" style="background: rgba(33, 150, 243, 0.1); color: #2196F3; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Argon</span>
                </div>
              {% elsif company_key == 'rk-electrodes' %}
                <p class="mui-company-tagline" style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">Welding Solutions & Equipment</p>
                <div class="mui-company-specialties" style="display: flex; gap: 0.5rem; margin-top: 0.5rem;">
                  <span class="mui-tag" style="background: rgba(255, 152, 0, 0.1); color: #FF9800; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Electrodes</span>
                  <span class="mui-tag" style="background: rgba(255, 152, 0, 0.1); color: #FF9800; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Welding</span>
                </div>
              {% elsif company_key == 'rk-palace' %}
                <p class="mui-company-tagline" style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">Real Estate & Property Development</p>
                <div class="mui-company-specialties" style="display: flex; gap: 0.5rem; margin-top: 0.5rem;">
                  <span class="mui-tag" style="background: rgba(76, 175, 80, 0.1); color: #4CAF50; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Properties</span>
                  <span class="mui-tag" style="background: rgba(76, 175, 80, 0.1); color: #4CAF50; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Development</span>
                </div>
              {% elsif company_key == 'sand-creations' %}
                <p class="mui-company-tagline" style="margin: 0; color: var(--text-secondary); font-size: 0.9rem;">Creative Design & Digital Artistry</p>
                <div class="mui-company-specialties" style="display: flex; gap: 0.5rem; margin-top: 0.5rem;">
                  <span class="mui-tag" style="background: rgba(156, 39, 176, 0.1); color: #9C27B0; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Design</span>
                  <span class="mui-tag" style="background: rgba(156, 39, 176, 0.1); color: #9C27B0; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem;">Art</span>
                </div>
              {% endif %}
            </div>
          </div>

          <!-- Company Info Section -->
          {% if company.main.gstin %}
          <div class="mui-company-info" style="background: var(--bg-primary); padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; border: 1px solid var(--border-secondary);">
            <div style="display: flex; align-items: center; margin-bottom: 0.5rem;">
              <span class="material-icons" style="font-size: 1rem; margin-right: 0.5rem; color: var(--text-secondary);">verified_user</span>
              <span style="font-size: 0.85rem; color: var(--text-secondary);">GSTIN: {{ company.main.gstin }}</span>
            </div>
            {% comment %}{% if company.main.contact and company.main.contact.phone %}
            <div style="display: flex; align-items: center;">
              <span class="material-icons" style="font-size: 1rem; margin-right: 0.5rem; color: var(--text-secondary);">phone</span>
              <span style="font-size: 0.85rem; color: var(--text-secondary);">{{ company.main.contact.phone }}</span>
            </div>
            {% endif %}{% endcomment %}
          </div>
          {% endif %}

          <div class="mui-company-actions" style="display: flex; gap: 1rem; margin-bottom: 1.5rem;">
            <a href="/companies/{{ company_key }}/" class="mui-btn mui-btn--primary" style="flex: 1; display: flex; align-items: center; justify-content: center; text-decoration: none; padding: 0.75rem; border-radius: 8px;">
              <span class="material-icons" style="margin-right: 0.5rem;">storefront</span>
              View Company
            </a>
            <div class="mui-company-links" style="display: flex; gap: 0.5rem;">
              <a href="/companies/{{ company_key }}/terms/" class="mui-link" title="Terms of Service" style="display: flex; align-items: center; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: 8px; text-decoration: none; color: var(--text-secondary);">
                <span class="material-icons">description</span>
              </a>
              <a href="/companies/{{ company_key }}/refund-policy/" class="mui-link" title="Refund Policy" style="display: flex; align-items: center; padding: 0.75rem; border: 1px solid var(--border-primary); border-radius: 8px; text-decoration: none; color: var(--text-secondary);">
                <span class="material-icons">policy</span>
              </a>
            </div>
          </div>

          {% assign branch_count = 0 %}
          {% for branch_pair in company %}
            {% assign branch_key = branch_pair[0] %}
            {% if branch_key != 'main' %}
              {% assign branch_count = branch_count | plus: 1 %}
            {% endif %}
          {% endfor %}

          {% if branch_count > 0 %}
            <div class="mui-company-branches" style="border-top: 1px solid var(--border-secondary); padding-top: 1.5rem;">
              <h4 style="display: flex; align-items: center; margin: 0 0 1rem 0; color: var(--text-primary); font-size: 1.1rem;">
                <span class="material-icons" style="margin-right: 0.5rem; color: var(--accent-primary);">location_on</span>
                {{ branch_count }} Branch Location{% if branch_count > 1 %}s{% endif %}
              </h4>
              <div class="mui-branches-list" style="display: flex; flex-direction: column; gap: 0.75rem;">
                {% for branch_pair in company %}
                  {% assign branch_key = branch_pair[0] %}
                  {% assign branch_data = branch_pair[1] %}
                  {% if branch_key != 'main' %}
                    <div class="mui-branch-item" style="display: flex; justify-content: space-between; align-items: center; padding: 1rem; background: var(--bg-primary); border-radius: 8px; border: 1px solid var(--border-secondary);">
                      <div class="mui-branch-info" style="flex: 1;">
                        <strong style="color: var(--text-primary); display: block; margin-bottom: 0.25rem;">{{ branch_data.name | default: branch_key | capitalize }}</strong>
                        {% comment %}{% if branch_data.contact and branch_data.contact.phone %}
                          <div style="display: flex; align-items: center; color: var(--text-secondary); font-size: 0.9rem;">
                            <span class="material-icons" style="font-size: 1rem; margin-right: 0.5rem;">phone</span>
                            {{ branch_data.contact.phone }}
                          </div>
                        {% endif %}{% endcomment %}
                        {% comment %}{% if branch_data.contact and branch_data.contact.address %}
                          <div style="display: flex; align-items: flex-start; color: var(--text-secondary); font-size: 0.85rem; margin-top: 0.25rem;">
                            <span class="material-icons" style="font-size: 1rem; margin-right: 0.5rem; margin-top: -0.1rem;">place</span>
                            <span>{{ branch_data.contact.address | truncate: 60 }}</span>
                          </div>
                        {% endif %}{% endcomment %}
                      </div>
                      <a href="/companies/{{ company_key }}/{{ branch_key }}/" class="mui-btn mui-btn--outline mui-btn--small" style="margin-left: 1rem; display: flex; align-items: center; text-decoration: none; padding: 0.5rem 1rem; border-radius: 6px;">
                        <span class="material-icons" style="font-size: 1rem; margin-right: 0.25rem;">arrow_forward</span>
                        Visit
                      </a>
                    </div>
                  {% endif %}
                {% endfor %}
              </div>
            </div>
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
