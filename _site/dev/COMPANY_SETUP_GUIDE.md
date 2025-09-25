# Company & Branch Setup Guide 📋

*Complete step-by-step guide for adding new companies and branches to rk-Groups.github.io*

## 🎯 Overview

This guide explains how to add new companies and their branches to the RK Groups website. The system uses Jekyll data files and shared layouts to create consistent, maintainable company pages.

## 📁 System Architecture

```
companies/
├── index.md                    # Main companies listing
├── [company-name]/
│   ├── index.md               # Company main page
│   ├── terms.md               # Company-wide terms
│   ├── refund-policy.md       # Company-wide refund policy
│   └── [branch-name]/
│       ├── index.md           # Branch landing page
│       ├── contact.md         # Branch contact info
│       ├── terms.md           # Branch-specific terms
│       ├── privacy.md         # Branch privacy policy
│       ├── refund-policy.md   # Branch refund policy
│       ├── shipping.md        # Branch shipping policy
│       └── details.js         # Branch-specific data (optional)

_data/
└── companies.yml              # Central data repository

_layouts/
├── company.html               # Company main page layout
├── company-branch.html        # Branch page layout
└── company-policy.html        # Policy page layout
```

## 🚀 Step-by-Step Process

### Part 1: Add Company Data

#### Step 1.1: Update `_data/companies.yml`

Add your company data to the central YAML file:

```yaml
# Template for new company
your-company-name:
  main:
    name: "Your Company Name"
    gstin: "09AAAFR4114P1Z2"                    # Optional
    constitution: "Partnership|Proprietorship"   # Optional
    principal_place: "Full address here"         # Optional
    proprietor: "Owner Name"                     # For proprietorship
    partners:                                    # For partnership
      - "Partner 1"
      - "Partner 2"
    contact:
      email: "contact@yourcompany.com"
      phone: "+91-1234567890"                   # Optional

  # Add branches (optional)
  branch-1:
    name: "Branch Name"
    gstin: "Branch GSTIN"                       # Optional
    constitution: "Partnership"                 # Optional
    principal_place: "Branch address"           # Optional
    partners:                                   # If different from main
      - "Local Partner"
    contact:
      email: "branch@yourcompany.com"
      phone: "+91-0987654321"
```

**Real Example:**
```yaml
rk-new-ventures:
  main:
    name: "RK New Ventures"
    gstin: "09AAAFR4114P1Z5"
    constitution: "Partnership"
    principal_place: "123, Business Park, Lucknow – 226001, Uttar Pradesh"
    partners:
      - "Ruhil Jaiswal"
      - "Partner Name"
    contact:
      email: "ventures.rkgroup@gmail.com"
      phone: "+91-9876543210"

  mumbai:
    name: "Mumbai"
    gstin: "27AAAFR4114P1Z6"
    constitution: "Partnership"
    principal_place: "456, Business District, Mumbai – 400001, Maharashtra"
    contact:
      email: "mumbai.ventures@gmail.com"
      phone: "+91-8765432109"
```

### Part 2: Create Directory Structure

#### Step 2.1: Create Company Directory

```bash
mkdir companies/your-company-name
```

#### Step 2.2: Create Branch Directories (if needed)

```bash
mkdir companies/your-company-name/branch-1
mkdir companies/your-company-name/branch-2
```

### Part 3: Create Company Pages

#### Step 3.1: Company Main Page

Create `companies/your-company-name/index.md`:

```markdown
---
layout: company
company: your-company-name
title: Your Company Name
description: "Your Company Name — branches and policies."
---

<!-- Optional: Add custom content here -->
```

#### Step 3.2: Company-Wide Policies

Create `companies/your-company-name/terms.md`:

```markdown
---
layout: company-policy
company: your-company-name
policy_type: "Terms of Service"
title: "Terms of Service - Your Company Name"
description: "Terms of service and conditions for Your Company Name."
---

# Terms of Service

## 1. Introduction
Your company-wide terms content here...

## 2. Services
Details about services...

## 3. Terms and Conditions
Your terms and conditions...
```

Create `companies/your-company-name/refund-policy.md`:

```markdown
---
layout: company-policy
company: your-company-name
policy_type: "Refund Policy"
title: "Refund Policy - Your Company Name"
description: "Refund policy and procedures for Your Company Name."
---

# Refund Policy

## Refund Conditions
Your refund policy content here...

## Process
Steps for refunds...
```

### Part 4: Create Branch Pages

#### Step 4.1: Branch Main Page

Create `companies/your-company-name/branch-1/index.md`:

```markdown
---
layout: company-branch
company: your-company-name
branch: branch-1
title: Your Company Name - Branch 1
description: "Your Company Name Branch 1 - services and contact information."
---

<!-- Optional: Add branch-specific content here -->
```

#### Step 4.2: Branch Policies

Create all required policy files in the branch directory:

