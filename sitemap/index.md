---
layout: default
title: Site Map - RK Groups
description: Complete site map of RK Groups website. Find all pages, companies, calculators, and resources organized by category.
---

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">map</span>
    </div>
    <h1 class="mui-hero-title">Site Map</h1>
    <p class="mui-hero-subtitle">Navigate through all RK Groups pages and resources</p>
  </div>
</div>

<div class="content-section">
  <div class="mui-card">
    <div class="sitemap-grid">
      <!-- Main Pages -->
      <div class="sitemap-section">
        <h2>
          <span class="material-icons">home</span>
          Main Pages
        </h2>
        <ul class="sitemap-list">
          <li><a href="/">Home</a></li>
          <li><a href="/companies/">Companies Network</a></li>
          <li><a href="/Calc/">Calculators Hub</a></li>
          <li><a href="/search/">Search</a></li>
          <li><a href="/contact/">Contact</a></li>
          <li><a href="/sitemap/">Site Map</a></li>
        </ul>
      </div>

      <!-- Companies -->
      <div class="sitemap-section">
        <h2>
          <span class="material-icons">business</span>
          Companies
        </h2>
        <ul class="sitemap-list">
          <li>
            <a href="/companies/rk-electrodes/">RK Electrodes</a>
            <ul class="sitemap-sublist">
              <li><a href="/companies/rk-electrodes/terms/">Terms of Service</a></li>
              <li><a href="/companies/rk-electrodes/refund-policy/">Refund Policy</a></li>
            </ul>
          </li>
          <li>
            <strong>RK Oxygen</strong>
            <ul class="sitemap-sublist">
              <li><a href="/companies/rk-oxygen/gorakhpur/">Gorakhpur Branch</a></li>
              <li><a href="/companies/rk-oxygen/gorakhpur/terms/">Terms of Service</a></li>
              <li><a href="/companies/rk-oxygen/gorakhpur/refund-policy/">Refund Policy</a></li>
              <li><a href="/companies/rk-oxygen/gorakhpur/privacy/">Privacy Policy</a></li>
              <li><a href="/companies/rk-oxygen/gorakhpur/shipping/">Shipping Policy</a></li>
              <li><a href="/companies/rk-oxygen/gorakhpur/contact/">Contact</a></li>
              <li><a href="/companies/rk-oxygen/lucknow/">Lucknow Branch</a></li>
              <li><a href="/companies/rk-oxygen/lucknow/terms/">Terms of Service</a></li>
              <li><a href="/companies/rk-oxygen/lucknow/refund-policy/">Refund Policy</a></li>
            </ul>
          </li>
          <li><a href="/companies/rk-palace/">RK Palace</a></li>
          <li>
            <a href="/companies/sand-creations/">Sand Creations</a>
            <ul class="sitemap-sublist">
              <li><a href="/companies/sand-creations/terms/">Terms of Service</a></li>
              <li><a href="/companies/sand-creations/refund-policy/">Refund Policy</a></li>
            </ul>
          </li>
        </ul>
      </div>

      <!-- Calculators -->
      <div class="sitemap-section">
        <h2>
          <span class="material-icons">calculate</span>
          Calculators
        </h2>
        <ul class="sitemap-list">
          <li><a href="/Calc/GST/">GST Calculator</a></li>
          <li><a href="/Calc/LIQ/">Liquid Calculator</a></li>
          <li><a href="/Calc/EMI/">EMI Calculator</a></li>
          <li><a href="/Calc/CI/">Compound Interest Calculator</a></li>
        </ul>
      </div>

      <!-- Legal & Info -->
      <div class="sitemap-section">
        <h2>
          <span class="material-icons">gavel</span>
          Legal & Information
        </h2>
        <ul class="sitemap-list">
          <li><a href="/terms/">Terms of Service</a></li>
          <li><a href="/privacy/">Privacy Policy</a></li>
          <li><a href="/companies/rk-oxygen/gorakhpur/terms/">Terms of Service (RK Oxygen)</a></li>
          <li><a href="/companies/rk-oxygen/gorakhpur/refund-policy/">Refund Policy (RK Oxygen)</a></li>
          <li><a href="/sitemap.xml">XML Sitemap</a></li>
          <li><a href="/feed.xml">RSS Feed</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>

<style>
.sitemap-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.sitemap-section {
  background: var(--bg-elevated);
  border: 1px solid var(--border-primary);
  border-radius: var(--mui-radius);
  padding: 1.5rem;
}

.sitemap-section h2 {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin: 0 0 1rem 0;
  color: var(--text-primary);
  font-size: 1.25rem;
  border-bottom: 1px solid var(--border-primary);
  padding-bottom: 0.5rem;
}

.sitemap-section .material-icons {
  color: var(--accent-primary);
}

.sitemap-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sitemap-list li {
  margin-bottom: 0.5rem;
}

.sitemap-list a {
  color: var(--text-secondary);
  text-decoration: none;
  transition: color 0.2s ease;
}

.sitemap-list a:hover {
  color: var(--accent-primary);
}

.sitemap-sublist {
  margin-left: 1rem;
  margin-top: 0.5rem;
  padding-left: 1rem;
  border-left: 2px solid var(--border-primary);
}

.sitemap-sublist li {
  margin-bottom: 0.25rem;
  font-size: 0.9rem;
}

.sitemap-sublist a {
  color: var(--text-tertiary);
}

@media (max-width: 768px) {
  .sitemap-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  .sitemap-section {
    padding: 1rem;
  }
}
</style>