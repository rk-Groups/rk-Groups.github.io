### High Priority
- [ ] Move the "Report Issue" button to the bottom bar, floating at the bottom right corner:
	1. Remove the current "Report Issue" button from `_layouts/default.html`.
	2. Add a floating button to `_includes/bottombar.html` linking to the GitHub issues page.
	3. Style the button to always appear in the lower right corner above the bottombar.
	4. Test on desktop and mobile for visibility and accessibility.
# TODO for rk-Groups.github.io

This file tracks pending and future tasks for the static site. Completed tasks have been moved to `COMPLETED.md` in the `dev/` folder.

---

## Maintenance & Best Practices
### High Priority
- [ ] Keep legal/policy pages up to date in each company/branch folder.
- [ ] Add onboarding notes for new contributors in `dev/`.
- [ ] Set up automated checks for broken links in the Jekyll build process.

### Medium Priority
- [ ] Periodically review navigation and company structure for consistency.
- [ ] Use Jekyll data files for company details and navigation where possible.
- [ ] Remove or update the pre-commit link checker (`check-hrefs.js`) if no longer needed.
- [ ] Document the process for adding a new company/branch (step-by-step guide).
- [ ] Add a changelog or release notes file for major updates.

## Future Enhancements
### High Priority
- [ ] Improve accessibility and mobile responsiveness.
- [ ] Add automated tests for navigation and link integrity.

### Medium Priority
- [ ] Add more calculators or tools as needed.
- [ ] Expand company/branch support as needed.
- [ ] Add a search feature for site-wide content.
- [ ] Integrate analytics (privacy-respecting) to monitor site usage.
- [ ] Add dark mode/theme toggle for better user experience.
- [ ] Create a feedback/contact form (static or using a service like Formspree).

---

**Last updated:** September 12, 2025 (navigation, sidebar, and report issue button implemented)
