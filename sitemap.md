---
layout: default
title: "Site Map"
description: "Complete navigation map for RK Groups multi-company website with all pages and sections"
---

# Site Map

A complete overview of all content available on the RK Groups website.

## Main Navigation

### 🏠 Home
- [Home]({{ "/" | relative_url }}) - Main landing page

### 🏢 Companies
- [All Companies]({{ "/companies/" | relative_url }}) - Complete network overview
{% for company_pair in site.data.companies %}
  {% assign key = company_pair[0] %}
  {% assign company = company_pair[1] %}
  {% assign main = company.main %}
  - [{{ main.name }}]({{ "/companies/" | append: key | append: "/" | relative_url }})
  {% for branch_pair in company %}
    {% unless branch_pair[0] == "main" %}
      {% assign branch_key = branch_pair[0] %}
      {% assign branch = branch_pair[1] %}
      - [{{ branch.name | default: main.name }} ({{ branch_key | capitalize }})]({{ "/companies/" | append: key | append: "/" | append: branch_key | append: "/" | relative_url }})
    {% endunless %}
  {% endfor %}
{% endfor %}

### 🧮 Calculators
- [Calculators Hub]({{ "/Calc/" | relative_url }}) - All business calculators
- [GST Calculator]({{ "/Calc/GST/" | relative_url }}) - GST calculations
- [Liquid Calculator]({{ "/Calc/LIQ/" | relative_url }}) - Liquid conversions
- [EMI Calculator]({{ "/Calc/EMI/" | relative_url }}) - Loan calculations

## All Pages

{% for page in site.pages %}
  {% if page.title %}
    - [{{ page.title }}]({{ page.url | relative_url }}) {% if page.description %}— {{ page.description }}{% endif %}
  {% endif %}
{% endfor %}

---

*This sitemap is automatically generated from site data and navigation structure.*