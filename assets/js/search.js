// Client-side search functionality using Lunr.js
class RKSearch {
  constructor() {
    this.searchIndex = null;
    this.lunrIndex = null;
    this.searchResults = [];
    this.isLoading = false;

    this.init();
  }

  async init() {
    try {
      // Load search index
      const response = await fetch('/search-index.json');
      const data = await response.json();

      this.searchIndex = data.pages;

      // Build Lunr index
      this.lunrIndex = lunr(function() {
        this.field('title', { boost: 10 });
        this.field('content', { boost: 5 });
        this.field('description', { boost: 3 });
        this.field('category', { boost: 2 });

        this.ref('id');

        data.pages.forEach(page => {
          this.add(page);
        });
      });

      console.log('Search index loaded:', data.total, 'pages');
    } catch (error) {
      console.error('Failed to load search index:', error);
    }
  }

  search(query, options = {}) {
    if (!this.lunrIndex || !query.trim()) {
      return [];
    }

    try {
      const results = this.lunrIndex.search(query);
      return results.map(result => {
        const page = this.searchIndex.find(p => p.id === result.ref);
        return {
          ...page,
          score: result.score,
          matchData: result.matchData
        };
      }).slice(0, options.limit || 20);
    } catch (error) {
      console.error('Search error:', error);
      return [];
    }
  }

  highlightText(text, query) {
    if (!query) return text;

    const words = query.toLowerCase().split(/\s+/);
    let highlighted = text;

    words.forEach(word => {
      if (word.length > 2) {
        const regex = new RegExp(`(${this.escapeRegex(word)})`, 'gi');
        highlighted = highlighted.replace(regex, '<mark>$1</mark>');
      }
    });

    return highlighted;
  }

  escapeRegex(string) {
    return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }

  // Get search suggestions
  getSuggestions(query) {
    if (!query || query.length < 2) return [];

    const results = this.search(query, { limit: 5 });
    return results.map(result => ({
      title: result.title,
      url: result.url,
      category: result.category
    }));
  }
}

// Search UI components
class RKSearchUI {
  constructor(searchInstance) {
    this.search = searchInstance;
    this.searchInput = document.getElementById('search-input');
    this.searchResults = document.getElementById('search-results');
    this.searchSuggestions = document.getElementById('search-suggestions');
    this.clearButton = document.getElementById('search-clear');

    if (this.searchInput) {
      this.init();
    }
  }

  init() {
    // Debounced search
    let searchTimeout;
    this.searchInput.addEventListener('input', (e) => {
      clearTimeout(searchTimeout);
      searchTimeout = setTimeout(() => {
        this.performSearch(e.target.value);
      }, 300);
    });

    // Clear search
    if (this.clearButton) {
      this.clearButton.addEventListener('click', () => {
        this.searchInput.value = '';
        this.clearResults();
      });
    }

    // Search on Enter
    this.searchInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        e.preventDefault();
        this.performSearch(this.searchInput.value, true);
      }
    });

    // Close suggestions on outside click
    document.addEventListener('click', (e) => {
      if (!this.searchInput.contains(e.target) && !this.searchSuggestions.contains(e.target)) {
        this.hideSuggestions();
      }
    });
  }

  performSearch(query, navigateToFirst = false) {
    if (!query.trim()) {
      this.clearResults();
      return;
    }

    const results = this.search.search(query);

    if (navigateToFirst && results.length > 0) {
      window.location.href = results[0].url;
      return;
    }

    this.displayResults(results, query);
    this.showSuggestions(this.search.getSuggestions(query));
  }

  displayResults(results, query) {
    if (!this.searchResults) return;

    if (results.length === 0) {
      this.searchResults.innerHTML = `
        <div class="search-no-results">
          <p>No results found for "${query}"</p>
          <p>Try different keywords or check spelling</p>
        </div>
      `;
      return;
    }

    const resultsHtml = results.map(result => `
      <div class="search-result-item">
        <h3>
          <a href="${result.url}">${this.search.highlightText(result.title, query)}</a>
        </h3>
        <div class="search-result-meta">
          <span class="search-category">${result.category}</span>
          <span class="search-url">${result.url}</span>
        </div>
        <p class="search-result-excerpt">
          ${this.search.highlightText(result.description || result.content.substring(0, 150), query)}...
        </p>
      </div>
    `).join('');

    this.searchResults.innerHTML = `
      <div class="search-results-header">
        <p>Found ${results.length} result${results.length !== 1 ? 's' : ''} for "${query}"</p>
      </div>
      <div class="search-results-list">
        ${resultsHtml}
      </div>
    `;

    // Announce results for screen readers
    this.announceResults(results.length, query);
  }

  showSuggestions(suggestions) {
    if (!this.searchSuggestions || suggestions.length === 0) {
      this.hideSuggestions();
      return;
    }

    const suggestionsHtml = suggestions.map(suggestion => `
      <div class="search-suggestion-item" data-url="${suggestion.url}">
        <div class="suggestion-title">${suggestion.title}</div>
        <div class="suggestion-category">${suggestion.category}</div>
      </div>
    `).join('');

    this.searchSuggestions.innerHTML = suggestionsHtml;
    this.searchSuggestions.style.display = 'block';

    // Add click handlers
    this.searchSuggestions.querySelectorAll('.search-suggestion-item').forEach(item => {
      item.addEventListener('click', () => {
        window.location.href = item.dataset.url;
      });
    });
  }

  hideSuggestions() {
    if (this.searchSuggestions) {
      this.searchSuggestions.style.display = 'none';
    }
  }

  clearResults() {
    if (this.searchResults) {
      this.searchResults.innerHTML = '';
    }
    this.hideSuggestions();
  }

  announceResults(count, query) {
    const announcement = `${count} search result${count !== 1 ? 's' : ''} found for ${query}`;
    const liveRegion = document.createElement('div');
    liveRegion.setAttribute('aria-live', 'polite');
    liveRegion.setAttribute('aria-atomic', 'true');
    liveRegion.className = 'sr-only';
    liveRegion.textContent = announcement;

    document.body.appendChild(liveRegion);
    setTimeout(() => document.body.removeChild(liveRegion), 1000);
  }
}

// Initialize search when DOM is ready
document.addEventListener('DOMContentLoaded', async () => {
  const search = new RKSearch();

  // Wait for search index to load
  await search.init();

  // Initialize search UI
  new RKSearchUI(search);

  // Track search analytics
  if (window.RKAnalytics) {
    window.RKAnalytics.trackSearchUsage = function(query, resultsCount) {
      window.RKAnalytics.trackEvent('search', 'query', query, resultsCount);
    };
  }
});