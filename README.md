
# rk-Groups.github.io

## Overview

This is the official website for RK Oxygen, now powered by Jekyll and GitHub Pages. All navigation, layout, and content are managed using Jekyll layouts, includes, and Markdown/HTML files for maintainability and consistency.

## Features
- **Company Navigation**: Topbar features a "Companies" dropdown for fast switching. Sidebar shows all subpages for the current company/branch.
- **Liquid Oxygen Converter**: Instantly convert between kilograms, tons, standard metric cubes (sm³), liters, and cylinders on the homepage.
- **GST Calculator**: Located at [`Calc/GST/index.md`](Calc/GST/index.md)
- **Liquid Calculator**: Located at [`Calc/LIQ/index.md`](Calc/LIQ/index.md)
- **Jekyll Layouts & Includes**: All pages use a single, shared layout (`_layouts/default.html`) and navigation components (`_includes/topbar.html`, `sidebar.html`, `bottombar.html`).
- **Navigation Data**: All navigation links and sidebar structure are managed in `_data/navigation.yml` for easy global updates.
- **Legal & Policy Pages**: Terms and refund policy are accessible from the navigation bar and sidebar for every company/branch.
- **Development Docs**: [TODOs](dev/TODO.md), [Completed Tasks](dev/COMPLETED.md), and [Static Rules](dev/STATIC_RULES.md) are now in the `dev/` folder.
- **Report Issue**: Every page has a "Report Issue" button linking to the GitHub issues page.

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


- [Terms of Service](companies/rk-oxygen/gorakhpur/terms.md)
- [Refund & Cancellation Policy](companies/rk-oxygen/gorakhpur/refund-policy.md)

These pages, as well as the Gorakhpur branch landing page, now display company details (GSTIN, addresses, partners, contact info) directly in Markdown or via Jekyll data files for easy updates.

---
