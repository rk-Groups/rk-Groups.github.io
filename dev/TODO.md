# TODO for rk-Groups.github.io

This file tracks key steps, improvements, and maintenance tasks for the static site. Use this as a checklist for onboarding, updates, and future enhancements.

---

## 1. Navigation & UI Consistency
- [x] Use a shared Bootstrap navigation bar, sidebar, and bottombar via Jekyll includes (`_includes/topbar.html`, etc.).
- [x] Centralize all navigation links in `_data/navigation.yml` for global updates.
- [x] All pages use the Jekyll layout system for consistent UI.
- [x] Navigation and UI are now consistent across all company/branch and calculator pages.

## 2. Company/Branch Structure
- [x] Organize all company content under `companies/` with a subfolder for each branch (e.g., `companies/rk-oxygen/gorakhpur`).
- [x] Place legal/policy pages (`terms.html`, `refund-policy.html`) in the correct branch folder.
- [x] Each branch folder should have its own `index.html` as a landing page.
- [x] Remove legacy folders (e.g., `rkoxygengkp`).

## 3. Dynamic Company Details
- [x] Store company/branch details in a single `details.js` file per branch.
- [x] Dynamically render company details (GSTIN, addresses, partners, contact info) on all legal/policy and branch landing pages.
- [ ] Apply this pattern to all branches and companies as they are added.

## 4. Link Integrity & Pre-commit Checks
- [x] Use `check-hrefs.js` to validate all internal links before commit (for legacy HTML; not needed for Jekyll-generated links).
- [ ] Remove or update pre-commit link checker as Jekyll migration completes.

## 5. Documentation
- [x] Keep `README.md` up to date with navigation, structure, and dynamic details approach.
- [x] Maintain `STATIC_RULES.md` with rules for static content, navigation, and directory scaffolding.
- [ ] Add onboarding notes for new contributors.

## 6. Future Enhancements
- [ ] Add more calculators or tools as needed.
- [ ] Improve accessibility and mobile responsiveness.
- [ ] Add automated tests for navigation and link integrity.
- [x] Migrate to Jekyll static site generator for maintainability and scalability.

---

**Last updated:** September 11, 2025
