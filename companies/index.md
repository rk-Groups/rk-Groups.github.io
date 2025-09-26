---
layout: default
title: Our Companies Network
breadcrumbs:
  - name: Home
    url: /
  - name: Companies
    url: /companies/
---

<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">business</span>
    </div>
    <h1 class="mui-hero-title">Our Companies Network</h1>
    <p class="mui-hero-subtitle">Discover our diverse portfolio of industrial solutions and services across Uttar Pradesh</p>
  </div>
</div>

<!-- Network Overview -->
<div class="mui-card mui-card--highlight">
  <div class="mui-container">
    <div class="mui-network-overview">
      <div class="mui-network-stat">
        <div class="mui-stat-number">{{ site.data.companies | size }}</div>
        <div class="mui-stat-label">Companies</div>
      </div>
      <div class="mui-network-stat">
        <div class="mui-stat-number">
          {% assign total_branches = 0 %}
          {% for company in site.data.companies %}
            {% assign company_data = site.data.companies[company[0]] %}
            {% for branch in company_data %}
              {% if branch[0] != 'main' %}
                {% assign total_branches = total_branches | plus: 1 %}
              {% endif %}
            {% endfor %}
          {% endfor %}
          {{ total_branches }}
        </div>
        <div class="mui-stat-label">Locations</div>
      </div>
      <div class="mui-network-stat">
        <div class="mui-stat-number">4+</div>
        <div class="mui-stat-label">Years Experience</div>
      </div>
    </div>
  </div>
</div>

<!-- Companies Section -->
<div class="mui-companies-section">
  <div class="mui-container">
    <h2 class="mui-section-title">Our Companies</h2>
    <div class="mui-companies-grid">
      {% for company_key in site.data.companies %}
        {% assign company = site.data.companies[company_key[0]] %}
        {% assign company_name = company.main.name | default: company_key[0] | replace: '-', ' ' | capitalize %}

        <div class="mui-company-card">
          <div class="mui-company-header">
            {% if company_key[0] == 'rk-oxygen' %}
              <span class="material-icons mui-company-icon">local_shipping</span>
            {% elsif company_key[0] == 'rk-electrodes' %}
              <span class="material-icons mui-company-icon">build</span>
            {% elsif company_key[0] == 'rk-palace' %}
              <span class="material-icons mui-company-icon">home</span>
            {% elsif company_key[0] == 'sand-creations' %}
              <span class="material-icons mui-company-icon">palette</span>
            {% else %}
              <span class="material-icons mui-company-icon">business</span>
            {% endif %}
            <div class="mui-company-title">
              <h3>{{ company_name }}</h3>
              {% if company_key[0] == 'rk-oxygen' %}
                <p class="mui-company-tagline">Industrial Gases & Medical Oxygen</p>
              {% elsif company_key[0] == 'rk-electrodes' %}
                <p class="mui-company-tagline">Welding Solutions & Equipment</p>
              {% elsif company_key[0] == 'rk-palace' %}
                <p class="mui-company-tagline">Real Estate & Property</p>
              {% elsif company_key[0] == 'sand-creations' %}
                <p class="mui-company-tagline">Creative Design & Artistry</p>
              {% endif %}
            </div>
          </div>

          <div class="mui-company-actions">
            <a href="/companies/{{ company_key[0] }}/" class="mui-btn mui-btn--primary">
              <span class="material-icons">business</span>
              View Company
            </a>
            <div class="mui-company-links">
              <a href="/companies/{{ company_key[0] }}/terms/" class="mui-link">
                <span class="material-icons">description</span>
                Terms
              </a>
              <a href="/companies/{{ company_key[0] }}/refund-policy/" class="mui-link">
                <span class="material-icons">refund</span>
                Refunds
              </a>
            </div>
          </div>

          {% assign branch_count = 0 %}
          {% for branch_key in company %}
            {% if branch_key[0] != 'main' %}
              {% assign branch_count = branch_count | plus: 1 %}
            {% endif %}
          {% endfor %}

          {% if branch_count > 0 %}
            <div class="mui-company-branches">
              <h4>
                <span class="material-icons">location_on</span>
                {{ branch_count }} Location{{ branch_count > 1 ? 's' : '' }}
              </h4>
              <div class="mui-branches-list">
                {% for branch_key in company %}
                  {% if branch_key[0] != 'main' %}
                    <div class="mui-branch-item">
                      <div class="mui-branch-info">
                        <strong>{{ company[branch_key[0]].name | default: branch_key[0] | capitalize }}</strong>
                        {% if company[branch_key[0]].contact and company[branch_key[0]].contact.phone %}
                          <span class="mui-branch-contact">{{ company[branch_key[0]].contact.phone }}</span>
                        {% endif %}
                      </div>
                      <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/" class="mui-btn mui-btn--outline mui-btn--small">
                        <span class="material-icons">arrow_forward</span>
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

<!-- Contact CTA -->
<div class="mui-cta-section">
  <div class="mui-container">
    <h2>Need Our Services?</h2>
    <p>Get in touch with any of our companies for industrial gases, welding solutions, or other services</p>
    <div class="mui-cta-actions">
      <a href="/Calc/" class="mui-btn mui-btn--outline mui-btn--large">
        <span class="material-icons">calculate</span>
        Use Calculators
      </a>
      <a href="/companies/rk-oxygen/gorakhpur/contact/" class="mui-btn mui-btn--primary mui-btn--large">
        <span class="material-icons">email</span>
        Contact Us
      </a>
    </div>
  </div>
</div>
