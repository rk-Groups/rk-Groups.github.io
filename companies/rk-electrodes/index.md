---
layout: default
title: RK Electrodes
description: "RK Electrodes — company overview and policies."
---

<div class="mui-hero mui-hero--bleed">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">build</span>
    </div>
    <h1 class="mui-hero-title">RK Electrodes</h1>
    <p class="mui-hero-subtitle">Overview and policies</p>
  </div>
</div>

<div class="mui-card">
  <h3>Policies</h3>
  <p>
    <a href="/companies/rk-electrodes/terms/">Terms of Service</a> •
    <a href="/companies/rk-electrodes/refund-policy/">Refund & Cancellation Policy</a>
  </p>
  {% assign main = site.data.companies['rk-electrodes'].main %}
  <div class="mui-info-grid" style="margin-top:16px;">
    <div class="mui-info-item"><strong>GSTIN:</strong><span>{{ main.gstin }}</span></div>
    <div class="mui-info-item"><strong>Constitution:</strong><span>{{ main.constitution }}</span></div>
    <div class="mui-info-item"><strong>Principal Place:</strong><span>{{ main.principal_place }}</span></div>
    <div class="mui-info-item"><strong>Proprietor:</strong><span>{{ main.proprietor }}</span></div>
    <div class="mui-info-item"><strong>Email:</strong><span><a href="mailto:{{ main.contact.email }}">{{ main.contact.email }}</a></span></div>
    <div class="mui-info-item"><strong>Phone:</strong><span><a href="tel:{{ main.contact.phone }}">{{ main.contact.phone }}</a></span></div>
  </div>
</div>
