---
layout: default
title: Site Search
description: Search across all RK Groups pages, companies, calculators, and resources.
---

<div class="mui-hero">
  <div class="mui-hero-content">
    <div class="mui-hero-icon">
      <span class="material-icons" style="font-size: 4rem;">search</span>
    </div>
    <h1 class="mui-hero-title">Search RK Groups</h1>
    <p class="mui-hero-subtitle">Find companies, calculators, policies, and resources</p>
  </div>
</div>

<div class="mui-card">
  <div class="search-container">
    <!-- Search Input -->
    <div class="search-input-wrapper">
      <div class="search-input-container">
        <span class="material-icons search-icon">search</span>
        <input
          type="text"
          id="search-input"
          placeholder="Search for companies, calculators, policies..."
          autocomplete="off"
          aria-label="Search RK Groups"
          class="search-input"
        >
        <button
          id="search-clear"
          class="search-clear"
          aria-label="Clear search"
          style="display: none;"
        >
          <span class="material-icons">clear</span>
        </button>
      </div>

      <!-- Search Suggestions -->
      <div id="search-suggestions" class="search-suggestions" style="display: none;"></div>
    </div>

    <!-- Search Results -->
    <div id="search-results" class="search-results" style="display: none;"></div>

    <!-- Loading Indicator -->
    <div id="search-loading" class="search-loading" style="display: none;">
      <div class="loading-spinner"></div>
      <p>Searching...</p>
    </div>

    <!-- Popular Searches -->
    <div class="popular-searches">
      <h3>Popular Searches</h3>
      <div class="popular-search-tags">
        <button class="search-tag mui-btn mui-btn--outline" data-query="GST calculator">GST Calculator</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="RK Oxygen">RK Oxygen</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="contact">Contact Information</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="terms">Terms & Policies</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="Gorakhpur">Gorakhpur Branch</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="welding">Welding Equipment</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="industrial gases">Industrial Gases</button>
        <button class="search-tag mui-btn mui-btn--outline" data-query="calculators">All Calculators</button>
      </div>
    </div>

    <!-- Search Tips -->
    <div class="search-tips">
      <h4>Search Tips</h4>
      <ul>
        <li>Use specific terms like "GST calculator" or "RK Oxygen Gorakhpur"</li>
        <li>Search for company names, services, or locations</li>
        <li>Find policies, terms, and contact information</li>
        <li>Results are ranked by relevance</li>
      </ul>
    </div>
  </div>
</div>

<!-- Load Search Dependencies -->
<script src="https://unpkg.com/lunr@2.3.9/lunr.min.js"></script>
{% if jekyll.environment == "production" %}
<script src="{{ '/assets/js/search.min.js' | relative_url }}"></script>
{% else %}
<script type="module" src="{{ '/assets/js/search.js' | relative_url }}"></script>
{% endif %}

<style>
.search-container {
  max-width: 800px;
  margin: 0 auto;
}

.search-input-wrapper {
  position: relative;
  margin-bottom: 2rem;
}

.search-input-container {
  position: relative;
  display: flex;
  align-items: center;
}

.search-icon {
  position: absolute;
  left: 1rem;
  color: var(--text-secondary);
  z-index: 1;
}

