# Quick Setup Templates 🚀

*Copy-paste templates for fast company/branch setup*

## 📋 Company Data Template

### For `_data/companies.yml`:

```yaml
# Replace 'your-company-name' with actual company name (lowercase, hyphens)
your-company-name:
  main:
    name: "Your Company Name"
    gstin: "09AAAFR4114P1Z2"                    # Optional - replace with actual GSTIN
    constitution: "Partnership"                  # Partnership|Proprietorship
    principal_place: "Full business address"    # Replace with actual address
    partners:                                    # For partnerships
      - "Partner 1 Name"
      - "Partner 2 Name"
    # OR for proprietorship, use:
    # proprietor: "Owner Name"
    contact:
      email: "contact@yourcompany.com"           # Replace with actual email
      phone: "+91-1234567890"                    # Optional - replace with actual phone

  # Add branches as needed (optional)
  branch-name:
    name: "Branch Display Name"
    gstin: "Branch GSTIN"                        # Optional
    constitution: "Partnership"                  # Optional
    principal_place: "Branch address"            # Optional
    contact:
      email: "branch@yourcompany.com"
      phone: "+91-0987654321"
```

## 📄 Page Templates

### Company Main Page (`companies/your-company-name/index.md`):

```markdown
---
layout: company
company: your-company-name
title: Your Company Name
description: "Your Company Name — branches and policies."
---

<!-- Optional: Add custom content here -->
```

### Company Terms (`companies/your-company-name/terms.md`):

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
Welcome to Your Company Name. By using our services, you agree to these terms.

## 2. Services
We provide [describe your services here].

## 3. Terms and Conditions
[Add your specific terms and conditions]

## 4. Contact
For questions about these terms, contact us at [email].
```

### Company Refund Policy (`companies/your-company-name/refund-policy.md`):

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
[Describe when refunds are available]

## Process
[Explain how to request refunds]

## Timeline
[Specify refund processing time]

## Contact
For refund requests, contact us at [email].
```

### Branch Main Page (`companies/your-company-name/branch-name/index.md`):

```markdown
---
layout: company-branch
company: your-company-name
branch: branch-name
title: Your Company Name - Branch Name
description: "Your Company Name Branch Name - services and contact information."
---

<!-- Optional: Add branch-specific content here -->
```

### Branch Contact (`companies/your-company-name/branch-name/contact.md`):

```markdown
---
layout: company-policy
company: your-company-name
branch: branch-name
policy_type: "Contact Information"
title: "Contact - Your Company Name Branch Name"
description: "Contact information for Your Company Name Branch Name."
---

# Contact Information

## Office Hours
- **Monday to Friday:** 9:00 AM - 6:00 PM
- **Saturday:** 9:00 AM - 2:00 PM
- **Sunday:** Closed

## Contact Details
- **Phone:** [Phone Number]
- **Email:** [Email Address]
- **WhatsApp:** [WhatsApp Number]

## Address
[Full Branch Address]
[City, State - PIN Code]

## Directions
[Optional: Add directions or landmarks]
```

### Branch Terms (`companies/your-company-name/branch-name/terms.md`):

```markdown
---
layout: company-policy
company: your-company-name
branch: branch-name
policy_type: "Terms of Service"
title: "Terms of Service - Your Company Name Branch Name"
description: "Terms of service for Your Company Name Branch Name."
---

# Terms of Service - Branch Name

## Local Terms
[Any branch-specific terms]

## Services Offered
[List branch-specific services]

## Operating Conditions
[Branch-specific operating terms]

## Contact
For questions about these terms, contact this branch at [branch email].
```

### Branch Privacy Policy (`companies/your-company-name/branch-name/privacy.md`):

```markdown
---
layout: company-policy
company: your-company-name
branch: branch-name
policy_type: "Privacy Policy"
title: "Privacy Policy - Your Company Name Branch Name"
description: "Privacy policy for Your Company Name Branch Name."
---

# Privacy Policy

## Information Collection
We collect information necessary to provide our services.

## Information Use
Your information is used to:
- Process orders and transactions
- Communicate about our services
- Improve our offerings

## Information Protection
We protect your information with appropriate security measures.

## Contact
For privacy concerns, contact us at [branch email].
```

### Branch Refund Policy (`companies/your-company-name/branch-name/refund-policy.md`):

```markdown
---
layout: company-policy
company: your-company-name
branch: branch-name
policy_type: "Refund Policy"
title: "Refund Policy - Your Company Name Branch Name"
description: "Refund policy for Your Company Name Branch Name."
---

# Refund Policy - Branch Name

## Branch-Specific Refund Terms
[Any branch-specific refund conditions]

## Local Processing
[Branch-specific refund processing details]

## Contact for Refunds
Contact this branch directly:
- **Email:** [branch email]
- **Phone:** [branch phone]
```

### Branch Shipping Policy (`companies/your-company-name/branch-name/shipping.md`):

```markdown
---
layout: company-policy
company: your-company-name
branch: branch-name
policy_type: "Shipping Policy"
title: "Shipping Policy - Your Company Name Branch Name"
description: "Shipping and delivery policy for Your Company Name Branch Name."
---

# Shipping & Delivery Policy

## Delivery Areas
We deliver to: [list areas covered by this branch]

## Delivery Times
- **Standard Delivery:** [timeframe]
- **Express Delivery:** [timeframe]

## Shipping Charges
[Detail shipping costs]

## Delivery Process
[Explain how delivery works]

## Contact
For delivery inquiries, contact us at [branch email] or [branch phone].
```

## 🔧 Navigation Template

### For `_data/navigation.yml`:

```yaml
# Add to the companies section:
companies:
  - name: "Your Company Name"
    url: "/companies/your-company-name/"
    branches:
      - name: "Branch 1"
        url: "/companies/your-company-name/branch-1/"
      - name: "Branch 2"
        url: "/companies/your-company-name/branch-2/"
```

## 🚀 Quick Commands

### Directory Creation:
```bash
mkdir companies/your-company-name
mkdir companies/your-company-name/branch-name
```

### File Creation Commands:
```bash
# Company files
touch companies/your-company-name/index.md
touch companies/your-company-name/terms.md
touch companies/your-company-name/refund-policy.md

# Branch files
touch companies/your-company-name/branch-name/index.md
touch companies/your-company-name/branch-name/contact.md
touch companies/your-company-name/branch-name/terms.md
touch companies/your-company-name/branch-name/privacy.md
touch companies/your-company-name/branch-name/refund-policy.md
touch companies/your-company-name/branch-name/shipping.md
```

## ✅ Quick Checklist

- [ ] Update `_data/companies.yml`
- [ ] Create directory structure
- [ ] Copy and customize templates
- [ ] Update navigation
- [ ] Test locally: `.\test-and-push.ps1 "Add [Company Name]" -QuickTest`
- [ ] Push when tests pass

---

*Copy these templates and replace placeholder text with actual company information.*
