# RK Groups Jekyll Site - AI Coding Agent Instructions

## Project Overview
This is a multi-company static Jekyll site for RK Groups, hosted on GitHub Pages. The site manages multiple companies and their branches through a data-driven architecture with shared layouts and includes.

## Architecture & Key Patterns

### Data-Driven Company Structure
- **Companies data**: All company info stored in `_data/companies.yml` using nested structure:
  ```yaml
  company-name:
    main: { name, gstin, constitution, contact }
    branch-name: { name, gstin, contact, ... }
  ```
- **Navigation**: Centrally managed in `_data/navigation.yml` - all menus auto-generated from here
- **Access pattern**: Use Jekyll dot notation: `{% assign details = site.data.companies.rk-oxygen.main %}`
- **No package.json**: Site uses `npx --yes` for Node tools to maintain clean Jekyll structure

### Jekyll Layout System
- **Single layout**: All pages inherit from `_layouts/default.html` (dark-mode only, Material UI)
- **Specialized layouts**: 
  - `company.html` - Company landing pages with auto-generated branch lists
  - `company-branch.html` - Individual branch pages with data integration
  - `company-policy.html` - Legal/policy pages with company context
- **Shared includes**: `_includes/navigation.html`, `bottombar.html` provide consistent UI

### File Organization Conventions
```
companies/[company-name]/[branch-name]/
├── index.md (landing page)
├── terms.md, refund-policy.md (legal docs)
├── contact.md, privacy.md, shipping.md
└── details.js (optional branch-specific data)
```

## Development Workflows

### Pre-Push Testing
- **Primary command**: `./test-and-push.ps1 "commit message"` 
- **Quick testing**: `.\scripts\test-before-push.ps1 -SkipLighthouse -SkipAxe`
- **Tests include**: Jekyll build, link checking, Lighthouse performance, axe accessibility
- **CI Integration**: GitHub Actions with Ruby gem and npm caching enabled

### Key Scripts
- `test-and-push.ps1` - Wrapper for test→commit→push workflow
- `scripts/test-before-push.ps1` - Comprehensive local testing (Jekyll, npm, Lighthouse, axe-core)
- **Skip options**: `-SkipLighthouse -SkipAxe` for faster testing
- Environment suppression: NPM warnings disabled via multiple env vars
- **Background tasks**: Use `isBackground=true` for servers, set `isBackground=false` for build commands

## Material UI & Theme Rules

### Strict Design System
- **Dark mode only**: Never implement light themes or toggles - `<body>` must have `dark-mode` class
- **Material Icons**: Use Material Icons CDN consistently across site
- **CSS Variables**: All styling uses CSS custom properties defined in `/assets/css/mui.css`
  - Colors: `--bg-primary`, `--text`, `--accent-primary`, etc.
  - Spacing: `--mui-radius: 8px`
  - Shadows: `--shadow-sm`, `--shadow-md`, `--shadow-lg`
- **Glass effects**: Use `.mui-glass` utility for navigation/headers with backdrop blur
- **Hero sections**: Use `.mui-hero--bleed` for full-width gradient heroes

### Interactive Components
- **Calculators**: Hybrid Markdown/HTML allowed (GST calc in `Calc/GST/index.md`)
- **Button patterns**: `.mui-btn--primary` (white text + shadow), `.mui-btn--outline`
- **Cards**: `.mui-card` with consistent padding, shadows, and border radius
- **No linting**: Markdownlint disabled to support interactive content
- **Accessibility**: All buttons require sufficient contrast, focus outlines with `box-shadow`

## Critical Development Rules

### Jekyll/Static Constraints
- **Static only**: No server-side code, GitHub Pages auto-builds Jekyll
- **Markdown preferred**: No legacy HTML files, use `.md` for content pages  
- **Data access**: Always use Jekyll data file dot notation for company details
- **Navigation**: Single source of truth in `_data/navigation.yml` - never hardcode menus

### Company Management
- **New companies**: Follow `dev/COMPANY_SETUP_GUIDE.md` step-by-step process
- **Branch structure**: Each branch needs full folder structure with required policy pages
- **Legal compliance**: Every company/branch must have terms.md, refund-policy.md accessible from navigation

## Development Environment Setup
1. **Primary testing**: Use `./test-and-push.ps1 "commit message"` for full workflow
2. **Quick testing**: Use `.\scripts\test-before-push.ps1 -SkipLighthouse -SkipAxe`
3. **PowerShell environment**: All scripts designed for PowerShell (pwsh.exe)
4. **Check documentation**: Reference `dev/STATIC_RULES.md` for UI consistency
5. **Current tasks**: Check `dev/TODO.md` for ongoing work and backlog items

## Key File Patterns & Examples

### Company Data Access
```liquid
{% assign key = page.company %}
{% assign company = site.data.companies[key] %}
{% assign main = company.main %}
<!-- Access: {{ main.gstin }}, {{ main.contact.email }} -->
```

### CSS Variable Usage
```css
.custom-component {
  background: var(--bg-elevated);
  border: 1px solid var(--border-primary);
  color: var(--text-primary);
  border-radius: var(--mui-radius);
}
```

### Navigation Structure
```yaml
# _data/navigation.yml
main:
  - title: Companies
    dropdown:
      - title: RK Oxygen (Gorakhpur)
        url: /companies/rk-oxygen/gorakhpur/
        icon: factory
        desc: Industrial gases branch
```

## Common Pitfalls to Avoid
- Don't hardcode navigation links - use `_data/navigation.yml`
- Don't add light theme support - site is dark-mode only by design
- Don't use legacy HTML for content - Markdown + Jekyll layouts only
- Don't skip the company setup guide when adding new companies
- Always test locally before pushing to prevent CI failures