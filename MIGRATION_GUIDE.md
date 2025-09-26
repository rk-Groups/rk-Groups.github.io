# 🚀 Calculator Submodule Migration Guide

This guide will help you migrate your calculators from a monolithic structure to independent repositories using git submodules.

## 📋 Migration Overview

**Current Structure:**
```
Calc/
├── GST/     # Inline in main repo
├── LIQ/     # Inline in main repo
├── EMI/     # Inline in main repo
└── CI/      # Inline in main repo
```

**Target Structure:**
```
Calc/
├── GST/     # Git submodule → rk-groups/calculator-gst
├── LIQ/     # Git submodule → rk-groups/calculator-liquid
├── EMI/     # Git submodule → rk-groups/calculator-emi
└── CI/      # Git submodule → rk-groups/calculator-ci
```

## 🎯 Step-by-Step Migration

### Step 1: Create GitHub Repositories

Create the following repositories on GitHub:

1. **https://github.com/rk-Groups/calculator-gst**
   - Description: "GST Calculator for tax calculations"
   - Make it public or private as needed

2. **https://github.com/rk-Groups/calculator-liquid**
   - Description: "Liquid Calculator for gas conversions"

3. **https://github.com/rk-Groups/calculator-emi**
   - Description: "EMI Calculator for loan calculations"

4. **https://github.com/rk-Groups/calculator-ci**
   - Description: "CI Calculator for compound interest"

### Step 2: Extract Calculators

Run the migration script to extract calculators:

```bash
# Extract calculators to temporary directories
.\migrate-calculators.ps1 -ExtractCalculators
```

This creates:
- `temp-calculators/calculator-gst/`
- `temp-calculators/calculator-liquid/`
- `temp-calculators/calculator-emi/`
- `temp-calculators/calculator-ci/`

### Step 3: Push to GitHub

For each extracted calculator:

```bash
# GST Calculator
cd temp-calculators/calculator-gst
git init
git add .
git commit -m "Initial commit: GST Calculator"
git remote add origin https://github.com/rk-Groups/calculator-gst.git
git push -u origin master

# Liquid Calculator
cd ../calculator-liquid
git init
git add .
git commit -m "Initial commit: Liquid Calculator"
git remote add origin https://github.com/rk-Groups/calculator-liquid.git
git push -u origin master

# EMI Calculator
cd ../calculator-emi
git init
git add .
git commit -m "Initial commit: EMI Calculator"
git remote add origin https://github.com/rk-Groups/calculator-emi.git
git push -u origin master

# CI Calculator
cd ../calculator-ci
git init
git add .
git commit -m "Initial commit: CI Calculator"
git remote add origin https://github.com/rk-Groups/calculator-ci.git
git push -u origin master
```

### Step 4: Convert to Submodules

Convert the main repository to use submodules:

```bash
# Go back to main repo
cd ../../..

# Convert directories to submodules
.\migrate-calculators.ps1 -CreateSubmodules
```

When prompted, enter the repository URLs:
- GST: `https://github.com/rk-Groups/calculator-gst.git`
- LIQ: `https://github.com/rk-Groups/calculator-liquid.git`
- EMI: `https://github.com/rk-Groups/calculator-emi.git`
- CI: `https://github.com/rk-Groups/calculator-ci.git`

### Step 5: Update Workflows

Update CI/CD and development workflows:

```bash
.\migrate-calculators.ps1 -UpdateWorkflows
```

### Step 6: Commit Changes

Commit the submodule configuration:

```bash
git add .
git commit -m "feat: Migrate calculators to git submodules

- Convert GST calculator to submodule
- Convert Liquid calculator to submodule
- Convert EMI calculator to submodule
- Convert CI calculator to submodule
- Update workflows for submodule support
- Add submodule management scripts"
```

### Step 7: Test Migration

Test that everything works:

```bash
.\migrate-calculators.ps1 -TestMigration
```

## 🔧 Post-Migration Workflow

### Working with Submodules

```bash
# Initialize submodules (first clone)
git submodule init
git submodule update

# Or use npm script
npm run submodules:init

# Update all calculators to latest
npm run submodules:update

# Check status
npm run submodules:status
```

### Developing a Calculator

```bash
# Work on GST calculator
cd Calc/GST
git checkout -b feature/new-feature
# Make changes...
git commit -m "Add new feature"
git push origin feature/new-feature

# Update main repo
cd ../..
git add Calc/GST
git commit -m "Update GST calculator"
git push
```

### Adding a New Calculator

```bash
# Use the management script
.\manage-calculators.ps1 -AddGST
```

## 🧪 Testing Strategy

### Unit Tests per Calculator
Each calculator repository should have:
- Unit tests for calculations
- Integration tests for UI
- Accessibility tests

### Integration Tests
Main repository should test:
- Submodules load correctly
- Calculators integrate with main site
- Navigation works properly

### CI/CD Updates

GitHub Actions will automatically:
- Checkout with submodules
- Build and test main site
- Deploy with calculator updates

## 🚨 Troubleshooting

### Submodule Issues

```bash
# Fix detached HEAD state
cd Calc/GST
git checkout master

# Remove and re-add submodule
cd ../..
git submodule deinit Calc/GST
git rm Calc/GST
git submodule add https://github.com/rk-Groups/calculator-gst.git Calc/GST
```

### Sync Problems

```bash
# Force update all submodules
git submodule update --init --recursive --force

# Update specific submodule
cd Calc/GST && git pull origin master
```

### Permission Issues

Ensure you have:
- Push access to all calculator repositories
- SSH keys configured for GitHub
- Correct repository URLs

## 📊 Benefits Achieved

✅ **Independent Development**: Each calculator can be developed separately
✅ **Version Control**: Isolated git history for each calculator
✅ **Team Collaboration**: Different teams can work on different calculators
✅ **Deployment Flexibility**: Update calculators without redeploying entire site
✅ **Code Reusability**: Calculators can be used in other projects
✅ **Better Testing**: Isolated testing for each calculator component

## 🎉 Migration Complete!

After following these steps, you'll have a modular calculator architecture that scales with your needs while maintaining the simplicity of a single website deployment.

## 📞 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Run `.\migrate-calculators.ps1 -TestMigration` to diagnose
3. Review the submodule status with `git submodule status`
4. Check individual calculator repositories for issues

The migration maintains backward compatibility - your existing calculator URLs and functionality will work exactly the same!