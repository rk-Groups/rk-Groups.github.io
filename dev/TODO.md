
# TODO for rk-Groups.github.io

This file tracks pending and future tasks for the static site. Completed tasks have been
moved to `COMPLETED.md` in the `dev/` folder.

---

## Maintenance & Best Practices

### High Priority

- [x] Keep legal/policy pages up to date in each company/branch folder. (All legacy
      HTML removed, only Markdown remains)
- [x] Set up automated checks for broken links in the Jekyll build process.
- [x] Add pre-commit linter for Markdown and basic formatting.

### Medium Priority

- [ ] Add onboarding notes for new contributors in `dev/`.
- [ ] Periodically review navigation and company structure for consistency.
- [ ] Use Jekyll data files for company details and navigation where possible.
- [x] Pre-commit link checker (`check-hrefs.js`) is now disabled in the hook; use only if
      needed for legacy HTML. Markdown link checking is automated via GitHub Actions.
- [ ] Document the process for adding a new company/branch (step-by-step guide).
- [ ] Add a changelog or release notes file for major updates.

## Future Enhancements

- [ ] Improve accessibility and mobile responsiveness.
- [ ] Add automated tests for navigation and link integrity.
- [ ] Add more calculators or tools as needed.
- [ ] Expand company/branch support as needed.
- [ ] Add a search feature for site-wide content.
- [ ] Integrate analytics (privacy-respecting) to monitor site usage.
- [ ] Add dark mode/theme toggle for better user experience.
- [ ] Create a feedback/contact form (static or using a service like Formspree).

---

**Last updated:** September 12, 2025 (automated link check enabled)
