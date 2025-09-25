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
      <span class="material-icons" style="font-size: 4rem;">factory</span>
    </div>
    <h1 class="mui-hero-title">Our Companies Network</h1>
    <p class="mui-hero-subtitle">Explore all companies and their branches across RK Groups</p>
  </div>

</div>

<h2 id="companies-section" class="mui-section-title">Company Overview</h2>
<div class="mui-features" role="region" aria-labelledby="companies-section">
  <div class="mui-features-grid">
    {% for company_key in site.data.companies %}
      {% assign company = site.data.companies[company_key[0]] %}
      {% assign company_name = company.main.name | default: company_key[0] | replace: '-', ' ' | capitalize %}
      <div class="mui-feature-card">
        <span class="material-icons mui-feature-icon">domain</span>
        <h3>{{ company_name }}</h3>
        <p class="mui-text-muted">Quick links</p>
        <p>
          <a href="/companies/{{ company_key[0] }}/">Main Page</a>
          &nbsp;•&nbsp;
          <a href="/companies/{{ company_key[0] }}/terms/">Terms</a>
          &nbsp;•&nbsp;
          <a href="/companies/{{ company_key[0] }}/refund-policy/">Refund Policy</a>
        </p>
        {% for branch_key in company %}
          {% if branch_key[0] != 'main' %}
            <p>
              <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/">{{ company[branch_key[0]].name | default: branch_key[0] | capitalize }} Branch</a>
              &nbsp;•&nbsp;
              <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/terms/">Terms</a>
              &nbsp;•&nbsp;
              <a href="/companies/{{ company_key[0] }}/{{ branch_key[0] }}/refund-policy/">Refund Policy</a>
            </p>
          {% endif %}
        {% endfor %}
      </div>
    {% endfor %}
  </div>
</div>