.search-input {
  width: 100%;
  padding: 1rem 3rem 1rem 3rem;
  font-size: 1.1rem;
  border: 2px solid var(--border-primary);
  border-radius: var(--mui-radius);
  background: var(--bg-elevated);
  color: var(--text-primary);
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.search-input:focus {
  outline: none;
  border-color: var(--accent-primary);
  box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
}

.search-clear {
  position: absolute;
  right: 1rem;
  background: none;
  border: none;
  color: var(--text-secondary);
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 50%;
  transition: background-color 0.2s ease;
}

.search-clear:hover {
  background: var(--bg-primary);
}

.search-suggestions {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: var(--bg-elevated);
  border: 1px solid var(--border-primary);
  border-radius: var(--mui-radius);
  box-shadow: var(--shadow-lg);
  z-index: 1000;
  max-height: 300px;
  overflow-y: auto;
}

.search-suggestion-item {
  padding: 0.75rem 1rem;
  border-bottom: 1px solid var(--border-primary);
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.search-suggestion-item:hover,
.search-suggestion-item:focus {
  background: var(--bg-primary);
  outline: none;
}

.search-suggestion-item:last-child {
  border-bottom: none;
}

.suggestion-title {
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 0.25rem;
}

.suggestion-category {
  font-size: 0.85rem;
  color: var(--accent-primary);
}

.search-results {
  margin-top: 2rem;
}

.search-results-header {
  margin-bottom: 1.5rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid var(--border-primary);
}

.search-results-header p {
  margin: 0;
  color: var(--text-secondary);
  font-size: 1.1rem;
}

.search-results-list {
  display: grid;
  gap: 1.5rem;
}

.search-result-item {
  padding: 1.5rem;
  background: var(--bg-elevated);
  border: 1px solid var(--border-primary);
  border-radius: var(--mui-radius);
  transition: box-shadow 0.2s ease;
}

.search-result-item:hover {
  box-shadow: var(--shadow-md);
}

.search-result-item h3 {
  margin: 0 0 0.5rem 0;
  font-size: 1.25rem;
}

.search-result-item h3 a {
  color: var(--text-primary);
  text-decoration: none;
  transition: color 0.2s ease;
}

.search-result-item h3 a:hover {
  color: var(--accent-primary);
}

.search-result-meta {
  display: flex;
  gap: 1rem;
  margin-bottom: 0.75rem;
  font-size: 0.9rem;
}

.search-category {
  background: var(--accent-primary);
  color: white;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-weight: 500;
}

.search-url {
  color: var(--text-secondary);
}

.search-result-excerpt {
  color: var(--text-secondary);
  line-height: 1.5;
  margin: 0;
}

.search-result-excerpt mark {
  background: #fff3cd;
  color: #856404;
  padding: 0.1rem 0.2rem;
  border-radius: 2px;
}

.search-no-results {
  text-align: center;
  padding: 3rem 1rem;
  color: var(--text-secondary);
}

.search-no-results p {
  margin: 0.5rem 0;
  font-size: 1.1rem;
}

.popular-searches {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 1px solid var(--border-primary);
}

.popular-searches h3 {
  color: var(--text-primary);
  margin-bottom: 1rem;
  font-size: 1.2rem;
}

.popular-search-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  margin-bottom: 2rem;
}

.search-tag {
  font-size: 0.9rem;
  padding: 0.5rem 1rem;
  white-space: nowrap;
}

.search-tips {
  background: var(--bg-elevated);
  padding: 1.5rem;
  border-radius: var(--mui-radius);
  border: 1px solid var(--border-primary);
}

.search-tips h4 {
  color: var(--text-primary);
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.search-tips h4 .material-icons {
  color: var(--accent-primary);
}

.search-tips ul {
  margin: 0;
  padding-left: 1.5rem;
}

.search-tips li {
  margin-bottom: 0.5rem;
  color: var(--text-secondary);
}

.search-loading {
  text-align: center;
  padding: 2rem;
  color: var(--text-secondary);
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid var(--border-primary);
  border-top: 4px solid var(--accent-primary);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Mobile responsiveness */
@media (max-width: 768px) {
  .popular-search-tags {
    justify-content: center;
  }

  .search-result-meta {
    flex-direction: column;
    gap: 0.5rem;
  }

  .search-tips {
    padding: 1rem;
  }
}
</style>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/" style="color: var(--text-secondary); text-decoration: none;">RK Oxygen</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-electrodes/" style="color: var(--text-secondary); text-decoration: none;">RK Electrodes</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-palace/" style="color: var(--text-secondary); text-decoration: none;">RK Palace</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/sand-creations/" style="color: var(--text-secondary); text-decoration: none;">Sand Creations</a></li>
          </ul>
        </div>

        <div>
          <h4 style="color: var(--text); margin-bottom: 1rem;">
            <span class="material-icons" style="vertical-align: middle; margin-right: 0.5rem;">calculate</span>
            Calculators
          </h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="/Calc/GST/" style="color: var(--text-secondary); text-decoration: none;">GST Calculator</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/Calc/LIQ/" style="color: var(--text-secondary); text-decoration: none;">Liquid Calculator</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/Calc/EMI/" style="color: var(--text-secondary); text-decoration: none;">EMI Calculator</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/Calc/" style="color: var(--text-secondary); text-decoration: none;">All Calculators</a></li>
          </ul>
        </div>

        <div>
          <h4 style="color: var(--text); margin-bottom: 1rem;">
            <span class="material-icons" style="vertical-align: middle; margin-right: 0.5rem;">location_on</span>
            Locations
          </h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/gorakhpur/" style="color: var(--text-secondary); text-decoration: none;">Gorakhpur Branch</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/lucknow/" style="color: var(--text-secondary); text-decoration: none;">Lucknow Branch</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/gorakhpur/contact/" style="color: var(--text-secondary); text-decoration: none;">Contact Information</a></li>
          </ul>
        </div>

        <div>
          <h4 style="color: var(--text); margin-bottom: 1rem;">
            <span class="material-icons" style="vertical-align: middle; margin-right: 0.5rem;">policy</span>
            Policies
          </h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/gorakhpur/terms/" style="color: var(--text-secondary); text-decoration: none;">Terms of Service</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/gorakhpur/privacy/" style="color: var(--text-secondary); text-decoration: none;">Privacy Policy</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/gorakhpur/refund-policy/" style="color: var(--text-secondary); text-decoration: none;">Refund Policy</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="/companies/rk-oxygen/gorakhpur/shipping/" style="color: var(--text-secondary); text-decoration: none;">Shipping Policy</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
// Search functionality
const searchInput = document.getElementById('searchInput');
const searchResults = document.getElementById('searchResults');
const resultsContainer = document.getElementById('resultsContainer');
const searchSuggestions = document.getElementById('searchSuggestions');

// Search data - in a real implementation, this would come from a search index
const searchData = [
  { title: 'RK Oxygen - Gorakhpur', url: '/companies/rk-oxygen/gorakhpur/', category: 'Company', description: 'Industrial gases branch in Gorakhpur, Uttar Pradesh' },
  { title: 'RK Oxygen - Lucknow', url: '/companies/rk-oxygen/lucknow/', category: 'Company', description: 'Industrial gases branch in Lucknow, Uttar Pradesh' },
  { title: 'RK Electrodes', url: '/companies/rk-electrodes/', category: 'Company', description: 'Welding electrodes and supplies' },
  { title: 'GST Calculator', url: '/Calc/GST/', category: 'Calculator', description: 'Calculate GST inclusive and exclusive amounts' },
  { title: 'Liquid Calculator', url: '/Calc/LIQ/', category: 'Calculator', description: 'Convert between liquid units and measurements' },
  { title: 'EMI Calculator', url: '/Calc/EMI/', category: 'Calculator', description: 'Calculate EMI for loans and mortgages' },
  { title: 'Terms of Service', url: '/companies/rk-oxygen/gorakhpur/terms/', category: 'Policy', description: 'Terms and conditions for RK Oxygen services' },
  { title: 'Privacy Policy', url: '/companies/rk-oxygen/gorakhpur/privacy/', category: 'Policy', description: 'How we handle your privacy and data' },
  { title: 'Contact Information', url: '/companies/rk-oxygen/gorakhpur/contact/', category: 'Contact', description: 'Get in touch with RK Oxygen Gorakhpur' },
  { title: 'Refund Policy', url: '/companies/rk-oxygen/gorakhpur/refund-policy/', category: 'Policy', description: 'Refund and cancellation terms' }
];

// Search function
function performSearch(query) {
  if (query.length < 2) {
    showSuggestions();
    return;
  }

  const results = searchData.filter(item => 
    item.title.toLowerCase().includes(query.toLowerCase()) ||
    item.description.toLowerCase().includes(query.toLowerCase()) ||
    item.category.toLowerCase().includes(query.toLowerCase())
  );

  displayResults(results, query);
}

// Display search results
function displayResults(results, query) {
  if (results.length === 0) {
    resultsContainer.innerHTML = `
      <div class="mui-alert mui-alert--info">
        <span class="material-icons">info</span>
        No results found for "${query}". Try a different search term or browse our suggestions below.
      </div>
    `;
  } else {
    resultsContainer.innerHTML = results.map(item => `
      <div class="mui-card" style="margin-bottom: 1rem; padding: 1.5rem;">
        <h4 style="margin: 0 0 0.5rem 0;">
          <a href="${item.url}" style="color: var(--accent-primary); text-decoration: none;">${item.title}</a>
        </h4>
        <span style="background: var(--bg-elevated); color: var(--text-secondary); padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.8rem; margin-bottom: 0.5rem; display: inline-block;">${item.category}</span>
        <p style="color: var(--text-secondary); margin: 0.5rem 0 0 0;">${item.description}</p>
      </div>
    `).join('');
  }

  searchSuggestions.style.display = 'none';
  searchResults.style.display = 'block';
}

// Show suggestions
function showSuggestions() {
  searchResults.style.display = 'none';
  searchSuggestions.style.display = 'block';
}

// Search input event listener
searchInput.addEventListener('input', (e) => {
  const query = e.target.value.trim();
  performSearch(query);
});

// Search suggestion buttons
document.querySelectorAll('.search-suggestion').forEach(button => {
  button.addEventListener('click', (e) => {
    const query = e.target.getAttribute('data-query');
    searchInput.value = query;
    performSearch(query);
  });
});

// Focus search input on page load
searchInput.focus();

// Track search analytics
searchInput.addEventListener('keypress', (e) => {
  if (e.key === 'Enter') {
    console.log('Search performed:', e.target.value);
    // Send to analytics if enabled
  }
});
</script>