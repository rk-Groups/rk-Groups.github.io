# Calculator Submodules Setup Guide

This guide explains how to separate calculators into independent projects and integrate them into the main RK Groups website.

## 🎯 Benefits of Separating Calculators

- **Independent Development**: Each calculator can be developed, tested, and deployed separately
- **Version Control**: Better tracking of changes for each calculator
- **Reusability**: Calculators can be used in other projects
- **Team Collaboration**: Different teams can work on different calculators
- **Modular Architecture**: Cleaner separation of concerns

## 📁 Current Calculator Structure

```
Calc/
├── GST/          # GST Calculator
│   ├── index.html
│   └── index.md
├── LIQ/          # Liquid Calculator
│   ├── index.html
│   └── index.md
├── EMI/          # EMI Calculator
│   ├── index.html
│   └── index.md
└── CI/           # CI Calculator
    ├── index.html
    └── index.md
```

## 🚀 Setup Process

### Step 1: Create Separate Repositories

Create individual GitHub repositories for each calculator:

1. **GST Calculator**: `rk-groups/calculator-gst`
2. **Liquid Calculator**: `rk-groups/calculator-liquid`
3. **EMI Calculator**: `rk-groups/calculator-emi`
4. **CI Calculator**: `rk-groups/calculator-ci`

### Step 2: Move Calculator Code

For each calculator repository:

```bash
# Create new repository
mkdir calculator-gst
cd calculator-gst
git init
git remote add origin https://github.com/rk-groups/calculator-gst.git

# Copy calculator files
cp -r ../rk-Groups.github.io/Calc/GST/* ./

# Add Jekyll front matter if needed
echo "---" > index.md.tmp
echo "layout: default" >> index.md.tmp
echo "title: GST Calculator" >> index.md.tmp
echo "---" >> index.md.tmp
cat index.md >> index.md.tmp
mv index.md.tmp index.md

# Commit and push
git add .
git commit -m "Initial commit: GST Calculator"
git push -u origin master
```

### Step 3: Convert to Submodules

Use the management script to convert directories to submodules:

```bash
# Add calculator submodules
.\manage-calculators.ps1 -AddGST
.\manage-calculators.ps1 -AddLIQ
.\manage-calculators.ps1 -AddEMI
.\manage-calculators.ps1 -AddCI

# Initialize submodules
.\manage-calculators.ps1 -Init

# Update submodules
.\manage-calculators.ps1 -Update
```

## 🔧 Alternative Approaches

### Option 1: Git Submodules (Recommended)

**Pros:**
- Maintains separate version control
- Easy to update individual calculators
- Clear separation of concerns

**Cons:**
- Slightly more complex workflow
- Need to manage multiple repositories

### Option 2: Git Subtree

**Pros:**
- Simpler workflow than submodules
- Single repository management

**Cons:**
- History gets merged into main repo
- Less clear separation

### Option 3: NPM Packages

If calculators are JavaScript-heavy:

**Pros:**
- Standard package management
- Versioned dependencies
- Easy to share across projects

**Cons:**
- Requires build process
- Not ideal for Jekyll integration

## 📋 Workflow Commands

### Adding a New Calculator

```bash
# 1. Create repository on GitHub
# 2. Add as submodule
.\manage-calculators.ps1 -AddGST

# 3. Initialize
.\manage-calculators.ps1 -Init
```

### Updating Calculators

```bash
# Update all calculators to latest version
.\manage-calculators.ps1 -Update

# Check status
.\manage-calculators.ps1 -Status
```

### Development Workflow

```bash
# Work on GST calculator
cd Calc/GST
git checkout -b feature/new-gst-feature
# Make changes...
git commit -m "Add new GST feature"
git push origin feature/new-gst-feature

# Update main site
cd ../..
git add Calc/GST
git commit -m "Update GST calculator"
git push
```

## 🔄 CI/CD Integration

Update your GitHub Actions workflow to handle submodules:

```yaml
- name: Checkout with submodules
  uses: actions/checkout@v3
  with:
    submodules: recursive
```

## 🧪 Testing Strategy

- **Unit Tests**: Each calculator repo should have its own tests
- **Integration Tests**: Main site tests ensure calculators load properly
- **E2E Tests**: Test calculator functionality in context

## 📚 Best Practices

1. **Version Tagging**: Tag releases for each calculator
2. **Documentation**: Each calculator repo should have README.md
3. **Dependencies**: Keep calculator dependencies minimal
4. **Compatibility**: Ensure calculators work with main site styles
5. **Updates**: Regularly update submodules in main repo

## 🚨 Migration Checklist

- [ ] Create separate repositories for each calculator
- [ ] Move calculator code to new repositories
- [ ] Update any shared dependencies
- [ ] Test calculators independently
- [ ] Convert main repo directories to submodules
- [ ] Update CI/CD pipelines
- [ ] Test integration
- [ ] Update documentation
- [ ] Train team on new workflow

## 🔍 Troubleshooting

### Submodule Issues

```bash
# Fix detached HEAD
cd Calc/GST
git checkout master

# Remove submodule
git submodule deinit Calc/GST
git rm Calc/GST
rm -rf .git/modules/Calc/GST
```

### Sync Issues

```bash
# Force update submodule
git submodule update --init --recursive --force
```

This approach gives you the best of both worlds: independent calculator development with seamless integration into your main website.