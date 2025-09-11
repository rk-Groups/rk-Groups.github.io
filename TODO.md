# TODO for rk-Groups.github.io

This file tracks key steps, improvements, and maintenance tasks for the static site. Use this as a checklist for onboarding, updates, and future enhancements.

---

## 1. Navigation & UI Consistency
- [x] Use a shared Bootstrap navigation bar (`Shared/topbar.html`) loaded dynamically on all pages.
- [x] Centralize all navigation links in `site-links.js` and use absolute paths for reliability.
- [x] Ensure `site-links.js` runs only after the topbar is loaded on every page.
- [x] Add Bootstrap and jQuery to all pages for consistent UI.
- [ ] Review all company/branch and calculator pages to ensure navigation and UI are consistent.

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
- [x] Use `check-hrefs.js` to validate all internal links before commit.
- [ ] Ensure `.git/hooks/pre-commit` runs `node check-hrefs.js`.
- [ ] Periodically review and update `check-hrefs.js` as the site structure evolves.

## 5. Documentation
- [x] Keep `README.md` up to date with navigation, structure, and dynamic details approach.
- [x] Maintain `STATIC_RULES.md` with rules for static content, navigation, and directory scaffolding.
- [ ] Add onboarding notes for new contributors.

## 6. Future Enhancements
- [ ] Add more calculators or tools as needed.
- [ ] Improve accessibility and mobile responsiveness.
- [ ] Add automated tests for navigation and link integrity.
- [ ] Consider a static site generator if content grows large.

---

**Last updated:** September 11, 2025
