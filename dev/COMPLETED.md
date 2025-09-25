
# Completed Tasks for rk-Groups.github.io

This file tracks all completed tasks and milestones for the static site project.
Use this as a historical record of progress.

---

## 2025 Milestones

### January 2025 - Major Site Enhancements

**Visual Design & Branding Improvements:**
- Enhanced homepage with compelling stats section (15+ years experience, 500+ satisfied customers, 98% customer satisfaction)
- Added customer testimonials carousel with industry-specific feedback
- Improved call-to-action sections with gradient backgrounds and prominent buttons
- Implemented Material Design principles throughout with consistent visual hierarchy

**Navigation & User Experience:**
- Implemented site-wide search functionality with live suggestions and categorized results
- Added breadcrumb navigation system across all pages for better navigation context
- Enhanced responsive design for mobile and tablet users
- Added contact page with Netlify Forms integration and FAQ section

**Calculator Suite Expansion:**
- Added sophisticated Compound Interest Calculator with yearly breakdown tables
- Enhanced existing GST Calculator with improved user interface
- Updated Calculator hub page with better organization and descriptions
- Integrated analytics tracking for calculator usage patterns

**SEO & Performance Optimization:**
- Enhanced Open Graph tags and Twitter Cards for better social media sharing
- Improved structured data markup for search engines
- Added comprehensive meta descriptions and keywords
- Optimized page loading performance with efficient CSS/JS

**Interactive Features & Analytics:**
- Implemented privacy-friendly analytics system using sessionStorage (no cookies)
- Added contact forms with spam protection and success feedback
- Integrated form submission tracking and calculator usage analytics
- Enhanced external link tracking for better user behavior insights

### Previous 2025 Work

- Migrated all content to Jekyll with Markdown and YAML front matter
- Centralized navigation using `_data/navigation.yml` and Jekyll includes
- Removed all legacy and duplicate HTML files (site is now fully Jekyll-managed)
- Moved development docs (`TODO.md`, `STATIC_RULES.md`, `COMPLETED.md`) to the `dev/` folder
- Updated `README.md` and all references to reflect new structure
- Set up GitHub Actions workflow to automatically check all Markdown links on every push and pull request
- Created a central "Our Companies Network" page at `/companies/` listing all companies and branches
- Added navigation to the network page from the Companies dropdown in the topbar
- Moved the "Report Issue" button to the bottom bar, floating at the bottom right corner on all pages
- Topbar "Companies" dropdown for fast switching between companies
- Sidebar dynamically lists all subpages for the current company/branch
- "Report Issue" button on every page linking to GitHub issues
- Used a shared navigation bar, sidebar, and bottombar via Jekyll includes
- Centralized all navigation links in `_data/navigation.yml` for global updates
- All pages use the Jekyll layout system for consistent UI
- Navigation and UI are now consistent across all company/branch and calculator pages
- Organized all company content under `companies/` with a subfolder for each branch
- Placed legal/policy pages (`terms.md`, `refund-policy.md`) in the correct branch folder
- Each branch folder has its own `index.md` as a landing page
- Removed legacy folders (e.g., `rkoxygengkp`)
- Stored company/branch details in a single `details.js` file per branch
- Dynamically rendered company details (GSTIN, addresses, partners, contact info)
- Migrated all UI to Material UI-inspired design system (mui.css)
- Removed Bootstrap and all related dependencies
- Implemented dark/light theme toggle using CSS variables and prefers-color-scheme
- Moved all reusable and utility styles to `assets/css/mui.css`
- Ensured all custom classes used in the layout are defined in `mui.css`
- Added accessibility, responsive, and utility helpers to `mui.css`
- Added SEO meta tags and plugin

---

**Last updated:** September 12, 2025
  on all legal/policy and branch landing pages.


- Removed all legacy static HTML main pages for companies/branches
- Sidebar and topbar alignment fixed (no gap)
- Companies dropdown now shows both RK Oxygen Lucknow and Gorakhpur
- Improved company/branch pages with switcher and details table
- Added hybrid interactive/pure-Markdown calculator for liquid conversions (`Calc/LIQ/index.md`).
- Hybrid Markdown/HTML content is now allowed for interactive calculators and advanced layouts.
- Removed markdownlint and pre-commit hook (hybrid Markdown/HTML now allowed).
- Added CI caching to GitHub Actions workflow for faster, more reliable builds.
- Pinned Ruby version for workflow compatibility.

## Site-wide Dark Theme and Enhanced UX (September 2025)

- **Dark-Only Policy**: Enforced dark-only theme site-wide, documented in `dev/STATIC_RULES.md`
- **Modern Dark Palette**: Upgraded CSS variables to rich dark palette with improved contrast
- **Glassy Navigation**: Added modern glass-effect header with backdrop blur
- **Full-bleed Heroes**: Implemented full-viewport-width hero sections with gradient overlays
- **Data-Driven Companies**: Built shared layouts (`_layouts/company.html`, `_layouts/company-branch.html`, `_layouts/company-policy.html`) rendering from `_data/companies.yml`
- **Calculator UI Refresh**: Updated GST and LIQ calculators with heroes and MUI card layouts
- **Companies Coverage**: Added RK Electrodes, RK Palace, Sand Creations main pages and policies
- **Multi-Branch Support**: Added RK Oxygen Lucknow branch with complete policies
- **CI Quality Gates**: Implemented Lighthouse and axe-core accessibility/performance checks
- **CI Node Tools Fix**: Updated workflow to use `npx --yes` without requiring package.json
- **Button Contrast Fix**: Enhanced button color contrast and visibility with explicit white text, improved hover states, and text shadows
- **NPM Warning Suppression**: Enhanced environment variables to CI workflow and local testing to minimize npm deprecation warnings (NODE_NO_WARNINGS, NPM_CONFIG_UPDATE_NOTIFIER, etc.)
- **Local Testing Infrastructure**: Created comprehensive local testing scripts (`scripts/test-before-push.ps1`, `test-and-push.ps1`) that mirror GitHub Actions workflows for pre-push validation
- **CI Configuration Fix**: Fixed critical CI failure by removing invalid npm config commands (`npm config set warnings false`) and implementing npm config validation in local testing
- **Enhanced Monitoring Report**: Upgraded `dev/MONITORING_REPORT.md` with automatic page data collection, direct URLs, and comprehensive performance baselines

## Legal/Policy Page Consistency

- Ensured every company/branch folder has up-to-date `terms.md` and `refund-policy.md`
  files.
- Removed all legacy HTML legal/policy files from all branches.

## Documentation

- Kept `README.md` up to date with navigation, structure, and dynamic details approach.
- Maintained `STATIC_RULES.md` with rules for static content, navigation, and directory
  scaffolding.

---

**Last updated:** September 17, 2025
