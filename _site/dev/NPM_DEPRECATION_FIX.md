# NPM Deprecation Warnings Fix Guide 🔧

*Specific solution for Jekyll + npx setup*

## 🎯 **Your Current Setup Analysis**

✅ **What you have:**
- Jekyll static site (Ruby-based)
- npx-based Node tools (Lighthouse, axe-core, http-server)
- NO local package.json (correct approach)
- Environment variables already suppress most warnings

❌ **Why you see deprecation warnings:**
- Tools like `@lhci/cli` and `@axe-core/cli` have transitive dependencies
- These dependencies include deprecated packages (`inflight`, `glob`, `rimraf`)
- npx downloads these each time, bringing deprecated deps

## 🚀 **Solution Strategy**

### Option 1: Enhanced Warning Suppression (Recommended)

Update your CI workflows to suppress more npm warnings:

**Enhanced Environment Variables:**
```yaml
env:
  NPM_CONFIG_FUND: false
  NPM_CONFIG_AUDIT: false
  NPM_CONFIG_UPDATE_NOTIFIER: false
  NPM_CONFIG_WARNINGS: false
  NPM_CONFIG_PROGRESS: false
  NODE_NO_WARNINGS: 1
```

### Option 2: Pin Tool Versions (Advanced)

Specify exact versions of tools to use more recent releases:

```bash
# Instead of: npx --yes @lhci/cli
# Use: npx --yes @lhci/cli@0.13.0

# Instead of: npx --yes @axe-core/cli
# Use: npx --yes @axe-core/cli@4.8.0
```

### Option 3: Alternative Tools (If needed)

Replace tools with alternatives that have fewer deprecated dependencies:

| Current Tool | Alternative | Notes |
|--------------|-------------|-------|
| `@lhci/cli` | `lighthouse` | Core Lighthouse without LHCI wrapper |
| `@axe-core/cli` | `pa11y` | Alternative accessibility testing |
| `http-server` | `python -m http.server` | Built-in Python server |

## 📋 **Immediate Implementation**

Let's implement Option 1 (Enhanced Warning Suppression) for your workflow:

### Step 1: Update GitHub Actions

**File: `.github/workflows/a11y-and-lh.yml`**

Add enhanced environment variables to suppress all npm warnings:

```yaml
env:
  NPM_CONFIG_FUND: false
  NPM_CONFIG_AUDIT: false
  NPM_CONFIG_UPDATE_NOTIFIER: false
  NPM_CONFIG_WARNINGS: false
  NPM_CONFIG_PROGRESS: false
  NODE_NO_WARNINGS: 1
  SUPPRESS_NO_CONFIG_WARNING: true
```

### Step 2: Local Testing Script Updates

**File: `scripts/test-before-push.ps1`**

Add warning suppression to your local testing:

```powershell
# Set enhanced NPM config
$env:NPM_CONFIG_FUND = "false"
$env:NPM_CONFIG_AUDIT = "false"
$env:NPM_CONFIG_UPDATE_NOTIFIER = "false"
$env:NPM_CONFIG_WARNINGS = "false"
$env:NPM_CONFIG_PROGRESS = "false"
$env:NODE_NO_WARNINGS = "1"
```

## 🔍 **Verification Steps**

### 1. Check Current Warnings
Run a test to see current warning output:
```bash
npx --yes @lhci/cli --help 2>&1 | grep -i "deprecated\\|warn"
```

### 2. Test Suppression
After implementing, verify warnings are suppressed:
```bash
# Should show minimal output
NODE_NO_WARNINGS=1 npx --yes @lhci/cli --help
```

### 3. Monitor CI Logs
Watch GitHub Actions logs for reduced warning noise.

## 📊 **Long-term Strategy**

### Why This Approach is Best for Your Project:

1. **No package.json needed**: Maintains clean Jekyll structure
2. **npx advantages**: Always gets latest tool versions
3. **CI focus**: Warnings suppressed where they matter most
4. **Maintenance-free**: No local dependencies to manage

### When to Revisit:

- If tools stop working due to deprecated dependencies
- If new major versions of tools are released
- If warning suppression stops working

## 🎯 **Expected Results**

**Before:**
```
npm WARN deprecated inflight@1.0.6: This module is deprecated
npm WARN deprecated glob@7.2.3: Use @npmcli/glob instead
npm WARN deprecated rimraf@3.0.2: Use rm -rf instead
```

**After:**
```
[Clean output with minimal or no warnings]
```

## 🚨 **Important Notes**

1. **Don't add package.json**: This would complicate your Jekyll setup
2. **Keep using npx**: It's the right approach for your use case
3. **Monitor tool updates**: Major tools will eventually drop deprecated deps
4. **Warning vs Error**: Deprecation warnings don't break functionality
5. **⚠️ CRITICAL: Invalid npm config options**: Some npm config options are invalid and will cause CI failures
   - ❌ `npm config set warnings false` - 'warnings' is NOT a valid npm config option
   - ✅ Use `NPM_CONFIG_WARNINGS=false` environment variable instead
   - ✅ Local testing now validates npm config commands to prevent CI failures

## 🔍 **CI Failure Prevention**

**Local validation added to test-before-push.ps1:**
- Validates all `npm config set` commands found in GitHub Actions workflows
- Tests if npm config options are valid before pushing
- Prevents CI failures from invalid npm configuration

**Fixed in commit b25881d:**
- Removed invalid `npm config set warnings false` from workflows
- Enhanced local testing to catch npm config validation issues
- Rely exclusively on environment variables for npm configuration

## 📋 **Implementation Checklist**

- [ ] Update `.github/workflows/a11y-and-lh.yml` with enhanced env vars
- [ ] Update local testing scripts with warning suppression
- [ ] Test GitHub Actions to verify warning reduction
- [ ] Document changes in dev/COMPLETED.md
- [ ] Monitor CI logs for cleaner output

---

*This approach maintains your clean Jekyll architecture while minimizing deprecation warning noise.*
