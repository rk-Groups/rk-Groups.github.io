# Static Web Page Rules for This Repository

This repository is a static website hosted on GitHub Pages, fully managed by Jekyll. Please follow these rules:

1. **Static Content Only**: Only static files (Markdown, HTML, CSS, JS, images, etc.) are allowed. No server-side code or dynamic backend is supported.
2. **Jekyll Structure**: Organize files and folders using Jekyll conventions (`_layouts`, `_includes`, `_data`, etc.) so all public-facing pages and assets are accessible via GitHub Pages URLs.
3. **No Legacy HTML**: All content must be in Markdown (`.md`) or Jekyll-supported formats. Do not add or restore `.html` files for main content pages.
4. **No Build Step Required**: All files should be ready to serve as-is. GitHub Pages will build Jekyll sites automatically.
5. **Legal & Policy Pages**: Place legal documents (e.g., Terms, Refund Policy) under the appropriate company/branch folder (e.g., `companies/rk-oxygen/gorakhpur/terms.md`).
6. **Navigation**: All navigation, sidebar, and footer links should be managed in `_data/navigation.yml` and included via Jekyll layouts and includes. The navigation bar, sidebar, and footer are single-source-of-truth includes for the entire site. Sidebar must show all subpages for the current company/branch.
7. **Report Issue**: Every page must have a "Report Issue" button linking to the GitHub issues page.
8. **No Sensitive Data**: Do not include any private or sensitive information in the repository.
9. **README Maintenance**: Keep the `README.md` up to date with structure, navigation, and usage instructions.
10. **Development Docs**: All development documentation (e.g., TODO, rules, completed) must be kept in the `dev/` folder.

---

## Directory Scaffolding Rules

To support multiple companies and branches, use the following directory structure:

- All company-specific content must be placed under the `companies/` directory.
- Each company has its own folder, e.g., `companies/rk-oxygen/`.
- Each branch/location of a company has its own subfolder, e.g., `companies/rk-oxygen/gorakhpur/`.
- Legal and policy pages (e.g., `terms.md`, `refund-policy.md`) must be placed inside the relevant branch folder.
- Each branch folder should have its own `index.md` as a landing page.
- Do not use legacy folders (such as `rkoxygengkp`) for new content.

Example:

```
companies/
	rk-oxygen/
		gorakhpur/
			index.md
			terms.md
			refund-policy.md
		lucknow/
			index.md
			terms.md
			refund-policy.md
```

This ensures clear separation and maintainability for all company and branch content.

This repository is for a static website only and is designed for deployment via GitHub Pages.

---

**Last updated:** September 12, 2025