**`contact.md`:**
```markdown
---
layout: company-policy
company: your-company-name
branch: branch-1
policy_type: "Contact Information"
title: "Contact - Your Company Name Branch 1"
description: "Contact information for Your Company Name Branch 1."
---

# Contact Information

## Office Hours
Monday to Friday: 9:00 AM - 6:00 PM
Saturday: 9:00 AM - 2:00 PM

## Additional Contact Methods
- WhatsApp: [Phone Number]
- Address: [Full Address]
```

**`terms.md`:**
```markdown
---
layout: company-policy
company: your-company-name
branch: branch-1
policy_type: "Terms of Service"
title: "Terms of Service - Your Company Name Branch 1"
description: "Terms of service for Your Company Name Branch 1."
---

# Terms of Service - Branch 1

Branch-specific terms content...
```

**Create these additional policy files:**
- `privacy.md` - Privacy policy
- `refund-policy.md` - Branch refund policy
- `shipping.md` - Shipping and delivery policy

#### Step 4.3: Branch Data File (Optional)

Create `companies/your-company-name/branch-1/details.js` for dynamic data:

```javascript
// Branch-specific data and configurations
const branchData = {
    name: "Branch 1",
    specialServices: [
        "Service 1",
        "Service 2",
        "Service 3"
    ],
    operatingHours: {
        weekdays: "9:00 AM - 6:00 PM",
        saturday: "9:00 AM - 2:00 PM",
        sunday: "Closed"
    }
};
```

### Part 5: Update Navigation

#### Step 5.1: Update `_data/navigation.yml`

Add your company to the navigation dropdown:

```yaml
companies:
  - name: "Your Company Name"
    url: "/companies/your-company-name/"
    branches:
      - name: "Branch 1"
        url: "/companies/your-company-name/branch-1/"
      - name: "Branch 2"
        url: "/companies/your-company-name/branch-2/"
```

### Part 6: Testing and Validation

#### Step 6.1: Local Testing

```bash
# Use your new testing infrastructure
.\test-and-push.ps1 "Add Your Company Name with branches" -QuickTest
```

#### Step 6.2: Manual Validation

1. **Check Data Loading**: Verify company data appears correctly
2. **Test Navigation**: Ensure dropdowns work
3. **Validate Links**: Check all internal links function
4. **Review Layouts**: Confirm consistent styling
5. **Test Responsive**: Check mobile/tablet views

## ✅ Checklist Template

### Before Starting
- [ ] Choose company name (lowercase, hyphen-separated)
- [ ] Gather all company information (GSTIN, address, contacts)
- [ ] Identify required branches
- [ ] Prepare policy content

### Data Setup
- [ ] Add company to `_data/companies.yml`
- [ ] Add branch data (if applicable)
- [ ] Validate YAML syntax

### Directory Structure
- [ ] Create `companies/[company-name]/`
- [ ] Create branch directories
- [ ] Verify folder naming convention

### Company Pages
- [ ] Create `companies/[company-name]/index.md`
- [ ] Create `companies/[company-name]/terms.md`
- [ ] Create `companies/[company-name]/refund-policy.md`
- [ ] Set correct frontmatter

### Branch Pages (per branch)
- [ ] Create `[branch]/index.md`
- [ ] Create `[branch]/contact.md`
- [ ] Create `[branch]/terms.md`
- [ ] Create `[branch]/privacy.md`
- [ ] Create `[branch]/refund-policy.md`
- [ ] Create `[branch]/shipping.md`
- [ ] Create `[branch]/details.js` (optional)

### Integration
- [ ] Update `_data/navigation.yml`
- [ ] Test local build
- [ ] Validate all links
- [ ] Check responsive design

### Deployment
- [ ] Run comprehensive tests
- [ ] Commit and push changes
- [ ] Monitor GitHub Actions
- [ ] Verify live site

## 🎯 Pro Tips

### Naming Conventions
- **Companies**: `rk-company-name` (lowercase, hyphens)
- **Branches**: `city-name` or `location-name` (lowercase, hyphens)
- **Files**: Always use `.md` extension for content pages

### Content Guidelines
- Keep company descriptions concise and professional
- Ensure all required legal policies are included
- Use consistent formatting across all pages
- Include contact information for each branch

### Common Pitfalls
- ❌ **Inconsistent naming**: Use hyphens, not underscores or spaces
- ❌ **Missing frontmatter**: Every page needs proper YAML frontmatter
- ❌ **Broken data references**: Company/branch names must match exactly
- ❌ **Missing policies**: Each branch needs all required policy pages

### Quality Assurance
- Always test locally before pushing
- Use the monitoring system to check deployment
- Verify mobile responsiveness
- Test all navigation links

## 📚 Examples

See existing implementations:
- **RK Oxygen**: Full multi-branch setup
- **RK Electrodes**: Simple single-company setup
- **RK Palace**: Minimal company page

---

*This guide ensures consistent, maintainable company and branch additions to the RK Groups website.*
