---
layout: default
title: Site Map - RK Groups
description: "Complete sitemap of RK Groups website showing all companies, calculators, policies, and business pages for easy navigation."
---

# Site Map

<div class="mui-container">
  <h2>Main Navigation</h2>
  <ul class="mui-sitemap-list">
    <li><a href="{{ '/' | relative_url }}">🏠 Home</a></li>

    <!-- Companies Section - Dynamic from navigation data -->
    <li>
      <strong>🏢 Companies</strong>
      <ul>
        {% assign companies = site.data.navigation.main | where: "title", "Companies" | first %}
        {% for company in companies.dropdown %}
          <li><a href="{{ company.url | relative_url }}">{{ company.title }}</a></li>
        {% endfor %}

        <!-- Company-specific pages from sidebar data -->
        {% for company_group in site.data.navigation.sidebar %}
          {% assign company_name = company_group[0] %}
          {% assign company_sections = company_group[1] %}
          <li>
            <strong>{{ company_name | replace: '-', ' ' | capitalize }}</strong>
            <ul>
              {% for section in company_sections %}
                <li>
                  <strong>{{ section.title }}</strong>
                  <ul>
                    <li><a href="{{ section.url | relative_url }}">Main Page</a></li>
                    {% if section.children %}
                      {% for child in section.children %}
                        <li><a href="{{ child.url | relative_url }}">{{ child.title }}</a></li>
                      {% endfor %}
                    {% endif %}
                  </ul>
                </li>
              {% endfor %}
            </ul>
          </li>
        {% endfor %}
      </ul>
    </li>

    <!-- Calculators Section - Dynamic from navigation data -->
    <li>
      <strong>🧮 Calculators</strong>
      <ul>
        {% assign calculators = site.data.navigation.main | where: "title", "Calculators" | first %}
        {% for calc in calculators.dropdown %}
          <li><a href="{{ calc.url | relative_url }}">{{ calc.title }}</a></li>
        {% endfor %}
      </ul>
    </li>

    <!-- Additional main navigation items -->
    {% for item in site.data.navigation.main %}
      {% unless item.dropdown or item.title == "Home" or item.title == "Companies" or item.title == "Calculators" %}
        <li><a href="{{ item.url | relative_url }}">{{ item.title }}</a></li>
      {% endunless %}
    {% endfor %}
  </ul>

  <!-- All Pages Section - Dynamic from site pages -->
  <h2>All Site Pages</h2>
  <ul class="mui-sitemap-list">
    {% assign sorted_pages = site.pages | sort: 'url' %}
    {% for page in sorted_pages %}
      {% unless page.url contains '/dev/' or page.url == '/404.html' or page.url == '/sitemap/' %}
        <li>
          <a href="{{ page.url | relative_url }}">
            {% if page.title %}
              {{ page.title }}
            {% else %}
              {{ page.url | remove: '/index.html' | remove: '.html' | split: '/' | last | default: 'Home' | capitalize }}
            {% endif %}
          </a>
          <small class="mui-text-muted"> - {{ page.url }}</small>
        </li>
      {% endunless %}
    {% endfor %}
  </ul>

  <h2>Development & Admin</h2>
  <ul class="mui-sitemap-list">
    {% for page in site.pages %}
      {% if page.url contains '/dev/' %}
        <li>
          <a href="{{ page.url | relative_url }}">
            {% if page.url contains 'TODO' %}📋{% elsif page.url contains 'COMPLETED' %}✅{% elsif page.url contains 'RULES' %}📝{% else %}📄{% endif %}
            {{ page.title | default: page.name | remove: '.md' }}
          </a>
        </li>
      {% endif %}
    {% endfor %}
    <li><a href="{{ '/README.md' | relative_url }}">📖 README</a></li>
  </ul>

  <p class="mui-text-muted">
    <em>Last updated: {{ 'now' | date: '%B %d, %Y at %I:%M %p' }} (dynamically generated)</em>
  </p>
</div>
