name: Pull Request
description: Submit a pull request for code changes
title: "[PR]: "
labels: []
assignees: []

body:
  - type: markdown
    attributes:
      value: |
        Thanks for contributing to the RK Groups website! Please provide details about your changes.

  - type: dropdown
    id: pr_type
    attributes:
      label: Pull Request Type
      description: What type of changes are you making?
      options:
        - Bug fix (fixes an issue)
        - Feature (adds new functionality)
        - Content update (updates website content)
        - Refactoring (improves code without changing functionality)
        - Performance improvement
        - Documentation update
        - Build/CI changes
        - Other
    validations:
      required: true

  - type: dropdown
    id: component
    attributes:
      label: Component
      description: Which part of the website does this affect?
      options:
        - Homepage
        - Companies
        - Calculators
        - Visualizations
        - Navigation
        - UI/UX
        - Build System
        - Documentation
        - Other
    validations:
      required: true

  - type: textarea
    id: description
    attributes:
      label: Description
      description: Provide a clear description of the changes
      placeholder: "What does this PR do? Why is it needed?"
    validations:
      required: true

  - type: textarea
    id: changes
    attributes:
      label: Changes Made
      description: List the specific changes made
      placeholder: |
        - Added new feature X
        - Fixed bug in component Y
        - Updated documentation for Z
    validations:
      required: true

  - type: textarea
    id: related_issues
    attributes:
      label: Related Issues
      description: Link any related issues
      placeholder: |
        Closes #123
        Fixes #456
        Related to #789

  - type: checkboxes
    id: testing
    attributes:
      label: Testing
      description: How has this been tested?
      options:
        - label: Local testing completed
        - label: All existing tests pass
        - label: New tests added (if applicable)
        - label: Manual testing completed
        - label: Cross-browser testing completed
        - label: Mobile responsiveness tested

  - type: checkboxes
    id: checklist
    attributes:
      label: Pull Request Checklist
      description: Please verify the following before submitting
      options:
        - label: Code follows project style guidelines
        - label: No console.log statements or debug code left in
        - label: Documentation updated (if applicable)
        - label: No merge conflicts
        - label: Commits have descriptive messages
        - label: Ready for code review

  - type: textarea
    id: screenshots
    attributes:
      label: Screenshots/Media
      description: If applicable, add screenshots or videos to show the changes

  - type: textarea
    id: additional
    attributes:
      label: Additional Notes
      description: Any additional information for reviewers