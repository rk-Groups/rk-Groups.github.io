# Static Web Page Rules for This Repository

This repository is intended for use as a static website hosted on GitHub Pages. Please follow these rules:


1. **Static Content Only**: Only static files (HTML, CSS, JS, images, etc.) are allowed. No server-side code or dynamic backend is supported.
2. **GitHub Pages Structure**: Organize files and folders so that all public-facing pages and assets are accessible via GitHub Pages URLs.
3. **No Build Step Required**: All files should be ready to serve as-is. Do not require any build tools or compilation.
4. **Legal & Policy Pages**: Place legal documents (e.g., Terms, Refund Policy) under the appropriate company/branch folder (e.g., `companies/rk-oxygen/gorakhpur/terms.html`). Do not use legacy folders like `rkoxygengkp`. All legal/policy and branch landing pages must display company details (GSTIN, addresses, partners, contact info) dynamically using a shared `details.js` file in the branch folder.
5. **Navigation**: All navigation and footer links should use the centralized `site-links.js` system. Use the provided nav-* classes (e.g., `nav-home`, `nav-terms`) in HTML, and update links in `site-links.js` for global changes. The navigation bar itself is loaded dynamically from `Shared/topbar.html` using JavaScript for a single-source-of-truth navigation bar across all pages.
6. **No Sensitive Data**: Do not include any private or sensitive information in the repository.
7. **README Maintenance**: Keep the README.md up to date with structure, navigation, and usage instructions.

---


---

## Directory Scaffolding Rules

To support multiple companies and branches, use the following directory structure:

- All company-specific content must be placed under the `companies/` directory.
- Each company has its own folder, e.g., `companies/rk-oxygen/`.
- Each branch/location of a company has its own subfolder, e.g., `companies/rk-oxygen/gorakhpur/`.
- Legal and policy pages (e.g., `terms.html`, `refund-policy.html`) must be placed inside the relevant branch folder.
- Each branch folder should have its own `index.html` as a landing page.
- Do not use legacy folders (such as `rkoxygengkp`) for new content.

Example:

```
companies/
	rk-oxygen/
		gorakhpur/
			index.html
			terms.html
			refund-policy.html
		lucknow/
			index.html
			terms.html
			refund-policy.html
```

This ensures clear separation and maintainability for all company and branch content.

This repository is for a static website only and is designed for deployment via GitHub Pages.
