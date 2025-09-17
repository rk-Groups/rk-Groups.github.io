---
layout: default
title: RK Oxygen - Gorakhpur Branch
description: "RK Oxygen Gorakhpur branch - Industrial gases, oxygen, nitrogen, and welding solutions. GSTIN: 09ABAFR4114P1ZX. Located in GIDA, Gorakhpur, Uttar Pradesh."
---

{% assign details = site.data.companies.rk-oxygen.gorakhpur %}

<div class="mui-card">
  <h1 class="mui-card-title">🏭 RK Oxygen — Gorakhpur Branch</h1>

  <div class="mui-branch-switcher">
    <h3>Switch Branch</h3>
    <div class="mui-btn-group">
      <a class="mui-btn mui-btn--primary" href="/companies/rk-oxygen/gorakhpur/">Gorakhpur</a>
      <a class="mui-btn mui-btn--outline" href="/companies/rk-oxygen/lucknow/">Lucknow</a>
    </div>
  </div>

  <div class="mui-company-details">
    <h3>Company Information</h3>
    <div class="mui-info-grid">
      <div class="mui-info-item">
        <strong>GSTIN:</strong>
        <span>{{ details.gstin }}</span>
      </div>
      <div class="mui-info-item">
        <strong>Constitution:</strong>
        <span>{{ details.constitution }}</span>
      </div>
      <div class="mui-info-item">
        <strong>Principal Place:</strong>
        <span>{{ details.principal_place }}</span>
      </div>
      {% if details.branch_address %}
      <div class="mui-info-item">
        <strong>Branch Address:</strong>
        <span>{{ details.branch_address }}</span>
      </div>
      {% endif %}
      {% if details.proprietor %}
      <div class="mui-info-item">
        <strong>Proprietor:</strong>
        <span>{{ details.proprietor }}</span>
      </div>
      {% endif %}
      {% if details.partners and details.partners.size > 0 %}
      <div class="mui-info-item">
        <strong>Partners:</strong>
        <span>{{ details.partners | join: ', ' }}</span>
      </div>
      {% endif %}
      {% if details.contact and details.contact.email %}
      <div class="mui-info-item">
        <strong>Contact Email:</strong>
        <span><a href="mailto:{{ details.contact.email }}">{{ details.contact.email }}</a></span>
      </div>
      {% endif %}
      {% if details.contact and details.contact.phone %}
      <div class="mui-info-item">
        <strong>Contact Phone:</strong>
        <span><a href="tel:{{ details.contact.phone }}">{{ details.contact.phone }}</a></span>
      </div>
      {% endif %}
    </div>
  </div>
