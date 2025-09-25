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
  <div class="search-container" style="max-width: 600px; margin: 0 auto;">
    <div style="position: relative; margin-bottom: 2rem;">
      <input 
        type="text" 
        id="searchInput" 
        placeholder="Search for companies, calculators, policies..."
        style="width: 100%; padding: 1rem 1rem 1rem 3rem; font-size: 1.1rem; border: 2px solid var(--border-primary); border-radius: var(--mui-radius); background: var(--bg-elevated); color: var(--text);"
      >
      <span class="material-icons" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-secondary);">search</span>
    </div>
    
    <div id="searchResults" style="display: none;">
      <h3 style="color: var(--text); margin-bottom: 1rem;">Search Results</h3>
      <div id="resultsContainer"></div>
    </div>

    <div id="searchSuggestions">
      <h3 style="color: var(--text); margin-bottom: 1rem;">Popular Searches</h3>
      <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 2rem;">
        <button class="search-suggestion mui-btn mui-btn--outline" data-query="GST calculator">GST Calculator</button>
        <button class="search-suggestion mui-btn mui-btn--outline" data-query="RK Oxygen">RK Oxygen</button>
        <button class="search-suggestion mui-btn mui-btn--outline" data-query="contact">Contact Information</button>
        <button class="search-suggestion mui-btn mui-btn--outline" data-query="terms">Terms & Policies</button>
        <button class="search-suggestion mui-btn mui-btn--outline" data-query="Gorakhpur">Gorakhpur Branch</button>
        <button class="search-suggestion mui-btn mui-btn--outline" data-query="welding">Welding Equipment</button>
      </div>

      <div class="mui-features-grid" style="grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;">
        <div>
          <h4 style="color: var(--text); margin-bottom: 1rem;">
            <span class="material-icons" style="vertical-align: middle; margin-right: 0.5rem;">business</span>
            Companies
          </h4>
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