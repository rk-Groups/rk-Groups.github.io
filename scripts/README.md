# Local Testing Scripts

This directory contains scripts to test your changes locally before pushing to prevent CI failures.

## Scripts

### 🧪 `test-before-push.ps1`
Comprehensive testing script that mirrors GitHub Actions workflows locally.

**What it tests:**
- Git pull to ensure latest changes
- Jekyll build validation
- Markdown link checking
- Lighthouse performance testing
- Accessibility checks with axe-core
- Pre-commit quality checks

**Usage:**
```powershell
# Full test suite
.\scripts\test-before-push.ps1

# Skip specific tests
.\scripts\test-before-push.ps1 -SkipLighthouse -SkipAxe

# Verbose output
.\scripts\test-before-push.ps1 -Verbose
```

**Requirements:**
- Ruby with Bundler (for Jekyll)
- Node.js with npm (for Lighthouse and axe-core)
- Git

### 🚀 `test-and-push.ps1`
Convenience wrapper that tests, commits, and pushes in one command.

**Usage:**
```powershell
# Test, commit, and push
.\test-and-push.ps1 "Your commit message here"

# Quick test (skip performance and a11y)
.\test-and-push.ps1 "Quick fix" -QuickTest

# Test and push existing commits
.\test-and-push.ps1 -Force
```

## Workflow Integration

These scripts replicate the following GitHub Actions:
- ✅ Jekyll Build (`gh-pages.yml`)
- ✅ Lighthouse CI (`a11y-and-lh.yml`)
- ✅ Accessibility Testing (`a11y-and-lh.yml`)
- ✅ Link Checking (basic validation)
- ✅ Code Quality (whitespace, etc.)

## Troubleshooting

### "Bundle not found"
Install Ruby and Bundler:
```powershell
# Using Chocolatey (recommended)
choco install ruby
gem install bundler
```

### "Node.js not found"
Install Node.js:
```powershell
# Using Chocolatey
choco install nodejs

# Or download from nodejs.org
```

### "Permission denied"
Enable script execution:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Tests fail but CI passes
- Check Node.js version differences
- Ensure all dependencies are installed locally
- Compare local Ruby/Jekyll versions with CI

## Best Practices

1. **Always run tests before pushing:**
   ```powershell
   .\test-and-push.ps1 "Your changes"
   ```

2. **For quick fixes, use QuickTest:**
   ```powershell
   .\test-and-push.ps1 "Typo fix" -QuickTest
   ```

3. **For major changes, run full suite:**
   ```powershell
   .\scripts\test-before-push.ps1 -Verbose
   ```

4. **If tests fail, fix issues and retry**

## Performance Notes

- Full test suite: ~2-3 minutes
- QuickTest mode: ~30-60 seconds
- Tests are cached where possible
- Local server runs on ports 3000-3001
