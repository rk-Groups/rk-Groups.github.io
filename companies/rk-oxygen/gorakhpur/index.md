---
layout: default
title: RK Oxygen - Gorakhpur Branch
---

{% assign details = site.data.companies.rk-oxygen.gorakhpur %}

<div class="mui-container">
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
	<tr><th>Contact Email</th><td><a href="mailto:{{ details.contact.email }}">{{ details.contact.email }}</a></td></tr>
	{% if details.contact.phone %}
		<tr><th>Contact Phone</th><td><a href="tel:{{ details.contact.phone }}">{{ details.contact.phone }}</a></td></tr>
	{% endif %}
</table>
