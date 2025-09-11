
# Completed Tasks for rk-Groups.github.io

This file tracks all completed tasks and milestones for the static site project.
Use this as a historical record of progress.

---

## Automation & Quality

- Set up GitHub Actions workflow to automatically check all Markdown links on every
  push and pull request, ensuring documentation and site links remain healthy.

## Network & Multi-Company Dashboard

- Created a central "Our Companies Network" page at `/companies/` listing all
  companies and branches with quick links and summaries.
- Added navigation to the network page from the Companies dropdown in the topbar.

## UI Improvements

- Moved the "Report Issue" button to the bottom bar, floating at the bottom right
  corner on all pages for better visibility and accessibility.

## Jekyll Migration & Cleanup

- Migrated all content to Jekyll with Markdown and YAML front matter.
- Centralized navigation using `_data/navigation.yml` and Jekyll includes.
- Removed all legacy and duplicate HTML files (site is now fully Jekyll-managed).
- Moved development docs (`TODO.md`, `STATIC_RULES.md`, `COMPLETED.md`) to the
  `dev/` folder.
- Updated `README.md` and all references to reflect new structure.

## Navigation & User Experience

- Topbar "Companies" dropdown for fast switching between companies.
- Sidebar dynamically lists all subpages for the current company/branch.
- "Report Issue" button on every page linking to GitHub issues.

## Navigation & UI Consistency

- Used a shared Bootstrap navigation bar, sidebar, and bottombar via Jekyll includes
  (`_includes/topbar.html`, etc.).
- Centralized all navigation links in `_data/navigation.yml` for global updates.
- All pages use the Jekyll layout system for consistent UI.
- Navigation and UI are now consistent across all company/branch and calculator pages.

## Company/Branch Structure

- Organized all company content under `companies/` with a subfolder for each branch
  (e.g., `companies/rk-oxygen/gorakhpur`).
- Placed legal/policy pages (`terms.md`, `refund-policy.md`) in the correct branch
  folder.
- Each branch folder has its own `index.md` as a landing page.
- Removed legacy folders (e.g., `rkoxygengkp`).

## Dynamic Company Details

- Stored company/branch details in a single `details.js` file per branch.
- Dynamically rendered company details (GSTIN, addresses, partners, contact info)
  on all legal/policy and branch landing pages.


## Hybrid Calculator, Linting & CI Improvements
- Added hybrid interactive/pure-Markdown calculator for liquid conversions (`Calc/LIQ/index.md`).
- Hybrid Markdown/HTML content is now allowed for interactive calculators and advanced layouts.
- Removed markdownlint and pre-commit hook (hybrid Markdown/HTML now allowed).
- Added CI caching to GitHub Actions workflow for faster, more reliable builds.
- Pinned Ruby version for workflow compatibility.

## Legal/Policy Page Consistency

- Ensured every company/branch folder has up-to-date `terms.md` and `refund-policy.md`
  files.
- Removed all legacy HTML legal/policy files from all branches.

## Documentation

- Kept `README.md` up to date with navigation, structure, and dynamic details approach.
- Maintained `STATIC_RULES.md` with rules for static content, navigation, and directory
  scaffolding.

---

**Last updated:** September 12, 2025
