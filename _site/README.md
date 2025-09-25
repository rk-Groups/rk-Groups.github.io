
## Features
- **Hybrid Liquid Calculator**: [`Calc/LIQ/index.md`](Calc/LIQ/index.md) — interactive calculator (O₂, N₂, CO₂) plus a pure-Markdown conversion table for accessibility and compliance.
- **GST Calculator**: [`Calc/GST/index.md`](Calc/GST/index.md)
- **Data-Driven Navigation**: Topbar and sidebar menus are generated from `_data/navigation.yml` for easy updates.
- **Jekyll Layouts & Includes**: All pages use a single, shared layout (`_layouts/default.html`) and navigation components (`_includes/topbar.html`, `sidebar.html`, `bottombar.html`).
- **Legal & Policy Pages**: Terms and refund policy are accessible from the navigation bar and sidebar for every company/branch.
- **Development Docs**: [TODOs](dev/TODO.md), [Completed Tasks](dev/COMPLETED.md), and [Static Rules](dev/STATIC_RULES.md) are now in the `dev/` folder.
- **Report Issue**: Every page has a "Report Issue" button linking to the GitHub issues page.
- **CI/CD with Caching**: GitHub Actions workflow caches Ruby gems and npm packages for fast, reliable builds and deploys.
- **No Markdownlint**: Linting is now optional; hybrid Markdown/HTML is allowed for interactive content.

## Navigation
The site features a fixed navigation bar and footers with quick links to:
- Home
- Terms of Service
- Refund & Cancellation Policy
- GST Calculator
- Liquid Calculator

All navigation and footer links are generated from `_data/navigation.yml` and included via Jekyll's layout system. The navigation bar, sidebar, and footer are single-source-of-truth includes for the entire site.

## Central Landing Page
- [RK Groups Home](index.md)

## Legal & Policy Pages
- [Terms of Service](https://rk-groups.github.io/companies/rk-oxygen/gorakhpur/terms/)
- [Refund & Cancellation Policy](https://rk-groups.github.io/companies/rk-oxygen/gorakhpur/refund-policy/)

These pages, as well as the Gorakhpur branch landing page, now display company details (GSTIN, addresses, partners, contact info) directly in Markdown or via Jekyll data files for easy updates.

---
## Legal & Policy Pages


- [Terms of Service](https://rk-groups.github.io/companies/rk-oxygen/gorakhpur/terms/)
- [Refund & Cancellation Policy](https://rk-groups.github.io/companies/rk-oxygen/gorakhpur/refund-policy/)

These pages, as well as the Gorakhpur branch landing page, now display company details (GSTIN, addresses, partners, contact info) directly in Markdown or via Jekyll data files for easy updates.

---
